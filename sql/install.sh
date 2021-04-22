#!/bin/sh
#### @Whistle | www.mmotutkunlari.com | Otomatik veritabanı oluşturma scripti ####
main_dir=$(pwd)
main="game_db game_user"
schema="account common log player"
table_data="account banword item_attr item_attr_rare land object_proto refine_proto shop shop_item skill_proto"

read -p "Veritabanı şifrenizi girin: " pass

echo "Veritabanları oluşturuluyor... "
for m in $main
do
	mysql -uroot -p$pass < $main_dir/main/$m.sql
done

for s in $schema
do
	echo "Tablolar oluşturuluyor => "$s
	mysql -uroot -p$pass $s < $main_dir/schema/$s.sql
	
	for t in $table_data
	do
		if [ -f $main_dir/table_data/$s"__"$t".sql" ]; then
			echo $s"."$t" verileri ekleniyor."
			mysql -uroot -p$pass $s < $main_dir/table_data/$s"__"$t".sql"
		fi
	done
done

