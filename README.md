# MaybeLL Homebrew tap

Install [Workbox](https://github.com/MaybeLL/workbox-cli), a Go CLI for reusable configurations and local Git workspaces:

```sh
brew install MaybeLL/tap/workbox
workbox --version
```

Upgrade:

```sh
brew update
brew upgrade MaybeLL/tap/workbox
```

Native bottles are provided for Apple Silicon and Intel Macs on macOS 15 or later. Other supported Homebrew systems build from the pinned source release with Go as a build dependency. Git is required at runtime. No Python installation is needed.

Verify an installed copy without touching your configuration:

```sh
brew test MaybeLL/tap/workbox
```

Release binaries, checksums, bottle metadata and guides are published at [GitHub Releases](https://github.com/MaybeLL/workbox-cli/releases). Report bugs in the [Workbox issue tracker](https://github.com/MaybeLL/workbox-cli/issues).
