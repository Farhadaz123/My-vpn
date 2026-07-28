# Marzban Panel on Railway - Complete Setup

## 1. Create Dockerfile

```dockerfile
FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gcc git libffi-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/Gozargah/Marzban.git .

RUN pip install --no-cache-dir -r requirements/base.txt

ENV UVICORN_HOST=0.0.0.0
ENV UVICORN_PORT=8080
ENV SQLALCHEMY_DATABASE_URL=sqlite:///./marzban.db

EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
```

## 2. Railway Configuration (railway.yml)

```yaml
name: marzban-vpn
services:
  marzban:
    build: .
    ports:
      - internal: 8080
        public: true
    env:
      - key: UVICORN_HOST
        value: "0.0.0.0"
      - key: UVICORN_PORT
        value: "8080"
      - key: SQLALCHEMY_DATABASE_URL
        value: "sqlite:///./marzban.db"
      - key: JWT_SECRET_KEY
        value: "your-super-secret-jwt-key-change-this"
      - key: ADMIN_USERNAME
        value: "admin"
      - key: ADMIN_PASSWORD
        value: "your-secure-password"
      - key: XRAY_SUBSCRIPTION_URL_PREFIX
        value: "https://your-domain.up.railway.app"
```

## 3. Deployment Steps

1. **Push to GitHub:**
```bash
git add -A
git commit -m "Add Marzban VPN Panel"
git push origin master
```

2. **Deploy on Railway:**
- Go to railway.app → New Project → Deploy from GitHub
- Select your repo
- Add variables in Settings → Variables:
  - `JWT_SECRET_KEY` = random 32+ chars
  - `ADMIN_USERNAME` = admin
  - `ADMIN_PASSWORD` = secure password
  - `XRAY_SUBSCRIPTION_URL_PREFIX` = your Railway domain

3. **Redeploy**

## 4. Access Panel

After deploy, visit: `https://your-app.up.railway.app`

Login with:
- Username: admin
- Password: (your ADMIN_PASSWORD)

## 5. Create User & Connect

1. Dashboard → Users → Add User
2. Select protocols (VLESS, VMess, Trojan, etc.)
3. Copy subscription link or scan QR
4. Import in V2RayNG/V2RayN/Stash
5. Connect ✅

## Supported Protocols

- **VLESS** (XTLS-Reality, TLS, WebSocket)
- **VMess** (WebSocket + TLS)
- **Trojan** (TLS, WebSocket)
- **Shadowsocks** (2022-blake3-aes-128-gcm, etc.)
- **TUIC** (v5)

## Troubleshooting

- Check logs in Railway dashboard
- If database issues: delete and redeploy
- For custom domain: add in Railway Networking settings