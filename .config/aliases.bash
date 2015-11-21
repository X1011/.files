#! /usr/bin/env bash

unalias -a
source ~/.config/git-aliases.bash

alias al=alias
gv() { gvim "$@" & }
me() { medit "$@" & }
alias rc="rclone --config=$HOME/.config/rclone.conf --drive-use-trash --verbose"
alias cpr='cp --recursive --reflink --preserve=mode,ownership,timestamps'
alias sym="ln -s"

alias tra=gvfs-trash
alias str="sudo gvfs-trash"

alias pa="sudo pacman"
alias prm="pa --remove --recursive --unneeded"
alias rm-orphans="prm `pacman --query --quiet --unrequired --deps | xargs`"
alias pc=pacaur

alias pas="pa -S"
alias pcs="pacaur -S"
alias pps="sudo powerpill -S"
alias au="sudo aura -A"

alias syu="pa -Syu"
alias pu="pa -Su"
alias ppu="sudo powerpill -Su"
alias pcu="pacaur -Sau"

alias i="ls --color=auto"
alias ii="i -l"
alias ia="i -a"
alias iia="i -la"
alias e=i
alias ee=ii
alias ea=ia
alias eea=iia
o() { [[ -d $1 ]] && i "$@" || less "$@"; }

alias c=cd
alias u="cd .."
alias uu="cd ../.."
alias u3="cd ../../.."
alias pd=pushd
alias ppd=popd
mkcd() { mkdir -p "$@" && cd $1; }
mksud() { sudo mkdir -p "$@" && cd $1; }

alias tf="tail -f"

.() { source ${@:-~/.bashrc}; }
alias brc='$VISUAL ~/.bashrc && .'
