FROM rust:slim

LABEL "org.opencontainers.image.title"="Rust WASM"
LABEL "org.opencontainers.image.description"="Rust WASM Docker Image with wasm-pack, cargo generate, yarn, git, deno and miniserve pre-installed"
LABEL "org.opencontainers.image.authors"="SakaDream"

RUN set -ex \
    && apt-get update \
    && apt-get install -y curl ca-certificates pkg-config libssl-dev git unzip --no-install-recommends \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y nodejs yarn --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && cargo install wasm-pack cargo-generate \
    && curl -fsSL https://deno.land/x/install/install.sh | sh \
    && mkdir /miniserve \
    && curl -sL https://github.com/svenstaro/miniserve/releases/latest/download/miniserve-linux-x86_64 -o /miniserve/miniserve \
    && chmod +x /miniserve/miniserve

ENV PATH="/miniserve:${PATH}"
