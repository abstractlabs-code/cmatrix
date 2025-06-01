FROM alpine:3.22.0

LABEL org.opencontainers.image.authors="Abstract Labs"
LABEL org.opencontainers.image.description="Image for https://github.com/abishekvashok/cmatrix"

RUN apk update && apk add --no-cache \
    git \
    automake \
    autoconf \
    alpine-sdk \
    ncurses-dev \
    ncurses-static

WORKDIR /app

RUN mkdir -p /usr/lib/kbd/consolefonts /usr/share/consolefonts

RUN git clone https://github.com/abishekvashok/cmatrix.git
WORKDIR /app/cmatrix
RUN autoreconf -i
RUN ./configure LDFLAGS="-static"
RUN make

CMD /app/cmatrix/cmatrix
