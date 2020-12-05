#!/bin/bash

TMP_DIR=/tmp/bbalert
STORE_NAME="BestBuy"
NUM_SKUS=$#

if [ $# -lt 1 ]; then
	echo "Must provide a ${STORE_NAME} Item URL"
	exit 1
fi

while :
do
	for itemUrl in "$@"
	do
	
		DATE_STR=$(date)

		mkdir $TMP_DIR
		cd $TMP_DIR
	
		# echo "Retrieving $itemUrl"
		wget --user-agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" ${1} 2> /dev/null
	
		oos=$(cat * | grep -c "Sold Out")

		cd - > /dev/null

		if [ $oos -ne 0 ];
		then
			echo "${DATE_STR} ${STORE_NAME} Out of stock of ${itemUrl}"
		else
			echo "${DATE_STR} ${STORE_NAME} In stock !!!"
			echo "BUYBUYBUY ${itemUrl}"

			for i in {1..5}; do
				play ${STORE_NAME}Alert.mp3 2> /dev/null
			done
		fi
		
		# Sleep for a few seconds before querying the next URL
		sleep 5
		rm -rf $TMP_DIR
	done

	# After querying all the URLs, sleep for 30s
	sleep 30

done


