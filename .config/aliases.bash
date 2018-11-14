#! /usr/bin/env bash

set -o pipefail
unalias -a
source ~/.config/git-aliases.bash

alias rc-drive='rclone copy ~/drive drive: --verbose --fast-list --copy-links --filter-from=$HOME/.config/rclone/global.filter'
alias rcm=rclone-cache-mount
# not using Offline uploading (by --cache-tmp-upload-path), because modifications fail while file is being processed, and this messes up Chrome downloads (a.o. 2018-8-6)
# don't use --vfs-read-chunk-size: it only affects bytes requested, not reads, so has no effect on cache remote (https://forum.rclone.org/t/new-feature-vfs-read-chunk-size/5683)
alias rclone-cache-mount='rclone mount --vfs-cache-mode writes --rc --cache-writes "$@"'
alias rcl='rclone --verbose --fast-list'

alias pv='pv --progress --timer --eta --rate --average-rate --bytes --buffer-percent'
alias t=touch

alias tvod='time twitch_vod_fetch --create-part-file --aria2c-opts "--max-concurrent-downloads=5 --lowest-speed-limit=10K --rpc-listen-all"'

alias ytname='youtube-dl -o "%(title)s.%(ext)s"'
alias ytflat='youtube-dl -o "%(uploader)s - %(title)s.%(ext)s"'
alias ytpl='youtube-dl -o "~/video/%(playlist_title)s/%(uploader)s - %(title)s.%(ext)s"'

alias sudo='sudo ' # makes Bash expand the word after sudo if it's an alias: http://askubuntu.com/a/22043
alias userstyles='objectpath --url https://widget.userstyles.org/users/24012.json --expr "sum($.*.total_installs) + 2608"'
alias ff='ffmpeg -hide_banner'
alias ffp='ffprobe -hide_banner'
alias ffpl='ffplay -hide_banner'
filter-clipboard() { eval "xclip -out -selection clipboard | $@ | xclip -in -selection clipboard" ;}
alias al=id
id() {
	alias "$@" 2>/dev/null ||

	# join 1st 2 lines, because One True Brace Style!
	# on line 1, read in the next line, then remove the newline character
	declare -f "$@" | sed '1 {N; s/\n//}' ||

	whatis "$@" 2>/dev/null ||
	which "$@"
}
alias sgv="gksudo gvim"
alias gv=gvim
me() { medit "$@" & }
alias cpr='cp --reflink=auto --archive'
alias sym="ln -s"

alias tra=gvfs-trash
alias str="sudo gvfs-trash"

alias pa="sudo pacman"
alias prm="pa --remove --recursive --unneeded"
alias rm-orphans='prm `pacman --query --quiet --unrequired --deps | xargs`'
alias pc=pacaur

alias pas="pa -S"
alias pcs="pacaur -S"
alias pps="sudo powerpill -S"
alias au="sudo aura --aursync --unsuppress"

alias syu="pa -Syu"
alias pu="pa -Su"
alias ppu="sudo powerpill -Su"
alias pcu="pacaur -Sau"

alias i="ls --color=auto --si"
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
