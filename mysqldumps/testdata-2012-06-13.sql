-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: author_collab
-- ------------------------------------------------------
-- Server version	5.1.63-0ubuntu0.11.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_fbfc09f1` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(52,'Can add user profile',18,'add_userprofile'),(53,'Can change user profile',18,'change_userprofile'),(54,'Can delete user profile',18,'delete_userprofile'),(46,'Can add entity',16,'add_entity'),(47,'Can change entity',16,'change_entity'),(48,'Can delete entity',16,'delete_entity'),(49,'Can add member relation',17,'add_memberrelation'),(50,'Can change member relation',17,'change_memberrelation'),(51,'Can delete member relation',17,'delete_memberrelation');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'daniel','','','daniel.moniz@gmail.com','pbkdf2_sha256$10000$SzdBFGdh7oDU$a8oeplJaplMiSDRqtxKdaG/6+GYXoORapF9mKJAnDt4=',1,1,1,'2012-06-13 03:14:18','2012-04-03 22:13:47'),(15,'testman9','','','testman@test.com','sha1$7a8ec$3e2ad89a9eb30935e89f859706083c5ce990b0a5',0,1,0,'2012-04-28 15:57:44','2012-04-28 15:57:44'),(14,'testman6','','','testman6@test.com','sha1$6d3db$552b30f8e4a62382f32bfe847ce40bf839034fe5',0,1,0,'2012-04-22 01:44:15','2012-04-22 01:44:15'),(12,'testman4','','','testman4@test.com','sha1$ba59e$fc9dc86c7c3fc1fde619ac12bcc2076c66397136',0,1,0,'2012-04-22 00:53:01','2012-04-22 00:53:01'),(13,'testman5','','','testman5@test.com','sha1$fa5f9$b3bf14bdd052a0022cfecc3d25b257501f970ce5',0,1,0,'2012-04-28 15:54:20','2012-04-22 01:35:10'),(10,'testman2','','','','sha1$aef31$6bb2307e0299c052f0aa76faea6f9d779796b736',0,1,0,'2012-05-05 21:56:40','2012-04-21 21:42:30'),(9,'testman','','','testman@test.com','pbkdf2_sha256$10000$5lLlPDn08yC5$7iOAgeEeHyK5j5VOweqtu2LcjMM5xT7Q41EL+EuT8EA=',0,1,0,'2012-06-13 18:47:59','2012-04-21 21:38:18');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_edit`
--

DROP TABLE IF EXISTS `build_world_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_edit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `edit_hash` varchar(128) NOT NULL,
  `element_type` varchar(32) NOT NULL,
  `element_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_edit`
--

LOCK TABLES `build_world_edit` WRITE;
/*!40000 ALTER TABLE `build_world_edit` DISABLE KEYS */;
INSERT INTO `build_world_edit` VALUES (1,'9b0b87a5cac5c8a528e07a4ff8b3b849e42bb33b','section',1),(2,'8b10ae4877c35f702a204100a0b5f5bd501d1957','section',1),(3,'3db728c46478a33c921a80f0ffd4a7e4f39de1f4','section',1),(4,'8bb3817a4520c95caf6ab29e63bca6791e20707d','section',1),(5,'66c146890030846ba25bea06639cacf6ef1eef77','section',1),(6,'a36a28e006cd6ae38d72546ea58548c0a61314db','section',1),(7,'e05fc20356dbb37c89335fb178b2b11c48606f1b','section',1),(8,'2f8f12f6f286da38ab0f3ba5b46f34813739e815','section',1),(9,'7893b36b7e010f6c9fa0a79abf77bb55284d45c8','section',1),(10,'c7f2b0a44903aa86c11eaa587fc4def2c7810796','section',1),(11,'167fc6ae0815be4fb40144e163076da04579e06c','section',1),(12,'c97041e485ebbb27e40e5cc0312df943ccfd9958','section',1),(13,'066a1948d309053fa505bd851fd4e9d7432b96fa','section',1),(14,'234fb25be6908b8fcb4bd76b6d75c3e312ea914a','section',1),(15,'3a96c2f247da969acd158c08c46500d266d876d7','section',1),(16,'92e5c1089e7b4928b567fd3e7bfaa9f0e1dcabc6','section',1),(17,'24c432b549fca79d0b5fb4089e397a0fd5938dc5','section',1),(18,'6382fb1f85122cd23cba9614dfa4a91fd27b1e1e','section',1),(19,'c9fad61c57314b8d347799219f140943f1c8c002','section',1),(20,'d8d657cfe907a5a46d396f1276ca418bc2cd0395','section',1),(21,'e5a1f32b926ba69dcb34c65ccf9a1113fd59c23a','section',2),(22,'69377c9f8478be589b72df20b7ebdfd42d34961f','section',2),(23,'febe708e1d251798882d107e04f06580341fa832','section',2),(24,'4bd7a40ad901ab1f565b1a6eea2fc6d6f2c2d1c4','section',2),(25,'c570757429b9ba4d906a4c9b69a6b7eaa0e431d1','section',2),(30,'7fbc3142f5e8d9791f744dfab10d8f3a9f635402','section',1),(27,'62488cca12731688ce7b7c32a0061b04c90a871f','section',1),(31,'a258737db8c21287ee9ffd37eb50e200212e7889','section',1),(34,'9ae7065ccdb1dbd4e750bed5af223af76b0e9def','section',1),(33,'a24d229c6a68a2ff0322dd03b3d737f70e7b0907','section',1),(39,'54a8a5b2c9fecfc9c2e12b5f9d2bb989443511cd','section',1),(36,'bbba560cab0b56094119fdd5168d9b1a17d86447','section',1),(38,'c08a3615cb9fb2fbd1745ac956b960175e19c2f7','section',1),(46,'fa230acbd674a3735d97ba3d7416ab5eec285a57','Section',1),(41,'18f38da0c84bb8a72ca5776080332223c17376ef','Section',1),(42,'44a4a1b106b2978b370f4be9d47093a0ab7cd893','Section',1),(43,'0df3f23896def4e2ffaa9a1476cec838ff0b14d0','Section',1),(45,'4ea3ba4179d30536bc0755dcb703ea707bbdb0bf','Section',1),(47,'a4a1ab88a1828a98d4336b765323521cddbd5703','Section',1),(58,'7ad869ae58b00535bdb03043b02807746cd06cec','World',1),(49,'bb947d1df090d2e29ef690745f8729e0bf4e14ec','Story',1),(51,'ec24f21df4820a777d2388fc7173c63a548d593e','Story',1),(53,'61d10533c9ca9b4609c9b9b1ceae5363751378a7','World',1),(55,'0830cea52f1892b0b9a3792bddd1f745991ee24d','World',1),(57,'04e7000f5a3f8c022ab62af5a334d988f6d3abcd','World',1),(59,'ced5d5052b47b88f1a28622e5d74d5a21307f02f','Section',2),(60,'acb1b6de30e1c5518aedd9dbaced543394350469','World',1),(61,'85a4a1be21ed64510150d3dccda2557230c23f58','World',1),(62,'f463150e0a586adfe986faebaf656c87d883000f','World',1),(65,'f1ceb68fb2155b48586496f1d90cdc70783f5128','Section',1),(64,'53aa21c1e4b3b485b7182eea42029f1d1762ea5a','Section',1),(66,'79d34cc038f7a27b6cea4417dc77cbb9a56b0b48','Section',2);
/*!40000 ALTER TABLE `build_world_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_entity`
--

DROP TABLE IF EXISTS `build_world_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `founder_id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `description` longtext NOT NULL,
  `notes` longtext NOT NULL,
  `private` tinyint(1) NOT NULL,
  `active_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `founder_id_refs_id_50508897` (`founder_id`),
  KEY `owner_id_refs_id_50508897` (`owner_id`),
  KEY `parent_id_refs_id_21094f03` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_entity`
--

LOCK TABLES `build_world_entity` WRITE;
/*!40000 ALTER TABLE `build_world_entity` DISABLE KEYS */;
INSERT INTO `build_world_entity` VALUES (1,'world',NULL,1,1,'World Test','new sneaky body','description test','<p align=\"left\">Notes go here. You know it. Bananas, son!</p>\r\n<p align=\"left\">Test</p>\r\n<p align=\"left\">testingmoar tests</p>\r\n<p align=\"left\">### h1 test ###</p>',0,NULL),(3,'story',NULL,1,1,'Story Test Name','this is a big test','This is a story test.','Notes still go here in this story.',0,81),(4,'section',7,1,1,'Prologue','new sneaky body','This is the prologue to the test story.','No notes to be written.',0,NULL),(5,'section',7,1,1,'Chapter 1','new sneaky body','test description','',0,NULL),(6,'section',1,1,1,'World Epilogue','new sneaky body','','',0,NULL),(7,'section',3,1,9,'Part 1','new sneaky body test','This is the first part of the story.\r\n\r\nh1 testbold','h1 test\r\nbold test',0,38),(8,'world',NULL,1,1,'Project World','new sneaky body','A first attempt at creating a fleshed-out world.','',0,NULL),(9,'story',8,1,1,'The Tale of Gregor the Seer','new sneaky body','The story of Gregor the Seer, who led the First Pilgrimage.','',0,NULL),(32,'story',NULL,1,1,'Separate Story','new sneaky body','This is a story without a world.','No notes for now.',0,NULL),(30,'section',9,1,1,'People','People body','Description','Notes',0,40),(38,'story',35,9,9,'A Second New Story','I can show you a story\r\nTake you wonder by wonder\r\nUpwards, sideways, and under\r\nOn a magic carpet ride.','','',0,NULL),(36,'story',35,9,9,'A Whole New Story','This is a new story, fit for kings.','','',0,64),(37,'story',35,9,9,'A Second New Story','I can show you a story\r\nTake you wonder by wonder\r\nUpwards, sideways, and under\r\nOn a magic carpet ride.','','',0,NULL),(35,'world',NULL,9,9,'A Whole New World','This is a complete world.','A simple test world. Testing to ensure that versions are created initially.','No notes to speak of.\r\n\r\nChanges #3\r\n\r\nUnrelated changes.\r\n',0,63),(39,'story',35,9,9,'A Third New Story','# Title Test #\r\nI can show you a story\r\nTake you wonder by wonder\r\nUpwards, sideways, and under\r\nOn a magic carpet ride.','','',0,NULL),(40,'section',36,9,9,'A Whole New Section','# Title Test #\r\nI can show you a story\r\nTake you wonder by wonder\r\nUpwards, sideways, and under\r\nOn a magic carpet ride.','','',0,NULL),(41,'section',40,9,9,'A Whole New Sub-Section','I can show you a sub-section\r\n\r\nTake you wonder by wonder\r\n\r\nUpwards, sideways, and under\r\n\r\nOn a magic carpet ride.\r\n\r\nChanges #1','','',0,72),(42,'story',NULL,1,1,'OpenNation','Some text here.\r\n\r\n> This is a block quote.\r\nMore quote stuff here.\r\n\r\nMore text.','This is a story about an attempt by a number of a hopeful individuals that a new society can be created with the ideals of technology.','',0,126),(43,'section',42,1,1,'Philosophies','','This section contains the philosophies of various people in the OpenNation universe, be it the present or future.','',0,83),(44,'section',43,1,1,'On the Inevitability of the Merging of Biology and Computer Engineering','BODY GOES HERE','This is an essay discussing the inevitability of the availability and widespread prevalence of cybernetics.','',0,86);
/*!40000 ALTER TABLE `build_world_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_entity_old`
--

DROP TABLE IF EXISTS `build_world_entity_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_entity_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `founder_id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `description` varchar(1000) NOT NULL,
  `notes` longtext NOT NULL,
  `private` tinyint(1) NOT NULL,
  `active_version_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_entity_f0bd6439` (`type`),
  KEY `build_world_entity_63f17a16` (`parent_id`),
  KEY `build_world_entity_6d3dac22` (`founder_id`),
  KEY `build_world_entity_5d52dd10` (`owner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_entity_old`
--

LOCK TABLES `build_world_entity_old` WRITE;
/*!40000 ALTER TABLE `build_world_entity_old` DISABLE KEYS */;
INSERT INTO `build_world_entity_old` VALUES (1,'world',NULL,1,1,'World Test','cheese','description test','<p align=\"left\">Notes go here. You know it. Bananas, son!</p>\r\n<p align=\"left\">Test</p>\r\n<p align=\"left\">testingmoar tests</p>\r\n<p align=\"left\">### h1 test ###</p>',0,NULL),(3,'story',NULL,1,1,'Story Test Name','# h1 test #\r\nboldtextisnotbold\r\n\r\nboldtextisnotbold\r\n\r\nalert(\'hacked!\'); kajhf ajkdhf jka hjksd hf kdfj ksdjf klsdjf kldj gkdjs sdlfjklfj gkld jklfjkldjfgklfj klsdj kdsfg khsd hsdjkf hsdjkf hgjkdfh gdjkfh gjkdfh gjkdhfg sdjkfh gkjsdhf gjkdfh gkjdhsfgsdjk ghfj ghsdjk ghdjkf klsdj kdsfg khsd hsdjkf hsdjkf hgjkdfh gdjkfh gjkdfh gjkdhfg sdjkfh gkjsdhf gjkdfh \r\ngkjdhsfgsdjk ghfj ghsdjk ghdjkf klsdj kdsfg khsd hsdjkf hsdjkf hgjkdfh gdjkfh gjkdfh gjkdhfg sdjkfh gkjsdhf gjkdfh gkjdhsfgsdjk ghfj ghsdjk ghdjkf klsdj kdsfg khsd hsdjkf hsdjkf hgjkdfh gdjkfh gjkdfh gjkdhfg sdjkfh gkjsdhf gjkdfh gkjdhsfgsdjk ghfj ghsdjk ghdjkf','This is a story test.','Notes still go here in this story.',0,NULL),(4,'section',7,1,1,'Prologue','Doesn\'t it make you feel better/\r\nThe pigs have won tonight/\r\nThey can all sleep soundly/\r\nAnd everything is alright.','This is the prologue to the test story.','No notes to be written.',0,NULL),(5,'section',7,1,1,'Chapter 1','In the beginning, there was light.','test description','',0,NULL),(6,'section',1,1,1,'World Epilogue','And so it ends...','','',0,NULL),(7,'section',3,1,9,'Part 1','Big Title\r\n===========\r\n\r\ntest','This is the first part of the story.\r\n\r\nh1 testbold','h1 test\r\nbold test',0,NULL),(8,'world',NULL,1,1,'Project World','','A first attempt at creating a fleshed-out world.','',0,NULL),(9,'story',8,1,1,'The Tale of Gregor the Seer','So begins the tale of Gregor the Seer.','The story of Gregor the Seer, who led the First Pilgrimage.','',0,NULL),(32,'story',NULL,1,1,'Separate Story','Story goes here1','This is a story without a world.','No notes for now.',0,NULL),(30,'section',9,1,1,'People','This section describes the people involved in the story.','','',0,NULL);
/*!40000 ALTER TABLE `build_world_entity_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_entityversion`
--

DROP TABLE IF EXISTS `build_world_entityversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_entityversion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_num` int(11) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `modifies_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `body` longtext,
  `description` longtext,
  `notes` longtext,
  `edited` tinyint(1) NOT NULL,
  `accepted` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_refs_id_e7f72a62` (`user_id`),
  KEY `entity_id_refs_id_2c2177b0` (`entity_id`),
  KEY `modifies_id_refs_id_3413b6f9` (`modifies_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_entityversion`
--

LOCK TABLES `build_world_entityversion` WRITE;
/*!40000 ALTER TABLE `build_world_entityversion` DISABLE KEYS */;
INSERT INTO `build_world_entityversion` VALUES (2,1,3,NULL,1,'','','',1,1,1),(7,5,3,6,1,'','','',1,1,1),(4,2,3,2,1,'','','',1,1,1),(5,3,3,4,1,'','','',1,1,1),(6,4,3,5,1,'','','',1,1,1),(8,6,3,7,1,'','','',1,1,1),(9,7,3,8,1,'','','',1,1,1),(17,11,3,16,1,'','','',1,1,1),(11,8,3,9,1,'','','',1,1,1),(16,10,3,15,1,'','','',1,1,1),(15,9,3,11,1,'','','',1,1,1),(18,12,3,17,1,'','','',1,1,1),(42,16,3,41,1,'','','',1,1,9),(38,1,7,NULL,1,'','','',1,1,1),(41,15,3,39,1,'','','',1,1,9),(40,1,30,NULL,1,'','','',1,1,1),(39,14,3,31,1,'','','',1,1,1),(31,13,3,18,1,'','','',1,1,1),(45,1,35,NULL,1,'--- \n+++ \n@@ -1 +1 @@\n-\n+This is a complete world.','--- \n+++ \n@@ -1 +1 @@\n-\n+A simple test world. Testing to ensure that versions are created initially.','--- \n+++ \n@@ -1 +1 @@\n-\n+No notes to speak of.',0,1,9),(46,1,35,NULL,1,'','','',1,1,9),(61,4,35,60,1,'','','--- \n+++ \n@@ -1,3 +1,3 @@\n No notes to speak of.\r\n \r\n-Changes #2\n+Changes #3',1,1,9),(60,3,35,59,1,'','','--- \n+++ \n@@ -1,3 +1,3 @@\n No notes to speak of.\r\n \r\n-Changes #1\n+Changes #2',1,1,9),(59,2,35,46,1,'','','--- \n+++ \n@@ -1 +1,3 @@\n-No notes to speak of.\n+No notes to speak of.\r\n+\r\n+Changes #1',1,1,9),(62,5,35,61,1,'','','--- \n+++ \n@@ -1,3 +1,5 @@\n No notes to speak of.\r\n \r\n-Changes #3\n+Changes #3\r\n+\r\n+Unrelated changes.',1,1,9),(63,6,35,62,1,'','','--- \n+++ \n@@ -2,4 +2,5 @@\n \r\n Changes #3\r\n \r\n-Unrelated changes.\n+Unrelated changes.\r\n+',1,1,9),(64,1,36,NULL,1,'--- \n+++ \n@@ -1 +1 @@\n-\n+This is a new story, fit for kings.','','',0,1,9),(65,1,38,NULL,1,'--- \n+++ \n@@ -1 +1,4 @@\n-\n+I can show you a story\r\n+Take you wonder by wonder\r\n+Upwards, sideways, and under\r\n+On a magic carpet ride.','','',0,1,9),(77,18,3,76,1,'--- \n+++ \n@@ -1,3 +1,3 @@\n this is a big test\r\n \r\n-Changes #3\n+Changes #4','','',1,1,9),(67,1,39,NULL,1,'--- \n+++ \n@@ -1 +1,5 @@\n-\n+# Title Test #\r\n+I can show you a story\r\n+Take you wonder by wonder\r\n+Upwards, sideways, and under\r\n+On a magic carpet ride.','','',0,1,9),(69,1,40,NULL,1,'--- \n+++ \n@@ -1 +1,5 @@\n-\n+# Title Test #\r\n+I can show you a story\r\n+Take you wonder by wonder\r\n+Upwards, sideways, and under\r\n+On a magic carpet ride.','','',0,1,9),(71,1,41,NULL,1,'--- \n+++ \n@@ -1 +1,8 @@\n-\n+# Title Test #\r\n+I can show you a sub-section\r\n+\r\n+Take you wonder by wonder\r\n+\r\n+Upwards, sideways, and under\r\n+\r\n+On a magic carpet ride.','','',0,1,9),(72,2,41,71,1,'--- \n+++ \n@@ -1,8 +1,9 @@\n-# Title Test #\r\n I can show you a sub-section\r\n \r\n Take you wonder by wonder\r\n \r\n Upwards, sideways, and under\r\n \r\n-On a magic carpet ride.\n+On a magic carpet ride.\r\n+\r\n+Changes #1','','',1,1,9),(76,17,3,42,1,'--- \n+++ \n@@ -1 +1,3 @@\n-\n+this is a big test\r\n+\r\n+Changes #3','--- \n+++ \n@@ -1 +1 @@\n-\n+This is a story test.','--- \n+++ \n@@ -1 +1 @@\n-\n+Notes still go here in this story.',1,1,9),(78,19,3,77,1,'--- \n+++ \n@@ -1,3 +1 @@\n-this is a big test\r\n-\r\n-Changes #4\n+this is a big test','','',1,1,9),(82,1,42,NULL,1,'','--- \n+++ \n@@ -1 +1 @@\n-\n+This is a story about an attempt by a number of a hopeful individuals that a new society can be created with the ideals of technology.','',0,1,1),(81,20,3,78,1,'','','',1,1,9),(83,1,43,NULL,1,'','--- \n+++ \n@@ -1 +1 @@\n-\n+This section contains the philosophies of various people in the OpenNation universe, be it the present or future.','',0,1,1),(85,1,44,NULL,1,'','--- \n+++ \n@@ -1 +1 @@\n-\n+This is an essay discussing the inevitability of the availability and widespread prevalence of cybernetics.','',0,1,1),(86,2,44,85,1,'--- \n+++ \n@@ -1 +1 @@\n-\n+BODY GOES HERE','','',1,1,1),(93,3,42,92,1,'--- \n+++ \n@@ -1,5 +1 @@\n-Testing\r\n-\r\n-This is bold\r\n-\r\n-Testing again\n+','','',1,1,1),(92,2,42,82,1,'--- \n+++ \n@@ -1 +1,5 @@\n-\n+Testing\r\n+\r\n+This is bold\r\n+\r\n+Testing again','','',1,1,1),(94,4,42,93,1,'--- \n+++ \n@@ -1 +1,3 @@\n-\n+_italic text_ or *italic text*\r\n+\r\n+__bold text__ or _bold text_','','',1,1,1),(95,5,42,94,1,'','','',1,1,1),(96,6,42,95,1,'--- \n+++ \n@@ -1,3 +1,3 @@\n _italic text_ or *italic text*\r\n \r\n-__bold text__ or _bold text_\n+__bold text__ or **bold text**','','',1,1,1),(97,7,42,96,1,'--- \n+++ \n@@ -1,3 +1,8 @@\n _italic text_ or *italic text*\r\n \r\n-__bold text__ or **bold text**\n+__bold text__ or **bold text**\r\n+\r\n+> Everything in here should be quoted!\r\n+But is this line quoted as well?\r\n+\r\n+This one shouldn\'t be!','','',1,1,1),(98,8,42,97,1,'--- \n+++ \n@@ -1,8 +1 @@\n-_italic text_ or *italic text*\r\n-\r\n-__bold text__ or **bold text**\r\n-\r\n-> Everything in here should be quoted!\r\n-But is this line quoted as well?\r\n-\r\n-This one shouldn\'t be!\n+','','',1,1,1),(130,NULL,42,126,0,NULL,NULL,NULL,0,0,1),(129,NULL,42,126,0,NULL,NULL,NULL,0,0,1),(128,NULL,42,126,0,NULL,NULL,NULL,0,0,1),(127,NULL,42,126,0,NULL,NULL,NULL,0,0,1),(126,9,42,98,1,'--- \n+++ \n@@ -1 +1,6 @@\n-\n+Some text here.\r\n+\r\n+> This is a block quote.\r\n+More quote stuff here.\r\n+\r\n+More text.','','',1,1,1);
/*!40000 ALTER TABLE `build_world_entityversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_memberrelation`
--

DROP TABLE IF EXISTS `build_world_memberrelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_memberrelation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `relation` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_memberrelation_2ce815e9` (`entity_id`),
  KEY `build_world_memberrelation_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_memberrelation`
--

LOCK TABLES `build_world_memberrelation` WRITE;
/*!40000 ALTER TABLE `build_world_memberrelation` DISABLE KEYS */;
INSERT INTO `build_world_memberrelation` VALUES (1,9,9,'chief_contrib'),(22,3,13,'editor'),(3,3,10,'chief_contrib'),(16,1,9,'chief_contrib'),(17,1,10,'chief_editor'),(18,1,13,'contributor'),(19,1,14,'editor'),(21,1,15,'contributor'),(20,1,12,'artist'),(23,3,9,'chief_editor');
/*!40000 ALTER TABLE `build_world_memberrelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_note`
--

DROP TABLE IF EXISTS `build_world_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `world_id` int(11) DEFAULT NULL,
  `body` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_note_12ff7a21` (`world_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_note`
--

LOCK TABLES `build_world_note` WRITE;
/*!40000 ALTER TABLE `build_world_note` DISABLE KEYS */;
INSERT INTO `build_world_note` VALUES (1,'People','Describes people in the world as I think of them and flesh them out.',1,'Gregor the Seer\r\n    - came from [WHERE]\r\n    - believed that people must move back to the Bleak Lands en masse\r\n    - led many people in the First Pilgrimage to the Bleak Lands\r\n    - few stories made it out, but it is believed that they made it at least to Fort Brimstone\r\n    - there are records/legends of a male and a female who escaped Fort Brimstone and the Pilgrimage together\r\n        - they told of incomparable horrors: murder, rape, cannibalism, and barbaric war due to factioned pilgrims\r\n        - though not fully sane, they were taken \r\n        - it is widely believed in \'current\' (NOTE: need to define \'current\' in years) educated circles that without their story, the world would not have \r\n            undergone the Age of Achievement'),(2,'World Ideas','',NULL,'- Post-apocalyptic sci-fi');
/*!40000 ALTER TABLE `build_world_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_section`
--

DROP TABLE IF EXISTS `build_world_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `parent_section_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_section_f5ae222e` (`story_id`),
  KEY `build_world_section_ea29c4d6` (`parent_section_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_section`
--

LOCK TABLES `build_world_section` WRITE;
/*!40000 ALTER TABLE `build_world_section` DISABLE KEYS */;
INSERT INTO `build_world_section` VALUES (1,1,NULL,'Part 1','TESTING AGAIN TEST','The first major part of the story.'),(2,1,1,'Chapter 1','CHAPTER 1 TEST','This is the first chapter.');
/*!40000 ALTER TABLE `build_world_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_story`
--

DROP TABLE IF EXISTS `build_world_story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_story` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_story_12ff7a21` (`world_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_story`
--

LOCK TABLES `build_world_story` WRITE;
/*!40000 ALTER TABLE `build_world_story` DISABLE KEYS */;
INSERT INTO `build_world_story` VALUES (1,1,'The Tale of Gregor the Seer','The story of Gregor the Seer, who led the First Pilgrimage.');
/*!40000 ALTER TABLE `build_world_story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_world_world`
--

DROP TABLE IF EXISTS `build_world_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_world_world` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `build_world_world_5d52dd10` (`owner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_world_world`
--

LOCK TABLES `build_world_world` WRITE;
/*!40000 ALTER TABLE `build_world_world` DISABLE KEYS */;
INSERT INTO `build_world_world` VALUES (1,'Project World','A first attempt at creating a fleshed-out world.',1);
/*!40000 ALTER TABLE `build_world_world` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (28,'2012-04-26 22:19:43',1,16,'9','story: The Tale of Gregor the Seer',2,'Changed parent.'),(23,'2012-04-26 22:18:59',1,16,'14','section: Test founder sub-section',3,''),(24,'2012-04-26 22:18:59',1,16,'13','section: Test founder section',3,''),(25,'2012-04-26 22:18:59',1,16,'12','story: Story Test',3,''),(26,'2012-04-26 22:18:59',1,16,'11','story: The Third Story',3,''),(27,'2012-04-26 22:18:59',1,16,'10','story: The Second Story',3,''),(19,'2012-04-25 14:26:08',1,17,'1','MemberRelation object',1,''),(20,'2012-04-25 14:26:23',1,17,'2','MemberRelation object',1,''),(21,'2012-04-25 19:44:54',1,17,'3','testman2, chief_contrib of story: Story Test Name',1,''),(22,'2012-04-26 22:18:59',1,16,'15','section: test sub-sub-section',3,''),(14,'2012-04-20 14:35:48',1,3,'2','testman',1,''),(15,'2012-04-23 00:49:04',1,16,'2','world: World Test',1,''),(16,'2012-04-23 00:49:20',1,16,'2','world: World Test',3,''),(17,'2012-04-23 00:50:32',1,16,'3','story: Story Test',1,''),(18,'2012-04-23 00:51:58',1,16,'4','section: Prologue',1,''),(29,'2012-04-27 23:47:05',1,16,'25','section: Test section 8',3,''),(30,'2012-04-27 23:47:05',1,16,'24','section: Test section 8',3,''),(31,'2012-04-27 23:47:05',1,16,'23','section: Test section 7',3,''),(32,'2012-04-27 23:47:05',1,16,'22','section: Test section 7',3,''),(33,'2012-04-27 23:47:05',1,16,'21','section: Test section 6',3,''),(34,'2012-04-27 23:47:05',1,16,'20','section: Test section 5',3,''),(35,'2012-04-27 23:47:05',1,16,'19','section: Test section 4',3,''),(36,'2012-04-27 23:47:05',1,16,'18','world: Test section 3',3,''),(37,'2012-04-27 23:47:05',1,16,'17','section: Test section 2',3,''),(38,'2012-04-27 23:47:05',1,16,'16','section: Test section',3,''),(39,'2012-04-27 23:58:25',1,16,'26','section: Test section 1',3,''),(40,'2012-04-27 23:58:25',1,16,'27','section: Test section 2',3,''),(41,'2012-04-27 23:58:25',1,16,'28','section: Test section 3',3,''),(42,'2012-04-27 23:58:25',1,16,'29','section: Test section 4',3,''),(43,'2012-04-28 14:05:17',1,16,'3','story: Story Test Name',2,'Changed parent.'),(44,'2012-04-28 14:05:46',1,16,'6','section: World Epilogue',2,'Changed parent.'),(45,'2012-04-28 15:48:30',1,17,'14','testman2, chief_contrib of world: World Test',3,''),(46,'2012-04-28 15:48:30',1,17,'13','testman2, chief_contrib of world: World Test',3,''),(47,'2012-04-28 15:48:30',1,17,'9','testman5, chief_contrib of story: The Tale of Gregor the Seer',3,''),(48,'2012-04-28 15:48:30',1,17,'8','testman6, chief_contrib of story: The Tale of Gregor the Seer',3,''),(49,'2012-04-28 18:06:16',1,17,'10','testman6, contributor of story: The Tale of Gregor the Seer',3,''),(50,'2012-04-28 18:06:16',1,17,'7','testman6, editor of section: People',3,''),(51,'2012-04-28 18:06:16',1,17,'5','testman5, contributor of story: The Tale of Gregor the Seer',3,''),(52,'2012-04-28 18:08:23',1,17,'12','testman5, artist of story: The Tale of Gregor the Seer',3,''),(53,'2012-04-28 19:02:10',1,16,'31','world: Test sub-section',3,''),(54,'2012-05-06 14:52:00',1,16,'34','world: A Whole New World',3,''),(55,'2012-05-06 14:52:00',1,16,'33','world: A Whole New World',3,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(18,'user profile','users','userprofile'),(16,'entity','build_world','entity'),(17,'member relation','build_world','memberrelation');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7d1bd0f739008e2d1c5ad1df59a3b4f1','N2RiNjk1ZGUyNjA4ZTY3ZTM4MmJlMGUxMmUxMDc4NTlkYzU1MDU2ODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-04-17 22:13:58'),('daf2ea8aec4de8ee9523cb15d48aac85','NjdhODg2NGE1NDczNGI1MjhmMjA4MjU5MTlkM2ZiNGY1OTc1NjYwOTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQl1Lg==\n','2012-06-27 18:47:59'),('a32dff73ee356e8bcb47c4effa4b31ed','NjdhODg2NGE1NDczNGI1MjhmMjA4MjU5MTlkM2ZiNGY1OTc1NjYwOTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQl1Lg==\n','2012-05-30 15:38:25');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `user_id` int(11) NOT NULL,
  `fav_author` varchar(64) NOT NULL,
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
INSERT INTO `users_userprofile` VALUES (1,'Neal Stephenson'),(12,''),(10,''),(9,''),(13,'Some Guy'),(14,'Rene Descartes'),(15,'');
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_aggregate`
--

DROP TABLE IF EXISTS `vote_aggregate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_aggregate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `vote_sum` int(11) NOT NULL,
  `spam_sum` int(11) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entity_id_refs_id_5789f7a0` (`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_aggregate`
--

LOCK TABLES `vote_aggregate` WRITE;
/*!40000 ALTER TABLE `vote_aggregate` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_aggregate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_currentvote`
--

DROP TABLE IF EXISTS `vote_currentvote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_currentvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `vote` varchar(32) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_refs_id_ca57d8de` (`user_id`),
  KEY `entity_id_refs_id_573b79fc` (`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_currentvote`
--

LOCK TABLES `vote_currentvote` WRITE;
/*!40000 ALTER TABLE `vote_currentvote` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_currentvote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_vote`
--

DROP TABLE IF EXISTS `vote_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `vote` varchar(32) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_refs_id_be8a4a9a` (`user_id`),
  KEY `entity_id_refs_id_b24b6818` (`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_vote`
--

LOCK TABLES `vote_vote` WRITE;
/*!40000 ALTER TABLE `vote_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-06-13 15:36:40
