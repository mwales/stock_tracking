#!/bin/bash

TMP_DIR=/tmp/gsalert

if [ $# -ne 1 ]; then
	echo "Must provide a Gamestop Item URL"
	exit 1
fi

while :
do
	date

	mkdir $TMP_DIR
	cd $TMP_DIR
	wget --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" ${1}
	
	oos=$(cat * | grep -c -i "data-available=\"false\"" )

	cd -
	rm -rf $TMP_DIR

	if [ $oos -ne 0 ];
	then
		echo "Out of stock..."
	else
		echo "In stock"

		for i in {1..5}; do
			play GamestopAlert.mp3
		done
	fi

	sleep 30


done


