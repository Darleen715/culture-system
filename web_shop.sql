/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80030
Source Host           : localhost:3306
Source Database       : web_shop

Target Server Type    : MYSQL
Target Server Version : 80030
File Encoding         : 65001

Date: 2023-06-14 14:47:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', 'admin', '63814a82384f9faca8bcca0f08d86eb9');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `goods_id` int NOT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `buy_count` int DEFAULT NULL,
  `is_pay` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `counts` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('5', '花丝', 'http://localhost:3000/uploads/7.png', '5500', '1', '0', '721355', '55');
INSERT INTO `cart` VALUES ('1', '官方国潮 ', 'http://localhost:3000/uploads/1.jpg', '6900', '1', '0', '721362', '11');
INSERT INTO `cart` VALUES ('2', '千里江山', 'http://localhost:3000/uploads/2.png', '3000', '2', '0', '721362', '22');
INSERT INTO `cart` VALUES ('1', '官方国潮 ', 'http://localhost:3000/uploads/1.jpg', '6900', '1', '0', '721361', '11');
INSERT INTO `cart` VALUES ('3', '餐具礼盒', 'http://localhost:3000/uploads/3.png', '9900', '1', '0', '721361', '33');
INSERT INTO `cart` VALUES ('5', '花丝', 'http://localhost:3000/uploads/7.png', '5500', '1', '0', '721361', '55');
INSERT INTO `cart` VALUES ('2', '千里江山', 'http://localhost:3000/uploads/2.png', '3000', '1', '0', '721354', '22');
INSERT INTO `cart` VALUES ('12', '桃气满满', 'http://localhost:3000/uploads/15.png', '18900', '2', '0', '721362', '1111');
INSERT INTO `cart` VALUES ('11', '青花瓷', 'http://localhost:3000/uploads/14.png', '98000', '1', '0', '721355', '4444');
INSERT INTO `cart` VALUES ('15', '芳翠满庭', 'http://localhost:3000/uploads/18.png', '8300', '1', '0', '721355', '3333');
INSERT INTO `cart` VALUES ('2', '千里江山', 'http://localhost:3000/uploads/2.png', '3000', '1', '0', '721355', '22');
INSERT INTO `cart` VALUES ('6', '手串', 'http://localhost:3000/uploads/8.png', '11100', '1', '0', '721355', '111');
INSERT INTO `cart` VALUES ('3', '餐具礼盒', 'http://localhost:3000/uploads/3.png', '9900', '1', '0', '721355', '33');
INSERT INTO `cart` VALUES ('10', '香薰摆件', 'http://localhost:3000/uploads/12.png', '25800', '1', '0', '721355', '444');
INSERT INTO `cart` VALUES ('1', '官方国潮 ', 'http://localhost:3000/uploads/1.jpg', '6900', '1', '0', '721355', '11');
INSERT INTO `cart` VALUES ('5', '花丝', 'http://localhost:3000/uploads/7.png', '5500', '1', '0', '721362', '55');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cate_id` int NOT NULL,
  `cate_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cate_icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cate_counts` int DEFAULT NULL,
  PRIMARY KEY (`cate_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '祥瑞潮玩系列', 'el-icon-reading', '39');
INSERT INTO `category` VALUES ('2', '锦鲤首饰', 'el-icon-box', '24');
INSERT INTO `category` VALUES ('3', '香薰纸艺灯', 'el-icon-present', '23');
INSERT INTO `category` VALUES ('4', '创意马克杯', 'el-icon-mobile-phone', '13');
INSERT INTO `category` VALUES ('5', '竹乡折扇', 'el-icon-ice-cream', '20');
INSERT INTO `category` VALUES ('6', '婚庆节庆', 'el-icon-fork-spoon', '15');
INSERT INTO `category` VALUES ('7', '故宫字画', 'el-icon-place', '20');
INSERT INTO `category` VALUES ('8', '手账文具', 'el-icon-thumb', '27');
INSERT INTO `category` VALUES ('10', '伞包服饰', 'el-icon-umbrella', '20');
INSERT INTO `category` VALUES ('10', '珠宝首饰', 'el-icon-trophy', '20');
-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NOT NULL,
  `comment_detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `comment_rating` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('1', '136590526', 'good', '5', '5');
INSERT INTO `comments` VALUES ('16', '136590526', 'nice', '5', '5');
INSERT INTO `comments` VALUES ('17', '136590526', 'bad', '1', '8');
INSERT INTO `comments` VALUES ('20', '65676090', 'success', '5', '5');
INSERT INTO `comments` VALUES ('21', '65676090', 'error', '5', '5');
INSERT INTO `comments` VALUES ('22', '6225284', '不好用', '2', '5');
INSERT INTO `comments` VALUES ('23', '6225284', '还可以', '4', '5');
INSERT INTO `comments` VALUES ('24', '8836407', '好吃', '5', '5');
INSERT INTO `comments` VALUES ('25', '621723438', '强烈推荐', '5', '5');
INSERT INTO `comments` VALUES ('26', '621723438', '毒鸡汤', '2', '9');
INSERT INTO `comments` VALUES ('27', '10519372', 'aaaaa', '5', '12');
INSERT INTO `comments` VALUES ('28', '11', '必须好评！！！！', '5', '14');
INSERT INTO `comments` VALUES ('29', '11', 'jjjjjjjj', '0', '14');
INSERT INTO `comments` VALUES ('30', '111', 'dsshdsadasd', '5', '13');
INSERT INTO `comments` VALUES ('31', '1', '很不错', '5', '3721588');
INSERT INTO `comments` VALUES ('32', '1', 'good\n', '5', '721355');
INSERT INTO `comments` VALUES ('33', '2', '11111', '5', '721355');
INSERT INTO `comments` VALUES ('34', '1', 'well', '5', '721362');
INSERT INTO `comments` VALUES ('35', '1', '这款商品还可以', '4', '721362');
INSERT INTO `comments` VALUES ('36', '5', '这个质量好', '5', '721362');

-- ----------------------------
-- Table structure for homecasual
-- ----------------------------
DROP TABLE IF EXISTS `homecasual`;
CREATE TABLE `homecasual` (
  `id` int NOT NULL,
  `imgurl` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of homecasual
-- ----------------------------
INSERT INTO `homecasual` VALUES ('1', 'http://localhost:3000/images/home/s1.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('2', 'http://localhost:3000/images/home/s2.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=228');
INSERT INTO `homecasual` VALUES ('3', 'http://localhost:3000/images/home/s3.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');
INSERT INTO `homecasual` VALUES ('4', 'http://localhost:3000/images/home/s4.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('5', 'http://localhost:3000/images/home/s5.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6230');
INSERT INTO `homecasual` VALUES ('6', 'http://localhost:3000/images/home/s6.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=190');
INSERT INTO `homecasual` VALUES ('7', 'http://localhost:3000/images/home/s7.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=229');
INSERT INTO `homecasual` VALUES ('8', 'http://localhost:3000/images/home/s8.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('10', 'http://localhost:3000/images/home/s9.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `goods_id` bigint NOT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hd_thumb_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` int DEFAULT NULL,
  `normal_price` int DEFAULT NULL,
  `market_price` int DEFAULT NULL,
  `sales_tip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `category` int DEFAULT NULL,
  `counts` int DEFAULT NULL,
  `comments_count` int DEFAULT NULL,
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES ('1', '紫禁城祥瑞蟠龙麒麟摆件', '官方国潮 ', 'http://localhost:3000/uploads/1.jpg', 'http://localhost:3000/uploads/1.jpg', 'http://localhost:3000/uploads/1.jpg', '6900', '99000', '11500', '国风', '1', '20', '6');
INSERT INTO `recommend` VALUES ('2', '千里江山炫彩玻璃杯', '千里江山', 'http://localhost:3000/uploads/2.png', 'http://localhost:3000/uploads/2.png', 'http://localhost:3000/uploads/2.png', '3000', '60000', '22500', '国风', '1', '22', '1');
INSERT INTO `recommend` VALUES ('3', '龙舟竞渡·餐具礼盒', '餐具礼盒', 'http://localhost:3000/uploads/3.png', 'http://localhost:3000/uploads/3.png', 'http://localhost:3000/uploads/3.png', '9980', '108000', '33500', '国风', '1', '33', '0');
INSERT INTO `recommend` VALUES ('4', '和美首饰', '玛瑙', 'http://localhost:3000/uploads/6.png', 'http://localhost:3000/uploads/6.png', 'http://localhost:3000/uploads/6.png', '4400', '44300', '44500', '国风', '2', '44', '0');
INSERT INTO `recommend` VALUES ('5', '平安挂坠', '花丝', 'http://localhost:3000/uploads/7.png', 'http://localhost:3000/uploads/7.png', 'http://localhost:3000/uploads/7.png', '5500', '55300', '55500', '国风', '2', '55', '1');
INSERT INTO `recommend` VALUES ('6', '玛瑙十八子手串', '手串', 'http://localhost:3000/uploads/8.png', 'http://localhost:3000/uploads/8.png', 'http://localhost:3000/uploads/8.png', '11100', '111300', '111500', '国风', '2', '111', '1');
INSERT INTO `recommend` VALUES ('7', '吉庆有鱼书本灯小夜灯宫灯创意礼品', '小夜灯', 'http://localhost:3000/uploads/10.png', 'http://localhost:3000/uploads/10.png', 'http://localhost:3000/uploads/10.png', '19900', '222300', '222500', '国风', '3', '221', '0');
INSERT INTO `recommend` VALUES ('8', '紫禁暗香疏影梅鹊小夜灯', '暗香', 'http://localhost:3000/uploads/11.png', 'http://localhost:3000/uploads/11.png', 'http://localhost:3000/uploads/11.png', '11900', '333300', '333500', '国风', '3', '333', '0');
INSERT INTO `recommend` VALUES ('10', '紫禁花开香氛摆件 ', '香薰摆件', 'http://localhost:3000/uploads/12.png', 'http://localhost:3000/uploads/12.png', 'http://localhost:3000/uploads/12.png', '25800', '444300', '444500', '国风', '3', '444', '0');
INSERT INTO `recommend` VALUES ('10', '陶瓷咖啡杯牛奶杯 ', '牛奶杯', 'http://localhost:3000/uploads/13.png', 'http://localhost:3000/uploads/13.png', 'http://localhost:3000/uploads/13.png', '25900', '555300', '555500', '国风', '4', '555', '0');
INSERT INTO `recommend` VALUES ('11', '青瓷镶嵌莲花杯礼盒套装', '青花瓷', 'http://localhost:3000/uploads/14.png', 'http://localhost:3000/uploads/14.png', 'http://localhost:3000/uploads/14.png', '98000', '4444300', '4444500', '国风', '4', '4444', '0');
INSERT INTO `recommend` VALUES ('12', '福果·桃气满满·马克杯', '桃气满满', 'http://localhost:3000/uploads/15.png', 'http://localhost:3000/uploads/15.png', 'http://localhost:3000/uploads/15.png', '18900', '1111300', '1111500', '国风', '4', '1111', '0');
INSERT INTO `recommend` VALUES ('13', '萌猫如意百花折扇', '萌猫如意百花折扇', 'http://localhost:3000/uploads/16.png', 'http://localhost:3000/uploads/16.png', 'http://localhost:3000/uploads/16.png', '22200', '222300', '222500', '国风', '5', '11', '0');
INSERT INTO `recommend` VALUES ('14', '墨兰图系列折扇', '水墨折扇', 'http://localhost:3000/uploads/17.png', 'http://localhost:3000/uploads/17.png', 'http://localhost:3000/uploads/17.png', '8900', '100000', '2222500', '国风', '5', '2221', '0');
INSERT INTO `recommend` VALUES ('15', '芳翠满庭折扇 ', '芳翠满庭', 'http://localhost:3000/uploads/18.png', 'http://localhost:3000/uploads/18.png', 'http://localhost:3000/uploads/18.png', '8300', '90000', '33333500', '国风', '5', '3333', '0');
INSERT INTO `recommend` VALUES ('16', '紫禁花语翠点星荷团扇中国风扇子蒲扇 ', '薄荷折扇', 'http://localhost:3000/uploads/19.png', 'http://localhost:3000/uploads/19.png', 'http://localhost:3000/uploads/19.png', '5500', '55553', '5555500', '国风', '5', '555', '0');
INSERT INTO `recommend` VALUES ('17', '金桂浮月 马克杯套装', '金桂浮月', 'http://localhost:3000/uploads/20.png', 'http://localhost:3000/uploads/20.png', 'http://localhost:3000/uploads/20.png', '13900', '443000', '44500', '国风', '1', '44', '0');

INSERT INTO `recommend` VALUES ('21', '春雨林塘茶饼礼盒生熟茶叶普洱茶', '茶饼双拼礼盒', 'http://localhost:3000/uploads/21.png', 'http://localhost:3000/uploads/21.png', 'http://localhost:3000/uploads/21.png', '62000', '72000', '74000', '节庆', '6', '20', '0');
INSERT INTO `recommend` VALUES ('22', '故宫日历台历2024龙年中国皇历万年历老黄历新年礼物', '故宫皇历', 'http://localhost:3000/uploads/22.png', 'http://localhost:3000/uploads/22.png', 'http://localhost:3000/uploads/22.png', '7800', '9800', '9900', '节庆', '6', '33', '0');
INSERT INTO `recommend` VALUES ('23', '龙凤呈祥婚庆礼包', '结婚请帖', 'http://localhost:3000/uploads/23.png', 'http://localhost:3000/uploads/23.png', 'http://localhost:3000/uploads/23.png', '1990', '2990', '3290', '节庆', '6', '19', '0');
INSERT INTO `recommend` VALUES ('24', '百年好合新婚礼包', '婚庆结婚', 'http://localhost:3000/uploads/24.png', 'http://localhost:3000/uploads/24.png', 'http://localhost:3000/uploads/24.png', '1990', '2990', '3290', '节庆', '6', '18', '0');

INSERT INTO recommend VALUES ('25', '千里江山-装饰画故宫藏品系列', '千里江山图', 'http://localhost:3000/uploads/25.png', 'http://localhost:3000/uploads/25.png', 'http://localhost:3000/uploads/25.png', '34800', '36800', '48000', '字画', '7', '24', '0');
INSERT INTO recommend VALUES ('26', '千里江山-12寸桌面装饰画带框', '长桥卧波', 'http://localhost:3000/uploads/26.png', 'http://localhost:3000/uploads/26.png', 'http://localhost:3000/uploads/26.png', '19900', '22900', '24900', '字画', '7', '26', '0');
INSERT INTO recommend VALUES ('27', '蒲塘秋艳图-镜片名画高清复刻', '蒲塘秋艳图', 'http://localhost:3000/uploads/27.png', 'http://localhost:3000/uploads/27.png', 'http://localhost:3000/uploads/27.png', '68900', '69900', '72900', '字画', '7', '34', '0');
INSERT INTO recommend VALUES ('28', '千里江山图-镜芯无框名画', '镜芯无框画', 'http://localhost:3000/uploads/28.png', 'http://localhost:3000/uploads/28.png', 'http://localhost:3000/uploads/28.png', '28900', '29900', '32900', '字画', '7', '35', '0');

INSERT INTO `recommend` VALUES ('29', '脊兽黄铜书签礼盒-全套10支装古风金属书签文具套装', '脊兽套装', 'http://localhost:3000/uploads/29.png', 'http://localhost:3000/uploads/29.png', 'http://localhost:3000/uploads/29.png', '19800', '23900', '24900', '伴手礼', '7', '35', '0');
INSERT INTO `recommend` VALUES ('30', '宫迎和瑞-金属书签礼盒-紫禁城600年纪念', '书签套装', 'http://localhost:3000/uploads/30.png', 'http://localhost:3000/uploads/30.png', 'http://localhost:3000/uploads/30.png', '9800', '11900', '18900', '生日礼物', '8', '33', '0');
INSERT INTO `recommend` VALUES ('31', '紫微四季-笔记本', '书签套装', 'http://localhost:3000/uploads/31.png', 'http://localhost:3000/uploads/31.png', 'http://localhost:3000/uploads/31.png', '26800', '27800', '29800', '生日礼物', '8', '21', '0');
INSERT INTO `recommend` VALUES ('32', '宫猫花影-艺术书签金属书签', '金属书签', 'http://localhost:3000/uploads/32.png', 'http://localhost:3000/uploads/32.png', 'http://localhost:3000/uploads/32.png', '3500', '3800', '4200', '生日礼物', '8', '16', '0');

INSERT INTO `recommend` VALUES ('33', '文武双全帆布袋包文武双全-双面彩画', '斜挎包', 'http://localhost:3000/uploads/33.png', 'http://localhost:3000/uploads/33.png', 'http://localhost:3000/uploads/33.png', '6800', '7200', '7500', '创意家居', '9', '18', '0');
INSERT INTO `recommend` VALUES ('34', '丹宸永瑞-环保丝巾环保围巾方巾', '方巾', 'http://localhost:3000/uploads/34.png', 'http://localhost:3000/uploads/34.png', 'http://localhost:3000/uploads/34.png', '8800', '9800', '9900', '方巾', '9', '27', '0');
INSERT INTO `recommend` VALUES ('35', '萌虎披肩披风毛毯', '披风毯子', 'http://localhost:3000/uploads/35.png', 'http://localhost:3000/uploads/35.png', 'http://localhost:3000/uploads/35.png', '12800', '13800', '14800', '毯子', '9', '23', '0');
INSERT INTO `recommend` VALUES ('36', '国潮口罩-独立包装国风成人口罩', '口罩', 'http://localhost:3000/uploads/36.png', 'http://localhost:3000/uploads/36.png', 'http://localhost:3000/uploads/36.png', '5800', '6800', '6900', '口罩', '9', '26', '0');

INSERT INTO recommend VALUES ('37', '和田玉-红手绳-小象玉象手链', '编制手链', 'http://localhost:3000/uploads/37.png', 'http://localhost:3000/uploads/37.png', 'http://localhost:3000/uploads/37.png', '69900', '72900', '73900', '手链', '10', '30', '0');
INSERT INTO recommend VALUES ('38', '古风珠翠耳饰耳线', '珍珠耳线', 'http://localhost:3000/uploads/38.png', 'http://localhost:3000/uploads/38.png', 'http://localhost:3000/uploads/38.png', '19800', '23900', '24900', '福禄珍珠翡翠', '10', '28', '0');
INSERT INTO recommend VALUES ('39', '璇子彩画-珐琅银项链', '项链', 'http://localhost:3000/uploads/39.png', 'http://localhost:3000/uploads/39.png', 'http://localhost:3000/uploads/39.png', '39800', '42900', '43900', '孔雀石吊坠', '10', '30', '0');
INSERT INTO recommend VALUES ('40', '暗香疏影贝珠系列胸针古风汉服装配饰', '配饰', 'http://localhost:3000/uploads/40.png', 'http://localhost:3000/uploads/40.png', 'http://localhost:3000/uploads/40.png', '29800', '32900', '33900', '福禄胸针', '10', '32', '0');





ALTER TABLE `recommend` ADD COLUMN `region` VARCHAR(255);

-- 更新前 9 条记录，分配到南昌市
UPDATE `recommend` SET `region` = '南昌市' WHERE `goods_id` BETWEEN 1 AND 9;

-- 更新接下来的 9 条记录，分配到九江市
UPDATE `recommend` SET `region` = '九江市' WHERE `goods_id` BETWEEN 10 AND 17;

-- 更新接下来的 9 条记录，分配到赣州市
UPDATE `recommend` SET `region` = '赣州市' WHERE `goods_id` BETWEEN 21 AND 27;

-- 更新剩余的记录，分配到吉安市
UPDATE `recommend` SET `region` = '吉安市' WHERE `goods_id` BETWEEN 28 AND 40;




-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_birthday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_sign` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3721589 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('721354', '13222222222', '032cee82df5b7be8073d3be42ea48a12', '15937309500', '女', '北海', '2002-07-07', '771', 'Y——', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('721355', 'admin', '63814a82384f9faca8bcca0f08d86eb9', '0371546325', '女', '上海', '2002-07-07', '771', '还未还愿', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('721361', '15937309500', null, '15937309500', '男', '湖南', '2002-07-07', '771', '蔚蓝', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('721362', '17513169627', null, '17513169627', '男', '三亚', '2002-07-07', '771', '爱你如初', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('721370', '13111111111', null, '13111111111', '女', '青岛', '2002-07-07', '771', '自娱自乐', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('725133', '17513169627', null, '1751319627', '女', '新乡', '2001-02-09', '771', '超级', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('3721344', '13111111111', 'd43533b0994949040511bb6076624b42', '15937309500', '男', '合肥', '2005-06-06', '771', '我不上你当', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('3721566', '18666666666', 'a163a36c731d1ac664841b6d196a05e3', '18666666666', '男', '新乡', '2001-02-09', '771', '踏花游湖', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('3721569', '13666666666', null, '13666666666', '女', '河南', '2000-01-01', '564154', '中毒的爱情', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('3721587', '15666666666', null, '15666666666', '女', '郑州', '1988-06-25', '336', '超级无敌', 'http://localhost:3000/avatar_uploads/no_login.jpg');
INSERT INTO `user_info` VALUES ('3721588', '15796967735', null, '15796967735', '女', '新乡', '2023-06-06', '诚信友善', '你好~', 'http://localhost:3000/avatar_uploads/no_login.jpg');



-- 判断表是否存在，如果存在则删除
DROP TABLE IF EXISTS articles;

CREATE TABLE articles (
    article_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author_id INT NOT NULL,
    publish_date DATE NOT NULL,
    likes INT DEFAULT 0,
    collects INT DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES user_info(id)
);



-- 插入第一条文章信息
INSERT INTO articles (title, content, author_id, publish_date)
VALUES ('龙舟竞渡·餐具礼盒', '龙舟竞渡·餐具礼盒，是端午节期间的特色礼品，内含丰富的餐具套装，精美实用，是送礼和自用的不二选择。', 1, '2024-02-27');

-- 插入第二条文章信息
INSERT INTO articles (title, content, author_id, publish_date)
VALUES ('探寻传统文化之美：吉庆有鱼书本灯小夜灯宫灯创意礼品', '在当今追求个性化、创意化的潮流中，传统文化元素的融入成为了不少创意产品的灵感来源。而吉庆有鱼书本灯小夜灯宫灯，则是一款兼具传统文化韵味与现代创意设计的独特礼品。详细介绍...', 1, '2024-02-27');

-- 更新第二条文章的标签字段
UPDATE articles
SET tags = '["传统文化", "创意产品", "礼品", "文化融合", "现代设计"]'
WHERE title = '探寻传统文化之美：吉庆有鱼书本灯小夜灯宫灯创意礼品';

-- 更新第一条文章的标签字段
UPDATE articles
SET tags = '["特色礼品", "餐具套装", "端午节", "送礼", "自用"]'
WHERE title = '龙舟竞渡·餐具礼盒';


INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags)
VALUES ('创意科技：智能音响与文化传承的完美结合', '探索创意科技的魅力，智能音响与传统文化相遇，让科技与文化共舞。', 3721344, '2024-02-27', 15, 8, '["创意科技", "智能音响", "文化传承", "科技与文化"]');

INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags)
VALUES ('原创设计：手工编织艺术与现代家居搭配', '从手工编织的艺术美感中感受传统与现代的碰撞，让家居空间充满温馨与艺术气息。', 3721344, '2024-02-28', 18, 10, '["原创设计", "手工编织", "艺术", "家居装饰"]');

INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags)
VALUES ('环保创意：再生材料与艺术创作的结合', '探索环保创意的新领域，用再生材料打造艺术作品，为地球贡献一份环保力量。', 3721344, '2024-03-01', 12, 5, '["环保创意", "再生材料", "艺术创作", "环保"]');


INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '“烟火气”搭上“文艺范”', 
    '艾诺琪&颐和园联名化妆刷、沧游记飞行棋、琉璃镇尺、沧州手账、单桥文创……人们在漫步非遗文创市集的同时，更能体味沧州非遗及文创的发展成果。现场还有剪纸、面花等非遗技艺展示体验区，沉浸式体验让人们感受沧州代代相传、生生不息的非遗文化魅力。',
    3721566, 
    '2024-02-27', 
    15, 
    8, 
    '["烟火气", "文艺范", "艾诺琪", "颐和园", "非遗文创", "沧游记", "琉璃镇", "沧州手账", "单桥文创", "剪纸", "面花", "体验", "非遗", "文化"]'
);
INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '银川文创大集上的吸睛产品', 
    '大集上的产品主要分为“最美丝路敦煌——丝路文化”“创意·让红色文化直抵人心——红色主题文创”“我把宁夏送给你——宁夏好物”“高手在民间——非遗手工制作”“梦回千年——西夏文创”，以及“北纬38度贺兰山的紫色梦想——葡萄酒专区”，共六大主题内容。众多文创产品中，比较受欢迎的有结合虎元素的非遗类剪纸作品，比如虎年卷轴画以及银川地图剪纸书签和老虎形象的冰箱贴、胸针等。而由西夏陵景区与宁夏大学西夏学研究院联合推出的纯手工虎头帽、瑞兽刺绣红包、吉祥玲珑杯、“西夏公主·武士公仔”更是成了集市上的亮点。',
    3721587, 
    '2024-02-27', 
    15, 
    8, 
    '["银川", "文创大集", "吸睛产品", "丝路文化", "红色主题", "宁夏", "非遗手工制作", "西夏文创", "葡萄酒", "虎元素", "剪纸", "冰箱贴", "手工", "虎头帽", "红包", "玲珑杯", "武士公仔", "亮点"]'
);

INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '中秋文创市集亮马河岸热闹开市', 
    '中秋国庆佳节将至，亮马河一带格外热闹。启皓大厦外的露天草坪上，十几只卡通小白兔围着一盏圆滚滚的大月球灯，“月落亮马”的场景烘托出中秋佳节的浪漫氛围。9月26日，2023“MADE BY 京”中秋市集在这里热闹开市，30余个品牌汇集，既有老字号，也有潮牌爆品。',
    3721588, 
    '2024-02-27', 
    15, 
    8, 
    '["中秋", "国庆", "亮马河", "MADE BY 京", "文创市集", "启皓大厦", "月球灯", "浪漫氛围", "品牌", "潮牌", "爆品", "露天草坪"]'
);
INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '赶一场“非遗”文创市集', 
    '10月23日，武当山非遗文创集市开市，玉虚街成为游、购、娱、食、文化体验的沉浸式打卡点。集市以小木屋为依托，39家参展企业（单位）汇聚于此，新潮文创、名优特产、中医康养、非遗手作吸引了众多游客前来“赶集”。',
    3721587, 
    '2024-02-27', 
    15, 
    8, 
    '["非遗", "文创市集", "武当山", "玉虚街", "文化体验", "游客", "购物", "娱乐", "食品", "特产", "中医康养", "手工艺", "集市", "沉浸式体验"]'
);
INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '“书店+集市”带你一起跨文化年', 
    '“书店+集市”的模式既能为读者带来多元化的体验，也能丰富书店业态。本次活动为丰富市民的文化生活，传播优秀文化，提升大众对文创、手作艺术的认识和欣赏，石家庄书城免费邀请各类非遗文化、文化创意、老字号创新、国风国潮、手作体验、生活美学等摊主参与，让广大市民近距离感受文化之美，领略创意之妙，深度体验文创与市井的奇妙融合，让越来越多人感受、拥有、分享文创产品及其文化魅力，一起跨文化年。',
    3721569, 
    '2024-02-27', 
    15, 
    8, 
    '["书店+集市", "文化生活", "文创", "手作艺术", "石家庄书城", "非遗文化", "文化创意", "老字号创新", "国风国潮", "手作体验", "生活美学", "市民", "跨文化年"]'
);

INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '鱼台县“烟火里的诗”非遗文创市集', 
    '近日，鱼台县在飞跃时代广场举办“烟火里的诗”非遗文创市集活动。非遗手艺人尽显才能，展出绾结葫芦、剪纸、葫芦烙画、蛋雕近千件非遗产品，为市民游客提供了一个可逛可赏可体验可购的游玩好去处。',
    3721587, 
    '2024-02-27', 
    15, 
    8, 
    '["鱼台县", "烟火里的诗", "非遗文创市集", "飞跃时代广场", "非遗手艺", "绾结葫芦", "剪纸", "葫芦烙画", "蛋雕", "非遗产品", "市民游客", "游玩好去处"]'
);

INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '龙年好礼引客来', 
    '在公园东门礼物旗舰店、双清别墅红色书屋等处，推出以市属公园自主设计开发的龙年IP吉祥物“隆隆”为主题的系列文创产品，龙纹黄绿琉璃古建筑构件造型的冰箱贴等极具龙年春节特色的文创新品，以及可自由组合成“十全十美”“洪福齐天”等美好寓意的DIY钥匙链、双清别墅红色款丝巾、静宜园红色款明信片等都成为新春佳节的文创好礼，吸引很多游客市民慕名而来。',
    3721569, 
    '2024-02-27', 
    15, 
    8, 
    '["龙年", "好礼", "公园东门", "礼物旗舰店", "双清别墅红色书屋", "龙年IP吉祥物", "隆隆", "文创产品", "冰箱贴", "DIY钥匙链", "丝巾", "明信片", "新春佳节", "游客市民"]'
);
INSERT INTO articles (title, content, author_id, publish_date, likes, collects, tags) 
VALUES (
    '延庆·好物文创市集走进北京世园公园', 
    '本次市集还推出了适合亲子互动体验的画兔爷、捏面人、制花灯、剪纸等节日传统手工艺体验项目，深受家长与小朋友的喜爱。琳琅满目的文创产品、非遗手工艺品、独具特色的非遗手工制作活动、内容丰富的文化体验活动让游客沉浸在浓浓的节日民俗氛围之中，留下了美好的节日记忆。',
    3721566, 
    '2024-02-27', 
    15, 
    8, 
    '["延庆", "好物文创市集", "北京世园公园", "亲子互动", "画兔爷", "捏面人", "制花灯", "剪纸", "传统手工艺", "非遗手工艺品", "节日记忆"]'
);


CREATE TABLE IF NOT EXISTS article_favorites (
    favorite_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    article_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_info(id),
    FOREIGN KEY (article_id) REFERENCES articles(article_id),
    UNIQUE KEY unique_favorite (user_id, article_id)
);


-- 在定义外键关系时，可以选择级联删除（CASCADE），这样当父表中的记录被删除时，相关联的子表中的记录也会被自动删除。在你的情况下，如果articles表中的author_id字段允许级联删除，那么删除user_info表中的记录时相关的articles表中的记录也会被删除。
ALTER TABLE articles
ADD CONSTRAINT fk_author
FOREIGN KEY (author_id) REFERENCES user_info(id)
ON DELETE CASCADE;