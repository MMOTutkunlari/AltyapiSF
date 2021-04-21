-- Metin2 Sıfırdan Altyapı Server Files Oluşturma Rehberi	--
-- MMO Tutkunları | Whistle	| mmotutkunlari.com				--
-- Bu komutlar server filesin veritabanına bağlanabilmesi	--
-- için hesaplarını oluşturur.								--

CREATE USER 'mt2'@'localhost' IDENTIFIED BY 'mt2sifre';
GRANT SELECT, INSERT, UPDATE, DELETE ON `account`.* TO 'mt2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON `common`.* TO 'mt2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON `hotbackup`.* TO 'mt2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON `log`.* TO 'mt2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON `player`.* TO 'mt2'@'localhost';
