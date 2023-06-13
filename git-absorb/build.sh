#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --locked --root ${PREFIX} --path .

install -Dd ${PREFIX}/etc/bash_completion.d ${PREFIX}/share/fish/vendor_completions.d ${PREFIX}/share/zsh/site-functions
install -Dm 644 Documentation/git-absorb.1 ${PREFIX}/share/man/man1/git-absorb.1
git-absorb --gen-completions bash > ${PREFIX}/etc/bash_completion.d/git-absorb
git-absorb --gen-completions fish > ${PREFIX}/share/fish/vendor_completions.d/git-absorb.fish
git-absorb --gen-completions zsh > ${PREFIX}/share/zsh/site-functions/_git-absorb

# strip debug symbols
"$STRIP" "$PREFIX/bin/${PKG_NAME}"

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
