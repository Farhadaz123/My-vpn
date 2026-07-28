FROM alpine:3.19

# Install dependencies only (V2Ray downloaded on startup)
RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    curl \
    unzip

ENV TZ=Asia/Tehran

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]