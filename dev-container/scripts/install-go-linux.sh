#!/bin/bash
###########
# GoLang
###########
GO_VERSION="1.15.5"
GOLANG_TAR=linux-amd64.tar.gz
GOLANG_DOWNLOAD_URL=https://dl.google.com/go/go${GO_VERSION}.${GOLANG_TAR}
curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz
tar -C /usr/local -xzf golang.tar.gz
rm golang.tar.gz
ln -sf /usr/local/go/bin/* /usr/local/bin
rm -rf ${GOLANG_TAR}

###########
# GRPC
###########
PROTOBUF_VERSION=3.14.0
PROTOBUF_ZIP=protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
PROTOBUF_DOWNLOAD_URL=https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/${PROTOBUF_ZIP}
curl -fsSL ${PROTOBUF_DOWNLOAD_URL} -o ${PROTOBUF_ZIP}
unzip -q -o ${PROTOBUF_ZIP} bin/protoc -d /usr/local
chmod 777 /usr/local/bin/protoc
rm ${PROTOBUF_ZIP}

# protoc --go_out=plugins=grpc:./proto -I./proto test.proto

