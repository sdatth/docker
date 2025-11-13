#!/bin/bash

docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once \
  --cleanup \
  --include-stopped
