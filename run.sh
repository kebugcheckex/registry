#!/usr/bin/env bash

set -e

if [ ! -d certs ] || [ ! -f certs/registry.crt ] || [ ! -f certs/registry.key ]
then
    echo "Error: certificate files not found."
    echo "Please place registry.crt and registry.key in certs directory."
    exit 1
fi    

docker run \
    --detach \
    --restart=always \
    --name registry \
    -v "$(pwd)"/certs:/certs \
    -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
    -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
    -p 443:443 \
    registry:2

