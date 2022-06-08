
CREATE TABLE `dm_filelist` (
  `no` int(11) NOT NULL auto_increment,
  `title` varchar(64) NOT NULL default '',
  `filename` varchar(64) NOT NULL default '',
  `crc` varchar(32) NOT NULL default '',
  `stepcount` int(11) NOT NULL default '0',
  `score_count` int(11) NOT NULL default '0',
  `last_reg_time` int(11) NOT NULL default '0',
  PRIMARY KEY  (`no`)
);


CREATE TABLE `dm_scorelist` (
  `no` int(11) NOT NULL auto_increment,
  `time` int(11) NOT NULL default '0',
  `id` varchar(64) NOT NULL default '',
  `name` varchar(64) NOT NULL default '',
  `ksf` int(11) NOT NULL default '0',
  `score` int(11) NOT NULL default '0',
  `exorbitant` int(11) NOT NULL default '0',
  `perfect` int(11) NOT NULL default '0',
  `great` int(11) NOT NULL default '0',
  `good` int(11) NOT NULL default '0',
  `bad` int(11) NOT NULL default '0',
  `miss` int(11) NOT NULL default '0',
  `maxcombo` int(11) NOT NULL default '0',
  `percentage` varchar(8) NOT NULL default '',
  `mode_fade` int(11) NOT NULL default '0',
  `mode_rush` int(11) NOT NULL default '0',
  `mode_random` int(11) NOT NULL default '0',
  `mode_unknown` int(11) NOT NULL default '0',
  `comment` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`no`)
);

