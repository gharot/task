FROM alpine:3.12.1

RUN apk update && \
    apk add curl postgresql-client==12.6-r0 && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl && \
    chmod a+x ./kubectl && \
    mv ./kubectl /usr/local/bin/

COPY ./rds-bootstrapper/bootstrap.sh /opt/

RUN chmod +x /opt/bootstrap.sh
