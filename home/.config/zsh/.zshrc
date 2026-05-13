# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc in $ZDOTDIR.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# XDG: история и кэш compinit (раньше файлы в $HOME)
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
[[ -d "$XDG_STATE_HOME/zsh" ]] || mkdir -p "$XDG_STATE_HOME/zsh"
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${HOST}-${ZSH_VERSION}"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation (рядом с $ZDOTDIR в ~/.config/zsh).
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/oh-my-zsh"

# Кастомные плагины и темы (powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting):
# $ZSH_CUSTOM/plugins/ и $ZSH_CUSTOM/themes/
export ZSH_CUSTOM="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/oh-my-zsh-custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="false"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see `man strftime` for details.
# HIST_STAMPS="mm-dd-yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git zsh-autosuggestions zsh-syntax-highlighting )

# eza: completions must appear in FPATH before oh-my-zsh runs compinit.
[[ -d /opt/homebrew/share/zsh/site-functions ]] && FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"
[[ -d /usr/local/share/zsh/site-functions ]] && FPATH="/usr/local/share/zsh/site-functions:$FPATH"
[[ -d "$HOME/eza/completions/zsh" ]] && FPATH="$HOME/eza/completions/zsh:$FPATH"

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $ZDOTDIR/.zshrc"
# alias ohmyzsh="mate $ZSH"

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

# =============================================================================
# Powerlevel10k — runtime presets (loaded после $ZDOTDIR/.p10k.zsh)
# -----------------------------------------------------------------------------
# These functions tweak POWERLEVEL9K_* in memory and call `p10k reload`.
# Nothing here edits .p10k.zsh; use the persist helpers below to remember
# choices across new terminal sessions.
#
# Cycle (interactive):
#   p10k_cycle_palette   — 8 presets for dir + vcs segment colors
#   p10k_cycle_icons     — 3 presets for OS / duration / jobs / git / status glyphs
#   p10k_cycle_dir       — 6 presets for path shortening + optional dir hyperlinks
#
# Persist the three indices to $ZDOTDIR/.p10k-cycle-state.zsh (0600 on write):
#   p10k_save_cycle_state   — write current indices after you finish cycling
#   p10k_load_cycle_state   — re-source the file and re-apply (manual refresh)
#   p10k_clear_cycle_state  — remove the file; open a new tab or `exec zsh`
#
# Startup: if the state file exists, indices are restored at the end of this
# block (_p10k_cycle_state_restore).
# =============================================================================

# Note: EZA_STANDARD_OPTIONS is not applied by current eza builds; flags are inlined below.
if (( $+commands[eza] )); then
  # Колонка даты (Date modified): код `da`, см. man eza_colors / https://github.com/eza-community/eza/blob/main/man/eza_colors.5.md
  export EZA_COLORS="da=36"
  # Oh My Zsh sets `alias ls=…`; `name () { }` then errors — use `function name { }` after unalias.
  unalias ls ll la lt lta 2>/dev/null
  typeset -ga _EZA_LS_COMMON=(
    --icons=auto
    --hyperlink
    --color-scale=all
    --color-scale-mode=gradient
    --git
    --classify=auto
    --no-permissions
    --no-filesize
    --no-user
    --sort=type
    --all
  )
  function ls {
    command eza "${_EZA_LS_COMMON[@]}" -lh --header --tree --level=1 "$@"
  }
  function ll {
    command eza "${_EZA_LS_COMMON[@]}" -lah --header --tree --level=2 "$@"
  }
  function la {
    command eza "${_EZA_LS_COMMON[@]}" -lah --header --tree --level=1 "$@"
  }
  function lt {
    command eza "${_EZA_LS_COMMON[@]}" --git-ignore --tree --level=4 -lh --header "$@"
  }
  function lta {
    command eza "${_EZA_LS_COMMON[@]}" --git-ignore --tree --level=4 -lah --header "$@"
  }
fi

export EDITOR="nano"
export VISUAL="$EDITOR"
