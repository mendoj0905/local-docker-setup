#!/bin/bash
cd local-gateway 
docker-compose down
cd ..

docker-compose down

# docker kill $(docker ps -q)