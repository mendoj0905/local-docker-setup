# Local Docker Development Setup

This repo is to quickly spin up your local development setup in a few simple commands using Docker. Builds and starts up nginx, local-gateway, and config-server containers. 

- https://github.com/MerrillCorporation/local-gateway
- https://github.com/MerrillCorporation/config-server
- https://github.com/MerrillCorporation/javelin-configurations

## Perequisites 

1. Install Docker (https://docs.docker.com/install/)
2. Setup ssh keys with github (https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)

## Run Containers
1. Copy `id_rsa` file to directory
    - Mac `cp ~/.ssh/id_rsa`
    - Windows 
2. Run `docker-compose up -d`

## Notes

### Cutover 

During cutover `config-server.Dockerfile` will need to be changed if changes haven't been pushed. 

`ENV TARGET_DOMAIN="apps.us2.devb.foundry.mrll.com"`