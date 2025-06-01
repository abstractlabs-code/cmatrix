FROM alpine:3.22.0 as cmatrixbuilder

WORKDIR cmatrix

RUN apk update && \
    apk add --no-cache \
    git \
    automake \
    autoconf \
    alpine-sdk \
    ncurses-dev \
    ncurses-static && \
    git clone https://github.com/abishekvashok/cmatrix.git . && \
    autoreconf -i && \
    mkdir -p /usr/lib/kbd/consolefonts /usr/share/consolefonts && \
    ./configure LDFLAGS="-static" && \
    make



FROM alpine:3.22.0 

LABEL org.opencontainers.image.authors="Abstract Labs" \
      org.opencontainers.image.description="Image for https://github.com/abishekvashok/cmatrix"

RUN apk update && \
    apk add --no-cache \
    ncurses-terminfo-base 

COPY --from=cmatrixbuilder /cmatrix/cmatrix /cmatrix

CMD ["./cmatrix"]
