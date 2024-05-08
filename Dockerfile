FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:team-gcc-arm-embedded/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    dfu-util \
    gcc-arm-embedded \
    git \
    libreadline-dev \
    unzip \
    zip \
    xxd \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/taubaland/lua.git
RUN cd lua && \
    git checkout -b luacc-5.3.4 && \
    make linux test && \
    make install && \
    cd ..

# RUN wget --quiet https://www.lua.org/ftp/lua-5.3.4.tar.gz -O lua.tar.gz
# RUN tar -xzf lua.tar.gz && \
#     cd lua-5.3.4 && \
#     make linux test && \
#     make install && \
#     cd ..

WORKDIR /target
ENTRYPOINT ["make", "-j", "R=1", "zip"]
