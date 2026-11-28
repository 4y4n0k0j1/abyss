#!/usr/bin/env bash
set -euo pipefail

# lines starting with < are the defaults, lines starting with > are your live values
defaults="$(dirname "$0")/../defaults/settings.json"
live="$HOME/.config/abyss/settings.json"
diff <(sed 's/,$//; s/^ *//' "$defaults" | sort) <(sed 's/,$//; s/^ *//' "$live" | sort) || true
