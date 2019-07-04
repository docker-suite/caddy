#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# echo "##################################################"
# echo "PLUGINS : $PLUGINS"
# echo "TELEMETRY: $TELEMETRY"
# echo "##################################################"

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh


# check if caddy is running
if [ -n "$(getpidsbyname caddy 2>/dev/null)" ]; then
    ERROR "Stop Caddy before updating"
    exit 1
fi

# Download from caddyserver.com
curl -L -o /tmp/caddy.tar.gz "https://caddyserver.com/download/linux/amd64?plugins=${PLUGINS}&license=${LICENSE}&telemetry=${TELEMETRY}"
# Extract caddy to /usr/bin
tar -zxf /tmp/caddy.tar.gz -C /usr/bin
# Remove archive
rm -f /tmp/caddy.tar.gz
# Make it executable
chmod +x /usr/bin/caddy

# caddy currently does not support dropping privileges so we
# change attributes with setcat to allow access to priv ports
# https://caddyserver.com/docs/faq
setcap cap_net_bind_service=+eip /usr/bin/caddy

# validate install
NOTICE "$(/usr/bin/caddy --version)"

# export verion to file
/usr/bin/caddy --version | grep "Caddy v" | cut -d ' ' -f2 | cut -d 'v' -f2 > /VERSION

