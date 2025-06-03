FROM linuxserver/qbittorrent

# Instalar dependências
RUN apk update && apk upgrade && apk add --no-cache \
    chromaprint \
    openjdk11 \
    openjdk11-jre \
    zlib-dev \
    libzen \
    libzen-dev \
    libmediainfo \
    libmediainfo-dev \
    libjna \
    curl \
    wget \
    tar \
    bash

# Criar diretórios
RUN mkdir -p /filebot /config/filebot/logs /downloads

# Baixar FileBot portátil versão fixa
ENV FILEBOT_VERSION=FileBot_5.2.3

RUN cd /filebot && \
    wget "https://get.filebot.net/filebot/${FILEBOT_VERSION}/${FILEBOT_VERSION}-portable.tar.xz" -O filebot.tar.xz && \
    tar -xJf filebot.tar.xz && \
    rm filebot.tar.xz

# Linkar bibliotecas necessárias
RUN ln -sf /usr/lib/libzen.so /filebot/lib/Linux-x86_64/libzen.so && \
    ln -sf /usr/lib/libmediainfo.so /filebot/lib/Linux-x86_64/libmediainfo.so || true && \
    rm -rf /filebot/lib/FreeBSD-amd64 \
           /filebot/lib/Linux-armv7l \
           /filebot/lib/Linux-i686 \
           /filebot/lib/Linux-aarch64

# Colocar FileBot no PATH
ENV PATH="/filebot:${PATH}"

# UID/GID padrão
ENV PUID=1000 \
    PGID=1000 \
    WEBUI_PORT=

# Configurações padrão do FileBot
ENV FILEBOT_LANG=en \
    FILEBOT_CONFLICT=auto \
    FILEBOT_ACTION=copy \
    FILEBOT_ARTWORK=y \
    FILEBOT_PROCESS_MUSIC=y \
    MUSIC_FORMAT={plex} \
    MOVIE_FORMAT={plex} \
    SERIE_FORMAT={plex} \
    ANIME_FORMAT="animes/{n}/{e.pad(3)} - {t}" \
    FILEBOT_OPTS=-Dnet.filebot.archive.unrar=/usr/bin/unrar \
    EXTRA_FILEBOT_PARAM=

# Diretórios padrão
ENV HOME="/data" \
    XDG_CONFIG_HOME="/data" \
    XDG_DATA_HOME="/data"

# Copiar scripts adicionais
COPY root/ /
RUN chmod +x /etc/cont-init.d/* || true

# Volumes padrão
VOLUME ["/data"]
VOLUME ["/downloads"]
VOLUME ["/media"]

EXPOSE 8080
