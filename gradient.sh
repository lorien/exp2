#!/usr/bin/env bash
set -euo pipefail

SYMBOL="${1:-#}"
COUNT=999

G_R_START=0
G_G_START=0
G_B_START=0

G_R_END=0
G_G_END=255
G_B_END=0

for ((i = 0; i < COUNT; i++)); do
    t=$((i * 1000 / (COUNT - 1)))
    r=$((G_R_START + (G_R_END - G_R_START) * t / 1000))
    g=$((G_G_START + (G_G_END - G_G_START) * t / 1000))
    b=$((G_B_START + (G_B_END - G_B_START) * t / 1000))
    printf '\033[38;2;%d;%d;%dm%s\033[0m\n' "$r" "$g" "$b" "$SYMBOL"
done
