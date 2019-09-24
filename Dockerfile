FROM anacierdem/libdragon

RUN apt-get update && apt-get install -yq git libsox-fmt-all sox

WORKDIR /Flood-N64
