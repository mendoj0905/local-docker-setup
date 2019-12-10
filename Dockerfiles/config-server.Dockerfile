FROM ubuntu as gitclone

WORKDIR /app
COPY ./id_rsa /app

RUN apt-get update && \
    apt-get -y install git && \
    eval `ssh-agent -s` && \
    mkdir ~/.ssh && \
    mv id_rsa ~/.ssh/ && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    cat /etc/ssh/ssh_config && \
    chmod go-w /root && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-add ~/.ssh/id_rsa
RUN git clone git@github.com:MerrillCorporation/config-server.git
RUN git clone git@github.com:MerrillCorporation/javelin-configurations.git

FROM gradle:5.2.1-jdk11-slim

ENV CONFIG_REPO_PATH="/app/javelin-configurations"
ENV ACTIVE_PCF_ENVIRONMENT="devb"
ENV SPRING_PROFILES_ACTIVE="urls,events,dev,local"
ENV TARGET_DOMAIN="apps.us2.devb.foundry.mrll.com"
ENV API_URL="http://localhost:8081"
ENV TARGET_ENVIRONMENT="local"
ENV TARGET_SERVICE="localhost:8200"

USER root

WORKDIR /app

COPY --from=gitclone /app /app

WORKDIR /app/config-server

EXPOSE 8888

CMD [ "./gradlew", "bootRun" ]