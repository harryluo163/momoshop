/*
 Navicat Premium Data Transfer

 Source Server         : 47.105.36.188
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 47.105.36.188:3306
 Source Schema         : momo

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 30/05/2019 10:06:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL,
  `name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (20000000, '陌陌');
INSERT INTO `goods` VALUES (20000001, '陌陌派对');
INSERT INTO `goods` VALUES (20000002, '关注');
INSERT INTO `goods` VALUES (20000003, '点赞');
INSERT INTO `goods` VALUES (20000004, '视频播放量');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
  `id` int(11) NOT NULL,
  `type` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'noname',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (10000001, '单次');
INSERT INTO `goodstype` VALUES (10000002, '包天');
INSERT INTO `goodstype` VALUES (10000003, '包周');
INSERT INTO `goodstype` VALUES (10000004, '半月');
INSERT INTO `goodstype` VALUES (10000005, '包月');

-- ----------------------------
-- Table structure for goodsvalue
-- ----------------------------
DROP TABLE IF EXISTS `goodsvalue`;
CREATE TABLE `goodsvalue`  (
  `id` int(11) NOT NULL,
  `goodsId` int(11) NOT NULL,
  `goodsTypeId` int(11) NOT NULL,
  `value` float NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodsvalue
-- ----------------------------
INSERT INTO `goodsvalue` VALUES (50000000, 20000000, 10000001, 10);
INSERT INTO `goodsvalue` VALUES (50000001, 20000000, 10000002, 20);
INSERT INTO `goodsvalue` VALUES (50000002, 20000000, 10000003, 100);
INSERT INTO `goodsvalue` VALUES (50000003, 20000000, 10000004, 200);
INSERT INTO `goodsvalue` VALUES (50000004, 20000000, 10000005, 250);
INSERT INTO `goodsvalue` VALUES (50000005, 20000001, 10000001, 10);
INSERT INTO `goodsvalue` VALUES (50000006, 20000001, 10000002, 20);
INSERT INTO `goodsvalue` VALUES (50000007, 20000001, 10000003, 100);
INSERT INTO `goodsvalue` VALUES (50000008, 20000001, 10000004, 200);
INSERT INTO `goodsvalue` VALUES (20000009, 20000001, 10000005, 250);
INSERT INTO `goodsvalue` VALUES (200000010, 20000002, 10000001, 100);
INSERT INTO `goodsvalue` VALUES (200000011, 20000003, 10000001, 100);
INSERT INTO `goodsvalue` VALUES (200000012, 20000004, 10000001, 100);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `room` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` int(11) NOT NULL,
  `price` float(20, 2) NOT NULL,
  `createBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'noname',
  `createAt` datetime(0) NOT NULL COMMENT '创建时间',
  `endDate` datetime(0) NOT NULL COMMENT '结束时间',
  `status` int(11) NULL DEFAULT 0 COMMENT ' 0 是恢复 1是暂停',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `coin` int(11) NULL DEFAULT NULL COMMENT '当时剩下积分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('02217417', '234532443', '陌陌 包月 250积分', 10, 2500.00, 'twdaaf0sigb6zoce', '2019-05-29 17:40:29', '2019-06-29 17:40:29', 0, '时速', 19462);
INSERT INTO `orders` VALUES ('13128489', '1', '陌陌 包天 20积分', 1, 20.00, 'kyl3jrslc5hus6n2', '2019-05-29 16:38:01', '2019-05-30 16:38:01', 0, '', NULL);
INSERT INTO `orders` VALUES ('24851100', '6666', '陌陌 单次 10积分', 15, 150.00, 'twdaaf0sigb6zoce', '2019-05-29 17:57:33', '2019-05-29 23:57:33', 0, '', 18112);
INSERT INTO `orders` VALUES ('26195712', '2332233', '陌陌 包天 20积分', 1, 20.00, 'kyl3jrslc5hus6n2', '2019-05-29 16:53:47', '2019-05-30 16:53:47', 1, '我', 21642);
INSERT INTO `orders` VALUES ('28792246', '2', '陌陌 包天 20积分', 2, 40.00, 'kyl3jrslc5hus6n2', '2019-05-29 16:52:42', '2019-05-30 16:52:42', 0, '', 28792246);
INSERT INTO `orders` VALUES ('34551800', '8888', '陌陌 单次 10积分', 5, 50.00, 'twdaaf0sigb6zoce', '2019-05-29 17:58:14', '2019-05-29 23:58:14', 1, '', 18062);
INSERT INTO `orders` VALUES ('36622091', '456456', '陌陌 单次 10积分', 10, 100.00, 'twdaaf0sigb6zoce', '2019-05-29 17:43:46', '2019-05-29 23:43:46', 0, '时速', 19362);
INSERT INTO `orders` VALUES ('38020749', '222', '点赞 单次 100积分', 2, 200.00, 'kyl3jrslc5hus6n2', '2019-05-29 16:51:41', '2019-05-29 22:51:41', 1, '2222', 38020749);
INSERT INTO `orders` VALUES ('39400716', '100', '陌陌 单次 10积分', 10, 100.00, 'twdaaf0sigb6zoce', '2019-05-29 17:44:13', '2019-05-29 23:44:13', 0, '001', 19262);
INSERT INTO `orders` VALUES ('39570292', '21111', '陌陌 包天 20积分', 1, 20.00, '6hulyr32dx7bct2j', '2019-05-28 22:38:26', '2019-05-29 22:38:26', 1, '', NULL);
INSERT INTO `orders` VALUES ('43504877', '1', '陌陌 半月 200积分', 2, 400.00, 'kyl3jrslc5hus6n2', '2019-05-29 17:56:43', '2019-06-13 17:56:43', 0, '', 20842);
INSERT INTO `orders` VALUES ('50132580', '3333', '陌陌 单次 10积分', 1, 10.00, 'twdaaf0sigb6zoce', '2019-05-29 00:34:57', '2019-05-29 06:34:57', 0, '时速', NULL);
INSERT INTO `orders` VALUES ('55579926', '33333', '陌陌派对 包月 250积分', 1, 250.00, 'twdaaf0sigb6zoce', '2019-05-29 00:34:30', '2019-06-29 00:34:30', 0, '', NULL);
INSERT INTO `orders` VALUES ('56072234', '1', '陌陌 半月 200积分', 2, 400.00, 'kyl3jrslc5hus6n2', '2019-05-29 17:56:39', '2019-06-13 17:56:39', 0, '', 21242);
INSERT INTO `orders` VALUES ('60054568', '110', '陌陌 包月 250积分', 1, 250.00, 'twdaaf0sigb6zoce', '2019-05-29 17:51:13', '2019-06-29 17:51:13', 0, '', 19012);
INSERT INTO `orders` VALUES ('60145239', '33333', '陌陌 包月 250积分', 3, 750.00, 'twdaaf0sigb6zoce', '2019-05-29 17:56:19', '2019-06-29 17:56:19', 0, '', 18262);
INSERT INTO `orders` VALUES ('70962208', '111111', '陌陌 包天 20积分', 1, 20.00, '6hulyr32dx7bct2j', '2019-05-28 22:38:28', '2019-05-29 22:38:28', 1, '1·12·', NULL);
INSERT INTO `orders` VALUES ('72929403', '1', '关注 单次 100积分', 1, 100.00, 'kyl3jrslc5hus6n2', '2019-05-29 15:17:38', '2019-05-29 21:17:38', 0, '', NULL);
INSERT INTO `orders` VALUES ('73608360', '2', '陌陌 包天 20积分', 1, 20.00, '6hulyr32dx7bct2j', '2019-05-28 22:38:22', '2019-05-29 22:38:23', 0, '', NULL);
INSERT INTO `orders` VALUES ('81753171', '3222', '关注 单次 100积分', 1, 100.00, 'kyl3jrslc5hus6n2', '2019-05-29 15:17:44', '2019-05-29 21:17:44', 1, '222222', NULL);
INSERT INTO `orders` VALUES ('87748654', '231231231231', '关注 单次 100积分', 1, 100.00, 'kyl3jrslc5hus6n2', '2019-05-29 15:17:42', '2019-05-29 21:17:42', 0, '121212312', NULL);
INSERT INTO `orders` VALUES ('89837528', '2', '陌陌 包周 100积分', 2, 200.00, '6hulyr32dx7bct2j', '2019-05-28 23:53:46', '2019-06-04 23:53:46', 1, '', NULL);

-- ----------------------------
-- Table structure for records
-- ----------------------------
DROP TABLE IF EXISTS `records`;
CREATE TABLE `records`  (
  `id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `momoId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` int(11) NULL DEFAULT NULL,
  `createBy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createAt` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `endDate` datetime(0) NULL,
  PRIMARY KEY (`id`, `momoId`) USING BTREE,
  INDEX `userId`(`momoId`) USING BTREE,
  INDEX `endDate`(`endDate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `coin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('5v5vmdhsikxdppv6', 'harry', 'e10adc3949ba59abbe56e057f20f883e', 'user', 0);
INSERT INTO `user` VALUES ('6hulyr32dx7bct2j', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 18540);
INSERT INTO `user` VALUES ('by3niciak9urp5wy', 'admin3', '21232f297a57a5a743894a0e4a801fc3', 'user', 0);
INSERT INTO `user` VALUES ('kyl3jrslc5hus6n2', 'admin1', '21232f297a57a5a743894a0e4a801fc3', 'user', 20842);
INSERT INTO `user` VALUES ('twdaaf0sigb6zoce', '123456', 'e10adc3949ba59abbe56e057f20f883e', 'user', 18062);
INSERT INTO `user` VALUES ('w5ov7m24iduzcrzk', '1234567', 'e10adc3949ba59abbe56e057f20f883e', 'user', 0);

SET FOREIGN_KEY_CHECKS = 1;
