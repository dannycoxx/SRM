-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: u5dc
-- ------------------------------------------------------
-- Server version	5.6.34-log

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
-- Table structure for table `Assessment`
--

DROP TABLE IF EXISTS `Assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assessment` (
  `assessId` int(6) NOT NULL AUTO_INCREMENT,
  `moduleCode` varchar(12) NOT NULL,
  `assessType` tinyint(1) NOT NULL,
  `resitType` tinyint(1) NOT NULL,
  `resitArrange` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`assessId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores assessment information for each assessment for each module. Primarily used to create resit letters.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assessment`
--

LOCK TABLES `Assessment` WRITE;
/*!40000 ALTER TABLE `Assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attendance`
--

DROP TABLE IF EXISTS `Attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attendance` (
  `sessionId` int(10) NOT NULL,
  `studentNo` int(10) NOT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores student attendance for each session.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendance`
--

LOCK TABLES `Attendance` WRITE;
/*!40000 ALTER TABLE `Attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `Attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AutoComm`
--

DROP TABLE IF EXISTS `AutoComm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoComm` (
  `commHistId` int(6) NOT NULL,
  `sent` tinyint(1) NOT NULL,
  `dateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of letters/emails that have been or will be automatically sent to a student';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AutoComm`
--

LOCK TABLES `AutoComm` WRITE;
/*!40000 ALTER TABLE `AutoComm` DISABLE KEYS */;
/*!40000 ALTER TABLE `AutoComm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comm`
--

DROP TABLE IF EXISTS `Comm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comm` (
  `commId` int(6) NOT NULL AUTO_INCREMENT,
  `subject` varchar(250) DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`commId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores letter/email templates.\r';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comm`
--

LOCK TABLES `Comm` WRITE;
/*!40000 ALTER TABLE `Comm` DISABLE KEYS */;
/*!40000 ALTER TABLE `Comm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CommHistory`
--

DROP TABLE IF EXISTS `CommHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CommHistory` (
  `commHistId` int(10) NOT NULL,
  `recipient` text NOT NULL,
  `sender` varchar(70) NOT NULL,
  `subject` varchar(70) DEFAULT NULL,
  `body` text,
  `read` tinyint(1) NOT NULL,
  `confidential` tinyint(1) NOT NULL,
  `dateTime` datetime NOT NULL,
  PRIMARY KEY (`commHistId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a history of letters/email that have been sent, as well as who can view communication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CommHistory`
--

LOCK TABLES `CommHistory` WRITE;
/*!40000 ALTER TABLE `CommHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `CommHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Degree`
--

DROP TABLE IF EXISTS `Degree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Degree` (
  `degreeCode` varchar(5) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `length` tinyint(1) NOT NULL,
  PRIMARY KEY (`degreeCode`),
  UNIQUE KEY `degreeCode_UNIQUE` (`degreeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores information regarding degrees that the University of Liverpool offer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Degree`
--

LOCK TABLES `Degree` WRITE;
/*!40000 ALTER TABLE `Degree` DISABLE KEYS */;
/*!40000 ALTER TABLE `Degree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ManModule`
--

DROP TABLE IF EXISTS `ManModule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ManModule` (
  `moduleCode` varchar(12) NOT NULL,
  `degreeCode` varchar(5) NOT NULL,
  `studyLevel` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of mandatory modules for each degree.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ManModule`
--

LOCK TABLES `ManModule` WRITE;
/*!40000 ALTER TABLE `ManModule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ManModule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Marks`
--

DROP TABLE IF EXISTS `Marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Marks` (
  `studentNo` int(10) NOT NULL,
  `assessId` int(6) NOT NULL,
  `attempt` tinyint(1) NOT NULL,
  `mark` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores uploaded marks from spreadsheets for each assessment student completes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Marks`
--

LOCK TABLES `Marks` WRITE;
/*!40000 ALTER TABLE `Marks` DISABLE KEYS */;
/*!40000 ALTER TABLE `Marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MeetingNote`
--

DROP TABLE IF EXISTS `MeetingNote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MeetingNote` (
  `studentNo` int(10) NOT NULL,
  `staffNo` int(5) NOT NULL,
  `content` text NOT NULL,
  `dateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a history of lecturers meeting notes with student.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MeetingNote`
--

LOCK TABLES `MeetingNote` WRITE;
/*!40000 ALTER TABLE `MeetingNote` DISABLE KEYS */;
/*!40000 ALTER TABLE `MeetingNote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Module`
--

DROP TABLE IF EXISTS `Module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Module` (
  `moduleCode` varchar(12) NOT NULL,
  `title` varchar(100) NOT NULL,
  `coordinator` varchar(70) NOT NULL,
  `academicYear` varchar(9) NOT NULL,
  `studyLevel` tinyint(1) NOT NULL,
  `semester` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `replacement` varchar(12) DEFAULT NULL,
  `credit` float(6,2) NOT NULL,
  PRIMARY KEY (`moduleCode`),
  UNIQUE KEY `moduleCode_UNIQUE` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores module information for each module.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Module`
--

LOCK TABLES `Module` WRITE;
/*!40000 ALTER TABLE `Module` DISABLE KEYS */;
/*!40000 ALTER TABLE `Module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registration`
--

DROP TABLE IF EXISTS `Registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registration` (
  `studentNo` int(10) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `yearStudy` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores information about what module student is registered on. ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registration`
--

LOCK TABLES `Registration` WRITE;
/*!40000 ALTER TABLE `Registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `Registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Request`
--

DROP TABLE IF EXISTS `Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Request` (
  `requestId` int(6) NOT NULL AUTO_INCREMENT,
  `requester` varchar(70) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`requestId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores current and past access requests to view confidential student information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Request`
--

LOCK TABLES `Request` WRITE;
/*!40000 ALTER TABLE `Request` DISABLE KEYS */;
/*!40000 ALTER TABLE `Request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Session`
--

DROP TABLE IF EXISTS `Session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Session` (
  `sessionId` int(10) NOT NULL AUTO_INCREMENT,
  `moduleCode` varchar(12) NOT NULL,
  `count` int(3) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of sessions for each module, such as lectures, labs and tutorials.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Session`
--

LOCK TABLES `Session` WRITE;
/*!40000 ALTER TABLE `Session` DISABLE KEYS */;
/*!40000 ALTER TABLE `Session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `staffNo` int(5) NOT NULL AUTO_INCREMENT,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `mwsUser` varchar(10) NOT NULL,
  `csdUser` varchar(5) DEFAULT NULL,
  `mwsPassword` varchar(70) NOT NULL,
  `csdPassword` varchar(70) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `address` varchar(160) NOT NULL,
  `phone` varchar(14) NOT NULL,
  PRIMARY KEY (`staffNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores all information about staff.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `studentNo` int(10) NOT NULL AUTO_INCREMENT,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `mwsUser` varchar(10) NOT NULL,
  `csdUser` varchar(5) DEFAULT NULL,
  `mwsPassword` varchar(70) NOT NULL,
  `csdPassword` varchar(70) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `perfEmail` varchar(70) DEFAULT NULL,
  `permAddress` varchar(160) NOT NULL,
  `termAddress` varchar(160) DEFAULT NULL,
  `phone` varchar(14) NOT NULL,
  `termPhone` varchar(14) DEFAULT NULL,
  `advisor` varchar(70) NOT NULL,
  `degreeCode` varchar(5) NOT NULL,
  `yearStudy` tinyint(1) NOT NULL,
  `admitYear` varchar(9) NOT NULL,
  PRIMARY KEY (`studentNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Personal information about a student.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (1,'Daniel','Jones','sgdjones2','u5dj2','a','b','d.jones2@student.liverpool.ac.uk','jones123@gmail.com','131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom','131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom','4.47812E+11','4.47812E+11','m.harris@liverpool.ac.uk','G502',2,'2016-17'),(2,'Olivia','Smith','sgosmith','u5os','a','b','o.smith@student.liverpool.ac.uk','o.smith@student.liverpool.ac.uk','2,Oaktree Close,Tarporley,Tarporley,Cheshire West and Chester,England,CW6 0TZ,United Kingdom','23A,Maristow Street,Westbury,Westbury,Wiltshire,England,BA13 3DN,United Kingdom','4.47718E+11','4.41515E+11','b.mixton@liverpool.ac.uk','G520',1,'2017-18'),(3,'Smithy','Jones','sgsjones','u4sj3','a','b','s.jones3@student.liverpool.ac.uk','s.jones3@student.liverpool.ac.uk','89,Okehampton Crescent,Welling,Welling,Greater London,England,DA16 1DQ,United Kingdom','9,Glebe Road,Skelmersdale,Skelmersdale,,Lancashire,England,WN8 9JP,United Kingdom','4.47993E+11','4.47993E+11','j.argyle@liverpool.ac.uk','G501',2,'2015-16');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-04 21:25:50
