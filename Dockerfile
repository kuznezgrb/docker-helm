FROM alpine:3.12

RUN apk add --update --no-cache ca-certificates git python3
RUN apk update && apk add bash openssl

RUN apk add --update --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.4/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

RUN apk add --update -t deps curl tar gzip
RUN curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

RUN mkdir /usr/local/gc/

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /usr/local/gc/google-cloud-sdk.tar.gz

RUN  tar -C /usr/local/gc/ -xvf /usr/local/gc/google-cloud-sdk.tar.gz
RUN /usr/local/gc/google-cloud-sdk/install.sh

ENV PATH $PATH:/usr/local/gc/google-cloud-sdk/bin

RUN helm plugin install https://github.com/hypnoglow/helm-s3.git
RUN helm plugin install https://github.com/hayorov/helm-gcs.git
RUN helm repo add "stable" "https://charts.helm.sh/stable" --force-update
