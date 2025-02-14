#!/usr/bin/env bash
set -euxv

if ! command -v convert file &>/dev/null; then
  echo "install: file, imagemagick" >&2
  exit 1
elif ! [ -d ./character_info ]; then
  echo "character_info is not found."
  exit 1
fi

# .png_large がなかったら、.png を .png_large にリネームしたあと 256x256 の .png を作成する
for i in ./character_info/*/icons/*.png; do
  if [ -f "${i/%/_large}" ]; then continue; fi
  echo "---"
  mv "$i" "${i/%/_large}"
  convert -resize 256x256 "${i/%/_large}" "$i"
  file "${i%/*}"/*
done
echo "--->done!"
