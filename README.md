# dotfiles

Личные конфиги для macOS: **zsh** (Oh My Zsh + Powerlevel10k), **[eza](https://github.com/eza-community/eza)** (через него в `.zshrc` заданы `ls` / `ll` / `la` / `lt` / `lta`) и **Ghostty**. 

Каталог `home/` зеркалится в `$HOME` через [GNU Stow](https://www.gnu.org/software/stow/): после установки появляются `~/.config/zsh/...`, `~/.config/ghostty/config` и т.д. `ZDOTDIR` задаётся в `home/.zshenv`.

Oh My Zsh, тема и плагины **не** в репозитории — их клонирует `scripts/install-zsh-from-github.sh` (он же вызывается из общего скрипта ниже).

## Установка

Зависимости через Homebrew (один раз):

```bash
brew install stow git eza
brew install --cask ghostty
```

`eza` при наличии Homebrew также ставит `scripts/install-dotfiles.sh`; без brew — поставь `eza` сам (или убери кастомные алиасы в `.zshrc`).

Клонирование и **полная** установка (конфиги Zsh и Ghostty через Stow + zsh с GitHub + eza через brew, если он есть):

```bash
git clone <url> ~/Desktop/dotfiles && cd ~/Desktop/dotfiles
chmod +x scripts/install-dotfiles.sh
./scripts/install-dotfiles.sh
```

### По отдельности

| Скрипт                               | Назначение                                                                                                                     |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `scripts/install-dotfiles.sh`        | Stow (`home/` → `$HOME`) + `brew install eza` при необходимости + `install-zsh-from-github.sh` + проверки Ghostty / eza в PATH |
| `scripts/install-macos-stow.sh`      | Только Stow                                                                                                                    |
| `scripts/install-zsh-from-github.sh` | Только Oh My Zsh и плагины с GitHub                                                                                            |

Если `install-zsh-from-github.sh` падает из‑за каталога, который не git-клон, удали этот каталог и запусти снова.
