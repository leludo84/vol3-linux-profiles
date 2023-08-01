#/bin/bash

test "$1" = "" && exit 1


banners_file=./banners
> $banners_file\.json
#> $banners_file\.txt

find $1 -type f -name "*.json.xz" | while read file
do
	#banner_file=${file%\.json\.xz}.banner.txt

	echo "Processing $file to $banner_file ..."
	banner=$(xz -d < $file | jq -r .symbols.linux_banner.constant_data | base64 -d | head -n 1 | jq --raw-input . )

	echo '{"symbols_file": "'$file'", "banner": '$banner'}' >> $banners_file\.json
	#echo "$file:$banner" >> $banners_file\.txt
done

