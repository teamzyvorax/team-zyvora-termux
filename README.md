# ZYVORA TERMUX

A ZYVORA ULTRA cyberpunk terminal theme packaged as a real Termux `.deb` package.

## Install

The package is distributed through the custom ZYVORA APT repository published by GitHub Pages.

```bash
pkg update -y && pkg install -y curl
curl -fsSL https://raw.githubusercontent.com/teamzyvorax/team-zyvora-termux/main/install-repo.sh -o $PREFIX/tmp-zyvora-repo.sh
bash $PREFIX/tmp-zyvora-repo.sh
pkg update
pkg install zyvora
```

Launch the terminal theme:

```bash
zyvora
```

## 28 built-in styles

```text
01 classic-hacker   08 skull-terminal    15 retro-dos       22 machine-mode
02 matrix           09 pixel-hacker      16 ghost-green     23 lab-terminal
03 cyber-neon       10 cyber-satellite   17 blue-protocol   24 cyber-web
04 purple-void      11 digital-core      18 quantum-purple  25 crt-hacker
05 red-alert        12 security-console  19 inferno         26 watcher
06 electric-storm   13 dark-ops          20 galaxy-terminal 27 ultra-boot
07 orange-cyber     14 network-grid      21 ai-core         28 zyvora-ultra
```

List them:

```bash
zyvora styles
```

Switch by number or name:

```bash
zyvora style 1
zyvora style matrix
zyvora style cyber-neon
zyvora style 25
zyvora style zyvora-ultra
```

The selected style is saved in `~/.config/zyvora/style` and survives new Termux sessions.

## UI features

- Old-school hacker / pixel terminal aesthetic
- Custom ZYVORA ULTRA ASCII banner
- 28 color + layout profiles
- Neon green, cyan, yellow, purple, red and blue variants
- Timestamp-ready status layout
- `zyvora@termux` custom prompt
- Current directory and Git branch display
- Startup system/status lines
- Lightweight: no heavy runtime framework
- Existing `.zshrc` is backed up before activation

## Commands

```bash
zyvora                 # start / activate
zyvora styles          # show all 28 styles
zyvora style <name>    # switch style
zyvora style <1-28>    # switch by number
zyvora status          # check installation + selected style
zyvora remove          # restore previous .zshrc when backed up
```

## Package development

The package recipe lives at `packages/zyvora/build.sh` and is built with the official Termux package build system. GitHub Actions builds the `.deb`, generates the APT index, and publishes the repository to GitHub Pages.

## Important

`pkg install zyvora` works through the custom ZYVORA APT repository after that repository has been added and its GitHub Pages deployment has completed. Official global Termux availability is a separate upstream package-submission process.

## Project

**Team ZyvoraX — ZYVORA TERMUX**
