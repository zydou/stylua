FROM buildpack-deps:trusty AS build
ARG TARGET=x86_64-unknown-linux-gnu
COPY src /app
WORKDIR /app
RUN if [ "$TARGET" = "aarch64-unknown-linux-gnu" ]; then \
    apt-get update -y; \
    apt-get install -y gcc-aarch64-linux-gnu; \
    fi
RUN sh -c "$(curl -sSLfk https://sh.rustup.rs)" -- --default-toolchain nightly -y --no-modify-path --target "$TARGET" && \
    /root/.cargo/bin/cargo build --locked --release --all-features --target "$TARGET" && \
    cp "target/$TARGET/release/stylua" /usr/local/bin/stylua
FROM scratch
COPY --from=build /usr/local/bin/stylua /stylua
