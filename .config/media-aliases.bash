#! /usr/bin/env bash

aue() { ia-upload-tvod "$@" -m language:English ;}
alias aut=ia-upload-tvod
ia-upload-tvod() {
	local id=$1
	local creator=$2
	local date=$3
	local title=$4
	local slug=$5
	local tags=$6
	local rest=${@:7}
	ia upload $creator-${date}_$slug "$creator $date"*.{srt,xz,mts} -m mediatype:movies -m collection:opensource_movies -m creator:$creator -m date:$date -m source:https://twitch.tv/videos/$id -m "title:$title" -m "subject:TwitchVod;$tags" "$rest"
}

alias tcv=twitch-chat-vod
twitch-chat-vod() {( set -o errexit
	tcd --format all --settings-file ~/.config/tcd/$1.json -v $2
	mv --verbose {$2,"$3"}.srt
	mv --verbose {$2,"$3"}.chat.json
	xz "$3".chat.json
	tvod https://twitch.tv/videos/$2 -o "$3.mts" "${@:4}"
)}

tvflatt() { tvflat "$1 %(title)s" "${@:2}" ;}
tvflat() { tvod -o "%(uploader)s 2020-$1.mts" "${@:2}" ;}

tvut() { tvu "$1 %(title)s" "${@:2}" ;}
# .ts would be the correct extension for these MPEG Transport Stream files, according to Wikipedia, but .mts is more compatible
tvu() { tvod -o "%(uploader)s/2020-$1.mts" "${@:2}" ;}
tvod() { tvodj 3 "$@" ;}
tvodj() { command time --format %E twitch_vod_fetch --aria2c-opts "max-concurrent-downloads=$1 lowest-speed-limit=10K rpc-listen-all" "${@:2}" ;}

alias ydls='youtube-dl --config-location ~/.config/youtube-dl/stream-config'
alias ytname='youtube-dl -o "%(title)s.%(ext)s"'
alias ytflat='youtube-dl -o "%(uploader)s - %(title)s.%(ext)s"'
alias ytpl='youtube-dl -o "~/video/%(playlist_title)s/%(uploader)s - %(title)s.%(ext)s"'

igs() { il '' --stories --no-posts --no-metadata-json "$@" ;}
il() { instaloader --filename-pattern="{date_utc:%Y-%m-%d %H.%M.%S}$1" --geotags --login x1011__ --sessionfile ~/.cache/instaloader-session "${@:2}" | 
	egrep --invert-match \
	-e 'profile_pic\.jpg already exists' \
	-e '^Logged in as ' \
	-e '^Loaded session from ' \
	-e '^Saved session to ' \
;}
#--filename-pattern: date story / post
    #rename existing

alias ff='ffmpeg -hide_banner'
alias ffp='ffprobe -hide_banner'
alias ffpl='ffplay -hide_banner'

