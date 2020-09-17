#!/bin/bash
cd local-gateway 
docker-compose down
cd ..

docker-compose down
docker image prune

rm -rf config-server ds1-configurations local-gateway
