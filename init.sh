#!/usr/bin/env bash

# Remove any config to make sure haproxy is start by consul-template
# on container boot even if there is an up to date config
echo "Cleaning any present config..."
rm -f /etc/haproxy/haproxy.cfg 2> /dev/null

# Start consul-template with all passed arguments
echo "Starting consul template..."
exec "/usr/bin/consul-template" "$@"