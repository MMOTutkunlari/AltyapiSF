#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | oyunu baslatma scripti ####

flags=""
while getopts l:I: flag
do
	case ${flag} in
		l) level=$OPTARG
			flags=" $flags -l $level "
			echo "LOG LEVEL: $level"
			;;
		I) IP=$OPTARG
			flags=" $flags -I $IP "
			echo "PUBLIC IP: $IP"
			;;
		?) echo ""
			echo "Kullanım: $0 -l log_level -I public_ip"
			echo -e "\t-l : Serverin log seviyesini belirlemek için 0'dan 3'e kadar değer alabilir."
			echo -e "\t-I : Serverin PUBLIC_IP değerini belirlemek içindir."
			exit 1
			;;
	esac
done

main_dir=$(pwd)
cores="db auth $(cat cores.list)"
for i in $cores
do
	PIDNUM=$(ps afx | fgrep "./$i" | fgrep -v grep | awk '{print $1}')
	if [ -z $PIDNUM ]; then
		echo "$i aciliyor..."
		cd $main_dir/cores/$i
		./$i $flags & pwd & sleep 5
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
