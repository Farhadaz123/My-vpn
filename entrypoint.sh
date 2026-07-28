#!/bin/sh
# entrypoint.sh - V2Ray startup for Railway
# Generates UUID and configures V2Ray dynamically

# Generate a random UUID if not set
UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}

# Get port from Railway environment
PORT=${PORT:-8080}

# Replace placeholders in config template
sed -i "s/UUID_PLACEHOLDER/$UUID/g" /etc/v2ray/config.json.template
sed -i "s/PORT_PLACEHOLDER/$PORT/g" /etc/v2ray/config.json.template

# Create final config
cp /etc/v2ray/config.json.template /etc/v2ray/config.json

# Start V2Ray
echo "Starting V2Ray with UUID: $UUID on port: $PORT"
exec v2ray run -config /etc/v2ray/config.json