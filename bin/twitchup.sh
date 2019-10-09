#! /usr/bin/env bash
# tubeup + Twitch-Chat-Downloader

set -o errexit
config=$1
id=$2
rest=${@:3}

shopt -s nullglob
find-info() { info=(*$id.info.json) ;}

pushd ~/.tubeup/downloads/ >/dev/null

tubeup http://twitch.tv/videos/$id $rest &
(
	set -o errexit
	tcd --video $id --format all --settings-file ~/.config/tcd/"$config".json
	
	find-info
	# if no file matches, wait and try again
	[[ ${#info[*]} -gt 0 ]] || (sleep 5s; find-info)
	base=${info%.info.json}
	
	echo # new line to reset cursor position from concurrent tubeup output
	mv --verbose {$id,"$base"}.srt
	mv --verbose {$id,"$base"}.chat.json
	echo
	xz --verbose "$base".chat.json
) || true
wait

popd >/dev/null
