# dotfiles

Личные конфиги для macOS: **zsh** (Oh My Zsh, Powerlevel10k) и **Ghostty**. Каталог `home/` зеркалится в `$HOME` через [GNU Stow](https://www.gnu.org/software/stow/): после установки появляются `~/.config/zsh/...`, `~/.config/ghostty/config` и т.д. `ZDOTDIR` задаётся в `home/.zshenv`.

Oh My Zsh, тема и плагины **не** в репозитории — их клонирует `scripts/install-zsh-from-github.sh` (он же вызывается из общего скрипта ниже).

## Установка

Зависимости через Homebrew (один раз):

```bash
brew install stow git
brew install --cask ghostty
```

Клонирование и **полная** установка (конфиги Zsh и Ghostty через Stow + zsh с GitHub):

```bash
git clone <url> ~/Desktop/dotfiles && cd ~/Desktop/dotfiles
chmod +x scripts/install-dotfiles.sh
./scripts/install-dotfiles.sh
```

### По отдельности

| Скрипт                               | Назначение                                                                                |
| ------------------------------------ | ----------------------------------------------------------------------------------------- |
| `scripts/install-dotfiles.sh`        | Stow (`home/` → `$HOME`) + `install-zsh-from-github.sh` + проверка пути к конфигу Ghostty |
| `scripts/install-macos-stow.sh`      | Только Stow                                                                               |
| `scripts/install-zsh-from-github.sh` | Только Oh My Zsh и плагины с GitHub                                                       |

Если `install-zsh-from-github.sh` падает из‑за каталога, который не git-клон, удали этот каталог и запусти снова.
