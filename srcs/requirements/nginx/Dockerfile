# A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only
FROM debian:buster

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
	apt-get update && \
	apt-get install -y nginx && \
	apt-get install -y openssl

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=BR/ST=Minas Gerais/L=Montes Claros/O=42FR/OU=42SP/CN=wjuneo-f.42.sp" \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt

RUN echo "<h1>NGINX with TLSv1.2 or TLSv1.3 only</h1>" > /var/www/html/index.html

COPY /conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

