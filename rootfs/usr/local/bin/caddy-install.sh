#!/usr/bin/env bash
# shellcheck disable=SC1091

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Add libraries
source /usr/local/lib/bash-logger.sh


# check if caddy is running
if [ -n "$(getpidsbyname caddy 2>/dev/null)" ]; then
    ERROR "Stop Caddy before updating"
    exit 1
fi

#
urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    local i=1
    local length="${#1}"
    while [ $i -le $length ]; do
        local c=$(echo "$(expr substr $1 $i 1)")
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            ' ') printf "%%20" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
        i=$(expr $i + 1)
    done

    LC_COLLATE=$old_lc_collate
}
# plugins list
PLUGIN_PARAM=""
for i in "${PLUGINS[@]}"; do
    if [ -n "${PLUGINS[$i]}" ]; then
        PLUGIN_PARAM="$PLUGIN_PARAM&p=$(urlencode ${PLUGINS[$i]})"
    fi
done

# Download from caddyserver.com
curl -L -o /usr/bin/caddy "https://caddyserver.com/api/download?os=linux&arch=amd64$PLUGIN_PARAM"
# Make it executable
chmod +x /usr/bin/caddy

# caddy currently does not support dropping privileges so we
# change attributes with setcat to allow access to priv ports
# https://caddyserver.com/docs/faq
setcap cap_net_bind_service=+eip /usr/bin/caddy

# validate install
echo "$(/usr/bin/caddy version)"
