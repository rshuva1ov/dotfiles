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

ensure_brew_formula() {
  local formula="$1"
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Homebrew не найден — установи вручную: brew install %s\n' "$formula" >&2
    return 0
  fi
  if brew list --formula "$formula" &>/dev/null; then
    printf 'Уже установлено (brew): %s\n' "$formula"
    return 0
  fi
  printf 'Установка (brew): %s\n' "$formula"
  brew install "$formula"
}

cd "$ROOT"
echo "Stow: пакет «home» → $TARGET (в т.ч. zsh и Ghostty)"
stow -v --restow --target="$TARGET" home

# В .zshrc алиасы ls/ll/… используют eza.
ensure_brew_formula eza

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

if ! command -v eza >/dev/null 2>&1; then
  printf 'Команда eza не найдена в PATH после установки — проверь brew или PATH.\n' >&2
fi

echo "Готово: dotfiles, eza, zsh с GitHub."
