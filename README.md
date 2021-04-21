# AltyapiSF

### Hakkında ###
Metin2 Sıfırdan Altyapı Server Files Hazırlama Rehberini hazırlarken oluşturduğum server files.                                                                                       
Rehbere bakmak isterseniz: https://www.mmotutkunlari.com/konu/metin2-sifirdan-altyapi-server-files-hazirlama-rehberi.7141

### Nasıl Kurulur? ####
Şuan için bu dosyalar Freebsd 13, Freebsd 12 veya 11.x ile çalışmaktadır. 
Ancak ilk önce server source dosyalarını derlemeniz gerekiyor: https://github.com/MMOTutkunlari/AltyapiServer

#### Kurulması Gereken Paketler ####
* mysql80-client
* mysql80-server
* openssl
* python
* git
* gcc9
* gmake
* makedepend
* subversion


MySQL'i Freebsd'ye kurun. Kurulumla ilgili detaylı bilgi: https://www.mmotutkunlari.com/konu/metin2-mysql-8-0-kurulumu-videolu-anlatim.7969/

Paketleri kurduktan ve kaynak kodlarını derledikten sonra filesi kurabilirsiniz.
Sırayla şu komutları uygulayın.                                                                                                                                                   
Ana dizine gidin.
> cd /home

Server filesi git ile çekin.
> git clone https://github.com/MMOTutkunlari/AltyapiSF.git

İlk önce veritabanına oyunun tablolarını ekliyoruz.
> cd /home/AltyapiSF/sql/                                                                                                                                               
> sh install.sh                                                                                                                                                         
> Veritabanı şifrenizi girin: <buraya mysql'u oluştururken tanımladığınız şifreyi girin.>

Derlediğiniz çekirdek dosyalarını filese tanımlayın
> cd /home/AltyapiSF/share/bin                                                                                                                                         
> ln -s /home/AltyapiSF/Srcs/Server/game/game_r40020 game                                                                                                               
> ln -s /home/AltyapiSF/Srcs/Server/db/db_r400200 db

Server files kanallarının oluşturulması
> cd /home/AltyapiSF                                                                                                                                                   
> sh gen.sh

Questlerin derlenmesi
> cd /home/AltyapiSF/share/locale/turkey/quest                                                                                                                         
> sh gen.sh

Oyunu başlatmak
> cd /home/AltyapiSF                                                                                                                                                   
> sh start.sh

### Sonra neler yapacağım? ###
Server filesi kurduktan sonra clienti ayarlayabilirsiniz.
> Client: https://github.com/MMOTutkunlari/AltyapiClient                                                                                                                         
> Pack: https://github.com/MMOTutkunlari/AltyapiPack

Aklınıza takılan sorular olursa sitemize gelip sormaktan çekinmeyiniz. :)                                                                                                         
www.mmotutkunlari.com | Whistle

Bu files yalnızca MMO Tutkunları adına Whistle tarafından oluşturulmuştur. Kaynağı gösterilmek şartı ile paylaşılabilir.
