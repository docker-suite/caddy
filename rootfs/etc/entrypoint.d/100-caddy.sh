#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Add libraries
source /usr/local/lib/bash-logger.sh

# make sure folders exist
mkdir -p /config/caddy
mkdir -p /data/caddy
mkdir -p /etc/caddy
mkdir -p /etc/caddy/certificates
mkdir -p /var/www
mkdir -p /var/log

# A Caddyfile must exist in /etc/caddy
# if not, just create a default simple one
if [ ! -f /etc/caddy/Caddyfile ]; then
    {
        echo "# The Caddyfile is an easy way to configure your Caddy web server."
        echo "#"
        echo "# Unless the file starts with a global options block, the first"
        echo "# uncommented line is always the address of your site."
        echo "#"
        echo "# Refer to the Caddy docs for more information:"
        echo "# https://caddyserver.com/docs/caddyfile"
        echo ""
        echo "# To use your own domain name (with automatic HTTPS), first make"
        echo "# sure your domain's A/AAAA DNS records are properly pointed to"
        echo "# this machine's public IP, then replace the line below with your"
        echo "# domain name."
        echo ":80"
        echo ""
        echo "# Set this path to your site's directory."
        echo "root * /var/www"
        echo ""
        echo "# Enable the static file server."
        echo "file_server"
        echo ""
        echo "# Another common task is to set up a reverse proxy:"
        echo "# reverse_proxy localhost:8080"
        echo ""
        echo "# Or serve a PHP site through php-fpm:"
        echo "# php_fastcgi localhost:9000"
        echo ""
        echo "# Configure where to write the logs"
        echo "log {"
        echo "	output stdout"
        echo "}"
    } > /etc/caddy/Caddyfile
fi

#
chown -R caddy:caddy /config/caddy
chown -R caddy:caddy /data/caddy
chown -R caddy:caddy /etc/caddy

# Display caddy version
[ -f /usr/bin/caddy ] && NOTICE "Caddy $(/usr/bin/caddy version)"


