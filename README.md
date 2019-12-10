# Local Docker Development Setup

This repo is to quickly spin up your local development setup in a few simple commands using Docker. Builds and starts up nginx, local-gateway, and config-server containers. 

- https://github.com/MerrillCorporation/local-gateway
- https://github.com/MerrillCorporation/config-server
- https://github.com/MerrillCorporation/javelin-configurations

## How to run 

1. Install Docker
2. Setup ssh keys with github
3. Copy `id_rsa` file to this repo
  - Mac `cp ~/.ssh/id_rsa`
  - Windows 
4. Run `docker-compose up -d`