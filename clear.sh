#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | Oyunu temizleme scripti ####
main_dir=$(pwd)
cores="db auth $(cat cores.list)"
files="p2p_packet_info.txt packet_info.txt stdout syserr syslog VERSION.txt *.core"
for i in $cores
do
	echo "$i temizligi yapiliyor... "
	cd $main_dir/logs/$i
	cat /dev/null > PTS
	rm -rf log/*
	
	cd $main_dir/cores/$i
	for f in $files
	do
		rm -fv $f
	done
done
