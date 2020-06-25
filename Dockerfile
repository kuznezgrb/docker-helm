FROM alpine:3.12

RUN apk add --update --no-cache ca-certificates git
RUN apk update && apk add bash openssl

RUN apk add --update -t deps curl tar gzip
RUN curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh