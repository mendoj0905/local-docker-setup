FROM ubuntu as builder

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
RUN git clone git@github.com:MerrillCorporation/local-gateway.git

FROM gradle:5.2.1-jdk11

USER root

WORKDIR /app

COPY --from=builder /app/local-gateway/ /app

EXPOSE 80 8085 8443

CMD [ "./gradlew", "bootRun" ]
