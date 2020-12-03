#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Must provide a Best Buy Item URL"
	exit 1
fi

while :
do
	date

	mkdir /tmp/bbalert
	cd /tmp/bbalert
	wget ${1}
	
	oos=$(cat * | grep -c "Sold Out")

	cd -
	rm -rf /tmp/bbalert

	if [ $oos -ne 0 ];
	then
		echo "Out of stock..."
	else
		echo "In stock"

		for i in {1..5}; do
			play BestBuyAlert.mp3
		done
	fi

	sleep 30


done


