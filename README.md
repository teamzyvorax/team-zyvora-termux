# ZYVORA TERMUX

A Zyvora Ultra cyberpunk terminal theme for Termux.

## Install

```bash
pkg update -y && pkg install -y git curl
curl -fsSL https://raw.githubusercontent.com/teamzyvorax/team-zyvora-termux/main/install.sh -o $PREFIX/tmp-zyvora-install.sh
bash $PREFIX/tmp-zyvora-install.sh
```

Then restart Termux or run:

```bash
exec zsh
```

## Features

- ZYVORA ULTRA startup banner
- Neon cyan/purple terminal styling
- Custom ZYVORA prompt
- Current working directory
- Git branch display inside repositories
- Automatic Zsh setup
- Existing `.zshrc` backup
- No root required

## Restore

```bash
cp ~/.zshrc.zyvora-backup ~/.zshrc
exec zsh
```

## Project

**Team ZyvoraX — ZYVORA TERMUX**
