FROM python:3.11-slim

# نصب unzip و وابستگی‌ها
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gcc git libffi-dev libssl-dev unzip \
    && rm -rf /var/lib/apt/lists/*

# نصب Xray-core
RUN curl -sL https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    unzip -o /tmp/xray.zip -d /usr/local/bin/ xray && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip

# نصب Marzban
WORKDIR /app
RUN git clone https://github.com/Gozargah/Marzban.git .
RUN pip install --no-cache-dir -r requirements/base.txt

# متغیرهای محیطی
ENV UVICORN_HOST=0.0.0.0
ENV UVICORN_PORT=8080
ENV SQLALCHEMY_DATABASE_URL=sqlite:////app/marzban.db
ENV XRAY_EXECUTABLE_PATH=/usr/local/bin/xray
ENV XRAY_ASSETS_PATH=/usr/local/share/xray

RUN mkdir -p /usr/local/share/xray

EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]