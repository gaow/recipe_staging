#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

gem install -N -l -V --ignore-dependencies parallel-${PKG_VERSION}.gem
gem unpack parallel-${PKG_VERSION}.gem
