#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | oyunu baslatma scripti ####
main_dir=$(pwd)
cores="db auth $(cat cores.list)"
for i in $cores
do
	PIDNUM=$(ps afx | fgrep "./$i" | fgrep -v grep | awk '{print $1}')
	if [ -z $PIDNUM ]; then
		echo "$i aciliyor..."
		cd $main_dir/cores/$i
		./$i & pwd & sleep 5
	else
		echo "$i zaten acik. pid: $PIDNUM"
	fi
	
	while true; do
		CHECK_PID=$(ps afx | fgrep "./$i" | fgrep -v grep | awk '{print $1}')
		
		if [ -z $CHECK_PID ]; then
			echo "$i hala acilmadi. Bekleniyor..."
		else
			#echo "$i acildi."
			break
		fi
		
		sleep 3
	done
done
