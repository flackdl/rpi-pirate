#!/bin/bash

shopt -s globstar

#sudo sshfs -o allow_other,default_permissions pi@192.168.1.222:/media/pi/ /mnt/pi/

echo -e "file, codec, size"

for file in /mnt/pi/{blackhole,vacuum,mariana_trench}/torrents/completed/{tv,movies}/**/*.{avi,mkv,m4a,m4v,mpg,mpeg,mp4}; do
#for file in ~/Desktop/**/*.{avi,mkv,m4a,m4v,mpg,mpeg,mp4}; do
  codec_name=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$file")
  if [[ $? -ne 0 ]]; then
    continue
  fi
  size=$(du -s "$file" | cut -f1)
  echo -e "\"$file\",$codec_name,$size"
done

echo Finished
