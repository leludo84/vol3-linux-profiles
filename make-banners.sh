#/bin/bash

test "$1" = "" && exit 1


banners_file=./banners.ndjson


function get_banner() {
	file=$1
	echo "Processing $file ..." 1>&2
	banner_b64=$(xz -d < $file | jq -r .symbols.linux_banner.constant_data)
	banner=$(base64 -d <<< $banner_b64 | head -n 1 | jq --raw-input .)

	echo '{"symbols_file": "'$file'", "banner_b64": "'$banner_b64'", "banner": '$banner'}' 
}
export -f get_banner


find $1 -type f -name "*.json.xz" | parallel get_banner {} | tee $banners_file

