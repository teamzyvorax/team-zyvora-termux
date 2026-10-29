# ZYVORA ULTRA banner engine: 2 giant banners + 100 distinct generated combinations.
# 10 layouts x 10 identity/motif profiles = 100 designs (IDs 3-102).
# Visual-only; normal Termux commands remain unchanged.

typeset -ga ZYVORA_BANNER_NAMES
ZYVORA_BANNER_NAMES=(
  "NAGI ULTRA" "ZYVORA CORE" "MATRIX GRID" "CYBER NEON" "QUANTUM VOID"
  "DARK OPS" "PIXEL ARCADE" "AI SENTINEL" "RETRO SHELL" "GALAXY NODE"
)
typeset -ga ZYVORA_BANNER_COLORS
ZYVORA_BANNER_COLORS=(46 51 141 45 196 208 39 213 118 226)
typeset -ga ZYVORA_BANNER_MARKS
ZYVORA_BANNER_MARKS=("[+]" "[*]" "[✓]" "[NET]" "[AI]" "[NAGI]" "[ULTRA]" "[CORE]" "[SYS]" "[OK]")

zyvora_render_banner() {
  local choice="\\\${ZYVORA_BANNER_CHOICE:-$(cat "$HOME/.config/zyvora/banner" 2>/dev/null || printf random)}"
  local id layout variant title color mark now host cwd
  now="$(date +%H:%M:%S 2>/dev/null || printf 'TIME')"
  host="\\\${USER:-nagi}@termux"
  cwd="\\\${PWD/#$HOME/~}"
  if [[ "$choice" == random || -z "$choice" ]]; then
    id=$(( (RANDOM % 102) + 1 ))
  elif [[ "$choice" == <-> ]] && (( choice >= 1 && choice <= 102 )); then
    id=$choice
  else
    id=$(( (RANDOM % 102) + 1 ))
  fi

  # The first two choices intentionally remain large ASCII wordmarks.
  if (( id == 1 )); then
    print -P "%F{46}███████╗██╗   ██╗██╗   ██╗ ██████╗ ██████╗  █████╗"
    print -P "%F{46}╚══███╔╝╚██╗ ██╔╝██║   ██║██╔═══██╗██╔══██╗██╔══██╗"
    print -P "%F{46}  ███╔╝  ╚████╔╝ ██║   ██║██║   ██║██████╔╝███████║"
    print -P "%F{46} ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║   ██║██╔══██╗██╔══██║"
    print -P "%F{46}███████╗   ██║    ╚████╔╝ ╚██████╔╝██║  ██║██║  ██║"
    print -P "%f"
    print -P "%F{51}[ $now ] [ ZYVORA ] — [ ONLINE ]%f"
    print -P "%F{226}[+] ZYVORA ULTRA SYSTEM%f"
    print -P "%F{51}[*] Terminal Ready...%f"
    print -P "%F{46}[✓] All Systems Operational%f"
    print
    return
  elif (( id == 2 )); then
    print -P "%F{51}███╗   ██╗ █████╗  ██████╗ ██╗"
    print -P "%F{51}████╗  ██║██╔══██╗██╔════╝ ██║"
    print -P "%F{51}██╔██╗ ██║███████║██║  ███╗██║"
    print -P "%F{51}██║╚██╗██║██╔══██║██║   ██║██║"
    print -P "%F{51}██║ ╚████║██║  ██║╚██████╔╝██║"
    print -P "%F{51}╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚═╝"
    print -P "%f"
    print -P "%F{141}[ $now ] [ NAGI × ZYVORA ULTRA ] — [ ONLINE ]%f"
    print -P "%F{226}[+] NAGI CORE INITIALIZED%f"
    print -P "%F{51}[*] Terminal Ready...%f"
    print -P "%F{46}[✓] All Systems Operational%f"
    print
    return
  fi

  # Ten structurally different layouts, combined with ten identities/motifs.
  layout=$(( (id - 3) % 10 ))
  variant=$(( (id - 3) / 10 ))
  title="\\\${ZYVORA_BANNER_NAMES[$((variant + 1))]}"
  color="\\\${ZYVORA_BANNER_COLORS[$((variant + 1))]}"
  mark="\\\${ZYVORA_BANNER_MARKS[$((variant + 1))]}"
  case "$layout" in
    0)
      print -P "%F{$color}╔══════════════════════════════════════════╗"
      print -P "║  $title"
      print -P "║  $mark  CORE ONLINE  |  SESSION READY"
      print -P "╚══════════════════════════════════════════╝%f"
      ;;
    1)
      print -P "%F{$color}┌─[ $title ]───────────────────────────────┐"
      print -P "│  SYSTEM  : ONLINE"
      print -P "│  SHELL   : ZSH / TERMUX"
      print -P "│  STATUS  : $mark READY"
      print -P "└──────────────────────────────────────────┘%f"
      ;;
    2)
      print -P "%F{$color}◆══════════ $title ══════════◆"
      print -P "       $mark  ZYVORA ULTRA"
      print -P "◆════════════════════════════════════════◆%f"
      ;;
    3)
      print -P "%F{$color}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
      print -P "┃  $title"
      print -P "┃  [01] TERMINAL READY   [02] CORE ONLINE"
      print -P "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛%f"
      ;;
    4)
      print -P "%F{$color}╭──────────────────────────────────────────╮"
      print -P "│  $title"
      print -P "│  ◈ IDENTITY : NAGI"
      print -P "│  ◈ STATE    : ACTIVE"
      print -P "╰──────────────────────────────────────────╯%f"
      ;;
    5)
      print -P "%F{$color}>>> $title <<<"
      print -P "[$now] $mark SYSTEM ONLINE"
      print -P "[+] ZYVORA ULTRA // TERMINAL READY%f"
      ;;
    6)
      print -P "%F{$color}▓▓▓▓▓▓▓▓▓▓ $title ▓▓▓▓▓▓▓▓▓▓"
      print -P "█  $mark  SESSION ACTIVE"
      print -P "█  CORE STATUS: READY"
      print -P "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓%f"
      ;;
    7)
      print -P "%F{$color}       .----------------------."
      print -P "      /  $title"
      print -P "     |  $mark SYSTEM ONLINE"
      print -P "     |  ZYVORA ULTRA READY"
      print -P "      \\----------------------'%f"
      ;;
    8)
      print -P "%F{$color}===========[ $title ]==========="
      print -P " :: $mark  LOCAL SESSION ACTIVE"
      print -P " :: TERMINAL READY"
      print -P "================================%f"
      ;;
    9)
      print -P "%F{$color}╔══[ $title ]══════════════════════════════╗"
      print -P "║ TIME: $now"
      print -P "║ USER: $host"
      print -P "║ PATH: $cwd"
      print -P "╚══[ $mark READY ]═════════════════════════╝%f"
      ;;
  esac
  print
}

zyvora_render_banner