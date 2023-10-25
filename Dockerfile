FROM buildpack-deps:trusty AS build
ARG VERSION=0.18.2
ARG TARGET=x86_64-unknown-linux-gnu
WORKDIR /app
RUN if [ "$TARGET" = "aarch64-unknown-linux-gnu" ]; then \
    apt-get update -y; \
    apt-get install -y gcc-aarch64-linux-gnu; \
    fi
RUN sh -c "$(curl -sSLfk https://sh.rustup.rs)" -- --profile minimal --default-toolchain nightly -y --no-modify-path --target "$TARGET" && \
    curl -sSLfk -o src.tar.gz "https://github.com/JohnnyMorganz/StyLua/archive/refs/tags/v$VERSION.tar.gz" && \
    tar -xzf src.tar.gz --strip-components=1 && \
    /root/.cargo/bin/cargo build --locked --release --all-features --target "$TARGET" && \
    cp "target/$TARGET/release/stylua" /usr/local/bin/stylua && \
    rm -rf /app
FROM scratch
COPY --from=build /usr/local/bin/stylua /stylua
