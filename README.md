# ZYVORA TERMUX

A Zyvora Ultra cyberpunk terminal theme packaged as a real Termux `.deb` package.

## Install the ZYVORA repository

The package is distributed through a custom APT repository published by GitHub Pages.

```bash
pkg update -y && pkg install -y curl
curl -fsSL https://raw.githubusercontent.com/teamzyvorax/team-zyvora-termux/main/install-repo.sh -o $PREFIX/tmp-zyvora-repo.sh
bash $PREFIX/tmp-zyvora-repo.sh
pkg update
pkg install zyvora
```

Then launch:

```bash
zyvora
```

## What `zyvora` does

- Installs/activates the ZYVORA Zsh theme
- Neon cyan/purple prompt
- ZYVORA ULTRA startup banner
- Current working directory
- Git branch display
- Backs up an existing `.zshrc`
- `zyvora status` checks the theme
- `zyvora remove` restores the backup when available

## Package development

The package recipe lives at `packages/zyvora/build.sh` and is built with the official Termux package build system. GitHub Actions builds the `.deb`, generates the APT index, and publishes the repository to GitHub Pages. Termux's package build system supports `build-package.sh` and produces `.deb` packages for distribution. citeturn0search0turn0search2

## Important

`pkg install zyvora` will only work after the custom ZYVORA APT repository has been added and the GitHub Pages deployment has completed.

## Project

**Team ZyvoraX — ZYVORA TERMUX**
