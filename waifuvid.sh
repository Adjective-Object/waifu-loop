#!/usr/bin/env bash

mkdir -p img_tmp
for x in `ls img | grep \.jpg$`; do
    out=img_tmp/${x%.jpg}.png;
    if [ ! -e $out ]; then
        echo "convert img/$x -> $out"
        convert -resize 256x256 img/$x $out
    fi
done

avconv -r 24 -i img_tmp/%d.png test.webm -y

