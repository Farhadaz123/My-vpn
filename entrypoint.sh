#!/bin/sh
# entrypoint.sh - V2Ray for Railway with direct binary download

set -e

UUID=${UUID:-$(cat /proc/sys/kernel/random/uuid)}
PORT=${PORT:-8080}

echo "=== Step 1: Downloading V2Ray ==="
curl -sL -o /tmp/v2ray.zip \
  "https://github.com/v2fly/v2ray-core/releases/download/v5.16.1/v2ray-linux-64.zip"
echo "Download complete ($(wc -c < /tmp/v2ray.zip) bytes)"

echo "=== Step 2: Extracting ==="
unzip -o /tmp/v2ray.zip v2ray v2ctl geosite.dat geoip.dat -d /usr/local/bin/ 2>&1
chmod +x /usr/local/bin/v2ray /usr/local/bin/v2ctl 2>/dev/null
echo "Extract complete"

echo "=== Step 3: Writing config ==="
cat > /etc/v2ray-config.json << EOF
{
  "inbounds": [
    {
      "port": ${PORT},
      "listen": "0.0.0.0",
      "protocol": "vmess",
      "settings": {
        "clients": [
          { "id": "${UUID}", "alterId": 0 }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "/", "headers": { "Host": "" } }
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" }
  ]
}
EOF
echo "Config written"

echo "=== Step 4: Starting V2Ray ==="
echo "UUID: ${UUID}"
echo "Port: ${PORT}"
exec /usr/local/bin/v2ray run -config /etc/v2ray-config.json