FROM alpine:3.19

# Install v2ray and dependencies
RUN apk add --no-cache \
    v2ray \
    ca-certificates \
    tzdata \
    curl \
    openssl

ENV TZ=Asia/Tehran

RUN mkdir -p /etc/v2ray /var/log/v2ray

COPY config.json.template /etc/v2ray/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]