#!/usr/bin/env bash

set -e

function waifu() {
    current=$1
    extension=$2

    currentfile="img/$1.$extension"
    nextfileno=$((current + 1))
    nextfile="img/$nextfileno.$extension"

    echo "downloading scaled version"
    curl \
        --silent \
        -X POST \
        -F "style=art" \
        -F "noise=1" \
        -F "scale=2" \
        -F "file=@./$currentfile" \
        "http://waifu2x.udp.jp/api" > $nextfile.tmp
    echo "downscaling"
    mogrify -resize 50% $nextfile.tmp
    echo "moving"
    mv $nextfile.tmp $nextfile
}

num_existing=`ls img | grep '\.jpg$'| wc -l`
num_existing=$((num_existing - 1))
while true; do
    echo "process generation $num_existing"
    waifu $num_existing jpg
    num_existing=$((num_existing + 1))
done

