FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    # add-apt-repository ppa:team-gcc-arm-embedded/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    dfu-util \
    # gcc-arm-embedded \
    # gcc-arm-none-eabi \
    git \
    libreadline-dev \
    unzip \
    zip \
    xxd \
    make \
    wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -O gcc-arm-none-eabi.tar.bz2
RUN mkdir gcc-arm-none-eabi && tar xjfv gcc-arm-none-eabi.tar.bz2 -C gcc-arm-none-eabi --strip-components 1
RUN rm gcc-arm-none-eabi.tar.bz2
ENV PATH="/gcc-arm-none-eabi/bin:${PATH}"

RUN git clone https://github.com/taubaland/lua.git
RUN cd lua && \
    git switch luacc-5.3.4 && \
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
