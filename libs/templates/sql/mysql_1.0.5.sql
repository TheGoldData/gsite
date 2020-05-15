


DROP TABLE IF EXISTS `$site`;
CREATE TABLE `$site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `name_abbr` varchar(100) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `note` varchar(512) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;



ALTER TABLE `$page_info` ADD COLUMN `site_id` bigint(20) AFTER `param`, ADD COLUMN `single` int AFTER `site_id`;
ALTER TABLE `$column_info` ADD COLUMN `site_id` bigint(20) AFTER `param`, ADD COLUMN `single` int AFTER `site_id`;


ALTER TABLE `$handle_info` ADD COLUMN `site_id` bigint(20) AFTER `cron`, ADD COLUMN `single` int AFTER `site_id`;



insert into `$setting` ( `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`) values ( '1', '2019-10-08 18:22:52', null, '1', null, 'goldsite.setting.remark.siteDomain', '2019-10-08 15:21:00', '1', '1', 'goldsite.setting.type.site', 'site.domain');

insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', '', '33', 'goldsite.resource.settings.site', '2', 'siteManage', 'site/index');

ALTER TABLE `$field_editor` ADD COLUMN `ssql` varchar(512);
ALTER TABLE `$field_editor` ADD COLUMN `ssql2` varchar(512);
ALTER TABLE `$field_editor` ADD COLUMN `js` varchar(1024);
ALTER TABLE `$field_editor` ADD COLUMN `js2` varchar(1024);
ALTER TABLE `$field_editor` ADD COLUMN `no` int;
ALTER TABLE `$field_editor` ADD COLUMN `js3` VARCHAR(1024);
ALTER TABLE `$field_editor` ADD COLUMN `lang` varchar(30);

ALTER TABLE `$site` ADD COLUMN `ad_code` varchar(32) , ADD COLUMN `css` text , ADD COLUMN `js` text ;
ALTER TABLE `$site` ADD COLUMN `vu` int;

CREATE TABLE `user_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `site_id` bigint(20) DEFAULT NULL,
  `provider_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


insert into `$setting` ( `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`) values ( '1', '2020-01-02 18:22:52', null, '1', null, 'goldsite.setting.remark.vu', '2020-01-02 18:22:52', '2', '1', 'goldsite.setting.type.site', 'app.vu');

CREATE TABLE `$filter` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`name` varchar(64),
	`kind` varchar(64),
	`path` varchar(128),
	`no` int,
	`content` text,
	`last_updated` datetime,
	`status` int,
	`site_id` bigint,
	`single` int,
	`version` bigint(20) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ;

insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', null, '1', 'goldsite.resource.presents.filters', '6', 'filterManage', 'filterInfo/index');



ALTER TABLE `$page_info` ADD COLUMN `scene` varchar(24);
ALTER TABLE `$filter` ADD COLUMN `scene` varchar(24);
ALTER TABLE `$site` ADD COLUMN `scene` varchar(24);
ALTER TABLE `$column_info` ADD COLUMN `scene` varchar(24);
ALTER TABLE `$handle_info` ADD COLUMN `scene` varchar(24);




insert into `$setting` ( `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`)
 values ( '1', '2020-01-16 18:22:52', null, '1', null, 'goldsite.setting.remark.scenes', '2020-01-02 18:22:52', '2', '1', 'goldsite.setting.type.site', 'app.scenes');

CREATE TABLE `$sec_script` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`name` varchar(24),
	`scene` varchar(24),
	`site_id` bigint,
	`content` text,
	`last_updated` datetime,
	`version` int,
	PRIMARY KEY (`id`)
) COMMENT='';

insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', null, '33', 'goldsite.resource.settings.secscript', '9', 'secScriptManage', 'secScript/index');


CREATE TABLE `$scene` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`name` varchar(255),
	`db_sql` text,
	`data_sql` text,
	`version` int,
	`status` int,
	PRIMARY KEY (`id`)
) COMMENT='';


insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', null, '33', 'goldsite.resource.settings.scene', '10', 'sceneList', 'scene/index');


ALTER TABLE `$i18n` ADD COLUMN `scene` varchar(30) AFTER `content`, ADD COLUMN `site_id` bigint AFTER `scene`, CHANGE COLUMN `version` `version` int(11) DEFAULT NULL AFTER `site_id`;

ALTER TABLE `$setting` ADD COLUMN `root` int;
ALTER TABLE `$setting` ADD COLUMN `site_id` bigint;

ALTER TABLE `$handle_info` ADD COLUMN `type`  int NULL AFTER `scene`;




insert into `$setting` (`root`, `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`)
 values ( '1','1', '2020-01-16 18:22:52', null, '1', 'css,js,png,jpg,ico', 'goldsite.setting.remark.excludeSuffixs', '2020-01-02 18:22:52', '2', '1', 'goldsite.setting.type.site', 'sys.excludeSuffixs');


ALTER TABLE `$field_editor` CHANGE COLUMN `lang` `lang2` varchar(30) DEFAULT NULL, ADD COLUMN `sep` varchar(255) AFTER `lang2`;

ALTER TABLE `$page_info` ADD COLUMN `dropdown_status` int AFTER `scene`;
ALTER TABLE `$column_info` ADD COLUMN `dropdown_status` int AFTER `scene`;

ALTER TABLE `$tab_cri` ADD COLUMN `save_before` text, ADD COLUMN `save_after` text;

ALTER TABLE `$field_editor` ADD COLUMN `multi` int ;

insert into `$setting` (`root`, `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`)
 values ( '1','1', '2020-01-16 18:22:52', null, '1', 'user_info,ip_log_daily,user_log,user_site,"$*,__*', 'goldsite.setting.remark.excludeTables', '2020-01-02 18:22:52', '2', '1', 'goldsite.setting.type.site', 'sys.excludeTables');

insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', null, '1', 'goldsite.resource.presents.staticInfo', '9', 'staticManage', 'staticInfo/index');

CREATE TABLE `$theme_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `theme_name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` text,
  `last_updated` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

ALTER TABLE `$tab_cri` ADD COLUMN `js` text ;


insert into `$console_resource` ( `version`, `icon_url`, `parent_id`, `display_name`, `orderno`, `name`, `url`) values ( '1', null, null, 'goldsite.resource.settings.ext', '10', 'ext', null);


ALTER TABLE `$page_info` ADD COLUMN `mana` int ;
ALTER TABLE `$page_info` ADD COLUMN `res` int ;
ALTER TABLE `$page_info` ADD COLUMN `resource_id` bigint(20) ;

ALTER TABLE `$handle_info` ADD COLUMN `mana` int ;


insert into `$setting` (`root`, `version`, `last_updated`, `admin_id`, `type`, `value`, `remark`, `date_created`, `no`, `edit_status`, `type_label`, `name`)
 values ( '1','1', '2020-01-16 18:22:52', null, '1', '', 'goldsite.setting.remark.helpUrl', '2020-01-02 18:22:52', '2', '1', 'goldsite.setting.type.site', 'sys.helpUrl');

insert into `$console_perm` ( `res_name`, `display_name`, `name`, `resource_id`, `version`) values ( 'tableList', 'goldsite.perm.table.create', 'table:create', null, '0');
insert into `$console_perm` ( `res_name`, `display_name`, `name`, `resource_id`, `version`) values ( 'tableList', 'goldsite.perm.table.update', 'table:update', null, '0');
insert into `$console_perm` ( `res_name`, `display_name`, `name`, `resource_id`, `version`) values ( 'tableList', 'goldsite.perm.table.index', 'table:index', null, '0');
insert into `$console_perm` ( `res_name`, `display_name`, `name`, `resource_id`, `version`) values ( 'tableList', 'goldsite.perm.table.delete', 'table:delete', null, '0');
insert into `$console_perm` ( `res_name`, `display_name`, `name`, `resource_id`, `version`) values ( 'tableList', 'goldsite.perm.table.editor', 'table:editor', null, '0');