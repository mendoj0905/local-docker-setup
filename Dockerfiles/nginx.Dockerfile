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

FROM nginx:alpine

RUN mkdir -p /etc/nginx/ssl && \ 
    mkdir -p /usr/local/var/www && \
    mkdir /etc/nginx/logs && \
    touch /etc/nginx/logs/error.log

COPY --from=builder /app/local-gateway/src/main/nginx/local-nginx.conf  /etc/nginx/nginx.conf
COPY --from=builder /app/local-gateway/src/main/nginx/local-web.core.merrillcorp.com.conf  /etc/nginx/servers/local-web.core.merrillcorp.com.conf
COPY --from=builder /app/local-gateway/src/main/nginx/core.merrillcorp.com.crt  /etc/nginx/ssl/core.merrillcorp.com.crt
COPY --from=builder /app/local-gateway/src/main/nginx/core.merrillcorp.com.key  /etc/nginx/ssl/core.merrillcorp.com.key
COPY --from=builder /app/local-gateway/src/main/nginx/us2.merrillcorp.com.crt /etc/nginx/ssl/us2.merrillcorp.com.crt
COPY --from=builder /app/local-gateway/src/main/nginx/us2.merrillcorp.com.key /etc/nginx/ssl/us2.merrillcorp.com.key
COPY --from=builder /app/local-gateway/src/main/nginx/mime.types  /etc/nginx/mime.types

# update nginx config to work with docker
RUN sed -i "s|127\.0\.0\.1:8085|gateway:8085|g" /etc/nginx/servers/local-web.core.merrillcorp.com.conf
RUN sed -i "s|127\.0\.0\.1|host.docker.internal|g" /etc/nginx/servers/local-web.core.merrillcorp.com.conf

COPY --from=builder /app/local-gateway/src/main/nginx/50x.html /usr/local/var/www/50x.html
COPY --from=builder /app/local-gateway/src/main/nginx/404.html /usr/local/var/www/404.htmldoc

CMD [ "nginx", "-g", "daemon off;" ]