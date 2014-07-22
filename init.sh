#!/bin/bash

if mountpoint -q /data; then
	if [ -f /data/tinydns.data ] && [ -f /data/axfrdns.tcp ]; then
		/rebuild_tinydns-data.sh
		/rebuild_axfrdns-tcp.sh
		echo "Starting tinydns and axfrdns (svscan)"
		svscan /etc/service
	else
		echo "Ressources files (tinydns.data, axfrdns.tcp) not found in /data: exiting"
		exit 1
	fi
else
	echo "/data is not a mountpoint: exiting"
	exit 1
fi