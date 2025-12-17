FROM nginx:alpine

RUN apk add --no-cache curl gettext

COPY site.conf.template /etc/nginx/conf.d/site.conf.template
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

