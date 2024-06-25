#! /usr/bin/env bash
set -euo pipefail

photo_dir=$1
photo_prefix=$2

(
	cd $photo_dir
	photos_count=$(ls | wc -l)
	i=1
	for photo in *; do
		filetype=${photo##*.}
		new_photo_name="$photo_prefix-$i.$filetype"
		mv $photo $new_photo_name
		echo $i
		i=$((i + 1))
	done
)
