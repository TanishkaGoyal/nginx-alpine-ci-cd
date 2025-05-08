FROM alpine:latest

RUN apk update && apk add --no-cache nginx

RUN mkdir -p /var/www/html

COPY index.html /var/www/html/index.html

RUN sed -i 's|root /var/lib/nginx/html;|root /var/www/html;|' /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
