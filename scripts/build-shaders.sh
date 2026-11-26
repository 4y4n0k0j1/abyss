#!/usr/bin/env bash
set -euo pipefail

QSB="$(command -v qsb || command -v qsb6 || echo /usr/lib64/qt6/bin/qsb)"
cd "$(dirname "$0")/../quickshell/shaders"

for src in *.frag; do
    "$QSB" --glsl "100 es,120,150" --hlsl 50 --msl 12 -o "${src}.qsb" "$src"
    echo "built ${src}.qsb"
done
