CREATE DATABASE  IF NOT EXISTS `db_test_7b` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_test_7b`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: db_test_7b
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_buyer_orders`
--

DROP TABLE IF EXISTS `tb_buyer_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_buyer_orders` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `shipping_address_id` int unsigned NOT NULL,
  `payment_method_id` bigint unsigned NOT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_status` enum('PENDING','PAID','SHIPPED','DELIVERED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_orders_user` (`user_id`),
  KEY `fk_orders_address` (`shipping_address_id`),
  KEY `fk_orders_payment` (`payment_method_id`),
  CONSTRAINT `fk_orders_address` FOREIGN KEY (`shipping_address_id`) REFERENCES `tb_user_addresses` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_payment` FOREIGN KEY (`payment_method_id`) REFERENCES `tbd_user_payment_methods` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_buyer_orders_after_insert` AFTER INSERT ON `tb_buyer_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_buyer_orders', 'Create', USER(), CONCAT('Orden creada ID=', NEW.ID, ' para User ID=', NEW.user_id, ', Total=$', NEW.total_amount), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_buyer_orders_after_update` AFTER UPDATE ON `tb_buyer_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_buyer_orders', 'Update', USER(), CONCAT('Orden ID=', NEW.ID, ' cambió a estado ', NEW.order_status), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_buyer_orders_after_delete` AFTER DELETE ON `tb_buyer_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_buyer_orders', 'Delete', USER(), CONCAT('Orden eliminada ID=', OLD.ID), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_carts` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int NOT NULL,
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_cart_user` (`user_ID`),
  CONSTRAINT `tb_carts_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_carts_ai` AFTER INSERT ON `tb_carts` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_carts', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_carts. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_carts_au` AFTER UPDATE ON `tb_carts` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_carts', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_carts. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_carts_ad` AFTER DELETE ON `tb_carts` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_carts', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_carts. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_logs`
--

DROP TABLE IF EXISTS `tb_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_logs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(80) NOT NULL,
  `record_id` int unsigned DEFAULT NULL,
  `table_operation` enum('Create','Read','Update','Delete') DEFAULT NULL,
  `db_user` varchar(80) NOT NULL,
  `table_description` text NOT NULL,
  `operation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation_status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `idx_logs_table_record_operation` (`table_name`,`record_id`,`table_operation`),
  KEY `idx_logs_table_operation_date` (`table_name`,`table_operation`,`operation_date`),
  KEY `idx_logs_db_user_date` (`db_user`,`operation_date`)
) ENGINE=InnoDB AUTO_INCREMENT=38877 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_order_cancellations`
--

DROP TABLE IF EXISTS `tb_order_cancellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_order_cancellations` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `requested_by` int NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Requested','Approved','Rejected','Completed') NOT NULL DEFAULT 'Requested',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_order_cancellations_order` (`order_ID`),
  KEY `fk_order_cancellations_user` (`requested_by`),
  CONSTRAINT `fk_order_cancellations_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_order_cancellations_user` FOREIGN KEY (`requested_by`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_ai` AFTER INSERT ON `tb_order_cancellations` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_order_cancellations', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_order_cancellations. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_au` AFTER UPDATE ON `tb_order_cancellations` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_order_cancellations', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_order_cancellations. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_order_cancellations_ad` AFTER DELETE ON `tb_order_cancellations` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_order_cancellations', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_order_cancellations. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_orders`
--

DROP TABLE IF EXISTS `tb_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_orders` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `seller_ID` int NOT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `shipping_cost` decimal(12,2) NOT NULL DEFAULT '0.00',
  `fulfillment_status` enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned') NOT NULL DEFAULT 'Pending',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `seller_ID` (`seller_ID`),
  CONSTRAINT `tb_orders_ibfk_1` FOREIGN KEY (`seller_ID`) REFERENCES `tb_users` (`ID`),
  CONSTRAINT `tb_orders_chk_1` CHECK ((`subtotal` >= 0)),
  CONSTRAINT `tb_orders_chk_2` CHECK ((`shipping_cost` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_orders_ai` AFTER INSERT ON `tb_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_orders', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_orders. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_orders_au` AFTER UPDATE ON `tb_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_orders', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_orders. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_orders_ad` AFTER DELETE ON `tb_orders` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_orders', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_orders. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payment_methods`
--

DROP TABLE IF EXISTS `tb_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payment_methods` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_methods_ai` AFTER INSERT ON `tb_payment_methods` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_methods', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_payment_methods. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_methods_au` AFTER UPDATE ON `tb_payment_methods` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_methods', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_payment_methods. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_methods_ad` AFTER DELETE ON `tb_payment_methods` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_methods', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_payment_methods. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payment_transaction`
--

DROP TABLE IF EXISTS `tb_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payment_transaction` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_ID` int unsigned NOT NULL,
  `transaction_reference` varchar(255) NOT NULL,
  `gateway_response` text,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_trans_payment` (`payment_ID`),
  CONSTRAINT `fk_trans_payment` FOREIGN KEY (`payment_ID`) REFERENCES `tb_payments` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_ai` AFTER INSERT ON `tb_payment_transaction` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_transaction', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_payment_transaction. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_au` AFTER UPDATE ON `tb_payment_transaction` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_transaction', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_payment_transaction. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payment_transaction_ad` AFTER DELETE ON `tb_payment_transaction` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payment_transaction', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_payment_transaction. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_payments`
--

DROP TABLE IF EXISTS `tb_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_payments` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `user_payment_method_ID` bigint unsigned DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_status` enum('Pending','Approved','Rejected','Refunded') NOT NULL DEFAULT 'Pending',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_payments_order` (`order_ID`),
  KEY `fk_payments_user_method` (`user_payment_method_ID`),
  CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_payments_user_method` FOREIGN KEY (`user_payment_method_ID`) REFERENCES `tbd_user_payment_methods` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payments_ai` AFTER INSERT ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payments', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_payments. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payments_au` AFTER UPDATE ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payments', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_payments. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_payments_ad` AFTER DELETE ON `tb_payments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_payments', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_payments. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_people`
--

DROP TABLE IF EXISTS `tb_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_people` (
  `person_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int DEFAULT NULL,
  `courtesy_title` varchar(20) DEFAULT NULL,
  `given_names` varchar(150) NOT NULL,
  `family_names` varchar(150) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('Hombre','Mujer','Prefiero no decirlo') NOT NULL DEFAULT 'Prefiero no decirlo',
  `country_code` char(2) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_ID`),
  UNIQUE KEY `user_ID` (`user_ID`),
  CONSTRAINT `fk_people_users` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_people_ai` AFTER INSERT ON `tb_people` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_people', NEW.person_ID, 'Create', USER(), CONCAT('Registro creado en tb_people. ID=', NEW.person_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_people_au` AFTER UPDATE ON `tb_people` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_people', NEW.person_ID, 'Update', USER(), CONCAT('Registro actualizado en tb_people. ID=', NEW.person_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_people_ad` AFTER DELETE ON `tb_people` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_people', OLD.person_ID, 'Delete', USER(), CONCAT('Registro eliminado en tb_people. ID=', OLD.person_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_product_categories`
--

DROP TABLE IF EXISTS `tb_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_product_categories` (
  `product_Id` int unsigned NOT NULL,
  `category_Id` int unsigned NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_Id`,`category_Id`),
  KEY `idx_pc_category_product` (`category_Id`,`product_Id`),
  CONSTRAINT `fk_pc_category` FOREIGN KEY (`category_Id`) REFERENCES `tb_categories` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_product` FOREIGN KEY (`product_Id`) REFERENCES `tb_products` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_product_categories_after_insert` AFTER INSERT ON `tb_product_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_product_categories', 'Create', USER(), CONCAT('Asociación Categ-Prod creada Product ID=', NEW.product_Id), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_product_categories_after_update` AFTER UPDATE ON `tb_product_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_product_categories', 'Update', USER(), CONCAT('Asociación Categ-Prod actualizada Product ID=', NEW.product_Id), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_product_categories_after_delete` AFTER DELETE ON `tb_product_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tb_product_categories', 'Delete', USER(), CONCAT('Asociación Categ-Prod eliminada Product ID=', OLD.product_Id), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_products` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU` varchar(50) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` text,
  `current_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `current_stock` int unsigned NOT NULL DEFAULT '0',
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SKU` (`SKU`)
) ENGINE=InnoDB AUTO_INCREMENT=5011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_products_after_insert` AFTER INSERT ON `tb_products` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_products', NEW.ID, 'Create', USER(), CONCAT('Producto creado: "', NEW.name, '". SKU: ', NEW.SKU, ', Precio: $', NEW.current_price, ', Stock inicial: ', NEW.current_stock));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_products_after_update` AFTER UPDATE ON `tb_products` FOR EACH ROW BEGIN
    DECLARE changes_detail TEXT DEFAULT '';
    IF NOT (OLD.SKU <=> NEW.SKU) THEN
        SET changes_detail = CONCAT(changes_detail, 'SKU: "', OLD.SKU, '" -> "', NEW.SKU, '"; ');
    END IF;
    IF NOT (OLD.name <=> NEW.name) THEN
        SET changes_detail = CONCAT(changes_detail, 'Nombre: "', OLD.name, '" -> "', NEW.name, '"; ');
    END IF;
    IF NOT (OLD.description <=> NEW.description) THEN
        SET changes_detail = CONCAT(changes_detail, 'Descripcion: "', COALESCE(OLD.description, 'NULL'), '" -> "', COALESCE(NEW.description, 'NULL'), '"; ');
    END IF;
    IF NOT (OLD.current_price <=> NEW.current_price) THEN
        SET changes_detail = CONCAT(changes_detail, 'Precio: $', OLD.current_price, ' -> $', NEW.current_price, '; ');
    END IF;
    IF NOT (OLD.current_stock <=> NEW.current_stock) THEN
        SET changes_detail = CONCAT(changes_detail, 'Stock: ', OLD.current_stock, ' -> ', NEW.current_stock, '; ');
    END IF;
    IF NOT (OLD.status <=> NEW.status) THEN
        SET changes_detail = CONCAT(changes_detail, 'Estado: ', COALESCE(CAST(OLD.status AS UNSIGNED), 0), ' -> ', COALESCE(CAST(NEW.status AS UNSIGNED), 0), '; ');
    END IF;
    IF changes_detail <> '' THEN
        INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
        VALUES ('tb_products', NEW.ID, 'Update', USER(), TRIM(changes_detail));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_products_after_delete` AFTER DELETE ON `tb_products` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_date, operation_status)
    VALUES ('tb_products', OLD.ID, 'Delete', USER(), CONCAT('Producto eliminado. ID=', OLD.ID, ', SKU=', OLD.SKU, ', nombre=', OLD.name), CURRENT_TIMESTAMP, b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_refunds`
--

DROP TABLE IF EXISTS `tb_refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_refunds` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_ID` int unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `reason` text,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_refunds_payment` (`payment_ID`),
  CONSTRAINT `fk_refunds_payment` FOREIGN KEY (`payment_ID`) REFERENCES `tb_payments` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_refunds_ai` AFTER INSERT ON `tb_refunds` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_refunds', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_refunds. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_refunds_au` AFTER UPDATE ON `tb_refunds` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_refunds', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_refunds. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_refunds_ad` AFTER DELETE ON `tb_refunds` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_refunds', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_refunds. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_returns`
--

DROP TABLE IF EXISTS `tb_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_returns` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `requested_by` int NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Requested','Approved','Rejected','Completed') NOT NULL DEFAULT 'Requested',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_returns_order_hdr` (`order_ID`),
  KEY `fk_returns_user` (`requested_by`),
  CONSTRAINT `fk_returns_order_hdr` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_returns_user` FOREIGN KEY (`requested_by`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_returns_ai` AFTER INSERT ON `tb_returns` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_returns', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_returns. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_returns_au` AFTER UPDATE ON `tb_returns` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_returns', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_returns. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_returns_ad` AFTER DELETE ON `tb_returns` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_returns', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_returns. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_shipments`
--

DROP TABLE IF EXISTS `tb_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_shipments` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `order_ID` int unsigned NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  `shipping_status` enum('Preparing','In_Transit','Delivered','Failed') NOT NULL DEFAULT 'Preparing',
  `shipped_date` datetime DEFAULT NULL,
  `delivered_date` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_shipments_order` (`order_ID`),
  CONSTRAINT `fk_shipments_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_shipments_ai` AFTER INSERT ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_shipments', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tb_shipments. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_shipments_au` AFTER UPDATE ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_shipments', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tb_shipments. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_shipments_ad` AFTER DELETE ON `tb_shipments` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tb_shipments', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tb_shipments. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_user_addresses`
--

DROP TABLE IF EXISTS `tb_user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_addresses` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_user_address` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_user_addresses_ai` AFTER INSERT ON `tb_user_addresses` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_status)
    VALUES ('tb_user_addresses', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Nueva dirección registrada para usuario: ', NEW.user_id), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_user_addresses_au` AFTER UPDATE ON `tb_user_addresses` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_status)
    VALUES ('tb_user_addresses', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Dirección actualizada ID: ', NEW.ID), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tb_user_addresses_ad` AFTER DELETE ON `tb_user_addresses` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_status)
    VALUES ('tb_user_addresses', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Dirección eliminada ID: ', OLD.ID), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `nick` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=7524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_users_after_insert` AFTER INSERT ON `tb_users` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_date, operation_status)
    VALUES ('tb_users', NEW.ID, 'Create', USER(), CONCAT('Usuario creado. ID=', NEW.ID, ', email=', NEW.email, ', nick=', NEW.nick), CURRENT_TIMESTAMP, b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_users_after_update` AFTER UPDATE ON `tb_users` FOR EACH ROW BEGIN
    IF NOT (OLD.email <=> NEW.email AND OLD.nick <=> NEW.nick AND OLD.last_login <=> NEW.last_login AND OLD.status <=> NEW.status) THEN
        INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_date, operation_status)
        VALUES ('tb_users', NEW.ID, 'Update', USER(), CONCAT('Usuario actualizado. ID=', NEW.ID, ', email nuevo=', NEW.email), CURRENT_TIMESTAMP, b'1');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_users_after_delete` AFTER DELETE ON `tb_users` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description, operation_date, operation_status)
    VALUES ('tb_users', OLD.ID, 'Delete', USER(), CONCAT('Usuario eliminado. ID=', OLD.ID, ', email=', OLD.email), CURRENT_TIMESTAMP, b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbc_categories`
--

DROP TABLE IF EXISTS `tbc_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_categories` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `description` text,
  `sup_id_category` int unsigned DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`),
  KEY `fk_superior_category` (`sup_id_category`),
  CONSTRAINT `fk_superior_category` FOREIGN KEY (`sup_id_category`) REFERENCES `tbc_categories` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_categories_after_insert` AFTER INSERT ON `tbc_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_categories', NEW.ID, 'Create', USER(), CONCAT('Categoria creada: "', NEW.name, '"'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_categories_after_update` AFTER UPDATE ON `tbc_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_categories', NEW.ID, 'Update', USER(), CONCAT('Categoria actualizada. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_categories_after_delete` AFTER DELETE ON `tbc_categories` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_categories', OLD.ID, 'Delete', USER(), CONCAT('Categoria eliminada. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbc_payment_methods_types`
--

DROP TABLE IF EXISTS `tbc_payment_methods_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_payment_methods_types` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_ai` AFTER INSERT ON `tbc_payment_methods_types` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_payment_methods_types', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbc_payment_methods_types. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_au` AFTER UPDATE ON `tbc_payment_methods_types` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_payment_methods_types', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbc_payment_methods_types. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbc_payment_methods_types_ad` AFTER DELETE ON `tbc_payment_methods_types` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbc_payment_methods_types', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbc_payment_methods_types. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_address_components`
--

DROP TABLE IF EXISTS `tbd_address_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_address_components` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address_ID` int unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `address_sup_ID` bigint unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_address_component` (`address_ID`,`ID`),
  KEY `idx_address_parent` (`address_ID`,`address_sup_ID`),
  CONSTRAINT `fk_component_address` FOREIGN KEY (`address_ID`) REFERENCES `tb_user_addresses` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_component_parent` FOREIGN KEY (`address_ID`) REFERENCES `tb_user_addresses` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_address_components_ai` AFTER INSERT ON `tbd_address_components` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_address_components', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_address_components. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_address_components_au` AFTER UPDATE ON `tbd_address_components` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_address_components', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_address_components. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_address_components_ad` AFTER DELETE ON `tbd_address_components` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_address_components', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_address_components. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_cancellation_items`
--

DROP TABLE IF EXISTS `tbd_cancellation_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_cancellation_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `cancellation_ID` int unsigned DEFAULT NULL,
  `order_ID` int unsigned NOT NULL,
  `reason` text NOT NULL,
  `requested_by` int NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_cancellations_order` (`order_ID`),
  KEY `fk_cancellations_user` (`requested_by`),
  KEY `fk_cancellation_items_header` (`cancellation_ID`),
  CONSTRAINT `fk_cancellation_items_header` FOREIGN KEY (`cancellation_ID`) REFERENCES `tb_order_cancellations` (`ID`),
  CONSTRAINT `fk_cancellations_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `fk_cancellations_user` FOREIGN KEY (`requested_by`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_ai` AFTER INSERT ON `tbd_cancellation_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_cancellation_items', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_cancellation_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_au` AFTER UPDATE ON `tbd_cancellation_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_cancellation_items', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_cancellation_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_cancellation_items_ad` AFTER DELETE ON `tbd_cancellation_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_cancellation_items', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_cancellation_items. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_carts_items`
--

DROP TABLE IF EXISTS `tbd_carts_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_carts_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_ci_cart` (`cart_id`),
  KEY `idx_ci_product` (`product_id`),
  CONSTRAINT `fk_ci_carts` FOREIGN KEY (`cart_id`) REFERENCES `tb_carts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ci_products` FOREIGN KEY (`product_id`) REFERENCES `tb_products` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_carts_items_after_insert` AFTER INSERT ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tbd_carts_items', 'Create', USER(), CONCAT('Ítem agregado a Carrito ID=', NEW.cart_id, ', Product ID=', NEW.product_id, ', Cantidad=', NEW.quantity), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_carts_items_after_update` AFTER UPDATE ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tbd_carts_items', 'Update', USER(), CONCAT('Ítem de Carrito actualizado ID=', NEW.ID, ', Cantidad=', NEW.quantity), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Damari`@`localhost`*/ /*!50003 TRIGGER `trg_carts_items_after_delete` AFTER DELETE ON `tbd_carts_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, table_operation, db_user, operation_description, operation_date, operation_status)
    VALUES ('tbd_carts_items', 'Delete', USER(), CONCAT('Ítem removido de Carrito ID=', OLD.cart_id), NOW(), b'1');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_order_items`
--

DROP TABLE IF EXISTS `tbd_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_order_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `seller_order_ID` int unsigned NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `provider_ID` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS ((`quantity` * `unit_price`)) STORED,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `seller_order_ID` (`seller_order_ID`),
  KEY `product_ID_provider_ID` (`product_ID`,`provider_ID`),
  CONSTRAINT `tbd_order_items_ibfk_1` FOREIGN KEY (`seller_order_ID`) REFERENCES `tb_orders` (`ID`),
  CONSTRAINT `tbd_order_items_ibfk_2` FOREIGN KEY (`product_ID`, `provider_ID`) REFERENCES `tbd_products_users_providers` (`product_ID`, `user_ID`),
  CONSTRAINT `tbd_order_items_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `tbd_order_items_chk_2` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_order_items_ai` AFTER INSERT ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_order_items', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_order_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_order_items_au` AFTER UPDATE ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_order_items', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_order_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_order_items_ad` AFTER DELETE ON `tbd_order_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_order_items', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_order_items. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_products_users_providers`
--

DROP TABLE IF EXISTS `tbd_products_users_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_users_providers` (
  `user_ID` int NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `type_ownership` enum('Owner','Reseller','Distributor') DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `avalaible_date` datetime NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  UNIQUE KEY `uidx_product_user` (`product_ID`,`user_ID`),
  CONSTRAINT `fk_products2` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_ai` AFTER INSERT ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_products_users_providers', NEW.product_ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_products_users_providers. Producto=', NEW.product_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_au` AFTER UPDATE ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_products_users_providers', NEW.product_ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_products_users_providers. Producto=', NEW.product_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_products_users_providers_ad` AFTER DELETE ON `tbd_products_users_providers` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_products_users_providers', OLD.product_ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_products_users_providers. Producto=', OLD.product_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_return_items`
--

DROP TABLE IF EXISTS `tbd_return_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_return_items` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `return_ID` int unsigned DEFAULT NULL,
  `order_ID` int unsigned NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Requested','Approved','Rejected','Completed') NOT NULL DEFAULT 'Requested',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_returns_order` (`order_ID`),
  KEY `fk_return_items_header` (`return_ID`),
  CONSTRAINT `fk_return_items_header` FOREIGN KEY (`return_ID`) REFERENCES `tb_returns` (`ID`),
  CONSTRAINT `fk_returns_order` FOREIGN KEY (`order_ID`) REFERENCES `tb_orders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_return_items_ai` AFTER INSERT ON `tbd_return_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_return_items', NEW.ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_return_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_return_items_au` AFTER UPDATE ON `tbd_return_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_return_items', NEW.ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_return_items. ID=', NEW.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_return_items_ad` AFTER DELETE ON `tbd_return_items` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_return_items', OLD.ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_return_items. ID=', OLD.ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbd_user_payment_methods`
--

DROP TABLE IF EXISTS `tbd_user_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_user_payment_methods` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `payment_type_id` int unsigned NOT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `account_number_masked` varchar(50) DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_upm_user_id` (`user_id`),
  KEY `idx_upm_payment_type_id` (`payment_type_id`),
  CONSTRAINT `fk_upm_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `tbc_payment_methods_types` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_upm_user` FOREIGN KEY (`user_id`) REFERENCES `tb_users` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbd_users_wishlist_products`
--

DROP TABLE IF EXISTS `tbd_users_wishlist_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_users_wishlist_products` (
  `user_ID` int NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  KEY `fk_products3` (`product_ID`),
  CONSTRAINT `fk_products3` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user2` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_ai` AFTER INSERT ON `tbd_users_wishlist_products` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_users_wishlist_products', NEW.user_ID, 'Create', CURRENT_USER(), CONCAT('Registro creado en tbd_users_wishlist_products. user_ID=', NEW.user_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_au` AFTER UPDATE ON `tbd_users_wishlist_products` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_users_wishlist_products', NEW.user_ID, 'Update', CURRENT_USER(), CONCAT('Registro actualizado en tbd_users_wishlist_products. user_ID=', NEW.user_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_tbd_users_wishlist_products_ad` AFTER DELETE ON `tbd_users_wishlist_products` FOR EACH ROW BEGIN
    INSERT INTO tb_logs (table_name, record_id, table_operation, db_user, table_description)
    VALUES ('tbd_users_wishlist_products', OLD.user_ID, 'Delete', CURRENT_USER(), CONCAT('Registro eliminado en tbd_users_wishlist_products. user_ID=', OLD.user_ID));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_people_details`
--

DROP TABLE IF EXISTS `vw_people_details`;
/*!50001 DROP VIEW IF EXISTS `vw_people_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_people_details` AS SELECT 
 1 AS `person_ID`,
 1 AS `user_ID`,
 1 AS `courtesy_title`,
 1 AS `given_names`,
 1 AS `family_names`,
 1 AS `full_name`,
 1 AS `birth_date`,
 1 AS `gender`,
 1 AS `country_code`,
 1 AS `phone`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_buyer_orders`
--

DROP TABLE IF EXISTS `vw_trazabilidad_buyer_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_buyer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_buyer_orders` AS SELECT 
 1 AS `ID`,
 1 AS `user_id`,
 1 AS `nick`,
 1 AS `total_amount`,
 1 AS `order_status`,
 1 AS `status`,
 1 AS `creation_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_carts_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_carts_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_carts_items` AS SELECT 
 1 AS `ID`,
 1 AS `cart_id`,
 1 AS `user_id`,
 1 AS `nick`,
 1 AS `product_id`,
 1 AS `quantity`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categorias`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categorias`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categorias` AS SELECT 
 1 AS `log_id`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `category_description`,
 1 AS `superior_category_id`,
 1 AS `superior_category_name`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `operation_type`,
 1 AS `performed_by`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categorizacion_productos`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categorizacion_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorizacion_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categorizacion_productos` AS SELECT 
 1 AS `log_id`,
 1 AS `product_id`,
 1 AS `product_sku`,
 1 AS `product_name`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `operation_type`,
 1 AS `performed_by`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_ordenes`
--

DROP TABLE IF EXISTS `vw_trazabilidad_ordenes`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_ordenes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_ordenes` AS SELECT 
 1 AS `order_id`,
 1 AS `user_id`,
 1 AS `total_amount`,
 1 AS `order_status`,
 1 AS `creation_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_order_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_order_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_order_items` AS SELECT 
 1 AS `ID`,
 1 AS `seller_order_ID`,
 1 AS `product_ID`,
 1 AS `provider_ID`,
 1 AS `product_name`,
 1 AS `quantity`,
 1 AS `unit_price`,
 1 AS `subtotal`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_payment_methods_types`
--

DROP TABLE IF EXISTS `vw_trazabilidad_payment_methods_types`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_payment_methods_types` AS SELECT 
 1 AS `ID`,
 1 AS `code`,
 1 AS `description`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_productos`
--

DROP TABLE IF EXISTS `vw_trazabilidad_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_productos` AS SELECT 
 1 AS `log_id`,
 1 AS `product_id`,
 1 AS `sku`,
 1 AS `product_name`,
 1 AS `product_description`,
 1 AS `current_price`,
 1 AS `current_stock`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `operation_type`,
 1 AS `performed_by`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_productos_categorias`
--

DROP TABLE IF EXISTS `vw_trazabilidad_productos_categorias`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos_categorias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_productos_categorias` AS SELECT 
 1 AS `product_ID`,
 1 AS `product_SKU`,
 1 AS `product_name`,
 1 AS `category_ID`,
 1 AS `category_name`,
 1 AS `category_description`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_buyer_orders`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_buyer_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_buyer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_buyer_orders` AS SELECT 
 1 AS `order_id`,
 1 AS `user_id`,
 1 AS `shipping_address_id`,
 1 AS `payment_method_id`,
 1 AS `total_amount`,
 1 AS `order_status`,
 1 AS `creation_date`,
 1 AS `ultima_accion_registrada`,
 1 AS `fecha_ultima_auditoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_carts`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_carts`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_carts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_carts` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `user_ID`,
 1 AS `user_nick`,
 1 AS `user_email`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_order_cancellations`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_order_cancellations`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_order_cancellations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_order_cancellations` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `order_ID`,
 1 AS `requested_by`,
 1 AS `requested_by_nick`,
 1 AS `requested_by_email`,
 1 AS `current_cancellation_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_orders`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_orders` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `seller_ID`,
 1 AS `seller_nick`,
 1 AS `seller_email`,
 1 AS `subtotal`,
 1 AS `shipping_cost`,
 1 AS `fulfillment_status`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_payment_methods` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `payment_method_name`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_payment_transaction`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_payment_transaction`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_transaction`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_payment_transaction` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `payment_ID`,
 1 AS `order_ID`,
 1 AS `transaction_reference`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_products`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_products`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_products` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `product_SKU`,
 1 AS `product_name`,
 1 AS `current_price`,
 1 AS `current_stock`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_refunds`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_refunds`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_refunds`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_refunds` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `payment_ID`,
 1 AS `order_ID`,
 1 AS `amount`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_returns`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_returns`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_returns`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_returns` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `order_ID`,
 1 AS `requested_by`,
 1 AS `requested_by_nick`,
 1 AS `requested_by_email`,
 1 AS `current_return_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_shipments`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_shipments`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_shipments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_shipments` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `order_ID`,
 1 AS `tracking_number`,
 1 AS `carrier`,
 1 AS `shipping_status`,
 1 AS `shipped_date`,
 1 AS `delivered_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tb_users`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tb_users`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tb_users` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `email`,
 1 AS `nick`,
 1 AS `last_login`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbc_payment_methods_types`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbc_payment_methods_types`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbc_payment_methods_types`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbc_payment_methods_types` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `type_code`,
 1 AS `type_description`,
 1 AS `current_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_cancellation_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_cancellation_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cancellation_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_cancellation_items` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `cancellation_ID`,
 1 AS `order_ID`,
 1 AS `requested_by`,
 1 AS `requested_by_nick`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_cart_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_cart_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cart_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_cart_items` AS SELECT 
 1 AS `cart_item_ID`,
 1 AS `cart_ID`,
 1 AS `user_ID`,
 1 AS `user_nick`,
 1 AS `user_email`,
 1 AS `product_ID`,
 1 AS `quantity`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_return_items`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_return_items`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_return_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_return_items` AS SELECT 
 1 AS `log_ID`,
 1 AS `table_name`,
 1 AS `record_id`,
 1 AS `table_operation`,
 1 AS `db_user`,
 1 AS `table_description`,
 1 AS `operation_date`,
 1 AS `operation_status`,
 1 AS `return_ID`,
 1 AS `order_ID`,
 1 AS `current_return_item_status`,
 1 AS `creation_date`,
 1 AS `last_update`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_tbd_user_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_tbd_user_payment_methods` AS SELECT 
 1 AS `payment_method_id`,
 1 AS `payment_method_name`,
 1 AS `status`,
 1 AS `creation_date`,
 1 AS `ultima_accion_registrada`,
 1 AS `fecha_ultima_auditoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_addresses`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_addresses`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_addresses` AS SELECT 
 1 AS `address_id`,
 1 AS `user_id`,
 1 AS `direccion_completa`,
 1 AS `country`,
 1 AS `is_default`,
 1 AS `created_at`,
 1 AS `ultima_modificacion_auditada`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_user_payment_methods`
--

DROP TABLE IF EXISTS `vw_trazabilidad_user_payment_methods`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_user_payment_methods` AS SELECT 
 1 AS `ID`,
 1 AS `user_id`,
 1 AS `nick`,
 1 AS `payment_type_id`,
 1 AS `provider`,
 1 AS `account_number_masked`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_usuarios`
--

DROP TABLE IF EXISTS `vw_trazabilidad_usuarios`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_usuarios` AS SELECT 
 1 AS `ID`,
 1 AS `email`,
 1 AS `nick`,
 1 AS `creation_date`,
 1 AS `last_update`,
 1 AS `last_login`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'db_test_7b'
--

--
-- Dumping routines for database 'db_test_7b'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_register_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_new_user`(
    IN p_email          VARCHAR(100),
    IN p_nick           VARCHAR(50),
    IN p_password       VARCHAR(255),
    IN p_courtesy_title VARCHAR(20),
    IN p_given_names    VARCHAR(150),
    IN p_family_names   VARCHAR(150),
    IN p_birth_date     DATE,
    IN p_gender         VARCHAR(30),
    IN p_country_code   CHAR(2),
    IN p_phone          VARCHAR(25)
)
    MODIFIES SQL DATA
BEGIN
    DECLARE v_db_user VARCHAR(32);
    DECLARE v_audit_user VARCHAR(100);
    DECLARE v_has_role INT DEFAULT 0;
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_user_id INT DEFAULT NULL;
    DECLARE v_person_id BIGINT UNSIGNED DEFAULT NULL;

    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El correo o el nick ya se encuentran registrados en la base de datos';
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_db_user = SUBSTRING_INDEX(USER(), '@', 1);

    IF v_db_user = 'app_web' THEN
        SET v_audit_user = 'app_web@DESKTOP-DH292';
    ELSEIF v_db_user = 'app_mobile' THEN
        SET v_audit_user = 'app_mobile@Samsung-Galaxy-S24';
    ELSE
        SET v_audit_user = USER();
    END IF;

    SELECT COUNT(*)
    INTO v_has_role
    FROM mysql.role_edges re
    WHERE re.TO_USER = v_db_user
      AND re.FROM_USER IN (
          'super_admin',
          'superadmin',
          'admin',
          'support',
          'user_not_registered'
      );

    IF v_has_role = 0 AND v_db_user <> 'root' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: el usuario no tiene asignado un rol autorizado';
    END IF;

    SET p_email = LOWER(TRIM(p_email));
    SET p_nick = TRIM(p_nick);
    SET p_given_names = TRIM(p_given_names);
    SET p_family_names = NULLIF(TRIM(p_family_names), '');
    SET p_courtesy_title = NULLIF(TRIM(p_courtesy_title), '');
    SET p_gender = COALESCE(NULLIF(TRIM(p_gender), ''), 'Prefiero no decirlo');
    SET p_country_code = NULLIF(UPPER(TRIM(p_country_code)), '');
    SET p_phone = NULLIF(TRIM(p_phone), '');

    IF p_email IS NULL OR p_email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico es inválido';
    END IF;

    IF p_nick IS NULL OR CHAR_LENGTH(p_nick) < 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick debe tener al menos 3 caracteres';
    END IF;

    IF p_password IS NULL OR CHAR_LENGTH(p_password) < 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La contraseña debe tener al menos 8 caracteres';
    END IF;

    IF p_given_names IS NULL OR p_given_names = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre es obligatorio';
    END IF;

    IF p_birth_date IS NOT NULL
       AND (p_birth_date > CURRENT_DATE OR p_birth_date < '1900-01-01') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de nacimiento es inválida';
    END IF;

    IF p_gender NOT IN ('Hombre', 'Mujer', 'Prefiero no decirlo') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El género debe ser Hombre, Mujer o Prefiero no decirlo';
    END IF;

    IF p_country_code IS NOT NULL AND p_country_code NOT REGEXP '^[A-Z]{2}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El código de país debe tener exactamente 2 letras (ISO)';
    END IF;

    IF p_phone IS NOT NULL AND p_phone NOT REGEXP '^[0-9+() -]{7,25}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono es inválido';
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM tb_users
    WHERE email = p_email;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo electrónico ya se encuentra registrado';
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM tb_users
    WHERE nick = p_nick;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nick ya se encuentra en uso';
    END IF;

    START TRANSACTION;

    INSERT INTO tb_users (email, nick, password)
    VALUES (p_email, p_nick, MD5(p_password));

    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO tb_people (
        user_ID,
        courtesy_title,
        given_names,
        family_names,
        birth_date,
        gender,
        country_code,
        phone
    )
    VALUES (
        v_user_id,
        p_courtesy_title,
        p_given_names,
        p_family_names,
        p_birth_date,
        p_gender,
        p_country_code,
        p_phone
    );

    SET v_person_id = LAST_INSERT_ID();

    COMMIT;

    SELECT
        'Usuario y persona registrados correctamente' AS mensaje,
        v_user_id AS user_id,
        v_person_id AS person_id,
        p_email AS email,
        p_nick AS nick,
        v_audit_user AS ejecutado_por,
        CURRENT_TIMESTAMP AS fecha_operacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_restore_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_restore_product`(
    IN p_product_id INT UNSIGNED
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto especificado no existe';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
          AND status = b'1'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya se encuentra activo';
    END IF;

    UPDATE tb_products
    SET status = b'1'
    WHERE ID = p_product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_soft_delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_soft_delete_product`(
    IN p_product_id INT UNSIGNED
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto especificado no existe';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM tb_products
        WHERE ID = p_product_id
          AND status = b'0'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya se encuentra eliminado';
    END IF;

    UPDATE tb_products
    SET status = b'0'
    WHERE ID = p_product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_people_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_people_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_people_details` AS select `tb_people`.`person_ID` AS `person_ID`,`tb_people`.`user_ID` AS `user_ID`,`tb_people`.`courtesy_title` AS `courtesy_title`,`tb_people`.`given_names` AS `given_names`,`tb_people`.`family_names` AS `family_names`,concat(`tb_people`.`given_names`,' ',coalesce(`tb_people`.`family_names`,'')) AS `full_name`,`tb_people`.`birth_date` AS `birth_date`,`tb_people`.`gender` AS `gender`,`tb_people`.`country_code` AS `country_code`,`tb_people`.`phone` AS `phone`,coalesce(cast(`tb_people`.`status` as unsigned),0) AS `status`,`tb_people`.`creation_date` AS `creation_date`,`tb_people`.`last_update` AS `last_update` from `tb_people` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_buyer_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_buyer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_buyer_orders` AS select `o`.`ID` AS `ID`,`o`.`user_id` AS `user_id`,`u`.`nick` AS `nick`,`o`.`total_amount` AS `total_amount`,`o`.`order_status` AS `order_status`,`o`.`status` AS `status`,`o`.`creation_date` AS `creation_date` from (`tb_buyer_orders` `o` join `tb_users` `u` on((`o`.`user_id` = `u`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_carts_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_carts_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_carts_items` AS select `ci`.`ID` AS `ID`,`ci`.`cart_id` AS `cart_id`,`c`.`user_ID` AS `user_id`,`u`.`nick` AS `nick`,`ci`.`product_id` AS `product_id`,`ci`.`quantity` AS `quantity`,`ci`.`status` AS `status` from ((`tbd_carts_items` `ci` join `tb_carts` `c` on((`ci`.`cart_id` = `c`.`ID`))) join `tb_users` `u` on((`c`.`user_ID` = `u`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categorias`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categorias` AS select `l`.`ID` AS `log_id`,`l`.`record_id` AS `category_id`,`c`.`name` AS `category_name`,`c`.`description` AS `category_description`,`c`.`sup_id_category` AS `superior_category_id`,`sc`.`name` AS `superior_category_name`,`c`.`status` AS `current_status`,`c`.`creation_date` AS `creation_date`,`c`.`last_update` AS `last_update`,`l`.`table_operation` AS `operation_type`,`l`.`db_user` AS `performed_by`,`l`.`table_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from ((`tb_logs` `l` left join `tbc_categories` `c` on((`c`.`ID` = `l`.`record_id`))) left join `tbc_categories` `sc` on((`sc`.`ID` = `c`.`sup_id_category`))) where (`l`.`table_name` = 'tbc_categories') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categorizacion_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorizacion_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categorizacion_productos` AS select `l`.`ID` AS `log_id`,`l`.`record_id` AS `product_id`,`p`.`SKU` AS `product_sku`,`p`.`name` AS `product_name`,(case when (locate('Category ID: ',`l`.`table_description`) > 0) then cast(substring_index(substring_index(`l`.`table_description`,'Category ID: ',-(1)),';',1) as unsigned) else NULL end) AS `category_id`,`c`.`name` AS `category_name`,`l`.`table_operation` AS `operation_type`,`l`.`db_user` AS `performed_by`,`l`.`table_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from ((`tb_logs` `l` left join `tb_products` `p` on((`p`.`ID` = `l`.`record_id`))) left join `tbc_categories` `c` on((`c`.`ID` = (case when (locate('Category ID: ',`l`.`table_description`) > 0) then cast(substring_index(substring_index(`l`.`table_description`,'Category ID: ',-(1)),';',1) as unsigned) else NULL end)))) where (`l`.`table_name` = 'tb_product_categories') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_ordenes`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_ordenes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `vw_trazabilidad_ordenes` AS select `bo`.`ID` AS `order_id`,`bo`.`user_id` AS `user_id`,`bo`.`total_amount` AS `total_amount`,`bo`.`order_status` AS `order_status`,`bo`.`creation_date` AS `creation_date` from `tb_buyer_orders` `bo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_order_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_order_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_order_items` AS select `oi`.`ID` AS `ID`,`oi`.`seller_order_ID` AS `seller_order_ID`,`oi`.`product_ID` AS `product_ID`,`oi`.`provider_ID` AS `provider_ID`,`oi`.`product_name` AS `product_name`,`oi`.`quantity` AS `quantity`,`oi`.`unit_price` AS `unit_price`,`oi`.`subtotal` AS `subtotal`,`oi`.`creation_date` AS `creation_date`,`oi`.`last_update` AS `last_update` from `tbd_order_items` `oi` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_payment_methods_types`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_payment_methods_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_payment_methods_types` AS select `pmt`.`ID` AS `ID`,`pmt`.`code` AS `code`,`pmt`.`description` AS `description`,`pmt`.`status` AS `status`,`pmt`.`creation_date` AS `creation_date`,`pmt`.`last_update` AS `last_update` from `tbc_payment_methods_types` `pmt` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Damari`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_productos` AS select `l`.`ID` AS `log_id`,`l`.`record_id` AS `product_id`,`p`.`SKU` AS `sku`,`p`.`name` AS `product_name`,`p`.`description` AS `product_description`,`p`.`current_price` AS `current_price`,`p`.`current_stock` AS `current_stock`,`p`.`status` AS `current_status`,`p`.`creation_date` AS `creation_date`,`p`.`last_update` AS `last_update`,`l`.`table_operation` AS `operation_type`,`l`.`db_user` AS `performed_by`,`l`.`table_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from (`tb_logs` `l` left join `tb_products` `p` on((`p`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tb_products') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_productos_categorias`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos_categorias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_productos_categorias` AS select `pc`.`product_Id` AS `product_ID`,`p`.`SKU` AS `product_SKU`,`p`.`name` AS `product_name`,`pc`.`category_Id` AS `category_ID`,`c`.`name` AS `category_name`,`c`.`description` AS `category_description`,`pc`.`status` AS `status`,`pc`.`creation_date` AS `creation_date`,`pc`.`last_update` AS `last_update` from ((`tb_product_categories` `pc` join `tb_products` `p` on((`pc`.`product_Id` = `p`.`ID`))) join `tbc_categories` `c` on((`pc`.`category_Id` = `c`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_buyer_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_buyer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_buyer_orders` AS select `b`.`ID` AS `order_id`,`b`.`user_id` AS `user_id`,`b`.`shipping_address_id` AS `shipping_address_id`,`b`.`payment_method_id` AS `payment_method_id`,`b`.`total_amount` AS `total_amount`,`b`.`order_status` AS `order_status`,`b`.`creation_date` AS `creation_date`,(select max(`l`.`table_operation`) from `tb_logs` `l` where ((`l`.`table_name` = 'tb_buyer_orders') and (`l`.`record_id` = `b`.`ID`))) AS `ultima_accion_registrada`,(select max(`l`.`operation_date`) from `tb_logs` `l` where ((`l`.`table_name` = 'tb_buyer_orders') and (`l`.`record_id` = `b`.`ID`))) AS `fecha_ultima_auditoria` from `tb_buyer_orders` `b` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_carts`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_carts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_carts` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`user_ID` AS `user_ID`,`u`.`nick` AS `user_nick`,`u`.`email` AS `user_email`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_carts` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_users` `u` on((`u`.`ID` = `t`.`user_ID`))) where (`l`.`table_name` = 'tb_carts') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_order_cancellations`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_order_cancellations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_order_cancellations` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`order_ID` AS `order_ID`,`t`.`requested_by` AS `requested_by`,`u`.`nick` AS `requested_by_nick`,`u`.`email` AS `requested_by_email`,`t`.`status` AS `current_cancellation_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_order_cancellations` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_users` `u` on((`u`.`ID` = `t`.`requested_by`))) where (`l`.`table_name` = 'tb_order_cancellations') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_orders` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`seller_ID` AS `seller_ID`,`u`.`nick` AS `seller_nick`,`u`.`email` AS `seller_email`,`t`.`subtotal` AS `subtotal`,`t`.`shipping_cost` AS `shipping_cost`,`t`.`fulfillment_status` AS `fulfillment_status`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_orders` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_users` `u` on((`u`.`ID` = `t`.`seller_ID`))) where (`l`.`table_name` = 'tb_orders') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_payment_methods` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`name` AS `payment_method_name`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tb_payment_methods` `t` on((`t`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tb_payment_methods') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_payment_transaction`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_payment_transaction`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_payment_transaction` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`payment_ID` AS `payment_ID`,`p`.`order_ID` AS `order_ID`,`t`.`transaction_reference` AS `transaction_reference`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_payment_transaction` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_payments` `p` on((`p`.`ID` = `t`.`payment_ID`))) where (`l`.`table_name` = 'tb_payment_transaction') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_products`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_products` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`p`.`SKU` AS `product_SKU`,`p`.`name` AS `product_name`,`p`.`current_price` AS `current_price`,`p`.`current_stock` AS `current_stock`,cast(`p`.`status` as unsigned) AS `current_status`,`p`.`creation_date` AS `creation_date`,`p`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tb_products` `p` on((`p`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tb_products') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_refunds`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_refunds`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_refunds` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`payment_ID` AS `payment_ID`,`p`.`order_ID` AS `order_ID`,`t`.`amount` AS `amount`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_refunds` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_payments` `p` on((`p`.`ID` = `t`.`payment_ID`))) where (`l`.`table_name` = 'tb_refunds') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_returns`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_returns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_returns` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`order_ID` AS `order_ID`,`t`.`requested_by` AS `requested_by`,`u`.`nick` AS `requested_by_nick`,`u`.`email` AS `requested_by_email`,`t`.`status` AS `current_return_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tb_returns` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_users` `u` on((`u`.`ID` = `t`.`requested_by`))) where (`l`.`table_name` = 'tb_returns') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_shipments`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_shipments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_shipments` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`order_ID` AS `order_ID`,`t`.`tracking_number` AS `tracking_number`,`t`.`carrier` AS `carrier`,`t`.`shipping_status` AS `shipping_status`,`t`.`shipped_date` AS `shipped_date`,`t`.`delivered_date` AS `delivered_date`,`t`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tb_shipments` `t` on((`t`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tb_shipments') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tb_users`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tb_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tb_users` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`email` AS `email`,`t`.`nick` AS `nick`,`t`.`last_login` AS `last_login`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tb_users` `t` on((`t`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tb_users') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbc_payment_methods_types`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbc_payment_methods_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbc_payment_methods_types` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`code` AS `type_code`,`t`.`description` AS `type_description`,cast(`t`.`status` as unsigned) AS `current_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tbc_payment_methods_types` `t` on((`t`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tbc_payment_methods_types') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_cancellation_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cancellation_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_cancellation_items` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`cancellation_ID` AS `cancellation_ID`,`t`.`order_ID` AS `order_ID`,`t`.`requested_by` AS `requested_by`,`u`.`nick` AS `requested_by_nick`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from ((`tb_logs` `l` left join `tbd_cancellation_items` `t` on((`t`.`ID` = `l`.`record_id`))) left join `tb_users` `u` on((`u`.`ID` = `t`.`requested_by`))) where (`l`.`table_name` = 'tbd_cancellation_items') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_cart_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_cart_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_cart_items` AS select `ci`.`ID` AS `cart_item_ID`,`ci`.`cart_id` AS `cart_ID`,`c`.`user_ID` AS `user_ID`,`u`.`nick` AS `user_nick`,`u`.`email` AS `user_email`,`ci`.`product_id` AS `product_ID`,`ci`.`quantity` AS `quantity`,`ci`.`status` AS `status`,`ci`.`creation_date` AS `creation_date`,`ci`.`last_update` AS `last_update` from ((`tbd_carts_items` `ci` join `tb_carts` `c` on((`ci`.`cart_id` = `c`.`ID`))) join `tb_users` `u` on((`c`.`user_ID` = `u`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_return_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_return_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_return_items` AS select `l`.`ID` AS `log_ID`,`l`.`table_name` AS `table_name`,`l`.`record_id` AS `record_id`,`l`.`table_operation` AS `table_operation`,`l`.`db_user` AS `db_user`,`l`.`table_description` AS `table_description`,`l`.`operation_date` AS `operation_date`,cast(`l`.`operation_status` as unsigned) AS `operation_status`,`t`.`return_ID` AS `return_ID`,`t`.`order_ID` AS `order_ID`,`t`.`status` AS `current_return_item_status`,`t`.`creation_date` AS `creation_date`,`t`.`last_update` AS `last_update` from (`tb_logs` `l` left join `tbd_return_items` `t` on((`t`.`ID` = `l`.`record_id`))) where (`l`.`table_name` = 'tbd_return_items') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_tbd_user_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_tbd_user_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_tbd_user_payment_methods` AS select `p`.`ID` AS `payment_method_id`,`p`.`name` AS `payment_method_name`,`p`.`status` AS `status`,`p`.`creation_date` AS `creation_date`,(select max(`l`.`table_operation`) from `tb_logs` `l` where ((`l`.`table_name` = 'tb_payment_methods') and (`l`.`record_id` = `p`.`ID`))) AS `ultima_accion_registrada`,(select max(`l`.`operation_date`) from `tb_logs` `l` where ((`l`.`table_name` = 'tb_payment_methods') and (`l`.`record_id` = `p`.`ID`))) AS `fecha_ultima_auditoria` from `tb_payment_methods` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_addresses`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_addresses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_user_addresses` AS select `a`.`ID` AS `address_id`,`a`.`user_id` AS `user_id`,concat(`a`.`street`,', ',`a`.`city`,', ',`a`.`state`,' (',`a`.`postal_code`,')') AS `direccion_completa`,`a`.`country` AS `country`,`a`.`is_default` AS `is_default`,`a`.`created_at` AS `created_at`,(select max(`l`.`operation_date`) from `tb_logs` `l` where ((`l`.`table_name` = 'tb_user_addresses') and (`l`.`record_id` = `a`.`ID`))) AS `ultima_modificacion_auditada` from `tb_user_addresses` `a` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_user_payment_methods`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_user_payment_methods`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `vw_trazabilidad_user_payment_methods` AS select `upm`.`ID` AS `ID`,`upm`.`user_id` AS `user_id`,`u`.`nick` AS `nick`,`upm`.`payment_type_id` AS `payment_type_id`,`upm`.`provider` AS `provider`,`upm`.`account_number_masked` AS `account_number_masked`,`upm`.`status` AS `status` from (`tbd_user_payment_methods` `upm` join `tb_users` `u` on((`upm`.`user_id` = `u`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_usuarios`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `vw_trazabilidad_usuarios` AS select `u`.`ID` AS `ID`,`u`.`email` AS `email`,`u`.`nick` AS `nick`,`u`.`creation_date` AS `creation_date`,`u`.`last_update` AS `last_update`,`u`.`last_login` AS `last_login`,`u`.`status` AS `status` from `tb_users` `u` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08 23:33:46
