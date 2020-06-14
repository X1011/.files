#! /usr/bin/env bash

set -o pipefail

tvut() { tvu "$1 %(title)s" "${@:2}" ;}
# .ts would be the correct extension for these MPEG Transport Stream files, according to Wikipedia, but .mts is more compatible
tvu() { tvod -o "%(uploader)s/2020-$1.mts" "${@:2}" ;}
tvod() { tvodj 3 "$@" ;}
tvodj() { command time --format %E twitch_vod_fetch --aria2c-opts "max-concurrent-downloads=$1 lowest-speed-limit=10K rpc-listen-all" "${@:2}" ;}

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

