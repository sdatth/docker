# Run temporary container
docker run -d --rm -v $HOME/docker/authelia/config/configuration.yml:/config/configuration.yml \
-v $HOME/docker/authelia/secrets:/config/secrets \
--name tempauth authelia/authelia:latest sleep infinity

# Generate # value for your password
docker exec tempauth authelia crypto hash generate --config "/config/configuration.yml" \
--password 'authelia' | grep -oP '(?<=Digest: ).*'

# Generate 3 secrets and put them in the docker compose enviroment variable
docker exec tempauth authelia crypto rand --length 64 --charset alphanumeric | \
grep -oP '(?<=Random Value: ).*'

# Add this in your traefik config middleware section

authelia:
  forwardauth:
    address: http://authelia:9091/api/verify?rd=https://auth.server.example.com:443
    trustForwardHeader: true
    authResponseHeaders: Remote-User,Remote-Groups,Remote-Name,Remote-Email

# Add this in the app labels to have authelia to authenticate
- "traefik.http.routers.<router>.middlewares=authelia@file"
