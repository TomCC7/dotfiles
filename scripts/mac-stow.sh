#!/bin/bash
# Stow only the Mac overlay, never the entire mixed Linux dotfiles tree.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
command -v stow >/dev/null || { printf 'Install the Home Manager packages first.\n' >&2; exit 1; }
stow --dir="$root/stow" --target="$HOME" --no-folding "$@" macos
