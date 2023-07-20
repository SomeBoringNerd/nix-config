#!/bin/bash

#this script is used to upload my screenshots to my server automatically
#you need spectacle, curl, xclip and libnotify

spectacle -br -o /tmp/copyshot.png 
secret=""
url="https://pics.self-hosted.lol/i/host"

output=$(curl \
	-F "secret=$secret" \
	-F "sharex=@/tmp/copyshot.png" \
	$url)

echo $output | xclip -selection clipboard

notify-send -t 2500 "Upload to pics.self-hosted.lol" "$output"
