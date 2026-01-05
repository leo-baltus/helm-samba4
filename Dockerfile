FROM alpine:latest

ARG VERSION=x.y

RUN apk add --update \
    samba-common-tools=~VERSION \
    samba-client=~VERSION \
    samba-server=~VERSION \
    && rm -rf /var/cache/apk/*

ADD samba4/scripts/k8s.sh /scripts/k8s.sh

EXPOSE 445/tcp

ENTRYPOINT [ "/scripts/k8s.sh" ]
CMD []
