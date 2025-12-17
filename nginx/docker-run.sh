#!/bin/bash
docker run -d -p 8080:80 \
  -e HOST_HOSTNAME=$(hostname) \
  -n nginx \
nginxmod
