# MaybeLL Homebrew tap

Install [Workbox](https://github.com/MaybeLL/workbox-cli), a Go CLI for reusable configurations and local Git workspaces:

```sh
brew install MaybeLL/tap/workbox
workbox --version
```

Install the optional Codex skill bundled with Workbox 0.1.1 or later:

```sh
workbox skill install
```

This installs into `~/.agents/skills/workbox` for use as `$workbox` in Codex. The executable includes the instructions, so this step works offline. Repeating it preserves identical installations and reports a conflict for different existing content.

Upgrade:

```sh
brew update
brew upgrade MaybeLL/tap/workbox
```

Uninstall the CLI and its unmodified companion skills together with Workbox 0.1.2 or later:

```sh
workbox uninstall --dry-run
workbox uninstall
```

This asks Homebrew to remove all installed Workbox versions and removes the skill locations recorded by the installer. Configuration databases and existing workspaces are preserved. Modified skills stop uninstall before deletion. Custom paths installed with 0.1.1 can be registered after upgrading using `workbox skill install --path DIR`, or passed once using `workbox uninstall --skill-path DIR`.

Native bottles are provided for Apple Silicon and Intel Macs on macOS 15 or later. Other supported Homebrew systems build from the pinned source release with Go as a build dependency. Git is required at runtime. No Python installation is needed.

Check the installed version:

```sh
workbox --version --format json
```

Both native bottles run the configuration and workspace smoke checks in release CI. Maintainers can also run `brew test MaybeLL/tap/workbox`; Homebrew's test framework requires current Command Line Tools on macOS even when the application itself was installed from a bottle.

Release binaries, checksums, bottle metadata and guides are published at [GitHub Releases](https://github.com/MaybeLL/workbox-cli/releases). Report bugs in the [Workbox issue tracker](https://github.com/MaybeLL/workbox-cli/issues).
