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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='项目接口表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='申请加入项目表';

-- ----------------------------
--  Table structure for `doc_config`
-- ----------------------------
DROP TABLE IF EXISTS `doc_config`;
CREATE TABLE `doc_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `config` text NOT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
--  Records of `doc_config`
-- ----------------------------
BEGIN;
INSERT INTO `doc_config` VALUES ('1', '{\"name\":\"\\u6854\\u5b50\\u5206\\u671f\",\"keywords\":\"\\u63a5\\u53e3\\u7ba1\\u7406\\uff0capi\\u6587\\u6863\\u7ba1\\u7406\",\"copyright\":\"Copyright \\u00a9 2017 APIDOC\\u7248\\u6743\\u6240\\u6709\",\"email\":\"245629560@qq.com\",\"default_password\":\"4567890\",\"is_close\":\"0\",\"close_msg\":\"\\u7cfb\\u7edf\\u5347\\u7ea7\\uff0c\\u6682\\u65f6\\u65e0\\u6cd5\\u8bbf\\u95ee\\uff0c\\u8bf7\\u7a0d\\u5019\\u518d\\u8bd5\\uff01\"}', '2017-10-23 22:19:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='项目字段表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='登录日志表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='项目成员表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='消息通知表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='项目表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
--  Records of `doc_user`
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
