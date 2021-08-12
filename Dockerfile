ARG ALPINE_VER=3.12
ARG KUBECTL_VER=1.18.0

FROM alpine:$ALPINE_VER

ADD config.env /

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

ENTRYPOINT ["kubectl"]