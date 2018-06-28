#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

[ -f /usr/bin/caddy ] && /usr/bin/caddy -version
