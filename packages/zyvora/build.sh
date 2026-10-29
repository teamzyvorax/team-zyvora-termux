TERMUX_PKG_HOMEPAGE=https://github.com/teamzyvorax/team-zyvora-termux
TERMUX_PKG_DESCRIPTION="ZYVORA cyberpunk theme and terminal launcher for Termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Team Zyvora"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SKIP_SRC_CHECK=true

termux_step_make_install() {
    mkdir -p "$TERMUX_PREFIX/bin"
    mkdir -p "$TERMUX_PREFIX/share/zyvora"

    cat > "$TERMUX_PREFIX/bin/zyvora" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -e

CYAN='\033[38;5;51m'
PURPLE='\033[38;5;141m'
RESET='\033[0m'

printf "${PURPLE}ZYVORA ULTRA${RESET} ${CYAN}TERMUX${RESET}\n"
printf "${CYAN}────────────────────────────────────${RESET}\n"
printf "${PURPLE}Theme package: 1.0.0${RESET}\n\n"

if command -v zsh >/dev/null 2>&1; then
    exec zsh
fi

printf "Zsh is not installed. Install it with: pkg install zsh\n"
EOF
    chmod 755 "$TERMUX_PREFIX/bin/zyvora"

    cat > "$TERMUX_PREFIX/share/zyvora/theme.zsh" <<'EOF'
# ZYVORA TERMUX theme
autoload -Uz colors && colors
setopt PROMPT_SUBST

export ZYVORA_THEME='ULTRA'

function zyvora_git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -n "$branch" ]] && print " %F{141}[$branch]%f"
}

function zyvora_banner() {
  clear
  if command -v figlet >/dev/null 2>&1; then
    print -P '%F{51}'
    figlet -f small 'ZYVORA'
    print -P '%f'
  else
    print -P '%F{141}╔══════════════════════════════════╗%f'
    print -P '%F{141}║          Z Y V O R A             ║%f'
    print -P '%F{141}║        T E R M U X               ║%f'
    print -P '%F{141}╚══════════════════════════════════╝%f'
  fi
  print -P '%F{51}ZYVORA ULTRA TERMINAL%f'
  print -P ''
}

PROMPT='%F{51}┌─[%f%F{141}ZYVORA%f@%F{51}TERMUX%f]%F{51}─[%f%F{141}%~%f%F{51}]%f$(zyvora_git_branch)\n%F{51}└─>%f '
EOF
}
