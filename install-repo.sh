#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_FILE="$PREFIX/etc/apt/sources.list.d/zyvora.list"
REPO_URL="https://teamzyvorax.github.io/team-zyvora-termux/apt"

mkdir -p "$(dirname "$REPO_FILE")"

cat > "$REPO_FILE" <<EOF
# ZYVORA TERMUX APT repository
# This repository currently uses GitHub Pages with trusted=yes because it is not signed by a Termux-recognized repository key.
deb [trusted=yes] $REPO_URL stable main
EOF

printf '\033[38;5;141mZYVORA APT repository added.\033[0m\n'
printf '\033[38;5;51mRun:\033[0m\n'
printf '  pkg update\n'
printf '  pkg install zyvora\n'
printf '  zyvora\n'
