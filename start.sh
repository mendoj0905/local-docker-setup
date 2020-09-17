#!/bin/bash
cd local-gateway
docker-compose up -d 
cd ..

docker-compose up -d
