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

 Date: 31/05/2019 09:28:23
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
INSERT INTO `goodsvalue` VALUES (50000009, 20000001, 10000005, 250);

INSERT INTO `goodsvalue` VALUES (50000010, 20000002, 10000001, 10);
INSERT INTO `goodsvalue` VALUES (50000011, 20000002, 10000002, 20);
INSERT INTO `goodsvalue` VALUES (50000012, 20000002, 10000003, 100);
INSERT INTO `goodsvalue` VALUES (50000013, 20000002, 10000004, 200);
INSERT INTO `goodsvalue` VALUES (50000014, 20000002, 10000005, 250);

INSERT INTO `goodsvalue` VALUES (50000015, 20000003, 10000001, 10);
INSERT INTO `goodsvalue` VALUES (50000016, 20000003, 10000002, 20);
INSERT INTO `goodsvalue` VALUES (50000017, 20000003, 10000003, 100);
INSERT INTO `goodsvalue` VALUES (50000018, 20000003, 10000004, 200);
INSERT INTO `goodsvalue` VALUES (50000019, 20000003, 10000005, 250);

INSERT INTO `goodsvalue` VALUES (50000020, 20000004, 10000006, 10);


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
  `createAt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `endDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `status` int(11) NULL DEFAULT 0 COMMENT ' 0 是恢复 1是暂停',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `coin` int(11) NULL DEFAULT NULL COMMENT '当时剩下积分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('04458766', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559226575000', '1559248175000', 0, '', 108320);
INSERT INTO `orders` VALUES ('12601497', '2', '陌陌 包月 250积分', 1, 250.00, '6hulyr32dx7bct2j', '1559204083000', '1561882485000', 2, '', 8080);
INSERT INTO `orders` VALUES ('13377895', '12', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201654000', '1559223254000', 0, '', 8340);
INSERT INTO `orders` VALUES ('18812019', '2222', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559265162000', '1559286762000', 2, '', 105370);
INSERT INTO `orders` VALUES ('22608016', '231', '陌陌派对 包月 250积分', 1, 250.00, '6hulyr32dx7bct2j', '1559264829000', '1561943229000', 2, '', 107570);
INSERT INTO `orders` VALUES ('34074435', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559200905000', '1559222506000', 0, '', 8350);
INSERT INTO `orders` VALUES ('34248957', '21', '陌陌派对 包天 20积分', 12, 240.00, '6hulyr32dx7bct2j', '1559202935000', '1559289335000', 2, '', 8090);
INSERT INTO `orders` VALUES ('40285729', '2', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202652000', '1559224252000', 2, '', 6120);
INSERT INTO `orders` VALUES ('47094811', '1', '关注 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202893000', '1559224493000', 2, '', 6130);
INSERT INTO `orders` VALUES ('48445033', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559203050000', '1559224650000', 2, '', 8320);
INSERT INTO `orders` VALUES ('49684429', '2', '陌陌 半月 200积分', 1, 200.00, '6hulyr32dx7bct2j', '1559264999000', '1560560999000', 2, '123123', 107370);
INSERT INTO `orders` VALUES ('52549400', '1', '陌陌 包月 250积分', 1, 250.00, '6hulyr32dx7bct2j', '1559204341000', '1561882741000', 2, '', 8080);
INSERT INTO `orders` VALUES ('57182923', '22559086', '陌陌 单次 10积分', 1, 10.00, 'twdaaf0sigb6zoce', '1559202057000', '1559223657000', 2, '', 17942);
INSERT INTO `orders` VALUES ('58504717', '2', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559265196000', '1559286796000', 2, '22', 105370);
INSERT INTO `orders` VALUES ('62041582', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559208414000', '1559230014000', 2, '', 104800);
INSERT INTO `orders` VALUES ('64934158', '2', '陌陌 包月 250积分', 2, 500.00, '6hulyr32dx7bct2j', '1559264800000', '1561943200000', 2, '不行', 107820);
INSERT INTO `orders` VALUES ('72451402', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559265799000', '1559287399000', 0, '', 107560);
INSERT INTO `orders` VALUES ('73334592', '4566456', '陌陌 包月 250积分', 10, 2500.00, '6hulyr32dx7bct2j', '1559206863000', '1561885263000', 2, '', 105830);
INSERT INTO `orders` VALUES ('73464007', '111111', '陌陌 单次 10积分', 100, 1000.00, '6hulyr32dx7bct2j', '1559206992000', '1559228592000', 2, '', 104830);
INSERT INTO `orders` VALUES ('77961997', '22', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202427000', '1559224027000', 2, '', 6110);
INSERT INTO `orders` VALUES ('81762038', '2', '陌陌 单次 10积分', 22, 220.00, '6hulyr32dx7bct2j', '1559204537000', '1559226137000', 2, '', 8110);
INSERT INTO `orders` VALUES ('85981846', '21', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201683000', '1559223283000', 2, '', 8310);
INSERT INTO `orders` VALUES ('89536158', '1', '陌陌 包天 20积分', 1, 20.00, '6hulyr32dx7bct2j', '1559206998000', '1559293398000', 2, '', 104810);
INSERT INTO `orders` VALUES ('93932517', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559208575000', '1559230175000', 2, '', 107290);
INSERT INTO `orders` VALUES ('93988143', '22', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201662000', '1559223262000', 0, '', 8330);
INSERT INTO `orders` VALUES ('95084816', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559199983000', '1559221608000', 0, '', 8350);
INSERT INTO `orders` VALUES ('97354668', '2', '陌陌 单次 10积分', 1, 10.00, 'kyl3jrslc5hus6n2', '1559204578000', '1559226178000', 2, '', 20832);
INSERT INTO `orders` VALUES ('98015239', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201669000', '1559223269000', 2, '', 8320);

-- ----------------------------
-- Table structure for orders_delete
-- ----------------------------
DROP TABLE IF EXISTS `orders_delete`;
CREATE TABLE `orders_delete`  (
  `id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `room` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` int(11) NOT NULL,
  `price` float(20, 2) NOT NULL,
  `createBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'noname',
  `createAt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `endDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `status` int(11) NULL DEFAULT 0 COMMENT ' 0 是恢复 1是暂停',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `coin` int(11) NULL DEFAULT NULL COMMENT '当时剩下积分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_delete
-- ----------------------------
INSERT INTO `orders_delete` VALUES ('12601497', '2', '陌陌 包月 250积分', 1, 250.00, '6hulyr32dx7bct2j', '1559204083000', '1561882485000', 0, '', 8080);
INSERT INTO `orders_delete` VALUES ('18812019', '2222', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559265162000', '1559286762000', 0, '', 105370);
INSERT INTO `orders_delete` VALUES ('34248957', '21', '陌陌派对 包天 20积分', 12, 240.00, '6hulyr32dx7bct2j', '1559202935000', '1559289335000', 0, '', 8090);
INSERT INTO `orders_delete` VALUES ('40285729', '2', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202652000', '1559224252000', 0, '', 6120);
INSERT INTO `orders_delete` VALUES ('47094811', '1', '关注 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202893000', '1559224493000', 0, '', 6130);
INSERT INTO `orders_delete` VALUES ('48445033', '1', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559203050000', '1559224650000', 0, '', 8320);
INSERT INTO `orders_delete` VALUES ('49684429', '2', '陌陌 半月 200积分', 1, 200.00, '6hulyr32dx7bct2j', '1559264999000', '1560560999000', 2, '123123', 107370);
INSERT INTO `orders_delete` VALUES ('52549400', '1', '陌陌 包月 250积分', 1, 250.00, '6hulyr32dx7bct2j', '1559204341000', '1561882741000', 0, '', 8080);
INSERT INTO `orders_delete` VALUES ('57182923', '22559086', '陌陌 单次 10积分', 1, 10.00, 'twdaaf0sigb6zoce', '1559202057000', '1559223657000', 1, '', 17942);
INSERT INTO `orders_delete` VALUES ('58504717', '2', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559265196000', '1559286796000', 2, '22', 105370);
INSERT INTO `orders_delete` VALUES ('62041582', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559208414000', '1559230014000', 0, '', 104800);
INSERT INTO `orders_delete` VALUES ('73334592', '4566456', '陌陌 包月 250积分', 10, 2500.00, '6hulyr32dx7bct2j', '1559206863000', '1561885263000', 0, '', 105830);
INSERT INTO `orders_delete` VALUES ('73464007', '111111', '陌陌 单次 10积分', 100, 1000.00, '6hulyr32dx7bct2j', '1559206992000', '1559228592000', 1, '', 104830);
INSERT INTO `orders_delete` VALUES ('77961997', '22', '视频播放量 单次 100积分', 22, 2200.00, '6hulyr32dx7bct2j', '1559202427000', '1559224027000', 0, '', 6110);
INSERT INTO `orders_delete` VALUES ('81762038', '2', '陌陌 单次 10积分', 22, 220.00, '6hulyr32dx7bct2j', '1559204537000', '1559226137000', 0, '', 8110);
INSERT INTO `orders_delete` VALUES ('85981846', '21', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201683000', '1559223283000', 0, '', 8310);
INSERT INTO `orders_delete` VALUES ('89536158', '1', '陌陌 包天 20积分', 1, 20.00, '6hulyr32dx7bct2j', '1559206998000', '1559293398000', 0, '', 104810);
INSERT INTO `orders_delete` VALUES ('93932517', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559208575000', '1559230175000', 0, '', 107290);
INSERT INTO `orders_delete` VALUES ('97354668', '2', '陌陌 单次 10积分', 1, 10.00, 'kyl3jrslc5hus6n2', '1559204578000', '1559226178000', 0, '', 20832);
INSERT INTO `orders_delete` VALUES ('98015239', '23', '陌陌 单次 10积分', 1, 10.00, '6hulyr32dx7bct2j', '1559201669000', '1559223269000', 1, '', 8320);

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
INSERT INTO `user` VALUES ('5s6fcytzbbz8sow3', '123335', 'a7df7c05fa90fe66ce93a0f142741464', 'user', 0);
INSERT INTO `user` VALUES ('5v5vmdhsikxdppv6', 'harry', 'e10adc3949ba59abbe56e057f20f883e', 'user', 0);
INSERT INTO `user` VALUES ('6hulyr32dx7bct2j', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 107560);
INSERT INTO `user` VALUES ('7epf4iqr3mlfemfh', 'ss123', 'a3026b0a6849f749c489cd798654a809', 'user', 0);
INSERT INTO `user` VALUES ('by3niciak9urp5wy', 'admin3', '21232f297a57a5a743894a0e4a801fc3', 'user', 0);
INSERT INTO `user` VALUES ('h512pgl31qj1fobq', '001', 'dc5c7986daef50c1e02ab09b442ee34f', 'user', 0);
INSERT INTO `user` VALUES ('kyl3jrslc5hus6n2', 'admin1', '21232f297a57a5a743894a0e4a801fc3', 'user', 20842);
INSERT INTO `user` VALUES ('twdaaf0sigb6zoce', '123456', 'e10adc3949ba59abbe56e057f20f883e', 'user', 17952);
INSERT INTO `user` VALUES ('w5ov7m24iduzcrzk', '1234567', 'e10adc3949ba59abbe56e057f20f883e', 'user', 0);
INSERT INTO `user` VALUES ('zas04vj6nlfpeenn', '5600636', '5600636', 'user', 0);

SET FOREIGN_KEY_CHECKS = 1;
