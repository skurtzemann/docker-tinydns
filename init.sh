#!/bin/bash

if mountpoint -q /data; then
	if [ -f /data/tinydns.data ]; then
		/rebuild_tinydns-data.sh
		echo "Starting tinydns (svscan)"
		svscan /etc/service
	else
		echo "/data/tinydns.data not found: exiting"
		exit 1
	fi
else
	echo "/data is not a mountpoint: exiting"
	exit 1
fi