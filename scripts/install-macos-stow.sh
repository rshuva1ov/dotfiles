#!/usr/bin/env bash
# Установка симлинков через GNU Stow (macOS: brew install stow).
# Запуск из корня репозитория: ./scripts/install-macos-stow.sh

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${HOME}"

if ! command -v stow >/dev/null 2>&1; then
  echo "Установите stow: brew install stow" >&2
  exit 1
fi

cd "$ROOT"
stow -v --restow --target="$TARGET" home
echo "Готово: пакет «home» развёрнут в $TARGET"
echo "Полная установка (zsh с GitHub + Ghostty): ./scripts/install-dotfiles.sh"
