# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.16)
# Database: ssm-crud
# Generation Time: 2018-11-15 14:19:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table tbl_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_dept`;

CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tbl_dept` WRITE;
/*!40000 ALTER TABLE `tbl_dept` DISABLE KEYS */;

INSERT INTO `tbl_dept` (`dept_id`, `dept_name`)
VALUES
	(1,'开发部'),
	(2,'测试部');

/*!40000 ALTER TABLE `tbl_dept` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tbl_emp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tbl_emp`;

CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(128) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_emp_dept` (`d_id`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tbl_emp` WRITE;
/*!40000 ALTER TABLE `tbl_emp` DISABLE KEYS */;

INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`)
VALUES
	(1,'Jerry','M','Jerry@atguigu.com',1),
	(2,'4291e0','F','4291e0@atguigu.com',2),
	(3,'a50311','M','a50311@atguigu.com',1),
	(4,'243a92','M','243a92@atguigu.com',2),
	(5,'649e73','F','321e73@atguigu.com',1),
	(6,'2f6484','M','2f6484@atguigu.com',1),
	(7,'c29655','M','c29655@atguigu.com',1),
	(8,'121026','M','121026@atguigu.com',1),
	(9,'8d9e57','M','8d9e57@atguigu.com',1),
	(10,'36dd58','M','36dd58@atguigu.com',1),
	(11,'74abf9','M','74abf9@atguigu.com',1),
	(12,'d79c810','M','d79c810@atguigu.com',1),
	(13,'6978711','M','6978711@atguigu.com',1),
	(14,'a978512','M','a978512@atguigu.com',1),
	(15,'92ebf13','M','92ebf13@atguigu.com',1),
	(16,'95bf714','M','95bf714@atguigu.com',1),
	(17,'2075415','M','2075415@atguigu.com',1),
	(18,'24c9516','M','24c9516@atguigu.com',1),
	(19,'7c4e217','M','7c4e217@atguigu.com',1),
	(20,'2c21118','M','2c21118@atguigu.com',1),
	(21,'00a6119','M','00a6119@atguigu.com',1),
	(22,'d998b20','M','d998b20@atguigu.com',1),
	(23,'7406921','M','7406921@atguigu.com',1),
	(24,'d3c0822','M','d3c0822@atguigu.com',1),
	(25,'614fa23','M','614fa23@atguigu.com',1),
	(26,'ec8ea24','M','ec8ea24@atguigu.com',1),
	(27,'0c3f825','M','0c3f825@atguigu.com',1),
	(28,'c2c1926','M','c2c1926@atguigu.com',1),
	(29,'f079227','M','f079227@atguigu.com',1),
	(30,'9b11228','M','9b11228@atguigu.com',1),
	(31,'sdf','F','hl@163.com',2),
	(32,'asd','F','bbb@163.com',1),
	(33,'asd','F','hl@123.com',1),
	(34,'me','F','hl@173.com',1),
	(35,'商店','F','hl@17.com',1),
	(36,'商店','M','hl',1),
	(37,'empName','M','hl',1),
	(38,'empName','M','hl',1),
	(39,'e','M','hl',1),
	(40,'e','M','sd@16.com',1),
	(41,'1','M','hl@163.com',1),
	(42,'1','M','hl@163.com',1),
	(43,'s','F','hl@163.com',1),
	(44,'12','M','hl',1),
	(45,'epmpsdmf','M','hl',1);

/*!40000 ALTER TABLE `tbl_emp` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
