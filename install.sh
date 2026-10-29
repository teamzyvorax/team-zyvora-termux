#!/data/data/com.termux/files/usr/bin/bash
set -e

CYAN='\033[38;5;51m'
PURPLE='\033[38;5;141m'
RESET='\033[0m'

printf "${PURPLE}Installing ZYVORA TERMUX THEME...${RESET}\n"
pkg update -y
pkg install -y zsh git curl figlet

ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then cp "$ZSHRC" "$HOME/.zshrc.zyvora-backup"
fi

cat > "$ZSHRC" <<'EOF'
# ZYVORA TERMUX THEME
autoload -Uz colors && colors
setopt PROMPT_SUBST

export EDITOR=nano
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

if [[ -z "$ZYVORA_SESSION_STARTED" ]]; then
  export ZYVORA_SESSION_STARTED=1
  zyvora_banner
fi
EOF

if command -v chsh >/dev/null 2>&1; then
  chsh -s zsh 2>/dev/null || true
fi

printf "${CYAN}✓ ZYVORA TERMUX THEME installed.${RESET}\n"
printf "${PURPLE}Restart Termux or run: exec zsh${RESET}\n"
printf "Backup: $HOME/.zshrc.zyvora-backup\n"
