# ZYVORA TERMUX

A NAGI × ZYVORA ULTRA cyberpunk terminal theme packaged as a real Termux `.deb` package, with 28 color themes and 102 banner designs (including two giant ASCII wordmarks).

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

## 102 banner designs

The first two banners are large ASCII wordmarks. The remaining 100 designs use 10 distinct layouts combined with 10 identity/color/motif profiles. The default is random on each new shell.

```bash
zyvora banner             # show saved selection (random by default)
zyvora banner random      # random banner every new shell
zyvora banner 1            # save giant ZYVORA wordmark
zyvora banner 2            # save giant NAGI wordmark
zyvora banner 37           # save a different layout/profile
zyvora banner preview 24   # preview without changing saved selection
zyvora banner list         # show banner command help
```

Selection is saved in `~/.config/zyvora/banner`.

## UI features

- Old-school hacker / pixel terminal aesthetic
- 102 banner designs: 2 giant wordmarks + 100 layout/profile combinations
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
zyvora styles          # show all 28 color themes
zyvora banner random   # random banner on each new shell
zyvora banner 1        # select a banner by number
zyvora banner preview 24 # preview a banner
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
