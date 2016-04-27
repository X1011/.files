#! /usr/bin/env bash

set -o pipefail
unalias -a
source ~/.config/git-aliases.bash

alientonx() { twitch-dl $4 $3 Alientonx reads My Immortal: ch. $1–$2 ;}
twitch-dl() {
	livestreamer --hls-start-time $2 --hls-segment-threads 4 twitch.tv/foo/v/$1 best --stdout |\
	ffmpeg -i - -codec copy -bsf:a aac_adtstoasc "${*:3}.mkv"
}

filter-clipboard() { eval "xclip -out -selection clipboard | $@ | xclip -in -selection clipboard" ;}
alias al=id
id() {
	alias "$@" 2>/dev/null || 
	declare -f "$@" | 
		sed -e '1N; # on the 1st line only, append the next line into the buffer
		        s/\n//' || # join 1st 2 lines, because One True Brace Style!
	whatis "$@"
}
gv() { gvim "$@" & }
me() { medit "$@" & }
alias rc="rclone --config=$HOME/.config/rclone/rclone.conf --drive-use-trash --verbose"
alias cpr='cp --reflink=auto --archive'
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
alias au="sudo aura --aursync --unsuppress"

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
o() { [[ -d $1 ]] && i "$@" || less "$@" ;}

alias c=cd
alias u="cd .."
alias uu="cd ../.."
alias u3="cd ../../.."
alias pd=pushd
alias ppd=popd
mkcd() {       mkdir -p "$@" && cd "$1" ;}
mksud() { sudo mkdir -p "$@" && cd "$1" ;}

alias tf="tail --follow --retry"

.() { source ${@:-~/.bashrc} ;}
alias brc='$VISUAL ~/.bashrc && .'
