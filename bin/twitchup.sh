#! /usr/bin/env bash
# tubeup + Twitch-Chat-Downloader

set -o errexit
[[ -n $1 && -n $2 ]] || (echo too few arguments; exit 1)
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
	if [[ ${#info[*]} = 0 ]]; then sleep 5s; find-info; fi
	base=${info%.info.json}
	
	echo # new line to reset cursor position from concurrent tubeup output
	mv --verbose {$id,"$base"}.srt
	mv --verbose {$id,"$base"}.chat.json
	echo
	xz --verbose "$base".chat.json
) || true
wait

popd >/dev/null
