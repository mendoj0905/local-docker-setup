#!/bin/bash
git clone git@github.com:MerrillCorporation/config-server.git
git clone git@github.com:MerrillCorporation/ds1-configurations.git
git clone git@github.com:MerrillCorporation/local-gateway.git

cd config-server
./gradlew dockerBuildImage
cd ..

cd local-gateway
./scripts/trust-certs.sh ./src/main/nginx/ssl
docker-compose build