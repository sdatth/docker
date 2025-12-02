#!/bin/bash

docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e DOCKER_API_VERSION=1.44 \
  containrrr/watchtower \
  --run-once \
  --cleanup \
  --include-stopped
