# A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only
FROM alpine:stable-slim
RUN apk update && apk install -y nginx openssl && rm -rf /var/lib/cache/apk/*
RUN echo "ssl_protocols TLSv1.2 TLSv1.3;" >> /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]