# Local Docker Development Setup (ONLY FOR MAC)

This repo is to quickly spin up your local development setup in a few simple commands using Docker. Builds and starts up nginx, local-gateway, and config-server containers. 

- https://github.com/MerrillCorporation/local-gateway
- https://github.com/MerrillCorporation/config-server
- https://github.com/MerrillCorporation/javelin-configurations

## Perequisites 

1. Install Docker (https://docs.docker.com/install/)
2. Setup ssh keys with github (https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
3. Setup Environmental Variables 

| Environment | Command  |
| ----------- |----------|
| Mac | export CONFIG_REPO_PATH=file:///Users/dkirber/dev/javelin/ds1-configurations<br/><br/> export ACTIVE_PCF_ENVIRONMENT=devb or devg or dev <br/><br/> export SPRING_PROFILES_ACTIVE=events,dev,local |

## Setup
- Run script `./setup.sh`

## Run Containers
- Run script `./start.sh`

## Clean up
- Run script `./cleanup.sh`

## Notes

### Cutover 

During cutover `config-server.Dockerfile` will need to be changed if changes haven't been pushed. 

`ENV TARGET_DOMAIN="apps.us2.devb.foundry.mrll.com"`