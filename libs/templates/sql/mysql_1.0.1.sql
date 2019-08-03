
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `$admin_info`
-- ----------------------------
DROP TABLE IF EXISTS `$admin_info`;
CREATE TABLE `$admin_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '登录名',
  `realname` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '真实姓名',
  `nickname` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '昵名',
  `pwd` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `salt` int(11) DEFAULT NULL COMMENT '盐',
  `date_created` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态1正常 0禁用',
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='管理员信息';

-- ----------------------------
--  Records of `$admin_info`
-- ----------------------------
BEGIN;
INSERT INTO `$admin_info` VALUES ('1', 'admin', '管理员', '超级人员', '68aee379d8f4721256fa91b8bb00d056', '5', '2017-06-22 11:27:58', '1', '16');
COMMIT;

-- ----------------------------
--  Table structure for `$audit_log`
-- ----------------------------
DROP TABLE IF EXISTS `$audit_log`;
CREATE TABLE `$audit_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `module` int(11) DEFAULT NULL COMMENT '模块 1管理员 2权限 3钱包 4 用户 5系统设置',
  `type` int(11) DEFAULT NULL COMMENT '操作类型1添加 2修改 3删除 4登录 5退出 6查看',
  `content` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `admin_id` bigint(20) DEFAULT NULL COMMENT '操作员ID',
  `admin_name` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '管理员名称',
  `date_created` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '操作状态0未成功1成功',
  `ip` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='审计日志';

-- ----------------------------
--  Table structure for `$bak_tpl`
-- ----------------------------
DROP TABLE IF EXISTS `$bak_tpl`;
CREATE TABLE `$bak_tpl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `ref_id` bigint(20) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `content` text,
  `date_created` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$col`
-- ----------------------------
DROP TABLE IF EXISTS `$col`;
CREATE TABLE `$col` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `content` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$column_info`
-- ----------------------------
DROP TABLE IF EXISTS `$column_info`;
CREATE TABLE `$column_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `ret_type` int(11) DEFAULT NULL,
  `tbl` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `hide_cols` varchar(255) DEFAULT NULL,
  `content` text,
  `version` bigint(20) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `criteria` varchar(512) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `afterjs` text,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `sort_fields` varchar(128) DEFAULT NULL,
  `tpl` text,
  `param` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_col_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$column_item`
-- ----------------------------
DROP TABLE IF EXISTS `$column_item`;
CREATE TABLE `$column_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_id` bigint(20) DEFAULT NULL,
  `name` varchar(512) DEFAULT NULL,
  `href` varchar(512) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `img_url` varchar(512) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$column_top`
-- ----------------------------
DROP TABLE IF EXISTS `$column_top`;
CREATE TABLE `$column_top` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target_id` varchar(32) NOT NULL,
  `no` int(11) DEFAULT NULL,
  `col_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_col_id` (`col_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$console_perm`
-- ----------------------------
DROP TABLE IF EXISTS `$console_perm`;
CREATE TABLE `$console_perm` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `display_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '标签',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `res_name` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='权限';

-- ----------------------------
--  Records of `$console_perm`
-- ----------------------------
BEGIN;
INSERT INTO `$console_perm` VALUES ('2', '0', 'goldsite.perm.license.register', 'license:register', '34', 'sysManage'), ('3', '0', 'goldsite.perm.license.revoke', 'license:cancel', '34', 'sysManage');
COMMIT;

-- ----------------------------
--  Table structure for `$console_perm_role_rela`
-- ----------------------------
DROP TABLE IF EXISTS `$console_perm_role_rela`;
CREATE TABLE `$console_perm_role_rela` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version` bigint(20) DEFAULT NULL,
  `perm_id` bigint(20) DEFAULT NULL COMMENT '权限ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='权限角色表';

-- ----------------------------
--  Table structure for `$console_resource`
-- ----------------------------
DROP TABLE IF EXISTS `$console_resource`;
CREATE TABLE `$console_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `icon_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `display_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '标签',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `orderno` int(11) DEFAULT NULL COMMENT '排序',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL',
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='后台资源';

-- ----------------------------
--  Records of `$console_resource`
-- ----------------------------
BEGIN;
INSERT INTO `$console_resource` VALUES ('1', 'fas fa-globe', 'goldsite.resource.presents', 'pageManager', '3', null, null, '1'), ('3', 'fas fa-shield-alt', 'goldsite.resource.permissions', 'privManager', '1', null, null, '1'), ('4', null, 'goldsite.resource.admins', 'adminList', '1', '3', 'admin/list_page', '1'), ('5', null, 'goldsite.resource.roles', 'roleList', '2', '3', 'admin/roleList_page', '1'), ('8', 'fas fa-compact-disc', 'goldsite.resource.audit', 'auditManager', '6', null, null, '1'), ('9', null, 'goldsite.resource.audit.list', 'auditLogList', '1', '8', 'auditLog/index', '1'), ('10', null, 'goldsite.resource.presents.pages', 'pageInfoManage', '2', '1', 'pageInfo/index', '1'), ('13', null, 'goldsite.resource.presents.menus', 'menuManage', '1', '1', 'menu/index', '1'), ('14', null, 'goldsite.resource.presents.columns', 'columnManager', '3', '1', 'columnInfo/index', '1'), ('28', 'fas fa-database', 'goldsite.resource.data', 'tableManager', '5', null, null, '1'), ('29', null, 'goldsite.resource.data.tables', 'tableList', '1', '28', 'table/index', '1'), ('31', 'fas fa-yin-yang', 'goldsite.resource.users', 'userInfoManager', '4', null, null, '1'), ('32', null, 'goldsite.resource.users.list', 'userInfoList', '1', '31', 'userInfo/index', '1'), ('33', 'fas fa-palette', 'goldsite.resource.settings', 'systemManager', '7', null, null, '1'), ('34', null, 'goldsite.resource.settings.system', 'sysManage', '1', '33', 'setting/index', '1'), ('35', null, 'goldsite.resource.settings.personal', 'personalManage', '3', '33', 'personal/personal', '1'), ('36', null, 'goldsite.resource.presents.handles', 'handleManage', '5', '1', 'handleInfo/index', '1'), ('37', null, 'goldsite.resource.settings.i18n', 'i18nManage', '6', '33', 'i18n/index', '1');
COMMIT;

-- ----------------------------
--  Table structure for `$console_resource_role_rela`
-- ----------------------------
DROP TABLE IF EXISTS `$console_resource_role_rela`;
CREATE TABLE `$console_resource_role_rela` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='资源角色关联表';

-- ----------------------------
--  Table structure for `$console_role`
-- ----------------------------
DROP TABLE IF EXISTS `$console_role`;
CREATE TABLE `$console_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `display_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '标签',
  `last_updated` datetime DEFAULT NULL COMMENT '最后更新日期',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='角色';

-- ----------------------------
--  Table structure for `$console_role_user_rela`
-- ----------------------------
DROP TABLE IF EXISTS `$console_role_user_rela`;
CREATE TABLE `$console_role_user_rela` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version` bigint(20) DEFAULT NULL COMMENT '版本',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `admin_id` bigint(20) DEFAULT NULL COMMENT 'adminID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='角色用户关联表';

-- ----------------------------
--  Table structure for `$field_editor`
-- ----------------------------
DROP TABLE IF EXISTS `$field_editor`;
CREATE TABLE `$field_editor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `dir` varchar(100) DEFAULT NULL,
  `opt` text,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `$field_editor`
-- ----------------------------
BEGIN;
INSERT INTO `$field_editor` VALUES ('4', 'user_info', 'pass', '0', null, null, '0', '2019-06-17 15:34:21', '2019-06-17 15:34:21'), ('5', 'user_info', 'salt', '0', null, null, '0', '2019-06-17 15:34:26', '2019-06-17 15:34:26'), ('9', 'user_info', 'date_created', '4', null, null, '0', '2019-06-20 23:47:05', '2019-06-20 23:47:05'), ('10', 'user_info', 'avator', '5', null, null, '0', '2019-06-27 13:27:31', '2019-06-27 13:27:31'), ('11', 'user_info', 'email', '1', null, null, '1', '2019-07-14 15:25:02', '2019-07-14 15:25:19');
COMMIT;

-- ----------------------------
--  Table structure for `$handle_info`
-- ----------------------------
DROP TABLE IF EXISTS `$handle_info`;
CREATE TABLE `$handle_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL,
  `param` varchar(1024) DEFAULT NULL,
  `js` varchar(2048) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$i18n`
-- ----------------------------
DROP TABLE IF EXISTS `$i18n`;
CREATE TABLE `$i18n` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `locale` varchar(10) DEFAULT NULL,
  `code` varchar(128) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$menu`
-- ----------------------------
DROP TABLE IF EXISTS `$menu`;
CREATE TABLE `$menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `page_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$page_info`
-- ----------------------------
DROP TABLE IF EXISTS `$page_info`;
CREATE TABLE `$page_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `tbl` varchar(255) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `criteria` varchar(512) DEFAULT NULL,
  `content` text,
  `tpl` varchar(128) DEFAULT NULL,
  `hide_cols` varchar(512) DEFAULT NULL,
  `ret_type` int(11) DEFAULT NULL,
  `js` text,
  `afterjs` text,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `sort_fields` varchar(100) DEFAULT NULL,
  `tpl_type` int(11) DEFAULT NULL,
  `page_max` int(11) DEFAULT NULL,
  `param` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$page_meta`
-- ----------------------------
DROP TABLE IF EXISTS `$page_meta`;
CREATE TABLE `$page_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_id` bigint(20) DEFAULT NULL,
  `after_title` int(11) DEFAULT NULL COMMENT '0在前，1在后',
  `attr_name` varchar(100) DEFAULT NULL,
  `attr_value` varchar(100) DEFAULT NULL,
  `content` varchar(512) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$page_top`
-- ----------------------------
DROP TABLE IF EXISTS `$page_top`;
CREATE TABLE `$page_top` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target_id` varchar(32) NOT NULL,
  `no` int(11) DEFAULT NULL,
  `page_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_page_page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$setting`
-- ----------------------------
DROP TABLE IF EXISTS `$setting`;
CREATE TABLE `$setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` int(11) DEFAULT NULL,
  `type_label` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `value` text COLLATE utf8_bin COMMENT '值',
  `date_created` datetime DEFAULT NULL COMMENT '创建时间',
  `version` bigint(20) DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `edit_status` int(11) DEFAULT NULL COMMENT '0不能在系统中配制 1可以',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='系统配制';

-- ----------------------------
--  Records of `$setting`
-- ----------------------------
BEGIN;
INSERT INTO `$setting` VALUES ('1', '1', 'goldsite.setting.type.site', 'site.name', '流量电商', '2017-07-01 13:55:44', '5', 'goldsite.setting.remark.sitename', null, '2019-07-11 11:23:51', '1', '1'), ('2', '1', 'goldsite.setting.type.site', 'site.theme', 'blue', '2017-07-01 14:46:20', '1', 'goldsite.setting.remark.theme', null, '2019-05-20 14:24:42', '1', '1'), ('7', '3', 'goldsite.setting.type.smtp', 'smtp.host', 'smtp.office365.com', '2018-05-23 23:33:38', '4', 'goldsite.setting.remark.smtphost', null, '2019-03-28 15:26:47', '1', '1'), ('8', '3', 'goldsite.setting.type.smtp', 'smtp.port', '587', '2018-05-23 23:33:38', '2', 'goldsite.setting.remark.smtpport', null, '2019-03-28 15:26:58', '2', '1'), ('9', '3', 'goldsite.setting.type.smtp', 'smtp.user', '', '2018-05-23 23:33:38', '2', 'goldsite.setting.remark.smtpuser', null, '2019-03-28 15:27:09', '3', '1'), ('10', '3', 'goldsite.setting.type.smtp', 'smtp.pass', '', '2018-05-23 23:33:38', '4', 'goldsite.setting.remark.smtppass', null, '2019-07-07 23:08:38', '4', '1'), ('19', '5', 'goldsite.setting.type.mailTpl', 'mail.register', 'goldsite.user.mail.register.tpl', '2019-07-02 15:37:30', '3', 'goldsite.setting.remark.mailRegister', null, '2019-07-23 18:01:58', '1', '1'), ('20', '5', 'goldsite.setting.type.mailTpl', 'mail.forgot', 'goldsite.user.mail.forgot.tpl', '2019-07-02 15:37:39', '3', 'goldsite.setting.remark.mailForgot', null, '2019-07-23 18:01:45', '1', '1'), ('21', '6', 'goldsite.setting.type.login', 'login.welcomeUrl', '/', '2019-07-03 15:37:46', '1', 'goldsite.setting.remark.loginWelcomeUrl', null, null, '1', '1'), ('22', '6', 'goldsite.setting.type.login', 'login.exitUrl', '/', '2019-07-03 15:37:55', '1', 'goldsite.setting.remark.loginExitUrl', null, null, '1', '1'), ('23', '1', 'goldsite.setting.type.site', 'sys.tplyes', 'yes', '2019-07-13 20:08:29', '3', 'goldsite.setting.remark.sysTplYes', null, '2019-07-13 20:11:08', '1', '1'), ('24', '1', 'goldsite.setting.type.site', 'sys.i18n', 'zh,en', '2019-07-22 07:01:28', '3', 'goldsite.setting.remark.sysi18n', null, '2019-07-22 13:08:47', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `$tab_cri`
-- ----------------------------
DROP TABLE IF EXISTS `$tab_cri`;
CREATE TABLE `$tab_cri` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tab` varchar(60) DEFAULT NULL,
  `cris` text,
  `version` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$update_event`
-- ----------------------------
DROP TABLE IF EXISTS `$update_event`;
CREATE TABLE `$update_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ref_id` bigint(20) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `pub_date` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `$version`
-- ----------------------------
DROP TABLE IF EXISTS `$version`;
CREATE TABLE `$version` (
  `id` bigint(20) NOT NULL,
  `value` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `ip_log_daily`
-- ----------------------------
DROP TABLE IF EXISTS `ip_log_daily`;
CREATE TABLE `ip_log_daily` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `ua` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮件',
  `phone` varchar(13) DEFAULT NULL COMMENT '电话',
  `nickname` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '昵称',
  `gender` int(11) DEFAULT NULL COMMENT '姓别:0 male 1 female',
  `date_created` datetime DEFAULT NULL COMMENT '创建日期',
  `date_birth` datetime DEFAULT NULL COMMENT '年龄',
  `pass` varchar(32) DEFAULT NULL COMMENT '密码',
  `salt` int(11) DEFAULT NULL COMMENT '加密盐',
  `avator` varchar(512) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_info_date_created` (`date_created`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `user_log`
-- ----------------------------
DROP TABLE IF EXISTS `user_log`;
CREATE TABLE `user_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `value` varchar(512) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
