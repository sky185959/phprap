/*
 Navicat Premium Data Transfer

 Source Server         : develop环境
 Source Server Type    : MySQL
 Source Server Version : 50634
 Source Host           : 101.200.36.159
 Source Database       : apidoc

 Target Server Type    : MySQL
 Target Server Version : 50634
 File Encoding         : utf-8

 Date: 10/25/2017 23:29:22 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `doc_api`
-- ----------------------------
DROP TABLE IF EXISTS `doc_api`;
CREATE TABLE `doc_api` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module_id` int(10) NOT NULL DEFAULT '0' COMMENT '模块id',
  `title` varchar(250) NOT NULL DEFAULT '' COMMENT '接口名',
  `method` int(3) NOT NULL DEFAULT '2' COMMENT '请求方法，1:get 2:post 3:put',
  `uri` varchar(250) NOT NULL DEFAULT '' COMMENT '接口地址',
  `intro` varchar(250) NOT NULL DEFAULT '' COMMENT '接口简介',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `demo` text COMMENT '演示数据',
  PRIMARY KEY (`id`),
  KEY `module_id_index` (`module_id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='项目接口表';

-- ----------------------------
--  Records of `doc_api`
-- ----------------------------
BEGIN;
INSERT INTO `doc_api` VALUES ('2', '3', '测试', '3', 'api/getUserInfo.json', '获取用户信息', '2', '2017-10-17 19:58:41', '{\"sites\":[{\"name\":\"勾国磊\",\"url\":\"www.runoob.com\"},{\"name\":\"勾国印\",\"url\":\"www.google.com\"},{\"name\":\"石武浩\",\"url\":\"www.weibo.com\"}]}'), ('3', '3', '测试1', '3', 'project/25.html', '', '7', '2017-10-18 00:39:14', '{\"code\":200,\"msg\":\"\\u6210\\u529f\",\"data\":{\"name\":\"\\u52fe\\u56fd\\u78ca\",\"title\":\"\\u6807\\u9898\"}}'), ('12', '7', '哈啊哈', '3', 'http://gocmf.com/project/26.html', 'http://gocmf.com/project/26.html', '7', '2017-10-19 20:43:57', null), ('13', '1', '获取会员列表', '1', 'user/getUserList.json', '获取会员列表获取会员列表获取会员列表', '7', '2017-10-21 22:19:52', null), ('14', '1', '获取会员详情', '3', 'project/17.html', '获取会员详情', '2', '2017-10-21 18:21:36', null), ('15', '8', '测试接口', '2', 'project/lmHQJHHzjW.html', '', '7', '2017-10-21 22:09:21', null);
COMMIT;

-- ----------------------------
--  Table structure for `doc_apply`
-- ----------------------------
DROP TABLE IF EXISTS `doc_apply`;
CREATE TABLE `doc_apply` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目id',
  `creater_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目创建者id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '申请用户id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态',
  `add_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '申请时间',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`),
  KEY `creater_id` (`creater_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='申请加入项目表';

-- ----------------------------
--  Records of `doc_apply`
-- ----------------------------
BEGIN;
INSERT INTO `doc_apply` VALUES ('9', '26', '7', '3', '1', '2017-10-19 20:02:52'), ('10', '17', '2', '7', '1', '2017-10-24 02:19:18'), ('11', '17', '2', '7', '1', '2017-10-24 02:25:26'), ('12', '17', '2', '7', '1', '2017-10-24 12:29:09');
COMMIT;

-- ----------------------------
--  Table structure for `doc_config`
-- ----------------------------
DROP TABLE IF EXISTS `doc_config`;
CREATE TABLE `doc_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `config` text NOT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
--  Records of `doc_config`
-- ----------------------------
BEGIN;
INSERT INTO `doc_config` VALUES ('2', '{\"name\":\"\\u6854\\u5b50\\u5206\\u671f\",\"keywords\":\"\\u63a5\\u53e3\\u7ba1\\u7406\\uff0capi\\u6587\\u6863\\u7ba1\\u7406\",\"copyright\":\"Copyright \\u00a9 2017 APIDOC\\u7248\\u6743\\u6240\\u6709\",\"email\":\"245629560@qq.com\",\"default_password\":\"4567890\",\"is_close\":\"0\",\"close_msg\":\"\\u7cfb\\u7edf\\u5347\\u7ea7\\uff0c\\u6682\\u65f6\\u65e0\\u6cd5\\u8bbf\\u95ee\\uff0c\\u8bf7\\u7a0d\\u5019\\u518d\\u8bd5\\uff01\"}', '2017-10-23 22:19:25');
COMMIT;

-- ----------------------------
--  Table structure for `doc_field`
-- ----------------------------
DROP TABLE IF EXISTS `doc_field`;
CREATE TABLE `doc_field` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `api_id` int(10) NOT NULL DEFAULT '0' COMMENT '接口id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建者用户id',
  `parent_id` int(10) NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '接口名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '接口标题',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '字段类型',
  `method` tinyint(3) NOT NULL DEFAULT '1' COMMENT '参数类型，1:请求字段 2:响应字段',
  `is_required` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否必传',
  `default_value` varchar(250) DEFAULT '' COMMENT '默认值',
  `intro` varchar(250) NOT NULL DEFAULT '' COMMENT '备注',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `api_id_index` (`api_id`),
  KEY `user_id_index` (`user_id`),
  KEY `parent_id_index` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='项目字段表';

-- ----------------------------
--  Records of `doc_field`
-- ----------------------------
BEGIN;
INSERT INTO `doc_field` VALUES ('18', '83', '7', '0', 'demo23456', 'jjjjj', '1', '1', '1', '', '', '2017-10-10 18:20:52'), ('21', '8', '7', '0', 'ppppp', '平平淡淡', 'string', '1', '1', '', '', '2017-10-10 14:33:47'), ('22', '8', '7', '0', 'uuuuuu', 'uuuuu', 'string', '1', '1', '', '', '2017-10-10 18:06:25'), ('25', '8', '7', '0', 'ddd', 'ddd', 'string', '1', '1', '', '', '2017-10-10 15:21:26'), ('27', '8', '7', '0', 'kkkk', 'kkkk', 'string', '2', '0', '', '', '2017-10-10 18:20:42'), ('28', '8', '7', '0', 'pppp', 'ppppp', 'string', '2', '0', '', '', '2017-10-10 15:31:08'), ('29', '8', '7', '0', 'dddddd', 'ffff', 'string', '2', '0', '', '', '2017-10-10 15:31:26'), ('30', '8', '7', '0', 'hhhh', 'hhhh', 'string', '2', '0', '', '', '2017-10-10 15:32:28'), ('31', '8', '7', '0', 'msg', '错误信息', 'string', '2', '0', '', '成功没有', '2017-10-10 18:27:43'), ('32', '8', '7', '0', 'lllll', 'kkkkk', 'string', '1', '1', '', '', '2017-10-10 18:10:04'), ('33', '8', '7', '0', 'kkkk', 'kkkk', 'string', '1', '1', '', '', '2017-10-10 18:09:54'), ('35', '3', '7', '0', 'data', '数据实体', 'array', '2', '0', '', '', '2017-10-10 20:46:52'), ('36', '3', '2', '0', 'msg', '错误信息', 'boolean', '2', '0', 'true', '', '2017-10-16 14:02:26'), ('38', '3', '2', '35', 'title', '标题', 'string', '2', '0', '标题5', '', '2017-10-16 20:47:41'), ('39', '3', '2', '35', 'name', '名字', 'string', '2', '0', '名字57', '', '2017-10-16 20:48:15'), ('42', '3', '2', '0', 'title', '标题', 'string', '1', '1', '123456', '标题', '2017-10-16 16:48:09'), ('43', '3', '2', '0', 'name', '名字', 'string', '1', '1', '就解决', '哈哈', '2017-10-17 10:41:51'), ('44', '3', '2', '0', 'code', '状态码', 'int', '2', '0', '854', '', '2017-10-16 12:23:56'), ('45', '2', '2', '0', 'api_id', '那么', 'string', '1', '1', '', '', '2017-10-16 20:05:56'), ('46', '2', '2', '0', 'msg', '错误信息', 'string', '2', '0', '错误信息86', '', '2017-10-16 20:22:00'), ('49', '13', '2', '0', 'code2', '状态码', 'int', '2', '0', '754', '200代表成功', '2017-10-21 00:16:17'), ('50', '13', '2', '0', 'msg', '错误信息', 'string', '2', '0', '错误信息32', '', '2017-10-21 00:16:29'), ('51', '13', '2', '0', 'data', '数据实体', 'array', '2', '0', null, '', '2017-10-21 00:17:29'), ('52', '13', '2', '0', 'token123456', '密钥', 'string', '1', '1', '', '', '2017-10-21 16:54:59'), ('53', '13', '2', '51', 'name', '名字', 'string', '2', '0', '名字94', '', '2017-10-21 17:19:12'), ('60', '15', '2', '0', 'title', '标题', 'string', '1', '1', '', '', '2017-10-24 14:02:36'), ('61', '14', '2', '0', 'name', '名字', 'string', '1', '1', '', '', '2017-10-24 14:07:42'), ('62', '14', '2', '0', 'code', '状态码', 'int', '2', '0', '768', '', '2017-10-24 14:09:41'), ('71', '13', '2', '0', 'kkkll', 'kkk', 'string', '1', '1', '', '', '2017-10-25 00:19:09'), ('74', '13', '2', '51', 'demo', 'demo', 'string', '2', '0', 'demo84', '', '2017-10-25 00:26:23');
COMMIT;

-- ----------------------------
--  Table structure for `doc_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `doc_login_log`;
CREATE TABLE `doc_login_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名称',
  `user_email` varchar(50) NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT '登录ip',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '登录地址',
  `device` varchar(50) NOT NULL DEFAULT '' COMMENT '登录设备',
  `add_time` datetime NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 COMMENT='登录日志表';

-- ----------------------------
--  Records of `doc_login_log`
-- ----------------------------
BEGIN;
INSERT INTO `doc_login_log` VALUES ('99', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-23 12:16:43'), ('100', '7', '勾国磊', '314418388@qq.com', '223.104.3.238', '中国  北京市 北京市', 'weixin', '2017-10-23 15:22:38'), ('101', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-23 23:18:38'), ('102', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 01:27:18'), ('103', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 01:27:48'), ('104', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:04:37'), ('105', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:18:11'), ('106', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:19:38'), ('107', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:19:49'), ('108', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:19:59'), ('109', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:20:10'), ('110', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:20:23'), ('111', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:20:46'), ('112', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:21:33'), ('113', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:25:00'), ('114', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:28:44'), ('115', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:29:15'), ('116', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:43:51'), ('117', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:44:13'), ('118', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:46:36'), ('119', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'weixin', '2017-10-24 02:55:54'), ('120', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 02:58:30'), ('121', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'weixin', '2017-10-24 08:18:39'), ('122', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'weixin', '2017-10-24 08:27:12'), ('123', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 10:10:48'), ('124', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 12:24:20'), ('125', '2', '勾国印', '245629560@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 12:28:58'), ('126', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 12:30:23'), ('127', '2', '勾国印', '245629560@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 12:31:18'), ('128', '2', '勾国印', '245629560@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 18:17:30'), ('129', '2', '勾国印', '245629560@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 18:18:45'), ('130', '2', '勾国印', '245629560@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-24 19:20:15'), ('131', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 22:51:01'), ('132', '2', '勾国印', '245629560@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-24 23:21:44'), ('133', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'weixin', '2017-10-25 00:43:05'), ('134', '7', '勾国磊', '314418388@qq.com', '223.104.3.153', '中国  北京市 北京市', 'weixin', '2017-10-25 09:46:23'), ('135', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-25 11:38:31'), ('136', '7', '勾国磊', '314418388@qq.com', '223.104.3.190', '中国  北京市 北京市', 'weixin', '2017-10-25 11:40:03'), ('137', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-25 13:15:23'), ('138', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-25 13:58:05'), ('139', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-25 15:36:02'), ('140', '7', '勾国磊', '314418388@qq.com', '61.135.18.162', '中国  北京市 北京市', 'pc', '2017-10-25 16:57:38'), ('141', '7', '勾国磊', '314418388@qq.com', '111.193.204.109', '中国  北京市 北京市', 'pc', '2017-10-25 22:09:15');
COMMIT;

-- ----------------------------
--  Table structure for `doc_member`
-- ----------------------------
DROP TABLE IF EXISTS `doc_member`;
CREATE TABLE `doc_member` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `project_rule` varchar(50) NOT NULL DEFAULT '' COMMENT '项目权限',
  `module_rule` varchar(50) NOT NULL DEFAULT '' COMMENT '权限',
  `api_rule` varchar(50) NOT NULL DEFAULT '' COMMENT '接口权限',
  `member_rule` varchar(50) NOT NULL DEFAULT '' COMMENT '成员权限',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `project_id_index` (`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COMMENT='项目成员表';

-- ----------------------------
--  Records of `doc_member`
-- ----------------------------
BEGIN;
INSERT INTO `doc_member` VALUES ('155', '26', '2', 'look', 'look', 'look', 'look', '2017-10-24 02:44:06'), ('156', '17', '7', 'look', 'look', 'look', 'look', '2017-10-24 12:29:09');
COMMIT;

-- ----------------------------
--  Table structure for `doc_module`
-- ----------------------------
DROP TABLE IF EXISTS `doc_module`;
CREATE TABLE `doc_module` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '模块名称',
  `intro` varchar(255) NOT NULL DEFAULT '' COMMENT '项目描述',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `project_id_index` (`project_id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='项目模块表';

-- ----------------------------
--  Records of `doc_module`
-- ----------------------------
BEGIN;
INSERT INTO `doc_module` VALUES ('1', '17', '7', '会员模块', '测试', '0', '2017-10-20 23:39:59'), ('2', '17', '7', '订单模块', '哈哈', '0', '2017-10-20 23:40:20'), ('3', '25', '2', '测试项目', '测试12345', '0', '2017-10-17 16:51:47'), ('4', '25', '2', '演示项目', '哈哈', '0', '2017-10-14 11:20:19'), ('6', '30', '2', '测试', '测试', '0', '2017-10-18 00:34:57'), ('8', '17', '2', '购物车模块', '什么？', '0', '2017-10-20 23:40:54'), ('9', '26', '7', '会员模块', '会员相关接口1', '0', '2017-10-20 21:44:06'), ('13', '26', '7', '订单模块', '订单相关', '0', '2017-10-22 16:00:41'), ('14', '38', '7', '哈哈', '哈哈', '0', '2017-10-23 20:32:39');
COMMIT;

-- ----------------------------
--  Table structure for `doc_notify`
-- ----------------------------
DROP TABLE IF EXISTS `doc_notify`;
CREATE TABLE `doc_notify` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '申请者id',
  `user_name` varchar(250) NOT NULL DEFAULT '' COMMENT '用户名',
  `project_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目id',
  `to_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '通知者id',
  `type` varchar(10) NOT NULL,
  `message` varchar(250) NOT NULL DEFAULT '',
  `is_readed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否读过',
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `to_user_id` (`to_user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='消息通知表';

-- ----------------------------
--  Table structure for `doc_project`
-- ----------------------------
DROP TABLE IF EXISTS `doc_project`;
CREATE TABLE `doc_project` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `title` varchar(255) NOT NULL COMMENT '项目标题',
  `intro` varchar(255) NOT NULL COMMENT '项目描述',
  `envs` text NOT NULL COMMENT '环境域名,json字符串',
  `allow_search` tinyint(3) NOT NULL DEFAULT '1' COMMENT '是否允许被搜索到',
  `add_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sort` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
--  Records of `doc_project`
-- ----------------------------
BEGIN;
INSERT INTO `doc_project` VALUES ('1', '7', '演示项目', '演示专用项目', '[{\"name\":\"product\",\"title\":\"\\u751f\\u4ea7\\u73af\\u5883\",\"domain\":\"http:\\/\\/gocmf.com\"},{\"name\":\"develop\",\"title\":\"\\u5f00\\u53d1\\u73af\\u5883\",\"domain\":\"http:\\/\\/gocmf.com\"}]', '1', '2017-10-20 21:44:06', '2017-10-25 23:28:13', '0'), ('2', '2', '测试项目', '测试专用', '[{\"name\":\"product\",\"title\":\"\\u751f\\u4ea7\\u73af\\u5883\",\"domain\":\"http:\\/\\/www.gocmf.com\"},{\"name\":\"develop\",\"title\":\"\\u5f00\\u53d1\\u73af\\u5883\",\"domain\":\"http:\\/\\/dev.gocmf.com\"}]', '1', '2017-10-21 17:39:03', '2017-10-25 23:28:16', '0');
COMMIT;

-- ----------------------------
--  Table structure for `doc_project_log`
-- ----------------------------
DROP TABLE IF EXISTS `doc_project_log`;
CREATE TABLE `doc_project_log` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `project_id` int(1) NOT NULL DEFAULT '0' COMMENT '项目id',
  `user_id` int(10) NOT NULL,
  `user_name` varchar(200) NOT NULL,
  `type` varchar(10) NOT NULL COMMENT '操作类型',
  `object` varchar(20) NOT NULL,
  `content` text NOT NULL COMMENT '对象',
  `add_time` datetime NOT NULL,
  `project_title` varchar(200) DEFAULT NULL,
  `module_title` varchar(50) DEFAULT NULL,
  `api_name` varchar(200) DEFAULT NULL,
  `field_name` varchar(200) DEFAULT NULL,
  `member_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`,`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `doc_project_log`
-- ----------------------------
BEGIN;
INSERT INTO `doc_project_log` VALUES ('1', '26', '7', '勾国磊(314418388@qq.com)', '更新', '项目', '将项目名<code>勾国磊测试项目</code>修改为<code>演示项目</code>', '2017-10-25 23:26:44', null, null, null, null, null), ('2', '26', '7', '勾国磊(314418388@qq.com)', '更新', '项目', '将项目描述<code>勾国磊测试专用项目99</code>修改为<code>演示项目</code>', '2017-10-25 23:26:44', null, null, null, null, null), ('3', '26', '7', '勾国磊(314418388@qq.com)', '更新', '项目', '将项目描述<code>演示项目</code>修改为<code>演示专用项目</code>', '2017-10-25 23:26:55', null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `doc_user`
-- ----------------------------
DROP TABLE IF EXISTS `doc_user`;
CREATE TABLE `doc_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1:用户 2:管理员',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态',
  `ip` varchar(250) NOT NULL DEFAULT '' COMMENT '注册ip',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '注册地址',
  `device` varchar(255) NOT NULL DEFAULT '' COMMENT '登录设备',
  `add_time` datetime NOT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
--  Records of `doc_user`
-- ----------------------------
BEGIN;
INSERT INTO `doc_user` VALUES ('2', '245629560@qq.com', '勾国印', '65a81041f28d51287b23dc2aa1cd4c3b', '1', '0', '111.193.200.187', '中国  北京市 北京市', 'pc', '2017-10-08 16:50:27'), ('7', '314418388@qq.com', '勾国磊', '65a81041f28d51287b23dc2aa1cd4c3b', '2', '1', '111.193.219.169', '中国  北京市 北京市', 'pc', '2017-10-02 13:34:08');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
