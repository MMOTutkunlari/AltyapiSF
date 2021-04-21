#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | oyunu kapatma scripti ####
main_dir=$(pwd)
cores="auth $(cat cores.list) db"
control="auth $(cat cores.list)"
for i in $cores
do
	if [ "db" == $i ]; then
		for i2 in $control
		do
			while true; do
				CHECK_PID=$(ps afx | fgrep "./$i2" | fgrep -v grep | awk '{print $1}')
				
				if [ ! -z $CHECK_PID ]; then
					echo "$i2 => $CHECK_PID hala kapatiliyor. Lutfen bekleyiniz... "
				else
					# echo "$i2 basariyla kapatildi."
					break
				fi
				
				sleep 3
			done
		done
	fi

	PIDNUM=$(ps afx | fgrep "./$i" | fgrep -v grep | awk '{print $1}')
	if [ ! -z $PIDNUM ]; then
		echo "$i => $PIDNUM kapatiliyor... "
		kill -1 $PIDNUM
		sleep 1
	else
		echo "$i => bulunamadi. "
	fi
done
