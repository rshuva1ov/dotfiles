# dotfiles

Единый репозиторий личных конфигов: **zsh** (Oh My Zsh + Powerlevel10k), **Ghostty**, **Cursor** (macOS).

## Структура (`home/` зеркалит `$HOME`)

| Путь в репозитории | Назначение |
|--------------------|------------|
| `home/.zshrc` | Zsh + Oh My Zsh |
| `home/.p10k.zsh` | Powerlevel10k |
| `home/.config/zsh/` | `ZSH_CUSTOM` (темы и плагины) |
| `home/.config/ghostty/config` | [Ghostty](https://ghostty.org/) |
| `home/Library/Application Support/Cursor/User/settings.json` | Cursor |
| `home/Library/Application Support/Cursor/User/keybindings.json` | Cursor |

**Oh My Zsh** ожидается в `~/.oh-my-zsh` (отдельная установка), в репозиторий не входит.

Каталог `~/.cursor/` (проекты, MCP, кэш) **намеренно не трекается** — только `User`-настройки редактора.

## Требования

- macOS (пути Cursor под `~/Library/...`)
- [GNU Stow](https://www.gnu.org/software/stow/): `brew install stow`
- [Oh My Zsh](https://ohmyz.sh/) в `~/.oh-my-zsh`

## Установка на эту или другую машину

```bash
git clone <url> ~/Desktop/dotfiles   # или другой путь
cd ~/Desktop/dotfiles
chmod +x scripts/install-macos-stow.sh
./scripts/install-macos-stow.sh
```

Stow создаст симлинки из `home/*` в `$HOME`. Редактируй файлы в репозитории (или через уже существующие ссылки в домашнем каталоге), затем коммить.

Если в `$HOME` уже лежат **обычные файлы** с теми же именами (не ссылки), `stow` не перезапишет их молча: временно переименуй (`mv ~/.zshrc ~/.zshrc.bak`), запусти скрипт, проверь shell, потом удали `.bak`.

### Без Stow (вручную)

```bash
REPO=~/Desktop/dotfiles
ln -sf "$REPO/home/.zshrc" ~/.zshrc
ln -sf "$REPO/home/.p10k.zsh" ~/.p10k.zsh
mkdir -p ~/.config
ln -sf "$REPO/home/.config/zsh" ~/.config/zsh
ln -sf "$REPO/home/.config/ghostty" ~/.config/ghostty
mkdir -p ~/Library/Application\ Support/Cursor/User
ln -sf "$REPO/home/Library/Application Support/Cursor/User/settings.json" ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf "$REPO/home/Library/Application Support/Cursor/User/keybindings.json" ~/Library/Application\ Support/Cursor/User/keybindings.json
```

## Обновление из текущего Mac (перезаписать копии в репо)

После правок в `~` выполни из репозитория (пример):

```bash
cp ~/.zshrc home/.zshrc
cp ~/.p10k.zsh home/.p10k.zsh
rsync -a --delete --exclude='.git' ~/.config/zsh/ home/.config/zsh/
cp ~/.config/ghostty/config home/.config/ghostty/config 2>/dev/null || true
cp ~/Library/Application\ Support/Cursor/User/settings.json "home/Library/Application Support/Cursor/User/"
cp ~/Library/Application\ Support/Cursor/User/keybindings.json "home/Library/Application Support/Cursor/User/"
```

## Раньше был `zsh-dotfiles`

Его можно архивировать или оставить как историю: этот репозиторий **заменяет** его по смыслу (zsh + Cursor + Ghostty). Старые симлинки на `zsh-dotfiles` при необходимости переключи на `dotfiles` тем же `stow` или ручными `ln -sf`.

## Первый push

Создай пустой репозиторий на GitHub/GitLab, затем:

```bash
cd ~/Desktop/dotfiles
git remote add origin git@github.com:<USER>/dotfiles.git
git branch -M main
git push -u origin main
```

Перед пушем проверь `settings.json` на токены и локальные пути, которые не стоит публиковать.
