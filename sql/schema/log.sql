-- Metin2 Sıfırdan Altyapı Server Files Oluşturma Rehberi	--
-- MMO Tutkunları | Whistle	| mmotutkunlari.com				--
-- Bu komutlar log tablolarını oluşturacak					--

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `bootlog`;
CREATE TABLE `bootlog` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`hostname` varbinary(56) NOT NULL DEFAULT 'UNKNOWN',
	`channel` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `change_empire`;
CREATE TABLE `change_empire` (
	`account_id` int(11) unsigned NOT NULL DEFAULT '0',
	`change_count` int(11) NOT NULL DEFAULT '0',
	`date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `change_name`;
CREATE TABLE `change_name` (
	`pid` int(11) unsigned NOT NULL DEFAULT '0',
	`old_name` varchar(16) NOT NULL DEFAULT '' COMMENT 'CHARACTER_NAME_MAX_LEN	= 24',
	`new_name` varchar(16) NOT NULL DEFAULT '' COMMENT 'CHARACTER_NAME_MAX_LEN	= 24',
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `command_log`;
CREATE TABLE `command_log` (
	`userid` int(11) unsigned NOT NULL DEFAULT '0',
	`server` int(11) NOT NULL DEFAULT '999',
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`port` int(11) NOT NULL DEFAULT '0',
	`username` varchar(16) NOT NULL DEFAULT 'NONAME',
	`command` varbinary(300) NOT NULL DEFAULT '',
	`date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cube`;
CREATE TABLE `cube` (
	`pid` int(11) unsigned NOT NULL DEFAULT '0',
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`x` int(11) unsigned NOT NULL DEFAULT '0',
	`y` int(11) unsigned NOT NULL DEFAULT '0',
	`item_vnum` int(11) unsigned DEFAULT NULL,
	`item_uid` int(11) unsigned DEFAULT NULL,
	`item_count` int(11) unsigned DEFAULT NULL,
	`success` tinyint(0) NOT NULL DEFAULT '0',
	INDEX `pid`(`pid`) USING BTREE,
	INDEX `item_vnum`(`item_vnum`) USING BTREE,
	INDEX `item_uid`(`item_uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `dragon_slay_log`;
CREATE TABLE `dragon_slay_log` (
	`guild_id` int(11) unsigned NOT NULL DEFAULT '0',
	`dragon_vnum` int(11) unsigned NOT NULL DEFAULT '0',
	`start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fish_log`;
CREATE TABLE `fish_log` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`pid` int(11) unsigned NOT NULL DEFAULT '0',
	`map_prob` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'Eğer mapIndex 1, 21 ve 41\'e eşit ise 0; 3, 23 ve 43\'e eşt ise 1; 60\'dan yüksek ise ve -1; default ise -1 değerini alır. GetProbIndexByMapIndex Whistle|MMOTutkunlari.com',
	`fish_id` int(11) unsigned NOT NULL DEFAULT '0',
	`fishing_level` int(11) NOT NULL DEFAULT '0',
	`waiting_time` int(11) NOT NULL DEFAULT '0',
	`success` tinyint(0) NOT NULL DEFAULT '0',
	`size` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goldlog`;
CREATE TABLE `goldlog` (
	`date` date DEFAULT NULL,
	`time` time DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`what` int(11) unsigned DEFAULT NULL,
	`how` set('BUY', 'SELL', 'SHOP_BUY', 'SHOP_SELL', 'EXCHANGE_TAKE', 'EXCHANGE_GIVE', 'QUEST') DEFAULT NULL,
	`hint` varbinary(80) DEFAULT NULL,
	INDEX `date_idx`(`date`) USING BTREE,
	INDEX `pid_idx`(`pid`) USING BTREE,
	INDEX `what_idx`(`what`) USING BTREE,
	INDEX `how_idx`(`how`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hack_crc_log`;
CREATE TABLE `hack_crc_log` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`login` varchar(16) DEFAULT NULL,
	`name` varchar(16) NOT NULL DEFAULT 'NONAME',
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`server` varbinary(56) DEFAULT NULL,
	`why` varbinary(33) DEFAULT NULL,
	`crc` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hack_log`;
CREATE TABLE `hack_log` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`login` varchar(16) DEFAULT NULL,
	`name` varchar(16) NOT NULL DEFAULT 'NONAME',
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`server` varbinary(56) DEFAULT NULL,
	`why` varbinary(33) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hackshield_log`;
CREATE TABLE `hackshield_log` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`account_id` int(11) unsigned DEFAULT NULL,
	`login` varchar(16) DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`name` varchar(16) DEFAULT NULL,
	`reason` int(11) unsigned DEFAULT NULL,
	`ip` int(11) unsigned DEFAULT NULL COMMENT "inet_aton('%s')"
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `invalid_server_log`;
CREATE TABLE `invalid_server_log` (
	`locale_type` int(11) unsigned DEFAULT NULL,
	`log_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`revision` varbinary(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `levellog`;
CREATE TABLE `levellog` (
	`name` varchar(16) DEFAULT NULL,
	`level` int(11) unsigned DEFAULT NULL,
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`account_id` int(11) unsigned DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`playtime` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
	`type` set('ITEM', 'CHARACTER') DEFAULT NULL,
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`who` int(11) unsigned DEFAULT NULL,
	`x` int(11) unsigned DEFAULT NULL,
	`y` int(11) unsigned DEFAULT NULL,
	`what` int(11) unsigned DEFAULT NULL,
	`how` varbinary(50) DEFAULT NULL,
	`hint` varbinary(80) DEFAULT NULL,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`vnum` int(11) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog` (
	`type` set('LOGIN', 'LOGOUT') DEFAULT NULL,
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`channel` int(11) unsigned DEFAULT NULL,
	`account_id` int(11) unsigned DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`level` int(11) DEFAULT NULL,
	`job` int(11) DEFAULT NULL,
	`playtime` int(11) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `loginlog2`;
CREATE TABLE `loginlog2` (
	`type` set('VALID', 'INVALID') DEFAULT NULL,
	`is_gm` set('Y', 'N') DEFAULT NULL,
	`login_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`channel` int(11) DEFAULT NULL,
	`account_id` int(11) unsigned DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`ip` int(11) unsigned DEFAULT NULL COMMENT "inet_aton('%s')",
	`client_version` varbinary(11) DEFAULT NULL,
	`logout_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`playtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `money_log`;
CREATE TABLE `money_log` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`type` int(11) DEFAULT NULL,
	`vnum` int(11) DEFAULT NULL,
	`gold` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pcbang_loginlog`;
CREATE TABLE `pcbang_loginlog` (
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`pcbang_id` int(11) unsigned DEFAULT NULL,
	`ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
	`pid` int(11) unsigned DEFAULT NULL,
	`play_time` int(11) unsigned DEFAULT NULL,
	INDEX `pid`(`pid`) USING BTREE,
	INDEX `pcbang_id`(`pcbang_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `quest_reward_log`;
CREATE TABLE `quest_reward_log` (
	`quest_name` varchar(32) DEFAULT NULL,
	`pid` int(11) unsigned DEFAULT NULL,
	`level` int(11) unsigned DEFAULT NULL,
	`type` set('EXP', 'ITEM') DEFAULT NULL,
	`how` int(11) unsigned DEFAULT NULL,
	`hint` int(11) unsigned DEFAULT NULL,
	`when` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `refinelog`;
CREATE TABLE `refinelog` (
	`pid` int(11) unsigned DEFAULT NULL,
	`item_name` varbinary(56) DEFAULT NULL,
	`item_id` int(11) unsigned DEFAULT NULL,
	`step` int(11) DEFAULT NULL,
	`time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`is_success` tinyint(1) DEFAULT NULL,
	`setType` set('HYUNIRON', 'POWER', 'SCROLL') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `shout_log`;
CREATE TABLE `shout_log` (
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `channel` int(11) DEFAULT NULL,
  `empire` int(11) DEFAULT NULL,
  `message` varbinary(512) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `speed_hack`;
CREATE TABLE `speed_hack` (
  `pid` int(11) unsigned DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `hack_count` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `vcard_log`;
CREATE TABLE `vcard_log` (
  `vcard_id` int(11) unsigned DEFAULT NULL,
  `x` int(11) unsigned DEFAULT NULL,
  `y` int(11) unsigned DEFAULT NULL,
  `hostname` varchar(50) DEFAULT NULL,
  `giver_name` varbinary(16) DEFAULT NULL,
  `giver_ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
  `taker_name` varbinary(16) DEFAULT NULL,
  `taker_ip` varchar(15) NOT NULL DEFAULT '000.000.000.000'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
