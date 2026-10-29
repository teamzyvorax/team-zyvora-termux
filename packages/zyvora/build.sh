TERMUX_PKG_HOMEPAGE=https://github.com/teamzyvorax/team-zyvora-termux
TERMUX_PKG_DESCRIPTION="ZYVORA cyberpunk theme and terminal launcher for Termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Team Zyvora"
TERMUX_PKG_VERSION=1.0.1
TERMUX_PKG_REVISION=2
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_DEPENDS="zsh, git"

# This package has no upstream source archive. The Termux license installer
# searches TERMUX_PKG_SRCDIR, so explicitly create the source tree and place
# the package's MIT license there.
termux_step_get_source() {
    mkdir -p "$TERMUX_PKG_SRCDIR"
    cp "$TERMUX_PKG_BUILDER_DIR/LICENSE" "$TERMUX_PKG_SRCDIR/LICENSE"
}

termux_step_make_install() {
    mkdir -p "$TERMUX_PREFIX/bin" "$TERMUX_PREFIX/share/zyvora"

    cat > "$TERMUX_PREFIX/bin/zyvora" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -e

THEME="$PREFIX/share/zyvora/theme.zsh"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.zyvora-backup"
MARKER="# ZYVORA TERMUX PACKAGE"

install_theme() {
    if [ -f "$ZSHRC" ] && ! grep -Fq "$MARKER" "$ZSHRC"; then
        cp "$ZSHRC" "$BACKUP"
    fi
    if ! grep -Fq "$MARKER" "$ZSHRC" 2>/dev/null; then
        {
            printf '\n%s\n' "$MARKER"
            printf 'source "%s"\n' "$THEME"
        } >> "$ZSHRC"
    fi
}

remove_theme() {
    if [ -f "$BACKUP" ]; then
        cp "$BACKUP" "$ZSHRC"
        rm -f "$BACKUP"
        printf 'ZYVORA theme removed; original .zshrc restored.\n'
    elif [ -f "$ZSHRC" ]; then
        sed -i '/# ZYVORA TERMUX PACKAGE/d' "$ZSHRC"
        sed -i '\|source .*share/zyvora/theme.zsh|d' "$ZSHRC"
        printf 'ZYVORA theme lines removed.\n'
    fi
}

case "${1:-start}" in
    install|start)
        install_theme
        printf '\033[38;5;141mZYVORA ULTRA\033[0m \033[38;5;51mTERMUX\033[0m\n'
        printf '\033[38;5;51m────────────────────────────────────\033[0m\n'
        exec zsh
        ;;
    remove|uninstall)
        remove_theme
        ;;
    status)
        if grep -Fq "$MARKER" "$ZSHRC" 2>/dev/null; then
            printf 'ZYVORA theme: installed\n'
        else
            printf 'ZYVORA theme: not installed\n'
        fi
        ;;
    *)
        printf 'Usage: zyvora [start|install|remove|status]\n'
        exit 2
        ;;
esac
EOF
    chmod 755 "$TERMUX_PREFIX/bin/zyvora"

    cat > "$TERMUX_PREFIX/share/zyvora/theme.zsh" <<'EOF'
# ZYVORA TERMUX PACKAGE THEME
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
  print -P '%F{51}'
  print -P '╔══════════════════════════════════════╗'
  print -P '║          Z Y V O R A                 ║'
  print -P '║        U L T R A  T E R M U X        ║'
  print -P '╚══════════════════════════════════════╝'
  print -P '%f'
  print -P '%F{51}ZYVORA ULTRA TERMINAL%f'
  print -P ''
}

PROMPT='%F{51}┌─[%f%F{141}ZYVORA%f@%F{51}TERMUX%f]%F{51}─[%f%F{141}%~%f%F{51}]%f$(zyvora_git_branch)\n%F{51}└─>%f '

if [[ -z "$ZYVORA_SESSION_STARTED" ]]; then
  export ZYVORA_SESSION_STARTED=1
  zyvora_banner
fi
EOF
}
