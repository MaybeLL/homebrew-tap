# MaybeLL Homebrew tap

Install [Workbox](https://github.com/MaybeLL/workbox-cli), a Go CLI for reusable configurations and local Git workspaces:

```sh
brew install MaybeLL/tap/workbox
workbox --version
```

Workbox 0.2.0 adds optional MySQL configuration storage behind the same interface as SQLite. SQLite remains the default and existing databases stay compatible. To select MySQL, set `WORKBOX_DB=mysql` and either `WORKBOX_MYSQL_DSN_FILE` or `WORKBOX_MYSQL_DSN` for an existing dedicated database. See the [storage setup and migration guide](https://github.com/MaybeLL/workbox-cli/blob/main/docs/storage.md). JSON export/import transfers configurations between backends; uninstall preserves both local and remote configuration.

Install the optional `workbox` agent skill bundled with Workbox 0.1.1 or later:

```sh
workbox skill install
```

This installs into the shared user directory `~/.agents/skills/workbox`, supported by Codex, Cursor and OpenCode. In Codex, invoke it as `$workbox`. The executable includes the instructions, so this step works offline. Repeating it preserves identical installations and reports a conflict for different existing content.

Workbox 0.1.3+ writes a root `AGENTS.md` in each new workspace. It directs agents to this one global skill for initialization and Git worktree development; no workspace-local `workbox-dev` skill is installed. For sessions started inside a nested repository/worktree, explicitly load the workspace entry point and global skill. Existing repository instructions and existing workspaces are preserved.

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
