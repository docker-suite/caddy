FROM dsuite/caddy:latest

ENV PLUGINS="http.git"

RUN bash -c '/usr/local/bin/caddy-install.sh'

COPY /rootfs /