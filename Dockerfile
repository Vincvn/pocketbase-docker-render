FROM alpine:latest as downloader

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG VERSION
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.8.0/pocketbase_0.8.0_linux_amd64.zip \
    && unzip pocketbase_0.8.0_linux_amd64.zip \
    && chmod +x /pocketbase

FROM alpine:3
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 8090

COPY --from=downloader /pocketbase /usr/local/bin/pocketbase
ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data", "--publicDir=/pb_public"]
