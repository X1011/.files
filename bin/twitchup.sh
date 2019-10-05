#! /usr/bin/env bash
# tubeup + Twitch-Chat-Downloader

set -o errexit
config=$1
id=$2
rest=${@:3}
pushd ~/.tubeup/downloads/ >/dev/null

tubeup http://twitch.tv/videos/$id $rest &
(
	set -o errexit
	tcd --video $id --format all --settings-file ~/.config/tcd/"$config".json
	info=(*$id.info.json)
	base=${info%.info.json}
	echo # new line to reset cursor position from concurrent tubeup output
	mv --verbose {$id,"$base"}.srt
	mv --verbose {$id,"$base"}.chat.json
	echo
	xz --verbose "$base".chat.json
) || true
wait

popd >/dev/null
