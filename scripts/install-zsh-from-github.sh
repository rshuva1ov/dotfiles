#!/usr/bin/env bash
# Клонирует Oh My Zsh и сторонние темы/плагины в каталоги из $ZSH / $ZSH_CUSTOM (как в .zshrc).
# Запуск после Stow (или когда ~/.config/zsh уже совпадает с репозиторием).
# Требуется: git

set -euo pipefail

CONFIG_ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
ZSH_DIR="${ZSH:-$CONFIG_ZSH/oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$CONFIG_ZSH/oh-my-zsh-custom}"
OMZ_URL="https://github.com/ohmyzsh/ohmyzsh.git"

clone_shallow() {
  local url="$1"
  local dest="$2"
  if [[ -d "$dest/.git" ]]; then
    echo "Обновление: $dest"
    git -C "$dest" pull --ff-only
    return
  fi
  if [[ -e "$dest" ]]; then
    echo "Ошибка: путь существует, но это не git-репозиторий — удалите или переименуйте: $dest" >&2
    exit 1
  fi
  echo "Клонирование: $url → $dest"
  git clone --depth=1 "$url" "$dest"
}

mkdir -p "$CONFIG_ZSH"
mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

if [[ -d "$ZSH_DIR/.git" ]]; then
  echo "Обновление Oh My Zsh: $ZSH_DIR"
  git -C "$ZSH_DIR" pull --ff-only
elif [[ -d "$ZSH_DIR" ]]; then
  echo "Ошибка: $ZSH_DIR существует, но не является клоном oh-my-zsh." >&2
  exit 1
else
  echo "Клонирование Oh My Zsh → $ZSH_DIR"
  git clone --depth=1 "$OMZ_URL" "$ZSH_DIR"
fi

clone_shallow "https://github.com/romkatv/powerlevel10k.git" "$ZSH_CUSTOM/themes/powerlevel10k"
clone_shallow "https://github.com/zsh-users/zsh-autosuggestions.git" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_shallow "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "Готово: Oh My Zsh, Powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting."
