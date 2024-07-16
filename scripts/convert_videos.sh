#!/bin/bash

shopt -s globstar

PATH_SOURCE="$1"

if [[ ! -d "$PATH_SOURCE" ]]; then
  echo 'Supply a valid path source'
  exit 1
fi

for file in "$PATH_SOURCE"/**/*.{avi,mkv,m4a,m4v,mpg,mpeg,mp4}; do
  codec_name=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$file")
  # validate response
  if [[ $? -ne 0 ]]; then
    echo "unable to retrieve codec from $file...skipping"
    continue
  fi
  if [[ $codec_name = "av1" ]] || [[ $codec_name = "mpeg1video" ]] || [[ $codec_name = "mpeg2video" ]] || [[ $codec_name = "mpeg4" ]] || [[ $codec_name = "msmpeg4v3" ]]; then
    echo "converting from codec $codec_name to h265: $file"
    ffmpeg -y -v quiet -stats -i "$file" -c:v libx265 -c:a aac "${file%.*}.mp4"
    if [[ $? -eq 0 ]]; then
      rm "$file"
    fi
  fi
done

echo Finished
