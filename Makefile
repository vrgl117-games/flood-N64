ROOTDIR = $(N64_INST)
GCCN64PREFIX = $(ROOTDIR)/bin/mips64-elf-
CHKSUM64PATH = $(ROOTDIR)/bin/chksum64
MKDFSPATH = $(ROOTDIR)/bin/mkdfs
MKSPRITE = $(ROOTDIR)/bin/mksprite
N64TOOL = $(ROOTDIR)/bin/n64tool
LINK_FLAGS = -L$(ROOTDIR)/lib -L$(ROOTDIR)/mips64-elf/lib -ldragon -lmikmod -lc -lm -ldragonsys -Tn64.ld
PROG_NAME = Flood-64
CFLAGS = -std=gnu99 -march=vr4300 -mtune=vr4300 -O2 -Wall -Werror -I$(ROOTDIR)/mips64-elf/include -Iinclude -I/usr/local/include/
ASFLAGS = -mtune=vr4300 -march=vr4300
CC = $(GCCN64PREFIX)gcc
AS = $(GCCN64PREFIX)as
LD = $(GCCN64PREFIX)ld
OBJCOPY = $(GCCN64PREFIX)objcopy

all: build

build: setup	##    Create rom.
	mkdir -p filesystem/gfx/sprites/en filesystem/gfx/sprites/fr  filesystem/gfx/sprites/es filesystem/gfx/maps/en filesystem/gfx/maps/fr filesystem/gfx/maps/es filesystem/sfx/bgms
	docker run -v ${CURDIR}:/Flood-N64 build make $(PROG_NAME).z64

rebuild: clean build	##  Erase temp files and create the rom.

# gfx #
PNGS := $(wildcard resources/gfx/*/*.png) $(wildcard resources/gfx/*/*/*.png)
SPRITES := $(subst .png,.sprite,$(subst resources/,filesystem/,$(PNGS)))
filesystem/gfx/sprites/%.sprite: resources/gfx/sprites/%.png
	$(MKSPRITE) 16 1 1 $< $@

filesystem/gfx/maps/%.sprite: resources/gfx/maps/%.png
	$(MKSPRITE) 16 1 1 $< $@

# sfx #
MODS := $(wildcard resources/sfx/bgms/*.mod)
BGMS := $(subst resources/,filesystem/,$(MODS))
filesystem/sfx/bgms/%.mod: resources/sfx/bgms/%.mod
	cp $< $@

# code #
SRCS := $(wildcard src/*.c)
OBJS := $(SRCS:.c=.o)
$(PROG_NAME).elf : $(OBJS)
	$(LD) -o $@ $^ $(LINK_FLAGS)

$(PROG_NAME).bin : $(PROG_NAME).elf
	$(OBJCOPY) -O binary $< $@

# dfs #
$(PROG_NAME).dfs: $(SPRITES) $(BGMS)
	$(MKDFSPATH) $@ ./filesystem/

# rom
$(PROG_NAME).z64: $(PROG_NAME).bin $(PROG_NAME).dfs
	@rm -f $@
	$(N64TOOL) -l 8M -t "$(PROG_NAME)" -h $(ROOTDIR)/mips64-elf/lib/header -o $(PROG_NAME).z64 $(PROG_NAME).bin -s 1M $(PROG_NAME).dfs
	$(CHKSUM64PATH) $@

setup:		##    Create dev environment (docker image).
	docker build -t build  - < Dockerfile

resetup:	##    Force recreate the dev environment (docker image).
	docker build -t build  --no-cache  - < Dockerfile
cen64:		##    Start rom in CEN64 emulator.
	$(CEN64_DIR)/cen64 -controller num=1,pak=rumble $(CEN64_DIR)/pifdata.bin $(PROG_NAME).z64

flashair: 	## Flash rom to EverDrive using a flashair SD card.
	curl -X POST -F 'file=@$(PROG_NAME).z64' http://vieux_flashair/upload.cgi

clean:		##    Cleanup temp files.
	rm -f *.z64 *.elf src/*.o *.bin *.dfs filesystem/sfx/*/*.mod filesystem/gfx/*/*/*.sprite filesystem/gfx/*/*.sprite

help:		##     Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/:.*##/:/' 
