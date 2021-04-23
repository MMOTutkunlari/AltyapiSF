-- Metin2 Sıfırdan Altyapı Server Files Oluşturma Rehberi	--
-- MMO Tutkunları | Whistle	| mmotutkunlari.com				--
-- Bu komutlar player.account'a verileri girecek			--

SET FOREIGN_KEY_CHECKS=0;

/* MySQL 8 */
INSERT INTO account (login, password, social_id, email, gold_expire, silver_expire, safebox_expire, autoloot_expire, fish_mind_expire, marriage_fast_expire, money_drop_rate_expire) VALUES ("Whistle", CONCAT('*', UPPER(SHA1(UNHEX(SHA1('12345'))))), 1111111, "whistle@mmotutkunlari.com", DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR));

/* MySQL 5 */
/*INSERT INTO account (login, password, social_id, email, gold_expire, silver_expire, safebox_expire, autoloot_expire, fish_mind_expire, marriage_fast_expire, money_drop_rate_expire) VALUES ("Whistle", PASSWORD('12345'), 1111111, "whistle@mmotutkunlari.com", DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR), DATE_ADD(NOW(), INTERVAL 1 YEAR));*/
