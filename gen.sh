#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | Server files olusturma scripti ####
## Bu script ile filesi olusturabilirsiniz. Yeni bir kanal eklemek isterseniz ch2'den sonra ch3, ch4 şeklinde devam ettirebilirsiniz. ##
## conf.txt ve CONFIG dosyalarinda surekli tekrarlanan ayarlar degiskenlerde bulunmaktadir. Kendinize gore duzenleyebilirsiniz. ##

main_dir="cores logs"
cores="db auth ch1 ch2 ch99"

## Ayalar | Kendinize gore duzenleyin. ##
adminPageLocalIP=$(ifconfig em0 | grep 'inet' | awk '{print $2}') #burayi ellemeyin.
adminPagePass="MMOTUTKUNLARI_ALTYAPI55"

sqlHostName="127.0.0.1" # mysql host
sqlUserPass="mt2 mt2sifre" # mysql kullanici adi ve sifre
dbPort=15900
mysqlPort=3306

#oyun ayalari
maxLevel=105

#kanal portlari - her kanalda +10 port
channel_idx=1
chPortStart=13900
chP2PPortStart=14900

for md in $main_dir
do
	echo "Ana klasor olusturuluyor => $md "
	if [ ! -d $md ]; then
		mkdir $md
	fi
	
	if [ "logs" == $md ]; then
		echo "logs icerigi olusturuluyor... "
		for c in $cores
		do
			echo "logs/$c olusturuluyor... "
			mkdir -p $md/$c/log
			cat /dev/null > $md/$c/PTS
		done	
	fi
	
	if [ "cores" == $md ]; then
		echo "cores icerigi olusturuluyor... "
		for c in $cores
		do
			echo "cores/$c olusturuluyor... "
			mkdir -p $md/$c
		
			if [ "db" == $c ]; then
				ln -Ffnsw ../../share/bin/db $md/$c/$c
				
				ln -Ffnsw ../../share/conf/item_names.txt $md/$c/item_names.txt
				ln -Ffnsw ../../share/conf/item_proto.txt $md/$c/item_proto.txt
				ln -Ffnsw ../../share/conf/mob_names.txt $md/$c/mob_names.txt
				ln -Ffnsw ../../share/conf/mob_proto.txt $md/$c/mob_proto.txt
				
				cat /dev/null > $md/$c/conf.txt
				
				echo "WELCOME_MSG = \"DB Serveri acildi... \"

SQL_ACCOUNT = \"$sqlHostName account $sqlUserPass $mysqlPort\"
SQL_PLAYER = \"$sqlHostName player $sqlUserPass $mysqlPort\"
SQL_COMMON = \"$sqlHostName common $sqlUserPass $mysqlPort\"
SQL_HOTBACKUP = \"$sqlHostName hotbackup $sqlUserPass $mysqlPort\"

TABLE_POSTFIX = \"\"

BIND_PORT               = $dbPort
DB_SLEEP_MSEC           = 10
CLIENT_HEART_FPS        = 10
HASH_PLAYER_LIFE_SEC    = 600
BACKUP_LIMIT_SEC        = 3600
PLAYER_ID_START = 100
PLAYER_DELETE_LEVEL_LIMIT = 70

ITEM_ID_RANGE = 2000000000 2100000000

LOCALE = \"latin1\"" >> $md/$c/conf.txt
			
			elif [ "auth" == $c ]; then
				#sabit dosyalar
				ln -Ffnsw ../../share/conf/BANIP $md/$c/BANIP
				
				#config
				cat /dev/null > $md/$c/CONFIG
				echo "HOSTNAME: auth
CHANNEL: 1
PORT: 11900
P2P_PORT: 12900
DB_PORT: $dbPort
DB_ADDR: $sqlHostName
PASSES_PER_SEC: 25
SAVE_EVENT_SECOND_CYCLE: 180
PING_EVENT_SECOND_CYCLE: 180
AUTH_SERVER: master
PLAYER_SQL: $sqlHostName $sqlUserPass account
COMMON_SQL: $sqlHostName $sqlUserPass common
LOG_SQL: $sqlHostName $sqlUserPass log
ADMINPAGE_IP1: $adminPageLocalIP
ADMINPAGE_PASSWORD: $adminPagePass" >> $md/$c/CONFIG
			elif [ "ch99" == $c ]; then
				#mark
				ln -Ffnsw ../../share/lib/mark $md/$c/mark
				
				#config
				cat /dev/null > $md/$c/CONFIG
				echo "HOSTNAME: ch99
CHANNEL: 99
PORT: 13999
P2P_PORT: 14999
DB_PORT: $dbPort
DB_ADDR: $sqlHostName
MAP_ALLOW: 81 113 212 103 105 110 111 114 118 119 120 121 122 123 124 125 126 127 128 181 182 183 190 191 192
PASSES_PER_SEC: 25
SAVE_EVENT_SECOND_CYCLE: 180
PING_EVENT_SECOND_CYCLE: 180
PLAYER_SQL: $sqlHostName $sqlUserPass player
COMMON_SQL: $sqlHostName $sqlUserPass common
LOG_SQL: $sqlHostName $sqlUserPass log
MALL_URL: www.mmotutkunlari.com

VIEW_RANGE: 10000

ADMINPAGE_IP1: $adminPageLocalIP
ADMINPAGE_PASSWORD: $adminPagePass
SPAM_BLOCK_MAX_LEVEL: 90

GOLD_DROP_LIMIT_TIME: 10

MAX_LEVEL: $maxLevel" >> $md/$c/CONFIG
			else
				#mark
				ln -Ffnsw ../../share/lib/mark $md/$c/mark
				
				#config
				cat /dev/null > $md/$c/CONFIG
				echo "HOSTNAME: $c
CHANNEL: $channel_idx
PORT: $chPortStart
P2P_PORT: $chP2PPortStart
DB_PORT: $dbPort
DB_ADDR: $sqlHostName
MAP_ALLOW: 1 3 21 23 25 41 43 45 61 62 63 64 65 66 67 68 208 216 217 351 352 
MAP_ALLOW: 69 70 71 72 73 104 108 109 301 302 303 304
PASSES_PER_SEC: 25
SAVE_EVENT_SECOND_CYCLE: 180
PING_EVENT_SECOND_CYCLE: 180
PLAYER_SQL: $sqlHostName $sqlUserPass player
COMMON_SQL: $sqlHostName $sqlUserPass common
LOG_SQL: $sqlHostName $sqlUserPass log
MALL_URL: www.mmotutkunlari.com

VIEW_RANGE: 10000

ADMINPAGE_IP1: $adminPageLocalIP
ADMINPAGE_PASSWORD: $adminPagePass
SPAM_BLOCK_MAX_LEVEL: 90

GOLD_DROP_LIMIT_TIME: 10

MAX_LEVEL: $maxLevel


PK_PROTECT_LEVEL: 30

item_count_limit: 200
REQUIRE_PRISM_ITEM: 0
EMPIRE_WHISPER: 0
GLOBAL_SHOUT
SHOUT_ADDON
DISABLE_EMOTION_MASK
SHOP_PRICE_3X_DISABLE
DISABLE_CHANGE_ATTR_TIME" >> $md/$c/CONFIG

				#kanal id ve portlari hesaplar
				channel_idx=$(expr $channel_idx + 1)
				chPortStart=$(expr $chPortStart + 10)
				chP2PPortStart=$(expr $chP2PPortStart + 10)
			fi
			
			if [ "db" != $c ]; then
				#core
				ln -Ffnsw ../../share/bin/game $md/$c/$c
				
				#files
				ln -Ffnsw ../../share/data $md/$c/data
				ln -Ffnsw ../../share/locale $md/$c/locale
				ln -Ffnsw ../../share/package $md/$c/package
				ln -Ffnsw ../../share/panama $md/$c/panama
				
				#sabit ayar dosyalari
				ln -Ffnsw ../../share/conf/CMD $md/$c/CMD
				ln -Ffnsw ../../share/conf/CRC $md/$c/CRC
				ln -Ffnsw ../../share/conf/state_user_count $md/$c/state_user_count
				ln -Ffnsw ../../share/conf/VERSION $md/$c/VERSION
			fi
			
			#hepsinde ortak olanlar.
			#loglar
			ln -Ffnsw ../../logs/$c/log $md/$c/log
			ln -Ffnsw ../../logs/$c/PTS $md/$c/PTS
		done
	fi
done

echo "Shell scriptleri ayarlaniyor... "
cat /dev/null > cores.list
echo $cores | awk '{gsub("db auth ", ""); print}' >> cores.list

echo "Server files basariyla olusturuldu.. "


