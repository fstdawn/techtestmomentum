FROM alpine:latest

RUN apk add --update curl sudo

RUN curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v0.26.0/opa_linux_amd64 \
    && chmod 755 ./opa \
    && sudo mv ./opa /usr/local/bin/opa
ENTRYPOINT ["/bin/sh", "-c"]
