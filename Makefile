ROOTDIR = $(N64_INST)
GCCN64PREFIX = $(ROOTDIR)/bin/mips64-elf-
CHKSUM64PATH = $(ROOTDIR)/bin/chksum64
MKDFSPATH = $(ROOTDIR)/bin/mkdfs
MKSPRITE = $(ROOTDIR)/bin/mksprite
N64TOOL = $(ROOTDIR)/bin/n64tool
LINK_FLAGS = -L$(ROOTDIR)/lib -L$(ROOTDIR)/mips64-elf/lib -ldragon -lc -lm -ldragonsys -Tn64ld.x
PROG_NAME = Flood-64
CFLAGS = -std=gnu99 -march=vr4300 -mtune=vr4300 -O2 -Wall -Werror -I$(ROOTDIR)/mips64-elf/include -Iinclude -I/usr/local/include/
ASFLAGS = -mtune=vr4300 -march=vr4300
CC = $(GCCN64PREFIX)gcc
AS = $(GCCN64PREFIX)as
LD = $(GCCN64PREFIX)ld
OBJCOPY = $(GCCN64PREFIX)objcopy

all: $(PROG_NAME).z64

# gfx #
PNGS := $(wildcard resources/gfx/*/*.png) $(wildcard resources/gfx/*/*/*.png)
SPRITES := $(subst .png,.sprite,$(subst resources/,filesystem/,$(PNGS)))
filesystem/gfx/sprites/%.sprite: resources/gfx/sprites/%.png
	$(MKSPRITE) 16 1 1 $< $@

filesystem/gfx/maps/%.sprite: resources/gfx/maps/%.png
	$(MKSPRITE) 16 1 1 $< $@

# sfx #
MP3S := $(wildcard resources/sfx/bgms/*.mp3)
BGMS := $(subst .mp3,.raw,$(subst resources/,filesystem/,$(MP3S)))
filesystem/sfx/bgms/%.raw: resources/sfx/bgms/%.mp3
	sox $< -b 16 -e signed-integer -B -r 44100 $@ remix -

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
	$(N64TOOL) -l 64M -t "$(PROG_NAME)" -h $(ROOTDIR)/mips64-elf/lib/header -o $(PROG_NAME).z64 $(PROG_NAME).bin -s 1M $(PROG_NAME).dfs
	$(CHKSUM64PATH) $@

docker:		## Create rom file in a docker container.
	docker build -t build .
	docker run --rm build cat $(PROG_NAME).z64 > $(PROG_NAME).z64

cen64:		## Start rom in CEN64 emulator
	$(CEN64_DIR)/cen64 -multithread -controller num=1,pak=rumble $(CEN64_DIR)/pifdata.bin $(PROG_NAME).z64

flashair: 	## Flash rom to EverDrive using a flashair SD card.
	curl -X POST -F 'file=@$(PROG_NAME).z64' http://vieux_flashair/upload.cgi

clean:		## Cleanup.
	rm -f *.z64 *.elf src/*.o *.bin *.dfs

help:		## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
