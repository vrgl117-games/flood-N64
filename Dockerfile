FROM vieux/libdragon:conker64

RUN apt-get update && apt-get install -yq git libsox-fmt-all sox

COPY . /Flood-N64
WORKDIR /Flood-N64

RUN mkdir -p filesystem/gfx/sprites/en filesystem/gfx/sprites/fr filesystem/gfx/sprites/es filesystem/gfx/maps/en filesystem/gfx/maps/fr filesystem/gfx/maps/es filesystem/sfx/bgms
RUN make