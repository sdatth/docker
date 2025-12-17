#!/bin/sh
set -e

PUBLIC_IP=$(curl -s https://api.ipify.org || curl -s https://ifconfig.me || echo "unknown")
HOST_HOSTNAME=${HOST_HOSTNAME:-unknown}

export PUBLIC_IP HOST_HOSTNAME

rm -f /etc/nginx/conf.d/default.conf

envsubst '${PUBLIC_IP} ${HOST_HOSTNAME}' \
  < /etc/nginx/conf.d/site.conf.template \
  > /etc/nginx/conf.d/site.conf

exec nginx -g "daemon off;"

