-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2018 at 10:35 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `srm`
--
CREATE DATABASE IF NOT EXISTS `srm` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `srm`;

-- --------------------------------------------------------

--
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
CREATE TABLE `assessment` (
  `assessId` int(6) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `assessType` tinyint(1) NOT NULL,
  `resitType` tinyint(1) NOT NULL,
  `resitArrange` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores assessment information for each assessment for each module. Primarily used to create resit letters.';

--
-- Truncate table before insert `assessment`
--

TRUNCATE TABLE `assessment`;
--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`assessId`, `moduleCode`, `assessType`, `resitType`, `resitArrange`) VALUES
(1, 'COMP201', 0, 2, 'Attend lab based resit exam'),
(2, 'COMP201', 0, 2, 'Attend lab based resit exam'),
(3, 'COMP205', 1, 0, ''),
(4, 'COMP219', 0, 1, 'Resit exam'),
(5, 'COMP110', 0, 2, 'Complete final report.'),
(6, 'COMP110', 0, 2, 'Complete final report.'),
(7, 'COMP110', 0, 2, 'Complete final report.'),
(8, 'COMP110', 0, 2, 'Complete final report.'),
(9, '', 0, 0, ''),
(10, '', 0, 0, ''),
(11, '', 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `sessionId` int(10) NOT NULL,
  `studentNo` int(10) NOT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores student attendance for each session.';

--
-- Truncate table before insert `attendance`
--

TRUNCATE TABLE `attendance`;
--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`sessionId`, `studentNo`, `status`) VALUES
(1, 1, '1'),
(1, 3, '0'),
(2, 1, '1'),
(2, 3, '1'),
(3, 1, '1'),
(3, 3, 'F'),
(4, 1, 'X'),
(4, 3, '1'),
(5, 1, 'F'),
(5, 3, '1'),
(6, 1, '0'),
(6, 3, '1'),
(7, 1, '1'),
(7, 3, '1'),
(8, 1, '0'),
(8, 3, '1'),
(9, 1, '0'),
(9, 3, 'X'),
(10, 1, '1'),
(10, 3, 'X'),
(11, 1, '1'),
(11, 2, '1'),
(12, 1, '1'),
(12, 2, '0'),
(13, 1, '0'),
(13, 2, '1'),
(14, 2, '1'),
(15, 2, 'X'),
(16, 2, 'X');

-- --------------------------------------------------------

--
-- Table structure for table `autocomm`
--

DROP TABLE IF EXISTS `autocomm`;
CREATE TABLE `autocomm` (
  `commHistId` int(6) NOT NULL,
  `sent` tinyint(1) NOT NULL,
  `dateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of letters/emails that have been or will be automatically sent to a student';

--
-- Truncate table before insert `autocomm`
--

TRUNCATE TABLE `autocomm`;
--
-- Dumping data for table `autocomm`
--

INSERT INTO `autocomm` (`commHistId`, `sent`, `dateTime`) VALUES
(9, 1, '0000-00-00 00:00:00'),
(10, 0, '2014-03-19 23:59:59'),
(11, 0, '2014-08-19 11:31:12');

-- --------------------------------------------------------

--
-- Table structure for table `comm`
--

DROP TABLE IF EXISTS `comm`;
CREATE TABLE `comm` (
  `commId` int(6) NOT NULL,
  `subject` varchar(250) DEFAULT NULL,
  `body` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores letter/email templates.\r';

--
-- Truncate table before insert `comm`
--

TRUNCATE TABLE `comm`;
--
-- Dumping data for table `comm`
--

INSERT INTO `comm` (`commId`, `subject`, `body`) VALUES
(1, ' Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.'),
(2, ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.');

-- --------------------------------------------------------

--
-- Table structure for table `commhistory`
--

DROP TABLE IF EXISTS `commhistory`;
CREATE TABLE `commhistory` (
  `commHistId` int(10) NOT NULL,
  `recipient` text NOT NULL,
  `sender` varchar(70) NOT NULL,
  `subject` varchar(70) DEFAULT NULL,
  `body` text,
  `read` tinyint(1) NOT NULL,
  `confidential` tinyint(1) NOT NULL,
  `dateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a history of letters/email that have been sent, as well as who can view communication.';

--
-- Truncate table before insert `commhistory`
--

TRUNCATE TABLE `commhistory`;
--
-- Dumping data for table `commhistory`
--

INSERT INTO `commhistory` (`commHistId`, `recipient`, `sender`, `subject`, `body`, `read`, `confidential`, `dateTime`) VALUES
(1, 'd.jones2@student.liverpool.ac.uk', 'm.harris@liverpool.ac.uk', 'Lecture Feedback', 'Hello there \\n\\nI think your lectures are great.\\n\\nThanks.', 0, 0, '2014-03-19 23:59:59'),
(2, 'd.jones2@student.liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Lecture Week 13', 'Hey \\n\\nI think your lectures are great.\\n\\nThanks.', 0, 1, '2014-08-19 11:31:12'),
(3, 'o.smith@student.liverpool.ac.uk', 'm.harris@liverpool.ac.uk', 'Feedback', 'Hello there \\n\\nI think your lectures are great.\\n\\nCheers.', 1, 1, '2014-08-19 11:31:13'),
(4, 'o.smith@student.liverpool.ac.uk', 'b.mixton@liverpool.ac.uk', 'RE: Assignment', 'The assignment was done very well', 1, 0, '2017-08-01 11:31:00'),
(5, 'm.harris@liverpool.ac.uk', 'f.thomas@liverpool.ac.uk', 'Class test Feedback', '27.658% was gained', 1, 1, '2017-08-01 13:31:00'),
(6, 'o.smith@student.liverpool.ac.uk', 'b.mixton@liverpool.ac.uk', '', 'www.google.co.uk', 1, 0, '2017-08-01 11:39:00'),
(7, 's.jones3@student.liverpool.ac.uk', 'j.argyle@liverpool.ac.uk', 'Email test', '', 0, 0, '2014-08-19 11:31:17'),
(8, 'b.mixton@liverpool.ac.uk', 'j.argyle@liverpool.ac.uk', 'Lecture 12 cancelled', '', 1, 0, '2014-08-19 11:31:18'),
(9, 'd.jones2@student.liverpool.ac.uk', 'csoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'I have noticed that you have missed quite a few sessions in the last two weeks, if there is any other reason that you cannot make them, you will need to come and complete another absence form for us to be able to excuse you from the sessions as there is quite a few. ', 1, 0, '2017-11-27 18:15:00'),
(10, 'o.smith@student.liverpool.ac.uk', 'csoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'I have noticed that you have missed quite a few sessions in the last two weeks, if there is any other reason that you cannot make them, you will need to come and complete another absence form for us to be able to excuse you from the sessions as there is quite a few. ', 0, 0, '2017-11-28 18:15:00'),
(11, 's.jones3@student.liverpool.ac.uk', 'csoffice@liverpool.ac.uk', 'Re-Sit of Failed modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit <b>all</b> assessments listed below.', 0, 1, '2017-11-29 18:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `degree`
--

DROP TABLE IF EXISTS `degree`;
CREATE TABLE `degree` (
  `degreeCode` varchar(5) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `length` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores information regarding degrees that the University of Liverpool offer.';

--
-- Truncate table before insert `degree`
--

TRUNCATE TABLE `degree`;
-- --------------------------------------------------------

--
-- Table structure for table `manmodule`
--

DROP TABLE IF EXISTS `manmodule`;
CREATE TABLE `manmodule` (
  `moduleCode` varchar(12) NOT NULL,
  `degreeCode` varchar(5) NOT NULL,
  `studyLevel` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of mandatory modules for each degree.';

--
-- Truncate table before insert `manmodule`
--

TRUNCATE TABLE `manmodule`;
--
-- Dumping data for table `manmodule`
--

INSERT INTO `manmodule` (`moduleCode`, `degreeCode`, `studyLevel`) VALUES
('COMP101', 'G502', 1),
('COMP101', 'G501', 1),
('COMP101', 'G503', 1),
('COMP110', 'G502', 1),
('COMP110', 'G520', 1),
('COMP110', 'G501', 1),
('COMP110', 'G503', 1),
('COMP119', 'G502', 1),
('COMP119', 'G501', 1),
('COMP119', 'G503', 1),
('COMP201', 'G502', 2),
('COMP201', 'G501', 2),
('COMP201', 'G503', 2),
('COMP304', 'G520', 3),
('COMP304', 'G503', 4),
('', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

DROP TABLE IF EXISTS `marks`;
CREATE TABLE `marks` (
  `studentNo` int(10) NOT NULL,
  `assessId` int(6) NOT NULL,
  `attempt` tinyint(1) NOT NULL,
  `mark` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores uploaded marks from spreadsheets for each assessment student completes.';

--
-- Truncate table before insert `marks`
--

TRUNCATE TABLE `marks`;
--
-- Dumping data for table `marks`
--

INSERT INTO `marks` (`studentNo`, `assessId`, `attempt`, `mark`) VALUES
(1, 5, 1, 25),
(1, 6, 1, 40),
(1, 7, 1, 45),
(1, 8, 1, 30);

-- --------------------------------------------------------

--
-- Table structure for table `meetingnote`
--

DROP TABLE IF EXISTS `meetingnote`;
CREATE TABLE `meetingnote` (
  `studentNo` int(10) NOT NULL,
  `staffNo` int(5) NOT NULL,
  `content` text NOT NULL,
  `dateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a history of lecturers meeting notes with student.';

--
-- Truncate table before insert `meetingnote`
--

TRUNCATE TABLE `meetingnote`;
--
-- Dumping data for table `meetingnote`
--

INSERT INTO `meetingnote` (`studentNo`, `staffNo`, `content`, `dateTime`) VALUES
(1, 1, 'Previous incidient regarding seating arrangements at 10/11/2017 lecture has now been sorted.', '2017-11-21 14:39:00'),
(1, 1, 'Student is displeased about seating arrangements at 10/11/2017 lecture.', '2017-11-16 09:21:00'),
(3, 3, 'Student unhappy with their extenuating circumstances.', '2016-12-02 11:31:00');

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `moduleCode` varchar(12) NOT NULL,
  `title` varchar(100) NOT NULL,
  `coordinator` varchar(70) NOT NULL,
  `academicYear` varchar(9) NOT NULL,
  `studyLevel` tinyint(1) NOT NULL,
  `semester` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `replacement` varchar(12) DEFAULT NULL,
  `credit` float(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores module information for each module.';

--
-- Truncate table before insert `module`
--

TRUNCATE TABLE `module`;
--
-- Dumping data for table `module`
--

INSERT INTO `module` (`moduleCode`, `title`, `coordinator`, `academicYear`, `studyLevel`, `semester`, `active`, `replacement`, `credit`) VALUES
('COMP101', 'Foundations of Programming', 'z.chindu@liverpool.ac.uk', '1', 1, 2, 1, '', 15.00),
('COMP110', 'Professional Skills in Computing', 'b.maddison@liverpool.ac.uk', '1', 1, 1, 0, 'COMP119', 15.00),
('COMP119', 'Algorithmic Foundations', 'j.argyle@liverpool.ac.uk', '1', 1, 2, 1, '', 7.50),
('COMP201', 'Database Development', 'm.harris@liverpool.ac.uk', '2', 2, 1, 1, '', 7.50),
('COMP205', 'Internet Principles', 'm.harris@liverpool.ac.uk', '2', 2, 1, 1, '', 7.50),
('COMP219', 'C++ Development', 'b.mixton@liverpool.ac.uk', '2', 2, 2, 1, '', 15.00),
('COMP304', 'Knowledge Representation and Reasoning', 'j.argyle@liverpool.ac.uk', '3', 3, 2, 1, '', 15.00),
('COMP305', 'Biocomputation', 'b.mixton@liverpool.ac.uk', '3', 3, 2, 1, '', 7.50);

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration` (
  `studentNo` int(10) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `yearStudy` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores information about what module student is registered on. ';

--
-- Truncate table before insert `registration`
--

TRUNCATE TABLE `registration`;
--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`studentNo`, `moduleCode`, `yearStudy`, `status`) VALUES
(1, 'COMP201', 2, 1),
(1, 'COMP205', 2, 1),
(1, 'COMP219', 2, 1),
(1, 'COMP101', 2, 1),
(1, 'COMP110', 1, 0),
(1, 'COMP119', 1, 0),
(2, 'COMP101', 1, 1),
(2, 'COMP110', 1, 1),
(2, 'COMP119', 1, 1),
(3, 'COMP201', 2, 1),
(3, 'COMP205', 2, 1),
(3, 'COMP219', 2, 1),
(3, 'COMP101', 1, 0),
(3, 'COMP110', 1, 0),
(3, 'COMP119', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `requestId` int(6) NOT NULL,
  `requester` varchar(70) NOT NULL,
  `student` varchar(70) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `dateTime` datetime NOT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores current and past access requests to view confidential student information.';

--
-- Truncate table before insert `request`
--

TRUNCATE TABLE `request`;
--
-- Dumping data for table `request`
--

INSERT INTO `request` (`requestId`, `requester`, `student`, `title`, `description`, `dateTime`, `status`) VALUES
(1, 'm.harris@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', '', '2017-05-26 15:02:00', 0),
(2, 'b.mixton@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view student information.', '2017-05-27 18:02:00', 0),
(3, 'b.mixton@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'Please accept request, it is a matter of urgency.', '2017-05-28 15:52:00', 0),
(4, 'm.harris@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:52:00', 0),
(5, 'j.argyle@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:02:00', 0),
(6, 'j.argyle@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-30 15:02:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `sessionId` int(10) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `count` int(3) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of sessions for each module, such as lectures, labs and tutorials.';

--
-- Truncate table before insert `session`
--

TRUNCATE TABLE `session`;
--
-- Dumping data for table `session`
--

INSERT INTO `session` (`sessionId`, `moduleCode`, `count`, `date`, `time`, `status`) VALUES
(1, 'COMP201', 1, '2016-10-08', '11:00:00', ''),
(2, 'COMP201', 2, '2016-10-08', '14:00:00', ''),
(3, 'COMP201', 3, '2016-10-08', '11:00:00', '1'),
(4, 'COMP201', 4, '2016-10-08', '14:00:00', ''),
(5, 'COMP205', 1, '2016-10-08', '09:00:00', ''),
(6, 'COMP205', 2, '2016-10-08', '09:00:00', '1'),
(7, 'COMP205', 3, '2016-10-08', '09:05:00', ''),
(8, 'COMP219', 1, '2016-10-08', '10:00:00', ''),
(9, 'COMP219', 2, '2016-10-08', '11:00:00', ''),
(10, 'COMP219', 3, '2016-10-08', '12:00:00', ''),
(11, 'COMP101', 1, '2016-10-08', '14:00:00', ''),
(12, 'COMP101', 2, '2016-10-08', '15:00:00', ''),
(13, 'COMP101', 3, '2016-10-08', '16:00:00', '1'),
(14, 'COMP110', 1, '2016-10-08', '10:00:00', ''),
(15, 'COMP110', 2, '2016-10-09', '11:00:00', '1'),
(16, 'COMP110', 3, '2016-10-10', '12:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staffNo` int(5) NOT NULL,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `mwsUser` varchar(10) NOT NULL,
  `csdUser` varchar(5) DEFAULT NULL,
  `mwsPassword` varchar(70) NOT NULL,
  `csdPassword` varchar(70) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `address` varchar(160) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `userType` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores all information about staff.';

--
-- Truncate table before insert `staff`
--

TRUNCATE TABLE `staff`;
--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffNo`, `forename`, `surname`, `mwsUser`, `csdUser`, `mwsPassword`, `csdPassword`, `email`, `address`, `phone`, `userType`) VALUES
(1, 'Martin', 'Harris', 'sgmharris', 's1mh', 'a', 'b', 'm.harris@liverpool.ac.uk', '15,Hockley Court,Marston Moretaine,Bedford,,Central Bedfordshire,England,MK43 0GD,United Kingdom', '078451324751', 'L'),
(2, 'Brian', 'Mixton', 'sgbmixton', 's1bm3', 'b', 'b', 'b.mixton@liverpool.ac.uk', '6,Fron Hyfryd,Dyffryn Ardudwy,Dyffryn Ardudwy,,Gwynedd,Wales,LL44 2DH,United Kingdom', '078451324751', 'L'),
(3, 'Jenny', 'Argyle', 'sgjargyle1', 's1ja1', 'c', 'b', 'j.argyle@liverpool.ac.uk', '41,Dumbarton Road,London,London,,Greater London,England,SW2 5LX,United Kingdom', '078451324751', 'L'),
(4, 'Irene', 'Bickerstaffe', 'sgibicker', 's2ib', 'd', 'b', 'i.bickerstaffee@liverpool.ac.uk', '102,Leeds Road,Methley,Leeds,,West Yorkshire,England,LS26 9EP,United Kingdom', '078451324751', 'OA'),
(5, 'Hilton', 'Silver', 'sghsilver', 's3hs', 'e', 'b', 'h.silver@liverpool.ac.uk', '3,The Terrace,Harrowbarrow,Callington,,Cornwall,England,PL17 8JP,United Kingdom', '078451324751', 'SA');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentNo` int(10) NOT NULL,
  `forename` varchar(35) NOT NULL,
  `surname` varchar(35) NOT NULL,
  `mwsUser` varchar(10) NOT NULL,
  `csdUser` varchar(5) DEFAULT NULL,
  `mwsPassword` varchar(70) NOT NULL,
  `csdPassword` varchar(70) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `prefEmail` varchar(70) DEFAULT NULL,
  `permAddress` varchar(160) NOT NULL,
  `termAddress` varchar(160) DEFAULT NULL,
  `phone` varchar(14) NOT NULL,
  `termPhone` varchar(14) DEFAULT NULL,
  `advisor` varchar(70) NOT NULL,
  `degreeCode` varchar(5) NOT NULL,
  `yearStudy` tinyint(1) NOT NULL,
  `admitYear` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Personal information about a student.';

--
-- Truncate table before insert `student`
--

TRUNCATE TABLE `student`;
--
-- Dumping data for table `student`
--

INSERT INTO `student` (`studentNo`, `forename`, `surname`, `mwsUser`, `csdUser`, `mwsPassword`, `csdPassword`, `email`, `prefEmail`, `permAddress`, `termAddress`, `phone`, `termPhone`, `advisor`, `degreeCode`, `yearStudy`, `admitYear`) VALUES
(1, 'Daniel', 'Jones', 'sgdjones2', 'u5dj2', 'a', 'b', 'd.jones2@student.liverpool.ac.uk', 'jones123@gmail.com', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '4.47812E+11', '4.47812E+11', 'm.harris@liverpool.ac.uk', 'G502', 2, '2016-17'),
(2, 'Olivia', 'Smith', 'sgosmith', 'u5os', 'a', 'b', 'o.smith@student.liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', '2,Oaktree Close,Tarporley,Tarporley,Cheshire West and Chester,England,CW6 0TZ,United Kingdom', '23A,Maristow Street,Westbury,Westbury,Wiltshire,England,BA13 3DN,United Kingdom', '4.47718E+11', '4.41515E+11', 'b.mixton@liverpool.ac.uk', 'G520', 1, '2017-18'),
(3, 'Smithy', 'Jones', 'sgsjones', 'u4sj3', 'a', 'b', 's.jones3@student.liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', '89,Okehampton Crescent,Welling,Welling,Greater London,England,DA16 1DQ,United Kingdom', '9,Glebe Road,Skelmersdale,Skelmersdale,,Lancashire,England,WN8 9JP,United Kingdom', '4.47993E+11', '4.47993E+11', 'j.argyle@liverpool.ac.uk', 'G501', 2, '2015-16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`assessId`);

--
-- Indexes for table `comm`
--
ALTER TABLE `comm`
  ADD PRIMARY KEY (`commId`);

--
-- Indexes for table `commhistory`
--
ALTER TABLE `commhistory`
  ADD PRIMARY KEY (`commHistId`);

--
-- Indexes for table `degree`
--
ALTER TABLE `degree`
  ADD PRIMARY KEY (`degreeCode`),
  ADD UNIQUE KEY `degreeCode_UNIQUE` (`degreeCode`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`moduleCode`),
  ADD UNIQUE KEY `moduleCode_UNIQUE` (`moduleCode`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`requestId`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`sessionId`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffNo`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`studentNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment`
--
ALTER TABLE `assessment`
  MODIFY `assessId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `comm`
--
ALTER TABLE `comm`
  MODIFY `commId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `requestId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `sessionId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staffNo` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `studentNo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
