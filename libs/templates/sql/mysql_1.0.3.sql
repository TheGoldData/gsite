

ALTER TABLE `$handle_info` ADD COLUMN `cron` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL after `last_updated`

ALTER TABLE `$handle_info` CHANGE COLUMN `js` `js` text CHARACTER SET utf8mb4 DEFAULT NULL after `param`