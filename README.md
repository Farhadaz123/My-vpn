# My-vpn - Marzban VPN Panel on Railway

Complete Marzban VPN panel with Xray-core, deployable on Railway.

## Features
- 🚀 Marzban Panel (Web Dashboard)
- ⚡ Xray-core (VLESS, VMess, Trojan, Shadowsocks, TUIC)
- 🔒 SSL/TLS with Let's Encrypt
- 📊 Traffic stats & limits
- 👥 Multi-user management
- 📱 QR codes & subscription links

## Quick Deploy on Railway

1. **Fork/Clone this repo**
2. Go to [railway.app](https://railway.app) → New Project → Deploy from GitHub
3. Select this repository
4. Add these **Environment Variables**:

| Variable | Value |
|----------|-------|
| `JWT_SECRET_KEY` | Your random 32+ char secret |
| `ADMIN_USERNAME` | `admin` |
| `ADMIN_PASSWORD` | Your secure password |
| `XRAY_SUBSCRIPTION_URL_PREFIX` | `https://your-app.up.railway.app` |

5. **Deploy**

## Access Panel

After deploy:
- URL: `https://your-app.up.railway.app`
- Login: `admin` / (your password)

## Create Users

1. Login to panel
2. **Users** → **Add User**
3. Select protocols: VLESS, VMess, Trojan, Shadowsocks, TUIC
4. Get subscription link or QR code
5. Import in V2RayNG / V2RayN / Stash

## Supported Protocols

- **VLESS** (XTLS-Reality, TLS, WebSocket)
- **VMess** (WebSocket + TLS)
- **Trojan** (TLS, WebSocket)
- **Shadowsocks** (2022-blake3-aes-128-gcm, etc.)
- **TUIC** (v5)

## Local Development

```bash
docker build -t my-vpn .
docker run -p 8080:8080 \
  -e JWT_SECRET_KEY=secret \
  -e ADMIN_USERNAME=admin \
  -e ADMIN_PASSWORD=password \
  -e XRAY_SUBSCRIPTION_URL_PREFIX=https://localhost:8080 \
  my-vpn
```

## License

MIT