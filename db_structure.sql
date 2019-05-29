/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : momo

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 28/05/2019 18:52:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES (20000000, '陌陌');
COMMIT;

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype` (
  `id` int(11) NOT NULL,
  `type` varchar(120) NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
BEGIN;
INSERT INTO `goodstype` VALUES (10000001, '单次');
INSERT INTO `goodstype` VALUES (10000002, '包天');
INSERT INTO `goodstype` VALUES (10000003, '包周');
INSERT INTO `goodstype` VALUES (10000004, '半月');
INSERT INTO `goodstype` VALUES (10000005, '包月');
COMMIT;

-- ----------------------------
-- Table structure for goodsvalue
-- ----------------------------
DROP TABLE IF EXISTS `goodsvalue`;
CREATE TABLE `goodsvalue` (
  `id` int(11) NOT NULL,
  `goodsId` int(11) NOT NULL,
  `goodsTypeId` int(11) NOT NULL,
  `value` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodsvalue
-- ----------------------------
BEGIN;
INSERT INTO `goodsvalue` VALUES (50000000, 20000000, 10000001, 10);
INSERT INTO `goodsvalue` VALUES (50000001, 20000000, 10000002, 20);
INSERT INTO `goodsvalue` VALUES (50000002, 20000000, 10000003, 100);
INSERT INTO `goodsvalue` VALUES (50000003, 20000000, 10000004, 200);
INSERT INTO `goodsvalue` VALUES (50000004, 20000000, 10000005, 250);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` varchar(11) NOT NULL,
  `room` varchar(20) NOT NULL,
  `goods` varchar(1000) NOT NULL,
  `num` int(11) NOT NULL,
  `price` float(20,2) NOT NULL,
  `createBy` varchar(50) NOT NULL DEFAULT 'noname',
  `createAt` datetime NOT NULL COMMENT '创建时间',
  `endDate` datetime NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for records
-- ----------------------------
DROP TABLE IF EXISTS `records`;
CREATE TABLE `records` (
  `id` varchar(11) NOT NULL,
  `momoId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` int(11) DEFAULT NULL,
  `createBy` varchar(20) DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `endDate` datetime NOT NULL,
  PRIMARY KEY (`id`,`momoId`) USING BTREE,
  KEY `userId` (`momoId`),
  KEY `endDate` (`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(20) NOT NULL,
  `username` varchar(40) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(100) NOT NULL DEFAULT '',
  `coin` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
