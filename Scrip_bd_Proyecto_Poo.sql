CREATE DATABASE  IF NOT EXISTS `marketplace_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marketplace_db`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace_db
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `street` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_addresses_user` (`user_id`),
  CONSTRAINT `fk_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,2,'calle 41 7b-21','ibague','tolima','770477',1),(2,3,'calle 41 7b-21','ibague','tolima','770477',1);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cart_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cart_product` (`cart_id`,`product_id`),
  KEY `fk_cartitems_product` (`product_id`),
  CONSTRAINT `fk_cartitems_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cartitems_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_carts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,2,'2026-10-01 02:40:24'),(2,3,'2026-10-02 03:45:23'),(3,4,'2026-10-19 02:23:34'),(4,5,'2026-10-19 02:35:56'),(5,12,'2026-10-29 23:28:19'),(6,9,'2026-10-29 23:28:19'),(7,7,'2026-10-29 23:28:19'),(8,11,'2026-10-29 23:28:19'),(9,8,'2026-10-29 23:28:19'),(10,10,'2026-10-29 23:28:19'),(11,6,'2026-10-29 23:28:19'),(12,13,'2026-10-29 23:28:19');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (7,'Belleza'),(4,'Deportes'),(2,'Hogar'),(5,'Juguetes'),(6,'Libros'),(3,'Moda'),(8,'Otros'),(1,'Tecnología');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderitems_order` (`order_id`),
  KEY `fk_orderitems_product` (`product_id`),
  CONSTRAINT `fk_orderitems_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orderitems_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,1,8000000.00),(2,1,2,1,300000.00),(3,1,3,5,200000.00),(4,2,3,1,200000.00),(5,3,3,1,200000.00),(6,4,1,1,8000000.00),(7,4,3,1,200000.00),(8,5,3,1,200000.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (5,'CANCELLED'),(4,'DELIVERED'),(2,'PAID'),(1,'PENDING'),(3,'SHIPPED');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `buyer_id` bigint NOT NULL,
  `address_id` bigint NOT NULL,
  `status_id` bigint NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_orders_buyer` (`buyer_id`),
  KEY `fk_orders_address` (`address_id`),
  KEY `fk_orders_status` (`status_id`),
  CONSTRAINT `fk_orders_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `fk_orders_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_orders_status` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,1,2,9300000.00,'2026-10-02 01:49:42'),(2,2,1,2,200000.00,'2026-10-02 02:53:08'),(3,2,1,2,200000.00,'2026-10-02 03:23:15'),(4,3,2,2,8200000.00,'2026-10-04 20:44:55'),(5,3,2,2,200000.00,'2026-10-04 21:45:10');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (4,'Contra entrega'),(3,'PSE'),(1,'Tarjeta de crédito'),(2,'Tarjeta débito');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `payment_method_id` bigint NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'APPROVED',
  `paid_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `fk_payments_method` (`payment_method_id`),
  CONSTRAINT `fk_payments_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,4,9300000.00,'APPROVED','2026-10-02 01:49:42'),(2,2,4,200000.00,'APPROVED','2026-10-02 02:53:08'),(3,3,4,200000.00,'APPROVED','2026-10-02 03:23:15'),(4,4,1,8200000.00,'APPROVED','2026-10-04 20:44:55'),(5,5,4,200000.00,'APPROVED','2026-10-04 21:45:10');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_images_product` (`product_id`),
  CONSTRAINT `fk_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,1,'/uploads/de9626cf-6f1e-4e6b-99ae-adde3a59f525.webp'),(2,2,'/uploads/5dfc4899-cb17-4aca-898c-8ec48585bb8c.webp'),(3,3,'/uploads/c70e7cb4-4a4a-4b7a-9170-42ca2aa33b47.webp'),(4,4,'/uploads/864ff7e9-6b89-4eeb-9a89-61d77b6c4281.webp'),(5,5,'/uploads/7b4815bd-dbf8-4384-bd3a-2fa144638113.webp'),(6,6,'/uploads/seed-tec-01.webp'),(7,7,'/uploads/seed-tec-02.webp'),(8,8,'/uploads/seed-tec-03.webp'),(9,9,'/uploads/seed-tec-04.webp'),(10,10,'/uploads/seed-tec-05.webp'),(11,11,'/uploads/seed-tec-06.webp'),(13,13,'/uploads/seed-tec-08.webp'),(14,14,'/uploads/seed-tec-09.webp'),(15,15,'/uploads/seed-tec-10.webp'),(16,16,'/uploads/seed-tec-11.webp'),(17,17,'/uploads/seed-tec-12.webp'),(18,18,'/uploads/seed-tec-13.webp'),(20,20,'/uploads/seed-tec-15.webp'),(21,21,'/uploads/seed-tec-16.webp'),(24,24,'/uploads/seed-tec-19.webp'),(25,25,'/uploads/seed-tec-20.webp'),(26,26,'/uploads/seed-tec-21.webp'),(27,27,'/uploads/seed-tec-22.webp'),(28,28,'/uploads/seed-tec-23.webp'),(29,29,'/uploads/seed-tec-24.webp'),(30,30,'/uploads/seed-tec-25.webp'),(31,31,'/uploads/seed-tec-26.webp'),(32,32,'/uploads/seed-tec-27.webp'),(33,33,'/uploads/seed-tec-28.webp'),(34,34,'/uploads/seed-tec-29.webp'),(37,37,'/uploads/seed-hog-02.webp'),(38,38,'/uploads/seed-hog-03.webp'),(40,40,'/uploads/seed-hog-05.webp'),(42,42,'/uploads/seed-hog-07.webp'),(43,43,'/uploads/seed-hog-08.webp'),(44,44,'/uploads/seed-hog-09.webp'),(45,45,'/uploads/seed-hog-10.webp'),(46,46,'/uploads/seed-hog-11.webp'),(47,47,'/uploads/seed-hog-12.webp'),(48,48,'/uploads/seed-hog-13.webp'),(49,49,'/uploads/seed-hog-14.webp'),(50,50,'/uploads/seed-hog-15.webp'),(52,52,'/uploads/seed-hog-17.webp'),(53,53,'/uploads/seed-hog-18.webp'),(54,54,'/uploads/seed-hog-19.webp'),(55,55,'/uploads/seed-hog-20.webp'),(56,56,'/uploads/seed-hog-21.webp'),(57,57,'/uploads/seed-hog-22.webp'),(58,58,'/uploads/seed-hog-23.webp'),(59,59,'/uploads/seed-hog-24.webp'),(60,60,'/uploads/seed-hog-25.webp'),(62,62,'/uploads/seed-hog-27.webp'),(63,63,'/uploads/seed-hog-28.webp'),(64,64,'/uploads/seed-hog-29.webp'),(65,65,'/uploads/seed-hog-30.webp'),(66,66,'/uploads/seed-mod-01.webp'),(67,67,'/uploads/seed-mod-02.webp'),(68,68,'/uploads/seed-mod-03.webp'),(69,69,'/uploads/seed-mod-04.webp'),(71,71,'/uploads/seed-mod-06.webp'),(72,72,'/uploads/seed-mod-07.webp'),(73,73,'/uploads/seed-mod-08.webp'),(74,74,'/uploads/seed-mod-09.webp'),(75,75,'/uploads/seed-mod-10.webp'),(76,76,'/uploads/seed-mod-11.webp'),(77,77,'/uploads/seed-mod-12.webp'),(81,81,'/uploads/seed-mod-16.webp'),(82,82,'/uploads/seed-mod-17.webp'),(83,83,'/uploads/seed-mod-18.webp'),(84,84,'/uploads/seed-mod-19.webp'),(87,87,'/uploads/seed-mod-22.webp'),(88,88,'/uploads/seed-mod-23.webp'),(89,89,'/uploads/seed-mod-24.webp'),(90,90,'/uploads/seed-mod-25.webp'),(91,91,'/uploads/seed-mod-26.webp'),(92,92,'/uploads/seed-mod-27.webp'),(93,93,'/uploads/seed-mod-28.webp'),(94,94,'/uploads/seed-mod-29.webp'),(95,95,'/uploads/seed-mod-30.webp'),(97,97,'/uploads/seed-dep-02.webp'),(98,98,'/uploads/seed-dep-03.webp'),(99,99,'/uploads/seed-dep-04.webp'),(100,100,'/uploads/seed-dep-05.webp'),(101,101,'/uploads/seed-dep-06.webp'),(102,102,'/uploads/seed-dep-07.webp'),(103,103,'/uploads/seed-dep-08.webp'),(104,104,'/uploads/seed-dep-09.webp'),(105,105,'/uploads/seed-dep-10.webp'),(106,106,'/uploads/seed-dep-11.webp'),(107,107,'/uploads/seed-dep-12.webp'),(108,108,'/uploads/seed-dep-13.webp'),(110,110,'/uploads/seed-dep-15.webp'),(112,112,'/uploads/seed-dep-17.webp'),(113,113,'/uploads/seed-dep-18.webp'),(115,115,'/uploads/seed-dep-20.webp'),(116,116,'/uploads/seed-dep-21.webp'),(117,117,'/uploads/seed-dep-22.webp'),(118,118,'/uploads/seed-dep-23.webp'),(119,119,'/uploads/seed-dep-24.webp'),(120,120,'/uploads/seed-dep-25.webp'),(121,121,'/uploads/seed-dep-26.webp'),(123,123,'/uploads/seed-dep-28.webp'),(124,124,'/uploads/seed-dep-29.webp'),(125,125,'/uploads/seed-dep-30.webp'),(126,126,'/uploads/seed-jug-01.webp'),(127,127,'/uploads/seed-jug-02.webp'),(128,128,'/uploads/seed-jug-03.webp'),(131,131,'/uploads/seed-jug-06.webp'),(132,132,'/uploads/seed-jug-07.webp'),(134,134,'/uploads/seed-jug-09.webp'),(135,135,'/uploads/seed-jug-10.webp'),(136,136,'/uploads/seed-jug-11.webp'),(137,137,'/uploads/seed-jug-12.webp'),(138,138,'/uploads/seed-jug-13.webp'),(139,139,'/uploads/seed-jug-14.webp'),(140,140,'/uploads/seed-jug-15.webp'),(141,141,'/uploads/seed-jug-16.webp'),(142,142,'/uploads/seed-jug-17.webp'),(144,144,'/uploads/seed-jug-19.webp'),(145,145,'/uploads/seed-jug-20.webp'),(146,146,'/uploads/seed-jug-21.webp'),(147,147,'/uploads/seed-jug-22.webp'),(148,148,'/uploads/seed-jug-23.webp'),(149,149,'/uploads/seed-jug-24.webp'),(150,150,'/uploads/seed-jug-25.webp'),(151,151,'/uploads/seed-jug-26.webp'),(153,153,'/uploads/seed-jug-28.webp'),(154,154,'/uploads/seed-jug-29.webp'),(155,155,'/uploads/seed-jug-30.webp'),(156,156,'/uploads/seed-lib-01.webp'),(158,158,'/uploads/seed-lib-03.webp'),(159,159,'/uploads/seed-lib-04.webp'),(160,160,'/uploads/seed-lib-05.webp'),(161,161,'/uploads/seed-lib-06.webp'),(165,165,'/uploads/seed-lib-10.webp'),(166,166,'/uploads/seed-lib-11.webp'),(167,167,'/uploads/seed-lib-12.webp'),(168,168,'/uploads/seed-lib-13.webp'),(169,169,'/uploads/seed-lib-14.webp'),(170,170,'/uploads/seed-lib-15.webp'),(171,171,'/uploads/seed-lib-16.webp'),(172,172,'/uploads/seed-lib-17.webp'),(173,173,'/uploads/seed-lib-18.webp'),(174,174,'/uploads/seed-lib-19.webp'),(175,175,'/uploads/seed-lib-20.webp'),(176,176,'/uploads/seed-lib-21.webp'),(177,177,'/uploads/seed-lib-22.webp'),(178,178,'/uploads/seed-lib-23.webp'),(179,179,'/uploads/seed-lib-24.webp'),(180,180,'/uploads/seed-lib-25.webp'),(181,181,'/uploads/seed-lib-26.webp'),(183,183,'/uploads/seed-lib-28.webp'),(184,184,'/uploads/seed-lib-29.webp'),(185,185,'/uploads/seed-lib-30.webp'),(186,186,'/uploads/seed-bel-01.webp'),(187,187,'/uploads/seed-bel-02.webp'),(188,188,'/uploads/seed-bel-03.webp'),(189,189,'/uploads/seed-bel-04.webp'),(191,191,'/uploads/seed-bel-06.webp'),(193,193,'/uploads/seed-bel-08.webp'),(194,194,'/uploads/seed-bel-09.webp'),(195,195,'/uploads/seed-bel-10.webp'),(196,196,'/uploads/seed-bel-11.webp'),(198,198,'/uploads/seed-bel-13.webp'),(199,199,'/uploads/seed-bel-14.webp'),(200,200,'/uploads/seed-bel-15.webp'),(201,201,'/uploads/seed-bel-16.webp'),(202,202,'/uploads/seed-bel-17.webp'),(203,203,'/uploads/seed-bel-18.webp'),(204,204,'/uploads/seed-bel-19.webp'),(205,205,'/uploads/seed-bel-20.webp'),(208,208,'/uploads/seed-bel-23.webp'),(209,209,'/uploads/seed-bel-24.webp'),(210,210,'/uploads/seed-bel-25.webp'),(212,212,'/uploads/seed-bel-27.webp'),(213,213,'/uploads/seed-bel-28.webp'),(214,214,'/uploads/seed-bel-29.webp'),(216,216,'/uploads/seed-otr-01.webp'),(217,217,'/uploads/seed-otr-02.webp'),(218,218,'/uploads/seed-otr-03.webp'),(220,220,'/uploads/seed-otr-05.webp'),(221,221,'/uploads/seed-otr-06.webp'),(223,223,'/uploads/seed-otr-08.webp'),(224,224,'/uploads/seed-otr-09.webp'),(225,225,'/uploads/seed-otr-10.webp'),(227,227,'/uploads/seed-otr-12.webp'),(228,228,'/uploads/seed-otr-13.webp'),(229,229,'/uploads/seed-otr-14.webp'),(230,230,'/uploads/seed-otr-15.webp'),(231,231,'/uploads/seed-otr-16.webp'),(232,232,'/uploads/seed-otr-17.webp'),(233,233,'/uploads/seed-otr-18.webp'),(235,235,'/uploads/seed-otr-20.webp'),(236,236,'/uploads/seed-otr-21.webp'),(237,237,'/uploads/seed-otr-22.webp'),(239,239,'/uploads/seed-otr-24.webp'),(240,240,'/uploads/seed-otr-25.webp'),(241,241,'/uploads/seed-otr-26.webp'),(242,242,'/uploads/seed-otr-27.webp'),(243,243,'/uploads/seed-otr-28.webp'),(244,244,'/uploads/seed-otr-29.webp'),(245,245,'/uploads/seed-otr-30.webp'),(246,211,'/uploads/a5d3a40b-4407-4795-8ef3-fcc7b449e6c3.webp'),(247,192,'/uploads/d22ce0ef-ebd8-439d-a0ba-464561b98e4d.webp'),(248,207,'/uploads/8c394c20-39b2-4ed1-86a1-c38f01497a0f.webp'),(249,215,'/uploads/2a1d144f-3b68-427c-bf75-23267e1739d0.webp'),(250,197,'/uploads/bf20cf01-f5b2-42b8-9483-17ebd8583d52.webp'),(251,190,'/uploads/58ac5b37-52f6-44fa-8ce1-4dc735dcc3b6.jpg'),(252,206,'/uploads/518e05be-f86c-42c4-b693-7d9af1c8e794.webp'),(253,114,'/uploads/7af49414-bb81-414a-81ca-2c79b9724d86.webp'),(254,111,'/uploads/6d72c483-0f70-4c42-b80e-bef68ee870ca.webp'),(255,96,'/uploads/a3d863f8-5792-440a-861d-7d7b5710a5b9.jpg'),(256,109,'/uploads/d7e00340-3d21-4fe2-9eff-70d1ff601606.webp'),(257,122,'/uploads/1297bdad-3cc0-4557-a59b-4e9897d59365.webp'),(258,39,'/uploads/df2e2428-d47d-49ff-b622-1e57f2dad15a.webp'),(259,61,'/uploads/6309d8e3-f303-442d-857a-5a3570e8a911.jpg'),(260,36,'/uploads/0a8c59e6-f837-4228-968e-2f7b120fea36.png'),(261,51,'/uploads/9deef9a0-a950-49f7-95d5-db0986546bf9.webp'),(262,41,'/uploads/bcf4c5f4-c052-4a4f-b259-662b0558699e.png'),(263,143,'/uploads/5e68ce55-0b51-46b9-93f8-6e72d07c5106.webp'),(264,133,'/uploads/8e08af95-7394-47ee-9a13-4ab063ea7dc9.png'),(265,130,'/uploads/8c2794cf-d1b7-4942-86ec-280f86f59045.jpg'),(266,152,'/uploads/ac4ecb4a-f96c-4efb-bf4c-1a6cf38daa8f.png'),(267,129,'/uploads/c1cdffff-7cee-429d-aa8d-d84db76be560.jpg'),(268,163,'/uploads/776ca14b-bfb3-4a18-91c1-835a416231c6.jpg'),(269,157,'/uploads/55893b43-500b-4588-ae8a-842637e11179.png'),(270,182,'/uploads/9eb715cb-212b-4d4e-9002-74d4a6dbfddd.png'),(271,164,'/uploads/205836ba-5389-4608-80f3-1a04c42ee696.webp'),(272,162,'/uploads/f2f0fe41-af7f-430e-b710-114faa2e76c1.png'),(273,80,'/uploads/71d4bfae-1fca-45b0-974b-bdf532569e25.png'),(274,70,'/uploads/6594a12b-f7fa-4579-9bcf-880d65141f11.webp'),(275,86,'/uploads/bc6d21e1-9966-46bb-94ee-2024e1cdb844.jpg'),(276,79,'/uploads/980086bd-b83e-4b1e-8893-f4926928e146.png'),(277,78,'/uploads/62f981bf-070b-4bf9-bb7a-7ba24cc05cb1.png'),(278,85,'/uploads/615098a6-43d2-463e-9306-c888efc4cc07.webp'),(279,234,'/uploads/cb3b00ad-621d-40b5-b3ec-b1682f74c279.webp'),(280,238,'/uploads/972b1c67-5453-4daa-95fe-015803a52bd3.jpg'),(281,219,'/uploads/7f0b9114-b3a1-46d6-8bb5-bc846dfc3013.jpg'),(282,222,'/uploads/392171ba-6377-4aeb-8e83-685aa5645d87.webp'),(283,226,'/uploads/95a476e4-28f6-4737-8303-ae35a7e6c129.png'),(284,19,'/uploads/c7deb25c-79c8-4e09-b0dc-25ecef097aac.jpg'),(285,23,'/uploads/033ff53d-c390-4815-ac3e-12188769b6e0.png'),(286,22,'/uploads/79e62649-e114-40d0-b06d-738a5282278a.webp'),(287,35,'/uploads/8a7504ba-c2b8-4522-bcc2-a3bd22a39532.webp'),(288,12,'/uploads/a31c8439-1979-46e6-a957-8b62c7d416ba.jpg');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `store_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(12,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_products_store` (`store_id`),
  KEY `fk_products_category` (`category_id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_products_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,1,'iphone 18 pro max','lo mas nuevo',8000000.00,8,1,'2026-10-01 03:14:38'),(2,1,5,'carro a control remoto','un juguete divertido',300000.00,9,1,'2026-10-01 03:25:48'),(3,1,4,'balon de futbol','balon',200000.00,6,1,'2026-10-01 03:26:55'),(4,1,2,'condones  usados','usalos si non te quieres encartar',60000.00,10,0,'2026-10-04 13:31:50'),(5,2,1,'audifonos','los mejores audifonos',150000.00,10,1,'2026-10-19 02:19:20'),(6,5,1,'Audífonos inalámbricos Bluetooth con cancelación de ruido','Hasta 30 horas de batería, micrófono integrado y estuche de carga. Sonido envolvente para música y llamadas.',189900.00,13,0,'2026-09-30 20:33:19'),(7,5,1,'Smartphone 128 GB pantalla AMOLED 6.5 pulgadas','Cámara triple de 50 MP, batería de 5000 mAh y carga rápida. Incluye cargador y funda protectora.',1299000.00,38,0,'2026-08-04 08:14:19'),(8,5,1,'Laptop 15.6 pulgadas Core i5 16 GB RAM 512 GB SSD','Ideal para estudio y trabajo. Pantalla Full HD, teclado retroiluminado y Windows 11 instalado.',2799000.00,38,0,'2026-09-01 00:39:19'),(9,5,1,'Tablet 10 pulgadas 64 GB con funda','Pantalla de alta resolución, cámara frontal y trasera. Perfecta para clases virtuales y entretenimiento.',649000.00,12,0,'2026-08-10 11:05:19'),(10,5,1,'Smartwatch deportivo resistente al agua','Monitor de ritmo cardíaco, contador de pasos, notificaciones y más de 20 modos deportivos.',159900.00,20,0,'2026-08-09 11:44:19'),(11,5,1,'Teclado mecánico retroiluminado RGB','Switches mecánicos de respuesta rápida, iluminación RGB personalizable y diseño antiderrame.',139900.00,44,0,'2026-09-03 08:49:19'),(12,5,1,'Mouse inalámbrico ergonómico recargable','Sensor de alta precisión, clics silenciosos y batería recargable de larga duración.',54900.00,41,1,'2026-09-21 15:38:19'),(13,5,1,'Monitor 24 pulgadas Full HD 75 Hz','Panel IPS con colores vivos, bordes delgados y conexiones HDMI y VGA.',499900.00,56,0,'2026-09-07 19:41:19'),(14,5,1,'Disco duro externo 1 TB USB 3.0','Respalda tus fotos, videos y documentos. Compacto, rápido y compatible con Windows y Mac.',229900.00,41,0,'2026-08-14 06:13:19'),(15,5,1,'Memoria USB 64 GB alta velocidad','Almacenamiento portátil con carcasa metálica resistente y transferencia ágil de archivos.',29900.00,52,0,'2026-08-20 06:02:19'),(16,5,1,'Cámara de seguridad WiFi 1080p','Visión nocturna, detección de movimiento y alertas en el celular. Instalación sencilla.',119900.00,55,0,'2026-09-15 06:05:19'),(17,5,1,'Parlante Bluetooth portátil resistente al agua','Sonido potente con graves profundos y hasta 12 horas de reproducción continua.',129900.00,54,0,'2026-08-20 13:40:19'),(18,5,1,'Power bank 20.000 mAh carga rápida','Carga tu celular hasta 4 veces. Dos puertos USB y un puerto USB-C.',99900.00,43,0,'2026-09-19 18:53:19'),(19,5,1,'Consola de videojuegos portátil retro','Más de 500 juegos clásicos incluidos, pantalla de 3 pulgadas y batería recargable.',189900.00,21,1,'2026-10-29 16:56:19'),(20,5,1,'Control inalámbrico para videojuegos','Diseño ergonómico con vibración, compatible con computador y consolas.',109900.00,45,0,'2026-10-22 14:08:19'),(21,5,1,'Router WiFi doble banda 1200 Mbps','Cobertura amplia para toda la casa, cuatro antenas y configuración desde el celular.',149900.00,13,0,'2026-10-03 18:59:19'),(22,5,1,'Cargador rápido USB-C 65 W','Carga laptops, tablets y celulares con un solo cargador compacto y seguro.',79900.00,58,1,'2026-10-21 00:17:20'),(23,5,1,'Cámara web Full HD con micrófono','Ideal para reuniones y clases virtuales. Enfoque automático y cubierta de privacidad.',89900.00,34,1,'2026-10-28 21:23:20'),(24,5,1,'Audífonos de diadema gamer con micrófono','Sonido envolvente, almohadillas suaves y micrófono flexible con cancelación de ruido.',119900.00,58,0,'2026-08-09 20:08:20'),(25,5,1,'Impresora multifuncional con tanque de tinta','Imprime, copia y escanea con bajo costo por página. Conexión WiFi incluida.',799900.00,49,0,'2026-09-15 07:26:20'),(26,5,1,'Soporte para laptop ajustable de aluminio','Mejora tu postura y la ventilación del equipo. Plegable y fácil de transportar.',69900.00,49,0,'2026-10-01 08:01:20'),(27,5,1,'Bombillo inteligente WiFi multicolor','Controla color e intensidad desde el celular y programa horarios de encendido.',34900.00,19,0,'2026-09-23 18:44:20'),(28,5,1,'Combo teclado y mouse inalámbricos','Conexión estable con un solo receptor USB. Teclas silenciosas y diseño compacto.',89900.00,22,0,'2026-09-28 07:00:20'),(29,5,1,'Lector de libros electrónicos 6 pulgadas','Pantalla de tinta electrónica sin reflejos, luz ajustable y semanas de batería.',399900.00,28,0,'2026-08-17 15:38:20'),(30,5,1,'Cámara deportiva 4K resistente al agua','Graba tus aventuras en 4K con estabilización y carcasa sumergible hasta 30 metros.',249900.00,30,0,'2026-08-23 00:53:20'),(31,5,1,'Proyector portátil LED HD','Convierte cualquier pared en una pantalla de hasta 120 pulgadas. Entradas HDMI y USB.',459900.00,38,0,'2026-09-01 21:22:20'),(32,5,1,'Auriculares in-ear con cable y micrófono','Sonido claro, control en el cable y almohadillas intercambiables para mayor comodidad.',24900.00,10,0,'2026-08-25 02:49:20'),(33,5,1,'Hub USB-C 7 en 1','HDMI 4K, lector de tarjetas SD, tres puertos USB y carga rápida en un solo adaptador.',99900.00,27,0,'2026-10-21 18:36:20'),(34,5,1,'Cargador inalámbrico para celular','Carga rápida sin cables, base antideslizante y protección contra sobrecalentamiento.',49900.00,41,0,'2026-09-10 23:03:20'),(35,5,1,'Mini drone con cámara y control remoto','Cámara HD, modo de altura fija y dos baterías incluidas para más tiempo de vuelo.',219900.00,24,1,'2026-10-03 18:12:20'),(36,6,2,'Juego de sábanas queen 4 piezas','Tela suave y transpirable que no se destiñe. Incluye sábana, bajera y dos fundas.',89900.00,35,1,'2026-10-17 02:42:20'),(37,6,2,'Edredón doble faz tamaño queen','Relleno ligero y cálido, ideal para las noches frías. Lavable en máquina.',159900.00,47,0,'2026-08-26 20:37:20'),(38,6,2,'Almohada viscoelástica ergonómica','Se adapta a tu cuello y cabeza para un descanso profundo y sin dolores.',69900.00,51,0,'2026-09-07 09:04:20'),(39,6,2,'Juego de ollas antiadherentes 8 piezas','Recubrimiento resistente, mangos ergonómicos y aptas para todo tipo de estufa.',249900.00,25,1,'2026-10-27 16:26:20'),(40,6,2,'Sartén antiadherente 28 cm','Distribuye el calor de forma uniforme y permite cocinar con menos aceite.',59900.00,60,0,'2026-08-26 05:34:20'),(41,6,2,'Licuadora con vaso de vidrio 1.5 litros','Motor potente de 600 W, seis velocidades y cuchillas de acero inoxidable.',139900.00,29,1,'2026-09-26 20:18:20'),(42,6,2,'Freidora de aire 4 litros','Cocina crujiente con hasta 90% menos aceite. Control digital de temperatura y tiempo.',289900.00,35,0,'2026-09-21 12:08:20'),(43,6,2,'Cafetera eléctrica de goteo 12 tazas','Filtro permanente, jarra de vidrio y función para mantener el café caliente.',119900.00,11,0,'2026-09-23 15:20:20'),(44,6,2,'Juego de cuchillos de cocina 6 piezas','Acero inoxidable afilado con base de madera. Cortes precisos y seguros.',79900.00,43,0,'2026-09-09 11:16:20'),(45,6,2,'Organizador de cocina multiusos','Optimiza el espacio de tu despensa con compartimentos ajustables.',44900.00,37,0,'2026-08-12 00:00:20'),(46,6,2,'Juego de vasos de vidrio 12 piezas','Vidrio resistente apto para lavavajillas. Elegantes para el uso diario.',49900.00,13,0,'2026-09-21 05:05:20'),(47,6,2,'Vajilla de cerámica 24 piezas','Diseño moderno para 6 personas. Apta para microondas y lavavajillas.',189900.00,38,0,'2026-08-17 21:17:20'),(48,6,2,'Lámpara de mesa LED regulable','Tres niveles de luz y brazo flexible, perfecta para estudiar o leer.',64900.00,54,0,'2026-08-12 01:01:20'),(49,6,2,'Cortinas blackout 2 paneles','Bloquean la luz y reducen el ruido. Ojales metálicos de fácil instalación.',99900.00,44,0,'2026-08-11 06:04:20'),(50,6,2,'Tapete decorativo para sala 160x230 cm','Fibras suaves y resistentes con diseño geométrico moderno.',229900.00,37,0,'2026-09-23 16:42:20'),(51,6,2,'Espejo decorativo de pared redondo','Marco metálico dorado que aporta amplitud y luz a cualquier espacio.',119900.00,39,1,'2026-10-06 09:28:20'),(52,6,2,'Aspiradora robot programable','Limpia los pisos de forma automática, evita obstáculos y regresa sola a cargarse.',599900.00,60,0,'2026-09-21 17:03:20'),(53,6,2,'Ventilador de torre silencioso','Tres velocidades, oscilación y control remoto. Perfecto para los días de calor.',189900.00,42,0,'2026-08-06 15:05:20'),(54,6,2,'Plancha de vapor 2000 W','Suela antiadherente y golpe de vapor para eliminar arrugas rápidamente.',89900.00,36,0,'2026-09-13 05:55:20'),(55,6,2,'Set de organizadores de ropa 6 piezas','Cajas plegables en tela transpirable para clóset y cajones.',54900.00,39,0,'2026-08-17 15:33:20'),(56,6,2,'Colchón ortopédico semidoble','Resortes de soporte y capa de espuma para un descanso firme y cómodo.',549900.00,7,0,'2026-09-07 13:14:20'),(57,6,2,'Mesa auxiliar de madera','Diseño nórdico con patas en madera maciza y superficie resistente.',149900.00,20,0,'2026-08-21 05:30:20'),(58,6,2,'Silla de comedor tapizada','Respaldo ergonómico y estructura metálica reforzada. Precio por unidad.',169900.00,14,0,'2026-08-16 11:14:20'),(59,6,2,'Juego de toallas de baño 4 piezas','Algodón absorbente y suave que conserva su color lavado tras lavado.',79900.00,9,0,'2026-08-03 07:22:20'),(60,6,2,'Organizador de zapatos de 3 niveles','Estructura estable para guardar hasta 12 pares y ahorrar espacio.',69900.00,51,0,'2026-09-12 07:29:20'),(61,6,2,'Reloj de pared silencioso moderno','Mecanismo silencioso que no interrumpe y un diseño minimalista.',49900.00,48,1,'2026-10-20 14:24:20'),(62,6,2,'Set de recipientes herméticos 10 piezas','Conservan tus alimentos frescos. Aptos para nevera y microondas.',69900.00,51,0,'2026-09-03 07:01:20'),(63,6,2,'Matera decorativa con plato','Cerámica esmaltada ideal para suculentas y plantas pequeñas.',34900.00,33,0,'2026-09-17 03:39:20'),(64,6,2,'Cojines decorativos set x2','Fundas removibles con cierre y relleno suave en fibra hipoalergénica.',59900.00,15,0,'2026-09-16 01:17:20'),(65,6,2,'Hervidor eléctrico de agua 1.8 litros','Apagado automático y base giratoria. Hierve agua en pocos minutos.',79900.00,20,0,'2026-08-13 14:26:20'),(66,7,3,'Camiseta básica de algodón unisex','Algodón suave y fresco en corte regular. Disponible en varios colores.',39900.00,13,0,'2026-09-02 21:30:20'),(67,7,3,'Jean clásico para hombre','Corte recto, tela resistente y cómoda con elasticidad.',119900.00,50,0,'2026-09-18 08:35:20'),(68,7,3,'Jean skinny tiro alto para mujer','Se ajusta al cuerpo sin apretar, con tela elástica que no pierde la forma.',109900.00,49,0,'2026-09-17 05:03:20'),(69,7,3,'Chaqueta impermeable ligera','Protege del viento y la lluvia sin pesar. Capucha ajustable y bolsillos con cierre.',159900.00,51,0,'2026-08-06 08:02:20'),(70,7,3,'Buzo con capucha unisex','Interior afelpado, bolsillo canguro y puños elásticos para mayor abrigo.',99900.00,40,1,'2026-10-07 02:09:20'),(71,7,3,'Vestido casual de verano','Tela fresca con corte fluido, perfecto para el día a día.',89900.00,41,0,'2026-09-23 08:07:20'),(72,7,3,'Falda plisada midi','Caída elegante y cintura elástica. Combina con blusas y camisetas.',74900.00,48,0,'2026-10-01 22:27:20'),(73,7,3,'Blusa elegante de manga larga','Tela ligera con caída suave. Ideal para la oficina o una salida.',69900.00,41,0,'2026-08-18 03:17:20'),(74,7,3,'Tenis casuales blancos','Suela cómoda y diseño versátil que combina con todo.',149900.00,47,0,'2026-09-14 06:04:20'),(75,7,3,'Zapatos formales de cuero para hombre','Cuero genuino con suela flexible, para el trabajo y eventos especiales.',219900.00,50,0,'2026-09-16 08:19:20'),(76,7,3,'Sandalias de plataforma para mujer','Cómodas y ligeras, con correa ajustable y suela antideslizante.',99900.00,57,0,'2026-08-10 10:22:20'),(77,7,3,'Botas de cuero casuales','Resistentes, con suela antideslizante y plantilla acolchada.',249900.00,31,0,'2026-09-20 12:26:20'),(78,7,3,'Bolso de mano elegante para mujer','Varios compartimentos, correa desmontable y cierre seguro.',129900.00,18,0,'2026-10-03 03:24:20'),(79,7,3,'Morral urbano impermeable','Compartimento para laptop de 15 pulgadas, puerto USB y tela resistente al agua.',99900.00,59,1,'2026-10-05 10:45:20'),(80,7,3,'Billetera de cuero para hombre','Diseño delgado con varias ranuras para tarjetas y bolsillo para billetes.',59900.00,6,1,'2026-10-26 22:09:20'),(81,7,3,'Cinturón de cuero reversible','Dos colores en una sola pieza con hebilla metálica giratoria.',49900.00,15,0,'2026-08-31 06:12:21'),(82,7,3,'Gafas de sol polarizadas','Protección UV400 y montura liviana y resistente.',79900.00,44,0,'2026-08-03 11:51:21'),(83,7,3,'Gorra deportiva ajustable','Tela transpirable y cierre trasero ajustable para cualquier tamaño.',34900.00,35,0,'2026-08-17 19:06:21'),(84,7,3,'Reloj análogo clásico de acero','Resistente al agua, correa de acero inoxidable y acabado elegante.',189900.00,39,0,'2026-08-06 13:30:21'),(85,7,3,'Pijama de dos piezas de algodón','Suave y fresca para dormir cómoda durante todo el año.',69900.00,37,1,'2026-09-27 04:11:21'),(86,7,3,'Medias deportivas pack x6','Algodón con refuerzo en talón y punta. Resistentes y transpirables.',29900.00,18,1,'2026-10-06 06:15:21'),(87,7,3,'Ropa interior de algodón pack x5','Costuras suaves, cintura cómoda y alta durabilidad.',49900.00,50,0,'2026-09-15 17:44:21'),(88,7,3,'Bufanda tejida de invierno','Tejido grueso y cálido en colores lisos.',39900.00,35,0,'2026-09-13 09:36:21'),(89,7,3,'Guantes térmicos para pantalla táctil','Forro cálido compatibles con celulares y tablets.',34900.00,55,0,'2026-08-15 17:40:21'),(90,7,3,'Camisa de lino manga larga','Fresca, ligera y elegante. Ideal para clima cálido.',99900.00,37,0,'2026-08-17 09:28:21'),(91,7,3,'Sudadera deportiva tipo jogger','Tela suave con cintura ajustable y puños elásticos.',89900.00,33,0,'2026-09-09 03:52:21'),(92,7,3,'Vestido largo de fiesta','Tela con brillo, corte elegante y cierre invisible. Perfecto para eventos.',189900.00,48,0,'2026-08-08 08:31:21'),(93,7,3,'Traje de baño de dos piezas para mujer','Tela con protección UV y secado rápido.',79900.00,8,0,'2026-08-15 06:15:21'),(94,7,3,'Pantaloneta de baño para hombre','Secado rápido con bolsillos y cintura elástica.',54900.00,24,0,'2026-10-01 02:44:21'),(95,7,3,'Set de collar y aretes de bisutería','Acabado dorado hipoalergénico, ideal para regalar.',44900.00,35,0,'2026-08-07 11:40:21'),(96,8,4,'Balón de fútbol profesional número 5','Costuras reforzadas y excelente rebote para entrenar y competir.',79900.00,57,1,'2026-10-20 23:34:21'),(97,8,4,'Balón de baloncesto número 7','Agarre superior para cancha interior y exterior.',89900.00,34,0,'2026-08-28 04:36:21'),(98,8,4,'Balón de voleibol de playa','Material suave al tacto y resistente al agua y a la arena.',59900.00,51,0,'2026-08-19 11:26:21'),(99,8,4,'Mancuernas ajustables 20 kg','Cambia el peso en segundos. Ideales para entrenar en casa.',189900.00,38,0,'2026-10-06 09:03:21'),(100,8,4,'Set de bandas elásticas de resistencia','Cinco niveles de resistencia con asas y bolsa de transporte.',49900.00,34,0,'2026-08-07 00:24:21'),(101,8,4,'Tapete de yoga antideslizante 6 mm','Amortigua las articulaciones y se mantiene firme sobre el piso.',59900.00,17,0,'2026-08-02 21:27:21'),(102,8,4,'Bicicleta estática plegable','Pantalla de monitoreo y resistencia ajustable. Se guarda fácilmente.',399900.00,33,0,'2026-08-14 06:08:21'),(103,8,4,'Cuerda para saltar con contador','Mango ergonómico y rodamientos de giro rápido.',24900.00,52,0,'2026-09-16 07:46:21'),(104,8,4,'Guantes de gimnasio con muñequera','Protegen las palmas y mejoran el agarre en cada ejercicio.',39900.00,10,0,'2026-08-31 21:42:21'),(105,8,4,'Botella deportiva térmica 750 ml','Acero inoxidable que mantiene el frío hasta 24 horas y el calor 12 horas.',54900.00,23,0,'2026-08-08 17:16:21'),(106,8,4,'Zapatillas de running livianas','Suela con amortiguación y malla transpirable para correr cómodo.',189900.00,37,0,'2026-09-26 05:55:21'),(107,8,4,'Casco de ciclismo con luz trasera','Ventilación, ajuste cómodo y luz LED para mayor visibilidad.',119900.00,12,0,'2026-10-12 05:24:21'),(108,8,4,'Bicicleta de montaña rin 26','Marco de aluminio, 21 velocidades y frenos de disco.',899900.00,53,0,'2026-08-12 23:07:21'),(109,8,4,'Raqueta de tenis de grafito','Ligera y con buen control. Incluye funda protectora.',169900.00,32,1,'2026-10-16 14:45:21'),(110,8,4,'Pelotas de tenis pack x3','Fieltro de alta calidad y rebote constante.',24900.00,34,0,'2026-08-07 12:24:21'),(111,8,4,'Set de raquetas de bádminton x2','Incluye tres volantes y bolso de transporte.',59900.00,6,1,'2026-10-21 13:08:21'),(112,8,4,'Guayos de fútbol para césped sintético','Tacos que ofrecen tracción y comodidad en cada movimiento.',159900.00,6,0,'2026-09-18 20:45:21'),(113,8,4,'Espinilleras de fútbol','Protección liviana con cierre ajustable.',29900.00,43,0,'2026-09-10 04:26:21'),(114,8,4,'Gafas de natación antiempañantes','Ajuste cómodo, protección UV y lentes antiempañantes.',34900.00,59,1,'2026-10-22 09:01:21'),(115,8,4,'Gorro de natación de silicona','Cómodo, elástico y resistente al cloro.',19900.00,45,0,'2026-08-18 16:27:21'),(116,8,4,'Patines en línea ajustables','Cuatro ruedas, tallas ajustables y rodamientos de alta velocidad.',179900.00,18,0,'2026-10-07 09:04:21'),(117,8,4,'Skateboard completo 31 pulgadas','Tabla de maple con ruedas de poliuretano y ejes resistentes.',149900.00,13,0,'2026-09-03 09:43:21'),(118,8,4,'Carpa de camping para 4 personas','Fácil de armar, impermeable y con ventilación para mayor comodidad.',249900.00,8,0,'2026-08-22 12:01:21'),(119,8,4,'Sleeping bag térmico','Relleno cálido y cierre de dos vías para noches frías.',119900.00,40,0,'2026-08-03 21:16:21'),(120,8,4,'Mochila de senderismo 40 litros','Espalda ventilada, correas acolchadas y cubierta para lluvia.',169900.00,23,0,'2026-08-30 02:10:21'),(121,8,4,'Linterna LED recargable para camping','Alta potencia, tres modos de luz y batería recargable.',44900.00,54,0,'2026-09-02 02:24:21'),(122,8,4,'Guantes de boxeo 12 onzas','Acolchado de espuma multicapa y cierre de velcro seguro.',69900.00,28,1,'2026-10-15 20:24:21'),(123,8,4,'Pesa rusa kettlebell 12 kg','Hierro fundido con base plana y mango ancho para agarre firme.',99900.00,6,0,'2026-10-01 09:45:21'),(124,8,4,'Rodillo de espuma para masajes','Alivia tensión muscular y mejora la recuperación después de entrenar.',49900.00,48,0,'2026-09-06 20:45:21'),(125,8,4,'Cronómetro digital para entrenamiento','Resistente al agua, con alarma y memoria de vueltas.',29900.00,42,0,'2026-08-20 21:25:21'),(126,9,5,'Bloques de construcción 500 piezas','Piezas compatibles que estimulan la creatividad y la motricidad. Incluye caja organizadora.',89900.00,37,0,'2026-08-28 03:41:21'),(127,9,5,'Muñeca articulada con accesorios','Cabello suave, ropa intercambiable y accesorios para jugar durante horas.',59900.00,52,0,'2026-08-05 14:27:21'),(128,9,5,'Carro de control remoto todoterreno','Llantas de alto agarre y batería recargable. Alcance de hasta 30 metros.',119900.00,14,0,'2026-09-10 06:09:21'),(129,9,5,'Rompecabezas 1000 piezas paisaje','Imagen de alta calidad y piezas de cartón grueso. Un reto para toda la familia.',44900.00,20,1,'2026-09-16 21:14:21'),(130,9,5,'Peluche oso gigante 80 cm','Suave, abrazable y con relleno hipoalergénico.',99900.00,43,1,'2026-10-17 23:50:21'),(131,9,5,'Set de cocina de juguete','Incluye ollas, utensilios y alimentos de juguete para jugar a ser chef.',79900.00,44,0,'2026-08-11 04:50:21'),(132,9,5,'Juego de mesa familiar de estrategia','Para 2 a 6 jugadores. Diversión asegurada en reuniones familiares.',69900.00,50,0,'2026-09-13 23:54:21'),(133,9,5,'Pista de carros con looping','Incluye dos carros y rampas para armar de distintas formas.',109900.00,24,1,'2026-10-22 06:02:21'),(134,9,5,'Tren eléctrico con vías','Locomotora con luz y sonido, vagones y vías para armar circuitos.',129900.00,32,0,'2026-08-30 02:00:22'),(135,9,5,'Set de herramientas de juguete','Martillo, taladro y llaves de juguete para pequeños constructores.',54900.00,16,0,'2026-08-05 19:49:22'),(136,9,5,'Dinosaurios de juguete x12','Figuras realistas de goma resistente en distintos tamaños.',49900.00,14,0,'2026-08-19 15:02:22'),(137,9,5,'Kit de ciencia con experimentos','Más de 30 experimentos seguros para aprender jugando.',74900.00,56,0,'2026-08-07 15:36:22'),(138,9,5,'Globos y pelota saltarina inflable','Para jugar dentro y fuera de casa, con bomba de aire incluida.',29900.00,43,0,'2026-10-02 02:00:22'),(139,9,5,'Piscina de pelotas con 100 pelotas','Estructura inflable resistente con pelotas de colores atóxicas.',69900.00,38,0,'2026-09-22 10:22:22'),(140,9,5,'Set de arte y pintura 150 piezas','Crayones, marcadores, acuarelas y pinceles en un maletín de transporte.',59900.00,30,0,'2026-08-17 09:23:22'),(141,9,5,'Plastilina moldeable 12 colores','Suave, atóxica y fácil de mezclar para modelar figuras.',24900.00,15,0,'2026-09-12 14:27:22'),(142,9,5,'Casa de muñecas de madera','Tres pisos con muebles incluidos y detalles pintados a mano.',189900.00,57,0,'2026-10-12 00:47:22'),(143,9,5,'Robot transformable','Se convierte en vehículo en pocos pasos. Articulaciones móviles.',79900.00,30,1,'2026-10-28 15:36:22'),(144,9,5,'Avión de juguete con luces y sonido','Motor de fricción y sonidos realistas de despegue.',49900.00,12,0,'2026-09-24 11:56:22'),(145,9,5,'Instrumentos musicales infantiles','Tambor, maracas, xilófono y pandereta en un solo set.',64900.00,10,0,'2026-10-25 06:15:22'),(146,9,5,'Bicicleta infantil rin 16','Con ruedas de entrenamiento, canasta y timbre.',289900.00,59,0,'2026-09-28 08:24:22'),(147,9,5,'Triciclo con manija para padres','Asiento ajustable, manija de guía y cinturón de seguridad.',179900.00,47,0,'2026-09-27 18:27:22'),(148,9,5,'Disfraz de superhéroe infantil','Incluye capa, antifaz y traje. Tela suave y cómoda.',59900.00,55,0,'2026-08-04 21:56:22'),(149,9,5,'Tablero magnético educativo','Letras y números magnéticos para aprender jugando.',54900.00,7,0,'2026-10-27 14:35:22'),(150,9,5,'Pistola de agua gigante','Gran capacidad y largo alcance para divertirse en verano.',29900.00,38,0,'2026-09-16 14:35:22'),(151,9,5,'Cometa colorida','Material resistente al viento con carrete y cuerda incluidos.',19900.00,26,0,'2026-08-28 18:53:22'),(152,9,5,'Monopatín infantil plegable','Manubrio ajustable, ruedas con luz y freno trasero.',139900.00,25,1,'2026-09-18 23:08:22'),(153,9,5,'Set de médico infantil','Estetoscopio, termómetro y maletín para jugar a ser doctor.',44900.00,26,0,'2026-08-07 17:54:22'),(154,9,5,'Carrito de supermercado de juguete','Con frutas, verduras y productos de juguete.',89900.00,13,0,'2026-09-14 15:31:22'),(155,9,5,'Juego de memoria con cartas','Desarrolla la concentración y la memoria de forma divertida.',24900.00,35,0,'2026-09-07 21:45:22'),(156,10,6,'Aprende Java desde cero','Guía práctica con ejercicios resueltos para dominar la programación orientada a objetos.',79900.00,45,0,'2026-08-17 16:04:22'),(157,10,6,'Fundamentos de bases de datos relacionales','Modelo entidad-relación, normalización y SQL explicados paso a paso.',89900.00,16,1,'2026-10-15 22:18:22'),(158,10,6,'Cuentos cortos latinoamericanos','Selección de relatos que recorren la cultura y la historia de la región.',39900.00,43,0,'2026-09-12 15:22:22'),(159,10,6,'Novela de misterio: La casa del lago','Un crimen sin resolver y un detective que no se rinde. Intriga hasta la última página.',49900.00,19,0,'2026-09-20 11:15:22'),(160,10,6,'Historia de Colombia ilustrada','Un recorrido visual por los hechos que marcaron al país, desde la época precolombina.',69900.00,45,0,'2026-09-29 07:33:22'),(161,10,6,'Cocina colombiana tradicional','Más de 100 recetas típicas con ingredientes fáciles de conseguir.',59900.00,35,0,'2026-09-05 11:39:22'),(162,10,6,'Finanzas personales para jóvenes','Aprende a ahorrar, presupuestar e invertir desde tus primeros ingresos.',54900.00,20,1,'2026-08-29 04:16:22'),(163,10,6,'El arte de hablar en público','Técnicas para perder el miedo escénico y comunicar con seguridad.',44900.00,51,1,'2026-10-23 14:38:22'),(164,10,6,'Hábitos que transforman tu vida','Estrategias sencillas para crear rutinas positivas y mantenerlas.',49900.00,41,1,'2026-09-23 14:30:22'),(165,10,6,'Cuaderno de ejercicios de matemáticas','Práctica graduada con respuestas para reforzar lo aprendido en clase.',34900.00,8,0,'2026-10-12 03:25:22'),(166,10,6,'Diccionario de la lengua española escolar','Definiciones claras, ejemplos de uso y apéndice de ortografía.',64900.00,47,0,'2026-08-07 01:31:22'),(167,10,6,'Atlas del mundo para estudiantes','Mapas actualizados, datos de cada país y curiosidades geográficas.',79900.00,17,0,'2026-10-25 19:39:22'),(168,10,6,'Poemas de amor y esperanza','Antología de versos para leer, regalar y compartir.',29900.00,47,0,'2026-09-10 08:25:22'),(169,10,6,'Cuentos infantiles para dormir','Historias breves con ilustraciones para la hora de acostarse.',39900.00,59,0,'2026-10-25 13:12:22'),(170,10,6,'Manual de primeros auxilios','Qué hacer ante emergencias comunes, explicado con imágenes.',44900.00,34,0,'2026-08-11 22:06:22'),(171,10,6,'Introducción a la inteligencia artificial','Conceptos básicos, aplicaciones reales y reflexiones éticas para principiantes.',94900.00,54,0,'2026-09-01 14:31:22'),(172,10,6,'Marketing digital paso a paso','Redes sociales, publicidad en línea y analítica para pequeños negocios.',74900.00,18,0,'2026-09-15 21:31:22'),(173,10,6,'Emprendimiento: de la idea al negocio','Cómo validar una idea, armar un plan y dar los primeros pasos.',59900.00,51,0,'2026-08-29 03:59:22'),(174,10,6,'Inglés para principiantes con audio','Lecciones progresivas con vocabulario y pronunciación para practicar.',49900.00,7,0,'2026-10-18 04:22:22'),(175,10,6,'Novela histórica: El viajero del tiempo','Una aventura a través de los siglos con personajes inolvidables.',54900.00,47,0,'2026-09-11 16:49:22'),(176,10,6,'Biología básica ilustrada','La célula, la genética y los ecosistemas con esquemas a todo color.',69900.00,19,0,'2026-08-19 10:43:22'),(177,10,6,'Física para todos','Los principios del universo explicados sin fórmulas complicadas.',64900.00,39,0,'2026-08-09 12:09:22'),(178,10,6,'Guía de jardinería en casa','Cultiva plantas, hierbas y hortalizas en espacios pequeños.',44900.00,14,0,'2026-10-15 08:06:22'),(179,10,6,'Mindfulness y meditación diaria','Ejercicios guiados para reducir el estrés y mejorar la concentración.',39900.00,48,0,'2026-08-14 01:55:22'),(180,10,6,'Novela de ciencia ficción: Mundos lejanos','Una expedición espacial que cambia el destino de la humanidad.',52900.00,17,0,'2026-09-24 10:34:22'),(181,10,6,'Libro para colorear: mandalas','Más de 60 diseños para relajarte y estimular tu creatividad.',24900.00,23,0,'2026-09-21 05:16:22'),(182,10,6,'Programación web con HTML, CSS y JavaScript','Crea páginas interactivas desde cero con proyectos prácticos.',84900.00,40,1,'2026-09-22 05:53:22'),(183,10,6,'Cómo estudiar mejor','Técnicas de memoria, organización del tiempo y preparación de exámenes.',34900.00,11,0,'2026-09-25 01:24:22'),(184,10,6,'Fábulas clásicas ilustradas','Las historias de siempre con moralejas y dibujos para los más pequeños.',37900.00,25,0,'2026-10-12 21:32:22'),(185,10,6,'Agenda 2027 planificador semanal','Vista semanal, metas del mes y hojas para notas. Tapa dura.',29900.00,28,0,'2026-10-14 00:51:22'),(186,11,7,'Crema hidratante facial con ácido hialurónico','Hidratación intensa por 24 horas y textura ligera de rápida absorción.',54900.00,22,0,'2026-09-17 17:02:22'),(187,11,7,'Protector solar facial SPF 50','Protección UVA y UVB de acabado seco, ideal bajo el maquillaje.',49900.00,37,0,'2026-08-19 22:00:22'),(188,11,7,'Sérum de vitamina C antioxidante','Ilumina la piel y ayuda a reducir manchas con el uso diario.',69900.00,58,0,'2026-09-22 02:17:22'),(189,11,7,'Limpiador facial en gel','Elimina impurezas y exceso de grasa sin resecar.',34900.00,24,0,'2026-09-17 08:46:22'),(190,11,7,'Agua micelar 400 ml','Desmaquilla y limpia en un solo paso. Apta para piel sensible.',29900.00,17,0,'2026-09-30 06:47:22'),(191,11,7,'Mascarilla de arcilla purificante','Controla el brillo y limpia los poros en profundidad.',24900.00,39,0,'2026-09-16 01:25:22'),(192,11,7,'Shampoo reparador sin sal','Fortalece el cabello dañado y aporta brillo desde el primer uso.',39900.00,34,1,'2026-10-19 00:06:22'),(193,11,7,'Acondicionador de hidratación profunda','Suaviza y desenreda sin apelmazar el cabello.',39900.00,39,0,'2026-08-18 10:16:22'),(194,11,7,'Aceite de argán para cabello','Reduce el frizz y aporta nutrición y brillo natural.',44900.00,39,0,'2026-08-18 10:02:22'),(195,11,7,'Secador de cabello iónico 2200 W','Seca rápido y reduce el frizz. Incluye difusor y concentrador.',119900.00,23,0,'2026-08-16 15:34:22'),(196,11,7,'Plancha alisadora de cerámica','Placas que protegen la fibra capilar y control de temperatura.',99900.00,12,0,'2026-08-13 18:16:22'),(197,11,7,'Cepillo desenredante para cabello','Cerdas flexibles que desenredan sin tirones ni quiebres.',24900.00,19,0,'2026-10-08 21:07:22'),(198,11,7,'Paleta de sombras de 18 colores','Tonos mate y brillantes de alta pigmentación y larga duración.',49900.00,6,0,'2026-08-04 03:09:22'),(199,11,7,'Base de maquillaje líquida','Cobertura media modulable de acabado natural.',44900.00,11,0,'2026-08-10 23:06:22'),(200,11,7,'Labial mate de larga duración','Color intenso y cómodo que no reseca los labios.',29900.00,35,0,'2026-09-01 03:58:22'),(201,11,7,'Máscara de pestañas voluminizadora','Pestañas largas y definidas sin grumos durante todo el día.',32900.00,27,0,'2026-09-22 19:11:23'),(202,11,7,'Delineador líquido a prueba de agua','Trazo preciso y de secado rápido que resiste todo el día.',24900.00,40,0,'2026-08-19 15:18:23'),(203,11,7,'Set de brochas de maquillaje x12','Cerdas suaves y estuche para guardarlas. Para rostro y ojos.',59900.00,59,0,'2026-08-13 14:44:23'),(204,11,7,'Esmaltes de uñas set x6','Colores de moda con acabado brillante y secado rápido.',34900.00,60,0,'2026-08-29 21:58:23'),(205,11,7,'Perfume floral para mujer 100 ml','Fragancia fresca y femenina de larga duración.',129900.00,17,0,'2026-08-03 10:42:23'),(206,11,7,'Perfume amaderado para hombre 100 ml','Notas cálidas y envolventes para uso diario o de noche.',139900.00,7,1,'2026-09-27 21:38:23'),(207,11,7,'Desodorante en barra 48 horas','Protección contra el sudor y el mal olor sin manchar la ropa.',14900.00,60,1,'2026-10-15 16:02:23'),(208,11,7,'Jabón artesanal de avena y miel','Hecho a mano para pieles sensibles. Limpia y suaviza.',12900.00,28,0,'2026-09-08 18:46:23'),(209,11,7,'Exfoliante corporal de café','Elimina las células muertas y deja la piel suave y tersa.',29900.00,49,0,'2026-09-07 20:12:23'),(210,11,7,'Crema corporal de karité','Nutrición profunda para piel seca con aroma suave.',34900.00,56,0,'2026-09-10 22:22:23'),(211,11,7,'Afeitadora eléctrica recargable','Cabezal flotante para un afeitado al ras sin irritación.',129900.00,19,1,'2026-10-19 22:51:23'),(212,11,7,'Kit de cuidado de barba','Aceite, bálsamo, peine y cepillo para una barba cuidada.',69900.00,45,0,'2026-08-25 18:19:23'),(213,11,7,'Set de manicure con cortaúñas','Acero inoxidable en estuche de viaje.',24900.00,23,0,'2026-09-09 08:19:23'),(214,11,7,'Rodillo facial de jade','Masajea el rostro, mejora la circulación y reduce la hinchazón.',39900.00,54,0,'2026-09-08 05:34:23'),(215,11,7,'Bálsamo labial hidratante pack x3','Protege y suaviza los labios con fórmula nutritiva.',19900.00,52,1,'2026-10-10 10:02:23'),(216,12,8,'Cama para mascotas mediana','Relleno suave y base antideslizante. Funda lavable.',89900.00,42,0,'2026-10-03 02:42:23'),(217,12,8,'Alimento para perros adultos 8 kg','Nutrición balanceada con proteínas y vitaminas para tu mejor amigo.',119900.00,42,0,'2026-10-05 12:48:23'),(218,12,8,'Rascador para gatos con torre','Postes de sisal, plataformas y casita para jugar y descansar.',129900.00,48,0,'2026-09-09 08:27:23'),(219,12,8,'Collar y correa ajustable para perro','Material resistente y cómodo con broche de seguridad.',34900.00,14,1,'2026-10-20 16:50:23'),(220,12,8,'Arenero para gatos con tapa','Controla olores y evita que la arena se esparza.',59900.00,56,0,'2026-10-05 22:23:23'),(221,12,8,'Kit de herramientas de 108 piezas','Todo lo que necesitas para reparaciones del hogar en un maletín.',149900.00,12,0,'2026-08-04 00:31:23'),(222,12,8,'Taladro inalámbrico 20 V','Dos baterías, cargador rápido y 30 accesorios incluidos.',249900.00,33,1,'2026-10-14 08:19:23'),(223,12,8,'Escalera plegable de aluminio','Ligera, resistente y con bloqueo de seguridad.',199900.00,12,0,'2026-08-28 15:04:23'),(224,12,8,'Aspiradora de mano para carro','Potente succión con accesorios para rincones difíciles.',69900.00,9,0,'2026-08-21 20:10:23'),(225,12,8,'Kit de limpieza y cera para automóvil','Cera, microfibras y shampoo para dejar tu carro como nuevo.',54900.00,28,0,'2026-08-25 04:28:23'),(226,12,8,'Cargador de carro con doble USB','Carga dos dispositivos a la vez de forma rápida y segura.',24900.00,57,1,'2026-10-13 01:15:23'),(227,12,8,'Kit de emergencia para vehículo','Incluye triángulos, botiquín, extintor y herramientas básicas.',89900.00,47,0,'2026-09-02 14:02:23'),(228,12,8,'Cuadernos universitarios 100 hojas pack x5','Papel de buena calidad, tapa resistente y rayado doble.',39900.00,12,0,'2026-09-13 19:44:23'),(229,12,8,'Set de esferos de colores x24','Tinta de secado rápido y trazo suave. Ideal para estudio y oficina.',19900.00,26,0,'2026-10-04 17:50:23'),(230,12,8,'Calculadora científica','Más de 240 funciones para estudiantes de colegio y universidad.',59900.00,43,0,'2026-08-14 17:10:23'),(231,12,8,'Silla de oficina ergonómica','Soporte lumbar, altura regulable y base con ruedas silenciosas.',349900.00,10,0,'2026-10-03 10:42:23'),(232,12,8,'Mesa plegable para laptop','Ligera y portátil. Ideal para trabajar desde la cama o el sofá.',129900.00,26,0,'2026-10-15 05:55:23'),(233,12,8,'Organizador de escritorio multiusos','Compartimentos para papeles, lápices y accesorios.',44900.00,22,0,'2026-10-06 14:58:23'),(234,12,8,'Coche de bebé liviano y plegable','Sistema de plegado fácil, capota ajustable y cinturón de seguridad.',449900.00,10,1,'2026-10-28 16:10:23'),(235,12,8,'Pañales desechables etapa 3 x100','Alta absorción y ajuste suave para proteger la piel del bebé.',79900.00,32,0,'2026-08-12 01:35:23'),(236,12,8,'Biberón anticólicos 260 ml','Válvula que reduce los gases y tetina de silicona suave.',24900.00,55,0,'2026-10-06 12:57:23'),(237,12,8,'Termo para café de acero 500 ml','Mantiene tu bebida caliente por 12 horas. Tapa hermética.',49900.00,32,0,'2026-08-03 01:27:23'),(238,12,8,'Candado de seguridad con clave','Combinación de cuatro dígitos y cuerpo de acero reforzado.',24900.00,6,1,'2026-10-24 17:17:23'),(239,12,8,'Set de cinta métrica y nivel','Precisión para trabajos de carpintería y decoración.',29900.00,12,0,'2026-10-08 12:37:23'),(240,12,8,'Linterna táctica recargable','Alta potencia, zoom ajustable y carcasa de aluminio.',54900.00,7,0,'2026-10-01 17:27:23'),(241,12,8,'Botiquín de primeros auxilios','Más de 100 elementos organizados en un estuche resistente.',69900.00,13,0,'2026-10-21 09:25:23'),(242,12,8,'Maleta de viaje mediana con ruedas','Cierre con candado, ruedas giratorias y estructura rígida.',229900.00,49,0,'2026-09-08 20:34:23'),(243,12,8,'Paraguas automático resistente al viento','Apertura y cierre con un botón. Estructura reforzada.',44900.00,42,0,'2026-07-31 23:59:23'),(244,12,8,'Pecera de vidrio de 30 litros con filtro','Incluye filtro y luz LED. Perfecta para peces tropicales.',189900.00,60,0,'2026-09-28 01:13:23'),(245,12,8,'Kit de jardinería de 10 piezas','Palas, tijeras y guantes de acero inoxidable en bolso de transporte.',54900.00,26,0,'2026-08-19 23:04:23');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `buyer_id` bigint NOT NULL,
  `rating` tinyint NOT NULL,
  `comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_review` (`product_id`,`buyer_id`),
  KEY `fk_reviews_buyer` (`buyer_id`),
  CONSTRAINT `fk_reviews_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,2,5,'muy bueno','2026-10-02 03:03:41');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'BUYER'),(2,'SELLER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seller_id` bigint NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seller_id` (`seller_id`),
  CONSTRAINT `fk_stores_seller` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,1,'mi tienda',NULL,NULL,'2026-10-01 02:39:07'),(2,3,'Tienda de JUAN GABRIEL DIAZ HERNÁNDEZ',NULL,NULL,'2026-10-19 02:17:37'),(3,4,'Tienda de Laura Katalina',NULL,NULL,'2026-10-19 02:25:44'),(4,5,'Fusion',NULL,NULL,'2026-10-19 02:37:14'),(5,6,'TecnoMax Colombia','Tecnología para estudio, trabajo y diversión con garantía.',NULL,'2026-10-29 23:28:19'),(6,7,'Hogar y Más','Todo para hacer de tu casa un lugar cómodo y acogedor.',NULL,'2026-10-29 23:28:19'),(7,8,'Moda Urbana','Ropa, calzado y accesorios con estilo para todos los días.',NULL,'2026-10-29 23:28:19'),(8,9,'Deportes Pro','Equipos y accesorios para entrenar y practicar tu deporte favorito.',NULL,'2026-10-29 23:28:19'),(9,10,'Mundo Juguetes','Diversión y aprendizaje para los más pequeños de la casa.',NULL,'2026-10-29 23:28:19'),(10,11,'Librería Central','Libros para estudiar, aprender y disfrutar de la lectura.',NULL,'2026-10-29 23:28:19'),(11,12,'Belleza Natural','Cuidado personal y maquillaje para resaltar tu belleza.',NULL,'2026-10-29 23:28:19'),(12,13,'Variedades Express','Mascotas, herramientas, papelería y mucho más en un solo lugar.',NULL,'2026-10-29 23:28:19');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` bigint NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_users_role` (`role_id`),
  CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'vendedor  tester','vendedor@test.com','$2a$10$eY3KnMxj02RRyemCn0Aq0u18w5VMUp/RKm4pKE01hTfA5PJw1.QF6',NULL,2,1,'2026-10-01 02:39:07'),(2,'comprador test','comprador@test.com','$2a$10$ub5wyShkeWRGuD.iL8m33usXvsNqg6hHskSUXe50QYb3BVHgaHmfu',NULL,1,1,'2026-10-01 02:40:24'),(3,'JUAN GABRIEL DIAZ HERNÁNDEZ','diazhernandesjuangabriel@gmail.com','$2a$10$x8Oj6tHx18oqEda80mwkfuX8uQ3ldfdmPWDDE5.t8QIdTi3UnzaDO',NULL,1,1,'2026-10-02 03:45:23'),(4,'Laura Katalina','laka@gmail.com','$2a$10$2Kh4BFEVcPvvhfErmpLNDeGa2DHE6gTwYxL7suJXWUP1nY67HA/hq',NULL,1,1,'2026-10-19 02:23:34'),(5,'usuario1','usuario1@gmail.com','$2a$10$3ONEXNUsAXRuyiL/E208Mu5/dQHkuAPPpEF79SQB4EE3IC.Z1/Yu6',NULL,1,1,'2026-10-19 02:35:56'),(6,'TecnoMax Colombia','tecnomax@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(7,'Hogar y Más','hogarymas@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(8,'Moda Urbana','modaurbana@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(9,'Deportes Pro','deportespro@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(10,'Mundo Juguetes','mundojuguetes@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(11,'Librería Central','libreriacentral@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(12,'Belleza Natural','bellezanatural@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19'),(13,'Variedades Express','variedades@mimercado.com','$2b$10$f0mLnb6QMjOhJ/ayWydSMuKTR12m7iPrQAzOwLY01Fpb4wSlT451u',NULL,1,1,'2026-10-29 23:28:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-04 21:49:06
