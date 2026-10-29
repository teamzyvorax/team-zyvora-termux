TERMUX_PKG_HOMEPAGE=https://github.com/teamzyvorax/team-zyvora-termux
TERMUX_PKG_DESCRIPTION="ZYVORA cyberpunk terminal theme with 28 themes and 102 randomized banner designs for Termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Team Zyvora"
TERMUX_PKG_VERSION=1.3.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_DEPENDS="zsh, git"

termux_step_get_source() {
    mkdir -p "$TERMUX_PKG_SRCDIR"
    cp "$TERMUX_PKG_BUILDER_DIR/LICENSE" "$TERMUX_PKG_SRCDIR/LICENSE"
    cp "$TERMUX_PKG_BUILDER_DIR/banners.zsh" "$TERMUX_PKG_SRCDIR/banners.zsh"
}

termux_step_make_install() {
    mkdir -p "$TERMUX_PREFIX/bin" "$TERMUX_PREFIX/share/zyvora" "$TERMUX_PREFIX/etc/zyvora"
    install -m 644 "$TERMUX_PKG_SRCDIR/banners.zsh" "$TERMUX_PREFIX/share/zyvora/banners.zsh"

    cat > "$TERMUX_PREFIX/bin/zyvora" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -e

THEME="$PREFIX/share/zyvora/theme.zsh"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.zyvora-backup"
CONFIG_DIR="$HOME/.config/zyvora"
STYLE_FILE="$CONFIG_DIR/style"
EFFECTS_FILE="$CONFIG_DIR/effects"
MARKER="# ZYVORA TERMUX PACKAGE"

styles() {
    cat <<'LIST'
1  classic-hacker
2  matrix
3  cyber-neon
4  purple-void
5  red-alert
6  electric-storm
7  orange-cyber
8  skull-terminal
9  pixel-hacker
10 cyber-satellite
11 digital-core
12 security-console
13 dark-ops
14 network-grid
15 retro-dos
16 ghost-green
17 blue-protocol
18 quantum-purple
19 inferno
20 galaxy-terminal
21 ai-core
22 machine-mode
23 lab-terminal
24 cyber-web
25 crt-hacker
26 watcher
27 ultra-boot
28 zyvora-ultra
LIST
}

banner_list() {
    local id layout variant
    local -a names=(NAGI-ULTRA ZYVORA-CORE MATRIX-GRID CYBER-NEON QUANTUM-VOID DARK-OPS PIXEL-ARCADE AI-SENTINEL RETRO-SHELL GALAXY-NODE)
    local -a layouts=(framed-console status-panel diamond-mark boxed-grid identity-card command-line pixel-block ascii-emblem retro-divider system-panel)
    printf '01  giant-zyvora\n02  giant-nagi-ultra\n'
    for ((id=3; id<=102; id++)); do
        layout=$(( (id - 3) % 10 ))
        variant=$(( (id - 3) / 10 ))
        printf '%02d  %-16s %s\n' "$id" "${names[$variant]}" "${layouts[$layout]}"
    done
}

install_theme() {
    mkdir -p "$CONFIG_DIR"
    [ -f "$STYLE_FILE" ] || printf 'zyvora-ultra\n' > "$STYLE_FILE"
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

normalize_style() {
    case "$1" in
        1|classic|hacker|classic-hacker) echo classic-hacker;;
        2|matrix) echo matrix;;
        3|cyber|cyber-neon) echo cyber-neon;;
        4|purple|purple-void) echo purple-void;;
        5|red|red-alert) echo red-alert;;
        6|storm|electric-storm) echo electric-storm;;
        7|orange|orange-cyber) echo orange-cyber;;
        8|skull|skull-terminal) echo skull-terminal;;
        9|pixel|pixel-hacker) echo pixel-hacker;;
        10|satellite|cyber-satellite) echo cyber-satellite;;
        11|digital|digital-core) echo digital-core;;
        12|security|security-console) echo security-console;;
        13|ops|dark-ops) echo dark-ops;;
        14|network|network-grid) echo network-grid;;
        15|dos|retro-dos) echo retro-dos;;
        16|ghost|ghost-green) echo ghost-green;;
        17|blue|blue-protocol) echo blue-protocol;;
        18|quantum|quantum-purple) echo quantum-purple;;
        19|inferno) echo inferno;;
        20|galaxy|galaxy-terminal) echo galaxy-terminal;;
        21|ai|ai-core) echo ai-core;;
        22|machine|machine-mode) echo machine-mode;;
        23|lab|lab-terminal) echo lab-terminal;;
        24|web|cyber-web) echo cyber-web;;
        25|crt|crt-hacker) echo crt-hacker;;
        26|watcher) echo watcher;;
        27|boot|ultra-boot) echo ultra-boot;;
        28|ultra|zyvora-ultra) echo zyvora-ultra;;
        *) return 1;;
    esac
}

menu() {
    mkdir -p "$CONFIG_DIR"
    while true; do
        clear
        printf '\\033[38;5;51m╔══════════════════════════════════════════╗\\033[0m\n'
        printf '\\033[38;5;141m║       NAGI × ZYVORA ULTRA                ║\\033[0m\n'
        printf '\\033[38;5;51m║             TERMUX CONTROL PANEL         ║\\033[0m\n'
        printf '\\033[38;5;51m╠══════════════════════════════════════════╣\\033[0m\n'
        printf '  1. Choose terminal theme (28 styles)\n'
        printf '  2. Choose banner (1-102)\n'
        printf '  3. Preview banner\n'
        printf '  4. Startup effects (full/light/off)\n'
        printf '  5. View current settings\n'
        printf '  6. Reset defaults\n'
        printf '  7. Uninstall theme\n'
        printf '  0. Exit menu\n'
        printf '\\033[38;5;51m╚══════════════════════════════════════════╝\\033[0m\n'
        read -r -p 'Select option: ' choice
        case "$choice" in
            1)
                styles
                read -r -p 'Enter style number (1-28): ' picked
                picked_style="$(normalize_style "$picked")" || { printf 'Invalid style.\n'; read -r -p 'Press Enter to continue...'; continue; }
                printf '%s\n' "$picked_style" > "$STYLE_FILE"
                install_theme
                printf 'Theme saved: %s\n' "$picked_style"
                read -r -p 'Press Enter to continue...'
                ;;
            2)
                banner_list
                read -r -p 'Enter banner 1-102 or random: ' picked
                if [[ "$picked" == random ]]; then
                    printf 'random\n' > "$CONFIG_DIR/banner"
                elif [[ "$picked" =~ ^[0-9]+$ ]] && (( picked >= 1 && picked <= 102 )); then
                    printf '%s\n' "$picked" > "$CONFIG_DIR/banner"
                else
                    printf 'Invalid banner choice.\n'
                fi
                read -r -p 'Press Enter to continue...'
                ;;
            3)
                read -r -p 'Preview banner number (1-102) or random: ' picked
                if [[ "$picked" == random || ( "$picked" =~ ^[0-9]+$ && picked -ge 1 && picked -le 102 ) ]]; then
                    ZYVORA_BANNER_CHOICE="$picked" zsh -c 'source "$PREFIX/share/zyvora/banners.zsh"; zyvora_render_banner'
                else
                    printf 'Invalid banner choice.\n'
                fi
                read -r -p 'Press Enter to continue...'
                ;;
            4)
                printf '1. Full effects\n2. Light effects\n3. Off\n'
                read -r -p 'Choose effects: ' picked
                case "$picked" in
                    1) printf 'full\n' > "$EFFECTS_FILE";;
                    2) printf 'light\n' > "$EFFECTS_FILE";;
                    3) printf 'off\n' > "$EFFECTS_FILE";;
                    *) printf 'Invalid choice.\n';;
                esac
                read -r -p 'Press Enter to continue...'
                ;;
            5)
                printf '\nTheme: '; cat "$STYLE_FILE" 2>/dev/null || printf 'zyvora-ultra (default)\n'
                printf 'Banner: '; cat "$CONFIG_DIR/banner" 2>/dev/null || printf 'random (default)\n'
                printf 'Effects: '; cat "$EFFECTS_FILE" 2>/dev/null || printf 'full (default)\n'
                if grep -Fq "$MARKER" "$ZSHRC" 2>/dev/null; then printf 'Installation: active\n'; else printf 'Installation: not active\n'; fi
                read -r -p 'Press Enter to continue...'
                ;;
            6)
                printf 'zyvora-ultra\n' > "$STYLE_FILE"
                printf 'random\n' > "$CONFIG_DIR/banner"
                printf 'full\n' > "$EFFECTS_FILE"
                install_theme
                printf 'Defaults restored. Restart the shell to apply.\n'
                read -r -p 'Press Enter to continue...'
                ;;
            7)
                read -r -p 'Uninstall theme and restore backed-up .zshrc? Type YES: ' confirm
                if [[ "$confirm" == YES ]]; then remove_theme; fi
                read -r -p 'Press Enter to continue...'
                ;;
            0|q|Q) return 0;;
            *) printf 'Invalid option.\n'; sleep 1;;
        esac
    done
}

case "${1:-start}" in
    menu|--menu|-m)
        menu
        ;;
    styles|list)
        styles
        ;;
    effects)
        mkdir -p "$CONFIG_DIR"
        case "\${2:-status}" in
            full|light|off)
                printf '%s\n' "$2" > "$EFFECTS_FILE"
                printf 'Startup effects set to: %s\n' "$2"
                ;;
            status)
                printf 'Startup effects: '
                cat "$EFFECTS_FILE" 2>/dev/null || printf 'full (default)\n'
                ;;
            *)
                printf 'Use: zyvora effects <full|light|off>\n'
                exit 2
                ;;
        esac
        ;;
    style)
        install_theme
        [ -n "${2:-}" ] || { printf 'Current style: '; cat "$STYLE_FILE"; printf '\nUse: zyvora style <1-28|name>\n'; exit 0; }
        NEW_STYLE="$(normalize_style "$2")" || { printf 'Unknown style. Run: zyvora styles\n'; exit 2; }
        printf '%s\n' "$NEW_STYLE" > "$STYLE_FILE"
        printf 'ZYVORA style set to: %s\n' "$NEW_STYLE"
        exec zsh
        ;;
    install|start)
        install_theme
        exec zsh
        ;;
    remove|uninstall)
        remove_theme
        ;;
    banner)
        BANNER_FILE="$CONFIG_DIR/banner"
        mkdir -p "$CONFIG_DIR"
        case "${2:-status}" in
            list|styles)
                banner_list
                printf '\nUse: zyvora banner <1-102|random|preview N>\n'
                ;;
            random)
                printf 'random\n' > "$BANNER_FILE"
                printf 'Random banner selected for each new shell.\n'
                ;;
            status)
                printf 'Banner selection: '; cat "$BANNER_FILE" 2>/dev/null || printf 'random (default)\n'
                ;;
            preview)
                [ -n "${3:-}" ] || { printf 'Use: zyvora banner preview <1-102|random>\n'; exit 2; }
                ZYVORA_BANNER_CHOICE="$3" zsh -c 'source "$PREFIX/share/zyvora/banners.zsh"; zyvora_render_banner'
                ;;
            [0-9]*)
                [[ "$2" =~ ^[0-9]+$ ]] && [ "$2" -ge 1 ] && [ "$2" -le 102 ] || { printf 'Banner number must be 1-102.\n'; exit 2; }
                printf '%s\n' "$2" > "$BANNER_FILE"
                printf 'Banner %s selected. Start a new shell with: zyvora\n' "$2"
                ;;
            *)
                printf 'Use: zyvora banner <1-102|random|list|preview N>\n'
                exit 2
                ;;
        esac
        ;;
    status)
        if grep -Fq "$MARKER" "$ZSHRC" 2>/dev/null; then
            printf 'ZYVORA theme: installed\n'
            printf 'Style: '; cat "$STYLE_FILE" 2>/dev/null || printf 'zyvora-ultra\n'
            printf 'Banner: '; cat "$CONFIG_DIR/banner" 2>/dev/null || printf 'random (default)\n'
        else
            printf 'ZYVORA theme: not installed\n'
        fi
        ;;
    *)
        printf 'Usage: zyvora [menu|start|install|remove|status|styles|style <1-28|name>|banner <1-102|random|list|preview N>|effects <full|light|off>]\n'
        exit 2
        ;;
esac
EOF
    chmod 755 "$TERMUX_PREFIX/bin/zyvora"

    cat > "$TERMUX_PREFIX/share/zyvora/theme.zsh" <<'EOF'
# ZYVORA ULTRA 28-STYLE TERMUX THEME
# Visual-only terminal customization; normal Termux commands remain unchanged.
autoload -Uz colors && colors
setopt PROMPT_SUBST

ZYVORA_CONFIG="$HOME/.config/zyvora/style"
ZYVORA_STYLE="$(cat "$ZYVORA_CONFIG" 2>/dev/null || printf 'zyvora-ultra')"

zyvora_style_data() {
  ZYVORA_C1=51; ZYVORA_C2=141; ZYVORA_SYMBOL='⚡'; ZYVORA_TITLE='ZYVORA ULTRA'
  case "$ZYVORA_STYLE" in
    classic-hacker) ZYVORA_C1=46; ZYVORA_C2=226; ZYVORA_SYMBOL='[+]'; ZYVORA_TITLE='HACKER';;
    matrix) ZYVORA_C1=46; ZYVORA_C2=40; ZYVORA_SYMBOL='[M]'; ZYVORA_TITLE='MATRIX';;
    cyber-neon) ZYVORA_C1=51; ZYVORA_C2=45; ZYVORA_SYMBOL='[C]'; ZYVORA_TITLE='CYBER NEON';;
    purple-void) ZYVORA_C1=141; ZYVORA_C2=135; ZYVORA_SYMBOL='[V]'; ZYVORA_TITLE='PURPLE VOID';;
    red-alert) ZYVORA_C1=196; ZYVORA_C2=202; ZYVORA_SYMBOL='[!]'; ZYVORA_TITLE='RED ALERT';;
    electric-storm) ZYVORA_C1=51; ZYVORA_C2=39; ZYVORA_SYMBOL='[~]'; ZYVORA_TITLE='ELECTRIC STORM';;
    orange-cyber) ZYVORA_C1=208; ZYVORA_C2=214; ZYVORA_SYMBOL='[>]'; ZYVORA_TITLE='ORANGE CYBER';;
    skull-terminal) ZYVORA_C1=255; ZYVORA_C2=196; ZYVORA_SYMBOL='[X]'; ZYVORA_TITLE='SKULL TERMINAL';;
    pixel-hacker) ZYVORA_C1=46; ZYVORA_C2=226; ZYVORA_SYMBOL='[8]'; ZYVORA_TITLE='PIXEL HACKER';;
    cyber-satellite) ZYVORA_C1=39; ZYVORA_C2=51; ZYVORA_SYMBOL='[S]'; ZYVORA_TITLE='CYBER SATELLITE';;
    digital-core) ZYVORA_C1=51; ZYVORA_C2=213; ZYVORA_SYMBOL='[D]'; ZYVORA_TITLE='DIGITAL CORE';;
    security-console) ZYVORA_C1=46; ZYVORA_C2=51; ZYVORA_SYMBOL='[SEC]'; ZYVORA_TITLE='SECURITY CONSOLE';;
    dark-ops) ZYVORA_C1=250; ZYVORA_C2=244; ZYVORA_SYMBOL='[OPS]'; ZYVORA_TITLE='DARK OPS';;
    network-grid) ZYVORA_C1=45; ZYVORA_C2=51; ZYVORA_SYMBOL='[NET]'; ZYVORA_TITLE='NETWORK GRID';;
    retro-dos) ZYVORA_C1=46; ZYVORA_C2=255; ZYVORA_SYMBOL='[DOS]'; ZYVORA_TITLE='RETRO DOS';;
    ghost-green) ZYVORA_C1=118; ZYVORA_C2=46; ZYVORA_SYMBOL='[G]'; ZYVORA_TITLE='GHOST GREEN';;
    blue-protocol) ZYVORA_C1=39; ZYVORA_C2=33; ZYVORA_SYMBOL='[P]'; ZYVORA_TITLE='BLUE PROTOCOL';;
    quantum-purple) ZYVORA_C1=141; ZYVORA_C2=213; ZYVORA_SYMBOL='[Q]'; ZYVORA_TITLE='QUANTUM PURPLE';;
    inferno) ZYVORA_C1=196; ZYVORA_C2=208; ZYVORA_SYMBOL='[F]'; ZYVORA_TITLE='INFERNO';;
    galaxy-terminal) ZYVORA_C1=51; ZYVORA_C2=135; ZYVORA_SYMBOL='[*]'; ZYVORA_TITLE='GALAXY TERMINAL';;
    ai-core) ZYVORA_C1=51; ZYVORA_C2=141; ZYVORA_SYMBOL='[AI]'; ZYVORA_TITLE='AI CORE';;
    machine-mode) ZYVORA_C1=250; ZYVORA_C2=208; ZYVORA_SYMBOL='[MCH]'; ZYVORA_TITLE='MACHINE MODE';;
    lab-terminal) ZYVORA_C1=118; ZYVORA_C2=51; ZYVORA_SYMBOL='[LAB]'; ZYVORA_TITLE='LAB TERMINAL';;
    cyber-web) ZYVORA_C1=45; ZYVORA_C2=213; ZYVORA_SYMBOL='[WEB]'; ZYVORA_TITLE='CYBER WEB';;
    crt-hacker) ZYVORA_C1=46; ZYVORA_C2=82; ZYVORA_SYMBOL='[CRT]'; ZYVORA_TITLE='CRT HACKER';;
    watcher) ZYVORA_C1=51; ZYVORA_C2=196; ZYVORA_SYMBOL='[EYE]'; ZYVORA_TITLE='WATCHER';;
    ultra-boot) ZYVORA_C1=51; ZYVORA_C2=226; ZYVORA_SYMBOL='[BOOT]'; ZYVORA_TITLE='ULTRA BOOT';;
  esac
}

zyvora_git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local branch=$(git branch --show-current 2>/dev/null)
  [[ -n "$branch" ]] && print " %F{$ZYVORA_C2}[$branch]%f"
}

source "$PREFIX/share/zyvora/banners.zsh"

zyvora_boot_sequence() {
  local mode step filled bar n
  mode="$(cat "$HOME/.config/zyvora/effects" 2>/dev/null || printf full)"
  [[ "$mode" == off ]] && return 0
  print -P "%F{51}╔══════════════════════════════════════╗%f"
  print -P "%F{141}║       NAGI × ZYVORA ULTRA BOOT       ║%f"
  print -P "%F{51}╚══════════════════════════════════════╝%f"
  print -P "%F{226}[BOOT] Initializing terminal interface...%f"
  if [[ "$mode" == full ]]; then
    for step in 1 2 3 4 5 6; do
      filled=$((step * 4))
      bar=""
      for ((n=0; n<filled; n++)); do bar+="█"; done
      printf '\r\033[38;5;51m[%-24s] %3d%%\033[0m' "$bar" "$((step * 100 / 6))"
      sleep 0.12
    done
    printf '\n'
  else
    print -P "%F{46}[✓] Core ready%f"
  fi
  print -P "%F{46}[✓] Terminal ready%f"
  sleep 0.15
}

zyvora_banner() {
  clear
  zyvora_boot_sequence
  zyvora_render_banner
  print -P "%F{$ZYVORA_C2}[*] STYLE: $ZYVORA_STYLE%f"
  print
}

zyvora_style_data
PROMPT="%F{$ZYVORA_C1}┌─[%f%F{$ZYVORA_C2}$ZYVORA_SYMBOL ZYVORA%f@%F{$ZYVORA_C1}TERMUX%f]%F{$ZYVORA_C1}─[%f%F{$ZYVORA_C2}%~%f%F{$ZYVORA_C1}]%f\$(zyvora_git_branch)\n%F{$ZYVORA_C1}└─>%f "

if [[ -z "$ZYVORA_SESSION_STARTED" ]]; then
  export ZYVORA_SESSION_STARTED=1
  zyvora_banner
fi
EOF
}
