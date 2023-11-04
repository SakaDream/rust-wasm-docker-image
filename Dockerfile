FROM rust:slim

LABEL "org.opencontainers.image.title"="Rust WASM"
LABEL "org.opencontainers.image.description"="Rust WASM Docker Image with rust, nodejs, nvm, yarn, pnpm, cargo-generate, trunk, git and deno pre-installed"
LABEL "org.opencontainers.image.authors"="SakaDream"

RUN set -ex \
    && apt-get update \
    && apt-get install -y curl ca-certificates pkg-config make git unzip libssl-dev cmake protobuf-compiler --no-install-recommends \
    && cargo install cargo-generate \
    && cargo install trunk \
    && cargo install deno --locked \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install --lts \
    && nvm use --lts \
    && corepack enable \
    && rustup target add wasm32-unknown-unknown \
    && npm cache verify \
    && yarn cache clean --all \
    && rm -rf ${CARGO_HOME}/git/* \
    && rm -rf ${CARGO_HOME}/registry/* \
    && rm -rf /var/lib/apt/lists/* \
    && rustup --version \
    && rustc --version \
    && cargo --version \ 
    && cargo-generate --version \
    && trunk --version \
    && node -v \
    && npm -v \
    && yarn -v \
    && pnpm -v \
    && deno --version \
    && mkdir /app

WORKDIR /app
