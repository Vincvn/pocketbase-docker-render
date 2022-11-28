FROM alpine:latest

ARG PB_VERSION=0.8.0

RUN apk add --no-cache \
    unzip \
    ca-certificates

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

ADD https://downloads.rclone.org/rclone-current-linux-amd64.zip /tmp/rclone.zip
RUN unzip /tmp/rclone.zip /tmp/rclone

RUN sudo cp /tmp/rclone/rclone /usr/bin/
RUN sudo chown root:root /usr/bin/rclone
RUN sudo chmod 755 /usr/bin/rclone

EXPOSE 8080

# start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
