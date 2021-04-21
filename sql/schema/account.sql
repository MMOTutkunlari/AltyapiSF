-- Metin2 Sıfırdan Altyapı Server Files Oluşturma Rehberi	--
-- MMO Tutkunları | Whistle	| mmotutkunlari.com				--
-- Bu komutlar account tablolarını oluşturacak				--

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`login` varchar(16) NOT NULL DEFAULT '' COMMENT 'LOGIN_MAX_LEN=30',
	`password` varchar(45) NOT NULL DEFAULT '' COMMENT 'PASSWD_MAX_LEN=16',
	`social_id` varchar(7) NOT NULL DEFAULT '',	
	`email` varchar(100) NOT NULL DEFAULT '',
	`securitycode` varchar(192) NOT NULL DEFAULT '',
	`status` varchar(9) NOT NULL DEFAULT 'OK' COMMENT 'OK, BLOCK=banli, VERIFY=dogrulanmamis, NOBILL=odeme yok, WEBBLK=web sitesi engeli Whistle|MMOTutkunlari.com',
	`availDt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_play` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	`gold_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`silver_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`safebox_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`autoloot_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`fish_mind_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`marriage_fast_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`money_drop_rate_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	`real_name` varchar(16) DEFAULT '',
	`phone1` varchar(16) DEFAULT NULL,
	`cash` int(11) DEFAULT 0 COMMENT 'ItemShop - EP',
	`mileage` int(11) DEFAULT 0 COMMENT 'ItemShop - EM',
	PRIMARY KEY (`id`),
	UNIQUE KEY `login` (`login`) USING BTREE,
	KEY `social_id` (`social_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `block_exception`;
CREATE TABLE `block_exception` (
	`login` varchar(16) NOT NULL DEFAULT '',
	UNIQUE KEY `login` (`login`) USING BTREE
) ENGINE=MyISAM default charset=latin1;


DROP TABLE IF EXISTS `GameTime`;
CREATE TABLE `GameTime` (
	`UserID` varchar(16) NOT NULL DEFAULT '',
	`paymenttype` tinyint(2) NOT NULL DEFAULT '1',
	`LimitTime` int(11) unsigned DEFAULT '0',
	`LimitDt` datetime DEFAULT CURRENT_TIMESTAMP,
	`Scores` int(11) DEFAULT '0',
	PRIMARY KEY (`UserID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `GameTimeIP`;
CREATE TABLE `GameTimeIP` (
	`ipid` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(128) DEFAULT NULL,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`startIP` int(11) NOT NULL DEFAULT '0',
	`endIP` int(11) NOT NULL DEFAULT '255',
	`paymenttype` tinyint(2) NOT NULL DEFAULT '1',
	`LimitTime` int(11) NOT NULL DEFAULT '0',
	`LimitDt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`readme` varchar(128) DEFAULT NULL,
	PRIMARY KEY (`ipid`),
	UNIQUE KEY `ip_uniq` (`ip`,`startIP`,`endIP`),
	KEY `ip_idx` (`ip`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `GameTimeLog`;
CREATE TABLE `GameTimeLog` (
	`login` varchar(16) DEFAULT NULL,
	`type` enum('IP_FREE', 'FREE', 'IP_TIME', 'IP_DAY', 'TIME', 'DAY') DEFAULT NULL,
	`logon_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`logout_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`use_time` int(11) unsigned DEFAULT NULL,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`server` varchar(56) NOT NULL DEFAULT '',
	KEY `login_key` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `iptocountry`;
CREATE TABLE `iptocountry` (
	`IP_FROM` varchar(16) DEFAULT NULL,
	`IP_TO` varchar(16) DEFAULT NULL,
	`COUNTRY_NAME` varchar(56) DEFAULT NULL,
	UNIQUE KEY `ipcountry_uniq` (`IP_FROM`, `IP_TO`, `COUNTRY_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `string`;
CREATE TABLE `string` (
	`name` varchar(255) NOT NULL DEFAULT '',
	`text` text NULL,
	PRIMARY KEY(`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vcard`;
CREATE TABLE `vcard` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`sell_account` varchar(16) NOT NULL DEFAULT '',
	`buy_account` varchar(16) NOT NULL DEFAULT '',
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
