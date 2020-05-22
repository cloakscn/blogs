/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : djangoblog

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 22/05/2020 15:47:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 类别管理', 7, 'add_articlecategory');
INSERT INTO `auth_permission` VALUES (26, 'Can change 类别管理', 7, 'change_articlecategory');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 类别管理', 7, 'delete_articlecategory');
INSERT INTO `auth_permission` VALUES (28, 'Can view 类别管理', 7, 'view_articlecategory');
INSERT INTO `auth_permission` VALUES (29, 'Can add 文章管理', 8, 'add_article');
INSERT INTO `auth_permission` VALUES (30, 'Can change 文章管理', 8, 'change_article');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 文章管理', 8, 'delete_article');
INSERT INTO `auth_permission` VALUES (32, 'Can view 文章管理', 8, 'view_article');
INSERT INTO `auth_permission` VALUES (33, 'Can add 评论管理', 9, 'add_comment');
INSERT INTO `auth_permission` VALUES (34, 'Can change 评论管理', 9, 'change_comment');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 评论管理', 9, 'delete_comment');
INSERT INTO `auth_permission` VALUES (36, 'Can view 评论管理', 9, 'view_comment');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_users_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2020-05-21 09:01:31.701355', '1', 'python', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (2, '2020-05-21 09:01:37.459831', '2', 'Java', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (3, '2020-05-21 09:01:59.178352', '3', 'html', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (4, '2020-05-21 09:02:36.469386', '4', '测试', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (5, '2020-05-22 07:43:56.892283', '5', '', 1, '[{\"added\": {}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (6, '2020-05-22 07:44:07.890867', '3', 'Html', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 7, 8);
INSERT INTO `django_admin_log` VALUES (7, '2020-05-22 07:44:24.674647', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 7, 8);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (8, 'home', 'article');
INSERT INTO `django_content_type` VALUES (7, 'home', 'articlecategory');
INSERT INTO `django_content_type` VALUES (9, 'home', 'comment');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-05-18 16:03:29.752586');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2020-05-18 16:03:29.830382');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2020-05-18 16:03:30.106645');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2020-05-18 16:03:30.162492');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2020-05-18 16:03:30.172466');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2020-05-18 16:03:30.182440');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2020-05-18 16:03:30.192414');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2020-05-18 16:03:30.196403');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2020-05-18 16:03:30.206416');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2020-05-18 16:03:30.218383');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2020-05-18 16:03:30.229313');
INSERT INTO `django_migrations` VALUES (12, 'users', '0001_initial', '2020-05-18 16:03:30.497599');
INSERT INTO `django_migrations` VALUES (13, 'admin', '0001_initial', '2020-05-18 16:03:30.621263');
INSERT INTO `django_migrations` VALUES (14, 'admin', '0002_logentry_remove_auto_add', '2020-05-18 16:03:30.638222');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0003_logentry_add_action_flag_choices', '2020-05-18 16:03:30.653178');
INSERT INTO `django_migrations` VALUES (16, 'sessions', '0001_initial', '2020-05-18 16:03:30.786825');
INSERT INTO `django_migrations` VALUES (17, 'home', '0001_initial', '2020-05-21 02:57:42.566608');
INSERT INTO `django_migrations` VALUES (18, 'users', '0002_auto_20200521_1640', '2020-05-21 08:40:50.985424');
INSERT INTO `django_migrations` VALUES (19, 'users', '0003_auto_20200521_1643', '2020-05-21 08:44:17.089549');
INSERT INTO `django_migrations` VALUES (20, 'home', '0002_article', '2020-05-21 09:45:22.787602');
INSERT INTO `django_migrations` VALUES (21, 'home', '0003_comment', '2020-05-22 03:46:37.054268');
INSERT INTO `django_migrations` VALUES (22, 'home', '0004_auto_20200522_1541', '2020-05-22 07:41:51.087476');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tags` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `summary` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_view` int(10) UNSIGNED NOT NULL,
  `comments` int(10) UNSIGNED NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_article_author_id_dcf763a4_fk_tb_users_id`(`author_id`) USING BTREE,
  INDEX `tb_article_category_id_d66932e8_fk_tb_catogory_id`(`category_id`) USING BTREE,
  CONSTRAINT `tb_article_author_id_dcf763a4_fk_tb_users_id` FOREIGN KEY (`author_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_article_category_id_d66932e8_fk_tb_catogory_id` FOREIGN KEY (`category_id`) REFERENCES `tb_catogory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_article
-- ----------------------------
INSERT INTO `tb_article` VALUES (33, 'article/20200522/QQ图片20200518153235.jpg', '这是一个测试问题？', '测试', '测试摘要', '<p>测试文章正文</p>\r\n', 30, 1, '2020-05-22 07:39:15.580907', '2020-05-22 07:43:31.942398', 8, 4);

-- ----------------------------
-- Table structure for tb_catogory
-- ----------------------------
DROP TABLE IF EXISTS `tb_catogory`;
CREATE TABLE `tb_catogory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_catogory
-- ----------------------------
INSERT INTO `tb_catogory` VALUES (1, 'Python', '2020-05-21 09:01:00.000000');
INSERT INTO `tb_catogory` VALUES (2, 'Java', '2020-05-21 09:01:00.000000');
INSERT INTO `tb_catogory` VALUES (3, 'Html', '2020-05-21 09:01:00.000000');
INSERT INTO `tb_catogory` VALUES (4, '测试', '2020-05-21 09:01:00.000000');
INSERT INTO `tb_catogory` VALUES (5, '', '2020-05-22 07:43:00.000000');

-- ----------------------------
-- Table structure for tb_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_comment_article_id_d3d5d1ea_fk_tb_article_id`(`article_id`) USING BTREE,
  INDEX `tb_comment_user_id_905a9388_fk_tb_users_id`(`user_id`) USING BTREE,
  CONSTRAINT `tb_comment_article_id_d3d5d1ea_fk_tb_article_id` FOREIGN KEY (`article_id`) REFERENCES `tb_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_comment_user_id_905a9388_fk_tb_users_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES (1, '<p>测试文章发言</p>\r\n', '2020-05-22 07:39:45.217776', 33, 8);

-- ----------------------------
-- Table structure for tb_users
-- ----------------------------
DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_desc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_users
-- ----------------------------
INSERT INTO `tb_users` VALUES (8, 'pbkdf2_sha256$120000$89gQQDAPyIjs$9U7SW/fPDY9nqWUxU8OH+8wMY9SRpBi8yfrmiooIsjw=', '2020-05-22 07:38:05.542683', 1, 'BilIitycu', '', '', 'wy0329@foxmail.com', 1, 1, '2020-05-21 08:33:25.207065', '13753844526', 'avatar/20200522/IMG_20200505_195241.jpg', 'i am a boy');

-- ----------------------------
-- Table structure for tb_users_groups
-- ----------------------------
DROP TABLE IF EXISTS `tb_users_groups`;
CREATE TABLE `tb_users_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_groups_user_id_group_id_b88eab82_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `users_user_groups_group_id_9afc8d0e_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_users_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `tb_users_user_permissions`;
CREATE TABLE `tb_users_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_user_permissions_user_id_permission_id_43338c45_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `users_user_user_perm_permission_id_0b93982e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
