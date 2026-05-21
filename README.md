# dotfiles

Личные конфиги для macOS: **[zsh](https://www.zsh.org/)** с [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) и темой [Powerlevel10k](https://github.com/romkatv/powerlevel10k), **[eza](https://github.com/eza-community/eza)** (алиасы `ls` / `ll` / `la` / `lt` / `lta`), **[yazi](https://github.com/sxyazi/yazi)** (файловый менеджер в терминале, тема в `~/.config/yazi/`, запуск через `y` в zsh) и **[Ghostty](https://ghostty.org/)**.

Каталог `home/` зеркалится в `$HOME` через [GNU Stow](https://www.gnu.org/software/stow/). [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) и связанные репозитории клонируются скриптом (см. шаг 4). Папки `~/.config/zsh/oh-my-zsh-custom` в репозитории **нет** — её создаёт установка и туда же кладутся тема и плагины.

### Yazi

- Конфиг в репозитории: `home/.config/yazi/theme.toml` (цвета Catppuccin Mocha).
- После Stow: `~/.config/yazi/theme.toml`.
- В zsh: функция **`y`** — открывает yazi и после выхода делает `cd` в каталог, где вы были в yazi (см. [документацию](https://yazi-rs.github.io/docs/quick-start#shell-wrapper)).
- В Powerlevel10k включён сегмент **yazi** (иконка/подсветка, пока открыт yazi).
- Запуск: `y` или `yazi` (после установки бинарника).

## Установка с нуля (строго по шагам)

**Не перескакивай шаги.** Скрипт из шага 4 не сработает без `stow` и `git` из шага 2.

1. **Homebrew**  
   Если ещё не ставил: инструкция на [brew.sh](https://brew.sh).

2. **Пакеты в систему** (нужны до запуска скрипта установки dotfiles):

   ```bash
   brew install stow git eza yazi
   brew install --cask ghostty
   ```

   Здесь же появляются **stow** и **git** — без них `./scripts/install-dotfiles.sh` сразу завершится с ошибкой. **eza** и **yazi** скрипт при необходимости дотянет через `brew install` сам; в шаге 2 их можно поставить заранее.

3. **Клонирование репозитория** (путь можно заменить на свой):

   ```bash
   git clone https://github.com/rshuva1ov/dotfiles.git ~/Desktop/dotfiles
   cd ~/Desktop/dotfiles
   ```

4. **Развёртывание конфигов и zsh с GitHub**:

   ```bash
   chmod +x scripts/install-dotfiles.sh
   ./scripts/install-dotfiles.sh
   ```

   Скрипт делает: Stow (`home/` → `$HOME`, в т.ч. `~/.config/yazi/`), при необходимости дотягивает **eza** и **yazi** через brew, клонирует Oh My Zsh в `~/.config/zsh/oh-my-zsh`, тему и плагины — в `~/.config/zsh/oh-my-zsh-custom/` (каталог создаётся скриптом).

5. **После успешного скрипта**  
   Открой новое окно терминала или выполни `exec zsh`, чтобы подхватился `~/.zshenv` и `ZDOTDIR`. Проверка yazi: `command -v yazi` и `y` (или `yazi`). Сообщение «Ghostty не в PATH» после скрипта часто нормально для cask: приложение всё равно в `/Applications`.

---

### Если что-то пошло не так

- Скрипт ругается на каталог, который **не** git-клон (остатки старой установки): удали этот каталог и снова запусти шаг 4.
- **Без Homebrew:** поставь `stow`, `git` и при желании `eza`, `yazi` сами; шаг 2 тогда заменяется на ручную установку этих утилит.
- **yazi не в PATH:** `brew install yazi`, затем новая сессия zsh.

### Скрипты по отдельности

| Скрипт | Когда нужен |
| --- | --- |
| `scripts/install-dotfiles.sh` | Полный сценарий (шаг 4): Stow, eza, yazi, Oh My Zsh |
| `scripts/install-macos-stow.sh` | Только симлинки Stow (в т.ч. `~/.config/yazi/`) |
| `scripts/install-zsh-from-github.sh` | Только Oh My Zsh и плагины с GitHub |

### Где почитать про стек

| Что ставится | Документация / репозиторий |
| --- | --- |
| [Homebrew](https://brew.sh) | [Документация](https://docs.brew.sh/) |
| [Git](https://git-scm.com/) | [Книга Pro Git](https://git-scm.com/book/ru/v2) |
| [GNU Stow](https://www.gnu.org/software/stow/) | [Руководство](https://www.gnu.org/software/stow/manual/stow.html) |
| [zsh](https://www.zsh.org/) | [Документация](https://zsh.sourceforge.io/Doc/) |
| [Oh My Zsh](https://ohmyz.sh/) | [Репозиторий](https://github.com/ohmyzsh/ohmyzsh), [wiki](https://github.com/ohmyzsh/ohmyzsh/wiki) |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | README в репозитории |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | README в репозитории |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | README в репозитории |
| [eza](https://github.com/eza-community/eza) | [Релизы](https://github.com/eza-community/eza/releases) |
| [yazi](https://github.com/sxyazi/yazi) | [Документация](https://yazi-rs.github.io/docs/), [конфиг](https://yazi-rs.github.io/docs/configuration/overview) |
| [Ghostty](https://ghostty.org/) | [Документация](https://ghostty.org/docs), [исходники](https://github.com/ghostty-org/ghostty) |
