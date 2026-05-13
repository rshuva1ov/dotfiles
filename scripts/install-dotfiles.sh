#!/usr/bin/env bash
# Разворачивает dotfiles (Stow: zsh, Ghostty и остальное из home/) и ставит Oh My Zsh с GitHub.
# Запуск из корня репозитория: ./scripts/install-dotfiles.sh

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${HOME}"
GHOSTTY_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"

need() {
  local name="$1"
  if ! command -v "$name" >/dev/null 2>&1; then
    printf 'Нужна команда «%s». Установи через Homebrew или другой менеджер.\n' "$name" >&2
    exit 1
  fi
}

need stow
need git

cd "$ROOT"
echo "Stow: пакет «home» → $TARGET (в т.ч. zsh и Ghostty)"
stow -v --restow --target="$TARGET" home

# Не наследовать ZSH/ZSH_CUSTOM от открытой сессии zsh — иначе клоны уйдут не в $HOME.
env -u ZSH -u ZSH_CUSTOM bash "$ROOT/scripts/install-zsh-from-github.sh"

if [[ -e "$GHOSTTY_CONFIG" ]]; then
  printf 'Ghostty: конфиг доступен по пути %s\n' "$GHOSTTY_CONFIG"
else
  printf 'Предупреждение: ожидался конфиг Ghostty по пути %s\n' "$GHOSTTY_CONFIG" >&2
fi

if ! command -v ghostty >/dev/null 2>&1; then
  printf 'Терминал Ghostty не найден в PATH. Установка: brew install --cask ghostty\n' >&2
fi

echo "Готово: dotfiles и zsh с GitHub."
