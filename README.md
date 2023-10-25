# stylua

This repository uses GitHub Actions to build the `stylua` tool.

The binary releases of the [official repository](https://github.com/BurntSushi/stylua) are built on Ubuntu 20.04. It may cause [compatibility issues](https://github.com/JohnnyMorganz/StyLua/issues/806) on older systems. This repository builds the binary on Ubuntu 14.04.

In addition, this repo also directly downloads the `stylua` binary from the official and uploads it to GitHub Release of the following architectures for convenience:

- darwin-amd64
- darwin-arm64
