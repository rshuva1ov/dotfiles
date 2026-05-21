# Точка входа zsh: дальше все startup-файлы читаются из $ZDOTDIR (XDG).
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
