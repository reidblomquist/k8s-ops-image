ARG BASE_IMAGE_TAG=3.12

FROM alpine:$BASE_IMAGE_TAG

# Make sure in-image args are defined after base
ARG KUBECTL_VERSION=1.22.0
ARG HELM_VERSION=3.6.3
ARG KUBELOGIN_VERSION=0.0.10
ARG AZCLI_VERSION=2.27.1

# install azcli
RUN \
  apk update && \
  apk add bash py-pip && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python3-dev make && \
  pip --no-cache-dir install -U pip && \
  pip --no-cache-dir install azure-cli==${AZCLI_VERSION} && \
  apk del --purge build

# install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# install helm
RUN wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

# install kubelogin
RUN wget -q https://github.com/Azure/kubelogin/releases/download/v${KUBELOGIN_VERSION}/kubelogin-linux-amd64.zip \
    && unzip kubelogin-linux-amd64.zip \
    && mv ./bin/linux_amd64/kubelogin /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubelogin \
    && rm -rf ./kubelogin-linux-amd64.zip \
    && rm -rf ./bin