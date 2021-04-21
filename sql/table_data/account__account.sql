-- Metin2 Sıfırdan Altyapı Server Files Oluşturma Rehberi	--
-- MMO Tutkunları | Whistle	| mmotutkunlari.com				--
-- Bu komutlar player.account'a verileri girecek			--

SET FOREIGN_KEY_CHECKS=0;

/* MySQL 8 */
INSERT INTO account (id, login, password, social_id, email) VALUES (1, "Whistle", CONCAT('*', UPPER(SHA1(UNHEX(SHA1('12345'))))), 1111111, "whistle@mmotutkunlari.com");

/* MySQL 5 */
/*INSERT INTO account (id, login, password, social_id, email) VALUES (1, "Whistle", PASSWORD('12345'), 1111111, "whistle@mmotutkunlari.com");*/
