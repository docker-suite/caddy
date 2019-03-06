# caddy apk builder
FROM craftdock/apk-caddy:0.11 as caddy_apk_builder

ENV PACKAGER "Hexosse <hexosse@gmail.com>"

RUN set -x \
    # Build apk file
    && /entrypoint abuild -r -P /packages \
    # Copy packages outside of builder volume
    && sudo cp -r /packages /tmp/caddy
    


# caddy    
FROM craftdock/alpine-runit:latest

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with Caddy server."

ENV CADDY_MAJOR 0.11
ENV CADDY_VERSION 0.11.5

COPY --from=caddy_apk_builder /tmp/caddy /tmp/caddy

RUN \
	# Print executed commands
	set -x \
    # Update repository indexes
    && apk-update \
    # Install Caddy server
    && apk-install --repository /tmp/caddy --allow-untrusted \
        caddy=${CADDY_VERSION}-r0 \
	# Clear apk's cache
	&& apk-cleanup

# Copy scripts
COPY /rootfs /

# Add volume to allow persistence
VOLUME ["/etc/caddy", "/etc/caddy/certificates", "/var/www"]

# Expose http, https and caddy port
EXPOSE 80 443 2015
