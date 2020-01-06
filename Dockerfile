
FROM dsuite/alpine-runit:3.11


LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with Caddy server." \
      vendor="docker-suite" \
      license="MIT"


ARG PLUGINS
ARG LICENSE
ARG TELEMETRY

## Define plugins, license an temetry to install
## or update caddy
ENV PLUGINS=${PLUGINS}
ENV LICENSE=${LICENSE:-"personal"}
ENV TELEMETRY=${TELEMETRY:-"on"}


## Create users
RUN \
	# Print executed commands
	set -x \
    # Ensure www-data user exists
    # 82 is the standard uid/gid for "www-data" in Alpine
    && addgroup -g 82 -S www-data 2>/dev/null \
    && adduser -u 82 -S -D -s /sbin/nologin -G www-data -g www-data www-data 2>/dev/null \
    # Add caddy user
    && addgroup -g 101 -S caddy 2>/dev/null \
    && adduser -u 100 -S -D -s /sbin/nologin -G caddy -g caddy caddy 2>/dev/null \
    # caddy user must be member of www-data
    && adduser caddy www-data 2>/dev/null

## Install packages
RUN \
	# Print executed commands
	set -x \
    # Update repository indexes
    && apk-update \
    # Install packages needed by Caddy server
    && apk-install libcap \
	# Clear apk's cache
	&& apk-cleanup

## Copy files
COPY /rootfs /

## Install latest version of caddy
RUN chmod +x /usr/local/bin/caddy-install.sh \
    && bash -c '/usr/local/bin/caddy-install.sh'

## Add volume to allow persistence
VOLUME ["/etc/caddy", "/etc/caddy/certificates", "/var/www", "/var/log"]

## Expose http, https and caddy port
EXPOSE 80 443 2015