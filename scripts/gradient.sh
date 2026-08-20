#!/usr/bin/env bash
set -euo pipefail

COUNT=999
SYMBOL="#"
DEST_R=0
DEST_G=255
DEST_B=0

for ((i = 0; i < COUNT; i++)); do
    r=$((DEST_R * i / (COUNT - 1)))
    g=$((DEST_G * i / (COUNT - 1)))
    b=$((DEST_B * i / (COUNT - 1)))
    printf '\e[38;2;%d;%d;%dm%s' "$r" "$g" "$b" "$SYMBOL"
done
printf '\e[0m\n'