ARG BASE_IMAGE_TAG=3.12

FROM alpine:$BASE_IMAGE_TAG

# Make sure in-image args are defined after base
ARG KUBECTL_VERSION=1.22.0

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

ENTRYPOINT ["kubectl"]