#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CGO_ENABLED=0
export LDFLAGS="-s -w"
export GO111MODULE=auto
go build -buildmode=pie -trimpath -o=${PREFIX}/bin/${PKG_NAME} -ldflags="${LDFLAGS}"