# dotfiles

Единый репозиторий личных конфигов: **zsh** (Oh My Zsh + Powerlevel10k через `ZDOTDIR`), **Ghostty**, **Cursor** (macOS).

## Структура (`home/` зеркалит `$HOME`)

| Путь в репозитории | Назначение |
| --- | --- |
| `home/.zshenv` | Задаёт `ZDOTDIR` на `~/.config/zsh` (читается из `$HOME` до остальных файлов) |
| `home/.config/zsh/.zshrc` | Интерактивный zsh + Oh My Zsh |
| `home/.config/zsh/.p10k.zsh` | Powerlevel10k |
| `home/.config/zsh/oh-my-zsh-custom/` | `ZSH_CUSTOM`: темы и плагины |
| `home/.config/ghostty/config` | [Ghostty](https://ghostty.org/) |
| `home/Library/Application Support/Cursor/User/settings.json` | Cursor |
| `home/Library/Application Support/Cursor/User/keybindings.json` | Cursor |

Файлы `~/.zshrc` и `~/.p10k.zsh` в корне домашнего каталога **не используются**: конфиг лежит в `$ZDOTDIR` (`~/.config/zsh/`).

**Oh My Zsh** ожидается в `~/.config/zsh/oh-my-zsh` (каталог не в git, см. `.gitignore`). История и compinit — по XDG в `~/.local/state/zsh` и `~/.cache/zsh` (см. `.zshrc`).

Каталог `~/.cursor/` (проекты, MCP, кэш) **намеренно не трекается** — только `User`-настройки редактора.

## Требования

- macOS (пути Cursor под `~/Library/...`)
- [GNU Stow](https://www.gnu.org/software/stow/): `brew install stow`
- [Oh My Zsh](https://ohmyz.sh/) в `~/.config/zsh/oh-my-zsh` (перенесите существующий `~/.oh-my-zsh` или установите в этот путь)

## Установка

```bash
git clone <url> ~/Desktop/dotfiles   # или другой путь
cd ~/Desktop/dotfiles
chmod +x scripts/install-macos-stow.sh
./scripts/install-macos-stow.sh
```

Stow создаст симлинки из `home/*` в `$HOME`. Редактируй файлы в репозитории (или через ссылки в домашнем каталоге), затем коммить.

Если раньше `~/.config/zsh` был **одним симлинком** на другой каталог (например отдельный репозиторий zsh), удали этот симлинк перед `stow`, иначе ссылки на отдельные файлы из `home/.config/zsh/` не создадутся.

Если в `$HOME` уже лежат **обычные файлы** с теми же именами (не ссылки), `stow` не перезапишет их молча: временно переименуй конфликтующие пути, запусти скрипт, проверь shell, потом удали резервные копии.

### Без Stow (вручную)

```bash
REPO=~/Desktop/dotfiles
mkdir -p ~/.config
ln -sf "$REPO/home/.zshenv" ~/.zshenv
ln -sf "$REPO/home/.config/zsh/.zshrc" ~/.config/zsh/.zshrc
ln -sf "$REPO/home/.config/zsh/.p10k.zsh" ~/.config/zsh/.p10k.zsh
ln -sf "$REPO/home/.config/zsh/oh-my-zsh-custom" ~/.config/zsh/oh-my-zsh-custom
ln -sf "$REPO/home/.config/ghostty" ~/.config/ghostty
mkdir -p ~/Library/Application\ Support/Cursor/User
ln -sf "$REPO/home/Library/Application Support/Cursor/User/settings.json" ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf "$REPO/home/Library/Application Support/Cursor/User/keybindings.json" ~/Library/Application\ Support/Cursor/User/keybindings.json
```

Для ручной установки каталог `~/.config/zsh` должен существовать; при необходимости: `mkdir -p ~/.config/zsh`.
