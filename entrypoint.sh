#!/bin/sh
# entrypoint.sh - V2Ray startup for Railway
# Downloads official V2Ray binary and runs it

UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}
PORT=${PORT:-8080}

# Download V2Ray binary
echo "Downloading V2Ray..."
curl -sL https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -o /tmp/v2ray.zip
unzip -o /tmp/v2ray.zip -d /usr/local/bin/ v2ray
chmod +x /usr/local/bin/v2ray

# Create config directory
mkdir -p /etc/v2ray

# Write config JSON directly
cat > /etc/v2ray/config.json << ENDCONFIG
{
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": ${PORT},
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${UUID}",
            "alterId": 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/",
          "headers": {
            "Host": ""
          }
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
ENDCONFIG

echo "V2Ray started — UUID: ${UUID} | Port: ${PORT}"
exec /usr/local/bin/v2ray run -config /etc/v2ray/config.json