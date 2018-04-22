-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: u5dc
-- ------------------------------------------------------
-- Server version	5.6.38-log

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='Stores assessment information for each assessment for each module. Primarily used to create resit letters.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assessment`
--

LOCK TABLES `Assessment` WRITE;
/*!40000 ALTER TABLE `Assessment` DISABLE KEYS */;
INSERT INTO `Assessment` VALUES (1,'COMP201',0,2,'Attend lab based resit exam'),(2,'COMP201',0,2,'Attend lab based resit exam'),(3,'COMP205',1,0,''),(4,'COMP219',0,1,'Resit exam'),(5,'COMP110',0,2,'Complete final report.'),(6,'COMP110',0,2,'Complete final report.'),(7,'COMP110',0,2,'Complete final report.'),(8,'COMP110',0,2,'Complete final report.'),(9,'',0,0,''),(10,'',0,0,''),(11,'',0,0,'');
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
INSERT INTO `Attendance` VALUES (1,1,'1'),(1,3,'0'),(2,1,'1'),(2,3,'1'),(3,1,'1'),(3,3,'F'),(4,1,'X'),(4,3,'1'),(5,1,'F'),(5,3,'1'),(6,1,'0'),(6,3,'1'),(7,1,'1'),(7,3,'1'),(8,1,'0'),(8,3,'1'),(9,1,'0'),(9,3,'X'),(10,1,'1'),(10,3,'X'),(11,1,'1'),(11,2,'1'),(12,1,'1'),(12,2,'0'),(13,1,'0'),(13,2,'1'),(14,2,'1'),(15,2,'X'),(16,2,'X');
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
INSERT INTO `AutoComm` VALUES (9,1,'0000-00-00 00:00:00'),(10,0,'2014-03-19 23:59:59'),(11,0,'2014-08-19 11:31:12');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Stores letter/email templates.\r';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comm`
--

LOCK TABLES `Comm` WRITE;
/*!40000 ALTER TABLE `Comm` DISABLE KEYS */;
INSERT INTO `Comm` VALUES (1,' Poor Engagement with Studies','The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.'),(2,' Re-Sit of Failed Modules','\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.');
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
INSERT INTO `CommHistory` VALUES (1,'d.jones2@student.liverpool.ac.uk','m.harris@liverpool.ac.uk','Lecture Feedback','Hello there \\n\\nI think your lectures are great.\\n\\nThanks.',0,0,'2014-03-19 23:59:59'),(2,'d.jones2@student.liverpool.ac.uk','o.smith@student.liverpool.ac.uk','Lecture Week 13','Hey \\n\\nI think your lectures are great.\\n\\nThanks.',0,1,'2014-08-19 11:31:12'),(3,'o.smith@student.liverpool.ac.uk','m.harris@liverpool.ac.uk','Feedback','Hello there \\n\\nI think your lectures are great.\\n\\nCheers.',1,1,'2014-08-19 11:31:13'),(4,'o.smith@student.liverpool.ac.uk','b.mixton@liverpool.ac.uk','RE: Assignment','The assignment was done very well',1,0,'2017-08-01 11:31:00'),(5,'m.harris@liverpool.ac.uk','f.thomas@liverpool.ac.uk','Class test Feedback','27.658% was gained',1,1,'2017-08-01 13:31:00'),(6,'o.smith@student.liverpool.ac.uk','b.mixton@liverpool.ac.uk','','www.google.co.uk',1,0,'2017-08-01 11:39:00'),(7,'s.jones3@student.liverpool.ac.uk','j.argyle@liverpool.ac.uk','Email test','',0,0,'2014-08-19 11:31:17'),(8,'b.mixton@liverpool.ac.uk','j.argyle@liverpool.ac.uk','Lecture 12 cancelled','',1,0,'2014-08-19 11:31:18'),(9,'d.jones2@student.liverpool.ac.uk','csoffice@liverpool.ac.uk','Poor Engagement with Studies','I have noticed that you have missed quite a few sessions in the last two weeks, if there is any other reason that you cannot make them, you will need to come and complete another absence form for us to be able to excuse you from the sessions as there is quite a few. ',1,0,'2017-11-27 18:15:00'),(10,'o.smith@student.liverpool.ac.uk','csoffice@liverpool.ac.uk','Poor Engagement with Studies','I have noticed that you have missed quite a few sessions in the last two weeks, if there is any other reason that you cannot make them, you will need to come and complete another absence form for us to be able to excuse you from the sessions as there is quite a few. ',0,0,'2017-11-28 18:15:00'),(11,'s.jones3@student.liverpool.ac.uk','csoffice@liverpool.ac.uk','Re-Sit of Failed modules','The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit <b>all</b> assessments listed below.',0,1,'2017-11-29 18:15:00');
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
INSERT INTO `ManModule` VALUES ('COMP101','G502',1),('COMP101','G501',1),('COMP101','G503',1),('COMP110','G502',1),('COMP110','G520',1),('COMP110','G501',1),('COMP110','G503',1),('COMP119','G502',1),('COMP119','G501',1),('COMP119','G503',1),('COMP201','G502',2),('COMP201','G501',2),('COMP201','G503',2),('COMP304','G520',3),('COMP304','G503',4),('','',0);
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
INSERT INTO `Marks` VALUES (1,5,1,25),(1,6,1,40),(1,7,1,45),(1,8,1,30);
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
INSERT INTO `MeetingNote` VALUES (1,1,'Previous incidient regarding seating arrangements at 10/11/2017 lecture has now been sorted.','2017-11-21 14:39:00'),(1,1,'Student is displeased about seating arrangements at 10/11/2017 lecture.','2017-11-16 09:21:00'),(3,3,'Student unhappy with their extenuating circumstances.','2016-12-02 11:31:00');
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
INSERT INTO `Module` VALUES ('COMP101','Foundations of Programming','z.chindu@liverpool.ac.uk','1',1,2,1,'',15.00),('COMP110','Professional Skills in Computing','b.maddison@liverpool.ac.uk','1',1,1,0,'COMP119',15.00),('COMP119','Algorithmic Foundations','j.argyle@liverpool.ac.uk','1',1,2,1,'',7.50),('COMP201','Database Development','m.harris@liverpool.ac.uk','2',2,1,1,'',7.50),('COMP205','Internet Principles','m.harris@liverpool.ac.uk','2',2,1,1,'',7.50),('COMP219','C++ Development','b.mixton@liverpool.ac.uk','2',2,2,1,'',15.00),('COMP304','Knowledge Representation and Reasoning','j.argyle@liverpool.ac.uk','3',3,2,1,'',15.00),('COMP305','Biocomputation','b.mixton@liverpool.ac.uk','3',3,2,1,'',7.50);
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
INSERT INTO `Registration` VALUES (1,'COMP201',2,1),(1,'COMP205',2,1),(1,'COMP219',2,1),(1,'COMP101',2,1),(1,'COMP110',1,0),(1,'COMP119',1,0),(2,'COMP101',1,1),(2,'COMP110',1,1),(2,'COMP119',1,1),(3,'COMP201',2,1),(3,'COMP205',2,1),(3,'COMP219',2,1),(3,'COMP101',1,0),(3,'COMP110',1,0),(3,'COMP119',1,0);
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
  `student` varchar(70) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `dateTime` datetime NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`requestId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='Stores current and past access requests to view confidential student information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Request`
--

LOCK TABLES `Request` WRITE;
/*!40000 ALTER TABLE `Request` DISABLE KEYS */;
INSERT INTO `Request` VALUES (1,'m.harris@liverpool.ac.uk','o.smith@student.liverpool.ac.uk','Request to View Confidentials','','2017-05-26 15:02:00',0),(2,'b.mixton@liverpool.ac.uk','d.jones2@student.liverpool.ac.uk','Request to View Confidentials','I need to view student information.','2017-05-27 18:02:00',0),(3,'b.mixton@liverpool.ac.uk','s.jones3@student.liverpool.ac.uk','Request to View Confidentials','Please accept request, it is a matter of urgency.','2017-05-28 15:52:00',0),(4,'m.harris@liverpool.ac.uk','s.jones3@student.liverpool.ac.uk','Request to View Confidentials','I need to view this student\'s confidential information.','2017-05-29 15:52:00',0),(5,'j.argyle@liverpool.ac.uk','d.jones2@student.liverpool.ac.uk','Request to View Confidentials','I need to view this student\'s confidential information.','2017-05-29 15:02:00',0),(6,'j.argyle@liverpool.ac.uk','o.smith@student.liverpool.ac.uk','Request to View Confidentials','I need to view this student\'s confidential information.','2017-05-30 15:02:00',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='Stores a list of sessions for each module, such as lectures, labs and tutorials.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Session`
--

LOCK TABLES `Session` WRITE;
/*!40000 ALTER TABLE `Session` DISABLE KEYS */;
INSERT INTO `Session` VALUES (1,'COMP201',1,'2016-10-08','11:00:00',''),(2,'COMP201',2,'2016-10-08','14:00:00',''),(3,'COMP201',3,'2016-10-08','11:00:00','1'),(4,'COMP201',4,'2016-10-08','14:00:00',''),(5,'COMP205',1,'2016-10-08','09:00:00',''),(6,'COMP205',2,'2016-10-08','09:00:00','1'),(7,'COMP205',3,'2016-10-08','09:05:00',''),(8,'COMP219',1,'2016-10-08','10:00:00',''),(9,'COMP219',2,'2016-10-08','11:00:00',''),(10,'COMP219',3,'2016-10-08','12:00:00',''),(11,'COMP101',1,'2016-10-08','14:00:00',''),(12,'COMP101',2,'2016-10-08','15:00:00',''),(13,'COMP101',3,'2016-10-08','16:00:00','1'),(14,'COMP110',1,'2016-10-08','10:00:00',''),(15,'COMP110',2,'2016-10-09','11:00:00','1'),(16,'COMP110',3,'2016-10-10','12:00:00','');
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
  `userType` char(2) NOT NULL,
  PRIMARY KEY (`staffNo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Stores all information about staff.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (1,'Martin','Harris','sgmharris','s1mh','a','b','m.harris@liverpool.ac.uk','15,Hockley Court,Marston Moretaine,Bedford,,Central Bedfordshire,England,MK43 0GD,United Kingdom','078451324751','L'),(2,'Brian','Mixton','sgbmixton','s1bm3','b','b','b.mixton@liverpool.ac.uk','6,Fron Hyfryd,Dyffryn Ardudwy,Dyffryn Ardudwy,,Gwynedd,Wales,LL44 2DH,United Kingdom','078451324751','L'),(3,'Jenny','Argyle','sgjargyle1','s1ja1','c','b','j.argyle@liverpool.ac.uk','41,Dumbarton Road,London,London,,Greater London,England,SW2 5LX,United Kingdom','078451324751','L'),(4,'Irene','Bickerstaffe','sgibicker','s2ib','d','b','i.bickerstaffee@liverpool.ac.uk','102,Leeds Road,Methley,Leeds,,West Yorkshire,England,LS26 9EP,United Kingdom','078451324751','OA'),(5,'Hilton','Silver','sghsilver','s3hs','e','b','h.silver@liverpool.ac.uk','3,The Terrace,Harrowbarrow,Callington,,Cornwall,England,PL17 8JP,United Kingdom','078451324751','SA');
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

-- Dump completed on 2018-02-17 22:15:02
