-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  KEY `account_emailaddress_upper` ((upper(`email`))),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add produit',1,'add_produit'),(2,'Can change produit',1,'change_produit'),(3,'Can delete produit',1,'delete_produit'),(4,'Can view produit',1,'view_produit'),(5,'Can add log entry',2,'add_logentry'),(6,'Can change log entry',2,'change_logentry'),(7,'Can delete log entry',2,'delete_logentry'),(8,'Can view log entry',2,'view_logentry'),(9,'Can add permission',3,'add_permission'),(10,'Can change permission',3,'change_permission'),(11,'Can delete permission',3,'delete_permission'),(12,'Can view permission',3,'view_permission'),(13,'Can add group',4,'add_group'),(14,'Can change group',4,'change_group'),(15,'Can delete group',4,'delete_group'),(16,'Can view group',4,'view_group'),(17,'Can add user',5,'add_user'),(18,'Can change user',5,'change_user'),(19,'Can delete user',5,'delete_user'),(20,'Can view user',5,'view_user'),(21,'Can add content type',6,'add_contenttype'),(22,'Can change content type',6,'change_contenttype'),(23,'Can delete content type',6,'delete_contenttype'),(24,'Can view content type',6,'view_contenttype'),(25,'Can add session',7,'add_session'),(26,'Can change session',7,'change_session'),(27,'Can delete session',7,'delete_session'),(28,'Can view session',7,'view_session'),(29,'Can add profile',8,'add_profile'),(30,'Can change profile',8,'change_profile'),(31,'Can delete profile',8,'delete_profile'),(32,'Can view profile',8,'view_profile'),(33,'Can add site',9,'add_site'),(34,'Can change site',9,'change_site'),(35,'Can delete site',9,'delete_site'),(36,'Can view site',9,'view_site'),(37,'Can add email address',10,'add_emailaddress'),(38,'Can change email address',10,'change_emailaddress'),(39,'Can delete email address',10,'delete_emailaddress'),(40,'Can view email address',10,'view_emailaddress'),(41,'Can add email confirmation',11,'add_emailconfirmation'),(42,'Can change email confirmation',11,'change_emailconfirmation'),(43,'Can delete email confirmation',11,'delete_emailconfirmation'),(44,'Can view email confirmation',11,'view_emailconfirmation'),(45,'Can add social account',12,'add_socialaccount'),(46,'Can change social account',12,'change_socialaccount'),(47,'Can delete social account',12,'delete_socialaccount'),(48,'Can view social account',12,'view_socialaccount'),(49,'Can add social application',13,'add_socialapp'),(50,'Can change social application',13,'change_socialapp'),(51,'Can delete social application',13,'delete_socialapp'),(52,'Can view social application',13,'view_socialapp'),(53,'Can add social application token',14,'add_socialtoken'),(54,'Can change social application token',14,'change_socialtoken'),(55,'Can delete social application token',14,'delete_socialtoken'),(56,'Can view social application token',14,'view_socialtoken'),(57,'Can add PayPal IPN',15,'add_paypalipn'),(58,'Can change PayPal IPN',15,'change_paypalipn'),(59,'Can delete PayPal IPN',15,'delete_paypalipn'),(60,'Can view PayPal IPN',15,'view_paypalipn'),(61,'Can add shipping',16,'add_shipping'),(62,'Can change shipping',16,'change_shipping'),(63,'Can delete shipping',16,'delete_shipping'),(64,'Can view shipping',16,'view_shipping');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$SI3LqEzEGgql3RNbpSxEaW$SnZp+wxsjqtliOTRsNS/JO75RNmjnANwZg5ExsahsJQ=','2024-08-26 01:00:47.426968',0,'username1','EL Mehdi','iskandar','elmehdiiskandar3@gmail.com',0,1,'2024-08-22 18:28:09.469775'),(2,'pbkdf2_sha256$600000$Q1xq5JBVN1FEwYbAaXzt74$r8r6C9YfmM4+WWr6J/FV4kTMtnINruB7tuX7Qwv+xGg=','2024-08-26 18:02:20.814506',1,'elmehdi','','','elmehdiiskandar@gmail.com',1,1,'2024-08-26 01:03:16.551892');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authen_profile`
--

DROP TABLE IF EXISTS `authen_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authen_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authen_profile_user_id_ee009460_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authen_profile`
--

LOCK TABLES `authen_profile` WRITE;
/*!40000 ALTER TABLE `authen_profile` DISABLE KEYS */;
INSERT INTO `authen_profile` VALUES (1,1);
/*!40000 ALTER TABLE `authen_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authen_profile_Produits`
--

DROP TABLE IF EXISTS `authen_profile_Produits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authen_profile_Produits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `profile_id` bigint NOT NULL,
  `produit_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authen_profile_Produits_profile_id_produit_id_b4022bc7_uniq` (`profile_id`,`produit_id`),
  KEY `authen_profile_Produits_produit_id_a054e6ee_fk_myapp_produit_id` (`produit_id`),
  CONSTRAINT `authen_profile_Produits_produit_id_a054e6ee_fk_myapp_produit_id` FOREIGN KEY (`produit_id`) REFERENCES `myapp_produit` (`id`),
  CONSTRAINT `authen_profile_Produits_profile_id_974975f1_fk_authen_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `authen_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authen_profile_Produits`
--

LOCK TABLES `authen_profile_Produits` WRITE;
/*!40000 ALTER TABLE `authen_profile_Produits` DISABLE KEYS */;
/*!40000 ALTER TABLE `authen_profile_Produits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (10,'account','emailaddress'),(11,'account','emailconfirmation'),(2,'admin','logentry'),(4,'auth','group'),(3,'auth','permission'),(5,'auth','user'),(8,'authen','profile'),(6,'contenttypes','contenttype'),(15,'ipn','paypalipn'),(1,'myapp','produit'),(16,'payment','shipping'),(7,'sessions','session'),(9,'sites','site'),(12,'socialaccount','socialaccount'),(13,'socialaccount','socialapp'),(14,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-08-22 18:26:20.761004'),(2,'auth','0001_initial','2024-08-22 18:26:21.632587'),(3,'account','0001_initial','2024-08-22 18:26:21.873135'),(4,'account','0002_email_max_length','2024-08-22 18:26:21.908125'),(5,'account','0003_alter_emailaddress_create_unique_verified_email','2024-08-22 18:26:21.946346'),(6,'account','0004_alter_emailaddress_drop_unique_email','2024-08-22 18:26:22.011247'),(7,'account','0005_emailaddress_idx_upper_email','2024-08-22 18:26:22.048005'),(8,'admin','0001_initial','2024-08-22 18:26:22.276055'),(9,'admin','0002_logentry_remove_auto_add','2024-08-22 18:26:22.297185'),(10,'admin','0003_logentry_add_action_flag_choices','2024-08-22 18:26:22.325769'),(11,'contenttypes','0002_remove_content_type_name','2024-08-22 18:26:22.430532'),(12,'auth','0002_alter_permission_name_max_length','2024-08-22 18:26:22.507362'),(13,'auth','0003_alter_user_email_max_length','2024-08-22 18:26:22.547312'),(14,'auth','0004_alter_user_username_opts','2024-08-22 18:26:22.561866'),(15,'auth','0005_alter_user_last_login_null','2024-08-22 18:26:22.632842'),(16,'auth','0006_require_contenttypes_0002','2024-08-22 18:26:22.637299'),(17,'auth','0007_alter_validators_add_error_messages','2024-08-22 18:26:22.648545'),(18,'auth','0008_alter_user_username_max_length','2024-08-22 18:26:22.771622'),(19,'auth','0009_alter_user_last_name_max_length','2024-08-22 18:26:22.873860'),(20,'auth','0010_alter_group_name_max_length','2024-08-22 18:26:22.905705'),(21,'auth','0011_update_proxy_permissions','2024-08-22 18:26:22.926991'),(22,'auth','0012_alter_user_first_name_max_length','2024-08-22 18:26:23.006981'),(23,'myapp','0001_initial','2024-08-22 18:26:23.032518'),(24,'myapp','0002_produit_matricule','2024-08-22 18:26:23.069798'),(25,'myapp','0003_remove_produit_matricule','2024-08-22 18:26:23.089142'),(26,'authen','0001_initial','2024-08-22 18:26:23.115376'),(27,'authen','0002_alter_user_options_alter_user_managers_and_more','2024-08-22 18:26:24.046676'),(28,'authen','0003_delete_user','2024-08-22 18:26:24.120235'),(29,'authen','0004_initial','2024-08-22 18:26:24.904922'),(30,'authen','0005_alter_user_options_alter_user_managers_and_more','2024-08-22 18:26:25.404047'),(31,'authen','0006_somemodel','2024-08-22 18:26:25.499465'),(32,'authen','0007_remove_user_produits_delete_somemodel','2024-08-22 18:26:25.560505'),(33,'authen','0008_delete_user','2024-08-22 18:26:25.708357'),(34,'authen','0009_initial','2024-08-22 18:26:26.093524'),(35,'authen','0010_alter_profile_produits','2024-08-22 18:26:26.159669'),(36,'authen','0011_remove_profile_produits_profile_produits','2024-08-22 18:26:26.290606'),(37,'authen','0012_remove_profile_produits_profile_produits','2024-08-22 18:26:26.667513'),(38,'authen','0013_alter_profile_produits','2024-08-22 18:26:26.712344'),(39,'ipn','0001_initial','2024-08-22 18:26:26.841716'),(40,'ipn','0002_paypalipn_mp_id','2024-08-22 18:26:26.918807'),(41,'ipn','0003_auto_20141117_1647','2024-08-22 18:26:27.107923'),(42,'ipn','0004_auto_20150612_1826','2024-08-22 18:26:29.758577'),(43,'ipn','0005_auto_20151217_0948','2024-08-22 18:26:29.830888'),(44,'ipn','0006_auto_20160108_1112','2024-08-22 18:26:29.999841'),(45,'ipn','0007_auto_20160219_1135','2024-08-22 18:26:30.015506'),(46,'ipn','0008_auto_20181128_1032','2024-08-22 18:26:30.032110'),(47,'ipn','0009_alter_paypalipn_id','2024-08-22 18:26:30.123593'),(48,'myapp','0004_alter_produit_image','2024-08-22 18:26:30.137246'),(49,'myapp','0005_alter_produit_image','2024-08-22 18:26:30.154055'),(50,'myapp','0006_remove_produit_description','2024-08-22 18:26:30.182520'),(51,'myapp','0007_produit_category','2024-08-22 18:26:30.211121'),(52,'myapp','0008_alter_produit_category','2024-08-22 18:26:30.226691'),(53,'myapp','0009_alter_produit_category','2024-08-22 18:26:30.248189'),(54,'myapp','0010_alter_produit_category','2024-08-22 18:26:30.265597'),(55,'myapp','0011_alter_produit_category','2024-08-22 18:26:30.283694'),(56,'myapp','0012_alter_produit_category','2024-08-22 18:26:30.299192'),(57,'myapp','0013_alter_produit_category','2024-08-22 18:26:30.323744'),(58,'payment','0001_initial','2024-08-22 18:26:30.431369'),(59,'payment','0002_shipping_email','2024-08-22 18:26:30.463687'),(60,'payment','0003_alter_shipping_user','2024-08-22 18:26:30.609419'),(61,'payment','0004_alter_shipping_user','2024-08-22 18:26:30.640482'),(62,'payment','0005_alter_shipping_user','2024-08-22 18:26:30.676911'),(63,'sessions','0001_initial','2024-08-22 18:26:30.734171'),(64,'sites','0001_initial','2024-08-22 18:26:30.763796'),(65,'sites','0002_alter_domain_unique','2024-08-22 18:26:30.795529'),(66,'socialaccount','0001_initial','2024-08-22 18:26:31.709552'),(67,'socialaccount','0002_token_max_lengths','2024-08-22 18:26:31.826074'),(68,'socialaccount','0003_extra_data_default_dict','2024-08-22 18:26:31.842225'),(69,'socialaccount','0004_app_provider_id_settings','2024-08-22 18:26:32.227891'),(70,'socialaccount','0005_socialtoken_nullable_app','2024-08-22 18:26:32.521130'),(71,'socialaccount','0006_alter_socialaccount_extra_data','2024-08-22 18:26:32.622941'),(72,'myapp','0014_alter_produit_category','2024-08-25 16:55:55.341903'),(73,'myapp','0015_alter_produit_category','2024-08-26 17:38:29.096505');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('120lcfwik5mjbtj79qfb4pszrxt88x32','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shVWH:7W7xbNuIdkPA3GDDnIqjg3GBalFcR-sJ5MOhA33-WIQ','2024-08-30 14:44:05.682422'),('1ode8pl77uf6e54zza2myjx2b5eyijjp','.eJxVjDEOgzAQBP_iGlnOGQ6RMn3eYJ3PZyAgLGEoIsTfAxIpaGdmd1NZcu7T5Ab5que2F3_AtEib5gMqGkdVKEfr0rk1y-z6cFC4M088yHSK8KGpTZrTtMy912eiL5v1OwUZX1d7O-god-daSjDEjCAEPhJQicF6jFKxNNDYwIFLEw1GqsFXiNYGtDVC1Zj4iGr_AUcLR10:1sieel:29Y51huAOCqhnTpdnZVlllsb_EQkZGHPU8xcKB8OVl0','2024-09-02 18:41:35.751286'),('20f7x23iyp4v30hukavuqang91kne9xv','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtap:-gdHrAJ9rr0AbEX8gZGCP09ZoT0snzvnTUhVqxqufUU','2024-08-31 16:26:23.158503'),('6wywrq6ryi8kg7s239yiyjg1lgem3jwt','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtpa:2b2Q4gCJ8qIkw8gJHWgbijsNSwPKq8_XbAzOAXIzgTM','2024-08-31 16:41:38.464060'),('7aahxurxhk9pgk3lu1mw3g022dnkkxn1','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtdx:g_jRbAxRrNJ_C7L1-1O6LepWAP2LixUPKO5DzQvuoC8','2024-08-31 16:29:37.691743'),('97aaef8soh1xmy9bv6fwqndi1571d6cw','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtej:QoVSoN9VGwoB3I7kIUVLNaVcuL3uYY7B9GWSs1KZs8I','2024-08-31 16:30:25.521632'),('bsjl5zv9u6e3b42b348dm9b7mx61g7ip','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtnW:QiXB1vFcMY3yOZORQGIkjzzJAzJWbIWt8kF7qlZNMS0','2024-08-31 16:39:30.794664'),('d7p0xoxi4ex53834vhmnzea247xz4te5','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtpO:UMpuFdXusM0K1tIh95heytRhZ0D7iYo5JZAEaG3NsS0','2024-08-31 16:41:26.445039'),('kwd4vic27va7a625rxgd5es517hqc7ms','.eJxtjcFugzAQRH8F7RkhbIMjuJEoSnPIBfXSE1rb60BC7BaTQxXx74UqipKql9Fq5u3MDRq8jm1zDTQ0nYESOMTPnkJ9JrcE5oTu6BPt3Th0KlmQ5J6G5OAN9es7-1LQYmiXb8p4ilpLTsiVRY6ZNEJJS7mmghfCaKOz1KbS4oqrXEohjBQryfMitczOpYFC6LxrzvQN5Q3YIl8jQZnF4PAyH7BpsRui_eUTYYpBPAj2h_jw_S_B2D9IVR-izVu1r6NdvX2vYJoe2xpHOvph3gfse5h-ALN8ZZw:1sie0f:vjt4hmNQOoZvy369pkGKGjB23y3BSvN5hPeXJledVl4','2024-09-02 18:00:09.448694'),('l63igj4nz1zuynrobw2tuqkf5zf4o9xq','.eJyrVipOLS7OzM-Lz06tVLKqVjIGEYUlqUpWxjpKeYm5QIaSc0ZiZpFCZH5OolJtrQ5MR3JiSWp6fhFQl1JiTo5SLQC79xlz:1siEGT:0I5rO4dLbXvM98kIvdjyIaApgmp8i_-M4LJhsesyKCU','2024-09-01 14:30:45.974801'),('nujwrce8e7vd0cztp17igswbha6slo0k','.eJxVjcGOwjAMRH9l5XNVpbglwHE5cdhvqMaNoV2WBJpyWKH-O6lUCeVi-c2MPS-KGuMQfHvVfzq8aLOMx6R0qOaCOKM6I5tR9aGCPG5poWOPYfw63e6gOUXWpg6TXsKY2qhbAlRQi-fUt8-oYzu4pFe5Juiu6hfD_cJfQtkFP42DlEukXN1Y_gSnf99rNnvQI_bp2qA-s8qe3WYLFuMas-O9VXXaCOCglZVGRaW2jeywZWUoC85sDKyl-Q2blWHV:1shWUR:yt3cbiB-jPkhjDMe34ZTycODvFeDVqTr14fhAs-4KHY','2024-08-30 15:46:15.987268'),('sbd7etm9e77k5mrmm3ee4xpitrxi67bn','eyJzZXNzaW9uY2F0ZWdvcnkiOiJhbGwiLCJzZXNzaW9uX2tleSI6e319:1siEGb:EgiWpXiqKhAhweSXqXwUoQ5yaseGu6v1CCJsHcVpmAQ','2024-09-01 14:30:53.477891'),('t5j4usbmuxgwf1rikjhoj24mf7qfxydu','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1sieMI:wvy2K6ahvaCFI59_2i4_L_NigEzd7OgkNVj7BIHVxqs','2024-09-02 18:22:30.483166'),('twyj7lbc9npgcxp4uhcdmm3lpdaomzva','.eJyrVipOLS7OzM-Lz06tVLKqVjIGEYUlqUpWpjpKeYm5QIaSc0ZiZpFCZH5OolKtjpIRXIUhmgq_xLxMkApDAyxKHIN8FZw9HD2DFIL8fSOVaoHqoFYnJ5akpucXAa1XSszJUaoFAEDnLbc:1shxjz:X5fmfJXMZgHpC3lr3zaOY6lOsaeEXYQLYPNbvFuwqzw','2024-08-31 20:52:07.175389'),('v2wqn77uxhztwvaochmzulmul92btj6p','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtoY:DDhSgRD_lNPEmCeP9PIgWxsWXAB1MH7JkRxLp9TIQaw','2024-08-31 16:40:34.689036'),('vndma7x0bxdp4hsflk2ee1xeliymuqhq','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1siees:TVhnuiOI-1NLTMvrt_BOB_pMFfgNCniKR1dsN-Qsr_U','2024-09-02 18:41:42.544023'),('x524uxepzmb3m59oxh5l059gsux9tsv3','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtp5:DU_NnqWaKU53R1m9HHD1Zvy5aWT0K3nt_iPuVdfMQyI','2024-08-31 16:41:07.165381'),('y2ic8tmjf9ubh4tpv7ym3eja9pru87n6','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shtUa:DYGVfi2j33ShKiyQn5_5-sTXQLtkRFFukE2gE09Fles','2024-08-31 16:19:56.266969'),('zlcillxl5vdo42khzhhipx49i2hr1qnx','eyJzZXNzaW9uX2tleSI6e30sInNlc3Npb25jYXRlZ29yeSI6ImFsbCJ9:1shsff:cZKVR3TvLgtnKUPX1aOZXnlyHoHHaXytQmwCYFkil7w','2024-08-31 15:27:19.316724');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (2,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myapp_produit`
--

DROP TABLE IF EXISTS `myapp_produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myapp_produit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `quantite` int NOT NULL,
  `image` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myapp_produit`
--

LOCK TABLES `myapp_produit` WRITE;
/*!40000 ALTER TABLE `myapp_produit` DISABLE KEYS */;
INSERT INTO `myapp_produit` VALUES (1,'Chair Impa',50.00,455,'photos/100ONP_PRODUKTBILD_WEB_MPERSPEKTIVE1-removebg-preview_XAEcjG1.png','chair'),(2,'Chair Nani',45.00,552,'photos/100PNZ_PRODUKTBILD_WEB_PERSPEKTIVE1-removebg-preview_oePaE14.png','chair'),(3,'Chair Yola',60.00,566,'photos/101B58_PRODUKTBILD_WEB_MPERSPEKTIVE1-removebg-preview_CZb3Av4.png','chair'),(4,'Chair Glenda',80.00,456,'photos/101CAD_PRODUKTBILD_WEB_PERSPEKTIVE1_1_-removebg-preview_BuDVXS6.png','chair'),(5,'CHAIR BALDUR',75.00,755,'photos/101HJA_PRODUKTBILD_WEB_MPERSPEKTIVE1_1_-removebg-preview1_D6cG5Sv.png','chair'),(6,'CHAIR GRETA',89.00,576,'photos/101SA9_PRODUKTBILD_WEB_PERSPEKTIVE1-removebg-preview_hyHDs6t.png','chair'),(7,'CHAIR URIM',75.00,500,'photos/1018PC_PRODUKTBILD_WEB_PERSPEKTIVE1_2_-removebg-preview_ewAijNg.png','chair'),(8,'CHAIR GINA',65.00,566,'photos/1018Q9_PRODUKTBILD_WEB_MPERSPEKTIVE1-removebg-preview_1BJajxI.png','chair'),(9,'CHAIR KUBA',80.00,553,'photos/1019PG_PRODUKTBILD_WEB_PERSPEKTIVE1-removebg-preview_M9EKm1D.png','chair'),(10,'ARM CHAIR ROMY',90.00,543,'photos/1019UX_PRODUKTBILD_WEB_MPERSPEKTIVE1-removebg-preview1_0T7BlEa.png','chair'),(11,'ARM CHAIR GRETA',75.00,450,'photos/100228_V1_WEB_PERSPEKTIVE1_1_-removebg-preview_l1ENCZ5.png','chair');
/*!40000 ALTER TABLE `myapp_produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_shipping`
--

DROP TABLE IF EXISTS `payment_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_shipping` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `adresse1` varchar(255) NOT NULL,
  `adresse2` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `time` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `_order` int NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_shipping_user_id_fdf0108f_uniq` (`user_id`),
  CONSTRAINT `payment_shipping_user_id_fdf0108f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_shipping`
--

LOCK TABLES `payment_shipping` WRITE;
/*!40000 ALTER TABLE `payment_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypal_ipn`
--

DROP TABLE IF EXISTS `paypal_ipn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paypal_ipn` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `business` varchar(127) NOT NULL,
  `charset` varchar(255) NOT NULL,
  `custom` varchar(256) NOT NULL,
  `notify_version` decimal(64,2) DEFAULT NULL,
  `parent_txn_id` varchar(19) NOT NULL,
  `receiver_email` varchar(254) NOT NULL,
  `receiver_id` varchar(255) NOT NULL,
  `residence_country` varchar(2) NOT NULL,
  `test_ipn` tinyint(1) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `txn_type` varchar(255) NOT NULL,
  `verify_sign` varchar(255) NOT NULL,
  `address_country` varchar(64) NOT NULL,
  `address_city` varchar(40) NOT NULL,
  `address_country_code` varchar(64) NOT NULL,
  `address_name` varchar(128) NOT NULL,
  `address_state` varchar(40) NOT NULL,
  `address_status` varchar(255) NOT NULL,
  `address_street` varchar(200) NOT NULL,
  `address_zip` varchar(20) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `payer_business_name` varchar(127) NOT NULL,
  `payer_email` varchar(127) NOT NULL,
  `payer_id` varchar(13) NOT NULL,
  `auth_amount` decimal(64,2) DEFAULT NULL,
  `auth_exp` varchar(28) NOT NULL,
  `auth_id` varchar(19) NOT NULL,
  `auth_status` varchar(255) NOT NULL,
  `exchange_rate` decimal(64,16) DEFAULT NULL,
  `invoice` varchar(127) NOT NULL,
  `item_name` varchar(127) NOT NULL,
  `item_number` varchar(127) NOT NULL,
  `mc_currency` varchar(32) NOT NULL,
  `mc_fee` decimal(64,2) DEFAULT NULL,
  `mc_gross` decimal(64,2) DEFAULT NULL,
  `mc_handling` decimal(64,2) DEFAULT NULL,
  `mc_shipping` decimal(64,2) DEFAULT NULL,
  `memo` varchar(255) NOT NULL,
  `num_cart_items` int DEFAULT NULL,
  `option_name1` varchar(64) NOT NULL,
  `option_name2` varchar(64) NOT NULL,
  `payer_status` varchar(255) NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_gross` decimal(64,2) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_type` varchar(255) NOT NULL,
  `pending_reason` varchar(255) NOT NULL,
  `protection_eligibility` varchar(255) NOT NULL,
  `quantity` int DEFAULT NULL,
  `reason_code` varchar(255) NOT NULL,
  `remaining_settle` decimal(64,2) DEFAULT NULL,
  `settle_amount` decimal(64,2) DEFAULT NULL,
  `settle_currency` varchar(32) NOT NULL,
  `shipping` decimal(64,2) DEFAULT NULL,
  `shipping_method` varchar(255) NOT NULL,
  `tax` decimal(64,2) DEFAULT NULL,
  `transaction_entity` varchar(255) NOT NULL,
  `auction_buyer_id` varchar(64) NOT NULL,
  `auction_closing_date` datetime(6) DEFAULT NULL,
  `auction_multi_item` int DEFAULT NULL,
  `for_auction` decimal(64,2) DEFAULT NULL,
  `amount` decimal(64,2) DEFAULT NULL,
  `amount_per_cycle` decimal(64,2) DEFAULT NULL,
  `initial_payment_amount` decimal(64,2) DEFAULT NULL,
  `next_payment_date` datetime(6) DEFAULT NULL,
  `outstanding_balance` decimal(64,2) DEFAULT NULL,
  `payment_cycle` varchar(255) NOT NULL,
  `period_type` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(255) NOT NULL,
  `profile_status` varchar(255) NOT NULL,
  `recurring_payment_id` varchar(255) NOT NULL,
  `rp_invoice_id` varchar(127) NOT NULL,
  `time_created` datetime(6) DEFAULT NULL,
  `amount1` decimal(64,2) DEFAULT NULL,
  `amount2` decimal(64,2) DEFAULT NULL,
  `amount3` decimal(64,2) DEFAULT NULL,
  `mc_amount1` decimal(64,2) DEFAULT NULL,
  `mc_amount2` decimal(64,2) DEFAULT NULL,
  `mc_amount3` decimal(64,2) DEFAULT NULL,
  `password` varchar(24) NOT NULL,
  `period1` varchar(255) NOT NULL,
  `period2` varchar(255) NOT NULL,
  `period3` varchar(255) NOT NULL,
  `reattempt` varchar(1) NOT NULL,
  `recur_times` int DEFAULT NULL,
  `recurring` varchar(1) NOT NULL,
  `retry_at` datetime(6) DEFAULT NULL,
  `subscr_date` datetime(6) DEFAULT NULL,
  `subscr_effective` datetime(6) DEFAULT NULL,
  `subscr_id` varchar(19) NOT NULL,
  `username` varchar(64) NOT NULL,
  `case_creation_date` datetime(6) DEFAULT NULL,
  `case_id` varchar(255) NOT NULL,
  `case_type` varchar(255) NOT NULL,
  `receipt_id` varchar(255) NOT NULL,
  `currency_code` varchar(32) NOT NULL,
  `handling_amount` decimal(64,2) DEFAULT NULL,
  `transaction_subject` varchar(256) NOT NULL,
  `ipaddress` char(39) DEFAULT NULL,
  `flag` tinyint(1) NOT NULL,
  `flag_code` varchar(16) NOT NULL,
  `flag_info` longtext NOT NULL,
  `query` longtext NOT NULL,
  `response` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `from_view` varchar(6) DEFAULT NULL,
  `mp_id` varchar(128) DEFAULT NULL,
  `option_selection1` varchar(200) NOT NULL,
  `option_selection2` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `paypal_ipn_txn_id_8fa22c44` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypal_ipn`
--

LOCK TABLES `paypal_ipn` WRITE;
/*!40000 ALTER TABLE `paypal_ipn` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypal_ipn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` json NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-27  1:32:41
