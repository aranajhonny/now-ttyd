FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      cmake \
      curl \
      g++ \
      git \
      libjson-c2 \
      libjson-c-dev \
      libssl1.0.0 \
      libssl-dev \
      libwebsockets7 \
      libwebsockets-dev \
      pkg-config \
      vim-common \
      zsh \
      curl \
      wget \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /tmp/ttyd \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && cd /tmp/ttyd && mkdir build && cd build \
    && cmake .. \
    && make \
    && make install \
    && apt-get remove -y --purge \
        cmake \
        g++ \
        libwebsockets-dev \
        libjson-c-dev \
        libssl-dev \
        pkg-config \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/ttyd

EXPOSE 7681

ENTRYPOINT ["ttyd"]

CMD ["zsh"]
