-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 23, 2018 at 01:44 AM
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
  `assessId` varchar(8) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `assessType` tinyint(1) NOT NULL,
  `resitType` tinyint(1) NOT NULL,
  `resitArrange` varchar(200) DEFAULT NULL,
  `weight` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores assessment information for each assessment for each module. Primarily used to create resit letters.';

--
-- Truncate table before insert `assessment`
--

TRUNCATE TABLE `assessment`;
--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`assessId`, `moduleCode`, `assessType`, `resitType`, `resitArrange`, `weight`) VALUES
('1', 'COMP201', 0, 2, 'Attend lab based resit exam', '50.00'),
('101.1', 'COMP101', 0, 0, NULL, '25.00'),
('101.2', 'COMP101', 0, 0, NULL, '25.00'),
('101.3', 'COMP101', 0, 0, NULL, '25.00'),
('101.4', 'COMP101', 0, 0, NULL, '25.00'),
('104', 'COMP104', 0, 1, 'Resit Exam', '80.00'),
('104.1', 'COMP104', 0, 0, NULL, '10.00'),
('104.2', 'COMP104', 0, 0, NULL, '10.00'),
('2', 'COMP201', 0, 2, 'Attend lab based resit exam', '50.00'),
('3', 'COMP205', 1, 0, NULL, '100.00'),
('4', 'COMP219', 0, 1, 'Resit exam', '0.00'),
('5', 'COMP110', 0, 2, 'Complete final report.', '0.00'),
('6', 'COMP110', 0, 2, 'Complete final report.', '0.00'),
('7', 'COMP110', 0, 2, 'Complete final report.', '0.00'),
('8', 'COMP110', 0, 2, 'Complete final report.', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `sessionId` int(10) NOT NULL,
  `studentNo` int(10) NOT NULL,
  `status` char(1) DEFAULT NULL,
  `attendanceId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores student attendance for each session.';

--
-- Truncate table before insert `attendance`
--

TRUNCATE TABLE `attendance`;
--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`sessionId`, `studentNo`, `status`, `attendanceId`) VALUES
(1, 1, '1', 1),
(1, 3, '0', 2),
(2, 1, '1', 3),
(2, 3, '1', 4),
(3, 1, '1', 5),
(3, 201012345, 'F', 6),
(4, 1, 'X', 7),
(4, 3, '1', 8),
(5, 1, 'F', 9),
(5, 201012345, '1', 10),
(6, 1, '0', 11),
(6, 2147483647, '1', 12),
(7, 1, '1', 13),
(7, 3, '1', 14),
(8, 1, '0', 15),
(8, 201012345, '1', 16),
(9, 1, '0', 17),
(9, 201012345, 'X', 18),
(10, 1, '1', 19),
(10, 201012345, 'X', 20),
(11, 1, '1', 21),
(11, 2, '1', 22),
(12, 1, '1', 23),
(12, 2, '0', 24),
(13, 1, '0', 25),
(13, 2, '1', 26),
(14, 2, '1', 27),
(15, 2, 'X', 28),
(16, 2, 'X', 29);

-- --------------------------------------------------------

--
-- Table structure for table `autocomm`
--

DROP TABLE IF EXISTS `autocomm`;
CREATE TABLE `autocomm` (
  `commHistId` int(6) NOT NULL,
  `sent` tinyint(1) NOT NULL,
  `dateTimeToSend` datetime DEFAULT NULL,
  `send` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of letters/emails that have been or will be automatically sent to a student';

--
-- Truncate table before insert `autocomm`
--

TRUNCATE TABLE `autocomm`;
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
(1, 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.'),
(2, ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.');

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
(10, 'o.smith@student.liverpool.ac.uk', 'csoffice@liverpool.ac.uk', 'Test', 'Test', 0, 0, '2017-11-28 18:15:00'),
(11, 's.jones3@student.liverpool.ac.uk', 'csoffice@liverpool.ac.uk', 'Re-Sit of Failed modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit <b>all</b> assessments listed below.', 0, 1, '2017-11-29 18:15:00'),
(12, 'd.jones2@student.liverpool.ac.uk', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 1.\r\n\r\n                Your new password is: \r\n                mRvFeWlMSBU3INw\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:37:30'),
(13, 'd.jones2@student.liverpool.ac.uk', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 1.\r\n\r\n                Your new password is: \r\n                zU86FDMgTEopxVk\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:38:50'),
(14, 'd.jones2@student.liverpool.ac.uk', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 1.\r\n\r\n                Your new password is: \r\n                rLEKsR20AUHIpib\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:39:12'),
(15, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                YGCbgWtadl47k1s\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:42:57'),
(16, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                lpg6vkMejJFzm3H\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:47:12'),
(17, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                3QaC4U6WnuN81VR\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:50:26'),
(18, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Test', 'Test email', 0, 1, '2018-04-02 22:51:18'),
(19, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Test', 'Test \n\n\n\n\nenmail', 0, 1, '2018-04-02 22:54:02'),
(20, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                cLVdsAia81E3XHq\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:54:20'),
(21, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                pwEBK3U6CGADlYk\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 22:55:15'),
(22, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 22:58:51'),
(23, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 22:58:58'),
(24, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 22:59:05'),
(25, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 22:59:05'),
(26, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 23:01:34'),
(27, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 23:01:35'),
(28, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkj', 0, 1, '2018-04-02 23:02:15'),
(29, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'njfkrbe', 'obkjtdg', 0, 1, '2018-04-02 23:02:21'),
(30, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:39'),
(31, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:41'),
(32, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:41'),
(33, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:41'),
(34, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:46'),
(35, 'info@hotmail.clm', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:02:48'),
(36, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(37, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(38, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(39, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(40, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(41, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(42, 'info@hotmail.clmdd\'op;op', 'studentoffice@liverpool.ac.uk', 'Ingo', 'fknrflkjre', 0, 1, '2018-04-02 23:03:22'),
(43, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:04:32'),
(44, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:05:33'),
(45, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:05:48'),
(46, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:05:48'),
(47, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:05:49'),
(48, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:05:49'),
(49, 'tersty@sdasd.cccc', 'studentoffice@liverpool.ac.uk', 'frbjfkje', 'Test', 0, 1, '2018-04-02 23:07:06'),
(50, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:08:14'),
(51, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:08:35'),
(52, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:09:03'),
(53, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:09:23'),
(54, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:10:05'),
(55, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:10:05'),
(56, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:10:39'),
(57, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:10:39'),
(58, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:21:56'),
(59, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:22:41'),
(60, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:23:18'),
(61, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:23:18'),
(62, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:26:56'),
(63, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:26:59'),
(64, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:27:06'),
(65, 'dannyc179@gmail.com', 'test@liverpool.ac.uk', 'Test Subject', 'BODY TEST', 0, 1, '2018-04-02 23:27:09'),
(66, 'info@hotmailrfj.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:28:24'),
(67, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'sadasd', 'asdas', 0, 1, '2018-04-02 23:28:24'),
(68, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Test', 'Test body', 0, 1, '2018-04-02 23:30:57'),
(69, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                JvG6q4OVmzZcMiY\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:32:47'),
(70, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                p90hfwlFBOo7c8S\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:33:53'),
(71, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                N5E0qK9Fwrx731j\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:35:35'),
(72, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                wFzNErsV79SqU1o\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:37:15'),
(73, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                vGneUgz5J4KmaZY\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:46:20'),
(74, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                K8dAUM7qps3oaJe\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:47:23'),
(75, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                $2y$10$yPVMwCaEMfER7FDOdDbv4u8qmF4sr8ltdkepMERIUymbSWriQTRt.\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-02 23:55:24'),
(76, 'dannyc179@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 201114790.\r\n\r\n                Your new password is: \r\n                \r\n                $2y$10$wvkf5otJnKd.z8Dr/sZr.O2jtgOje9lZFmTy6bG5R6ecLY/JELzwy\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-03 18:19:36'),
(77, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '0000-00-00 00:00:00'),
(78, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '0000-00-00 00:00:00'),
(79, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 00:36:38'),
(80, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 00:37:15'),
(81, 'o.smith@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 00:37:15'),
(82, 'd.jones2@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 00:37:15'),
(83, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:02:08'),
(84, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:02:12'),
(85, 'o.smith@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:02:12'),
(86, 'd.jones2@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:02:12'),
(87, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:24:46'),
(88, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-17 18:30:47'),
(89, 'b.mixton@liverpool.ac.uk', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 2.\r\n\r\n                Your new password is: \r\n                \r\n                $2y$10$AJUHnh00l1IkSb2DcOBAm.PQi1BsTvVfFVZjj7AZzAccdEqfvdcGq\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-11 17:11:12'),
(90, 'dannycox1996@gmail.com', 'admin@liverpool.ac.uk', 'IMPORTANT: Password Reset', '                Your password has been reset for account number: 2.\r\n\r\n                Your new password is: \r\n                \r\n                $2y$10$knhaCM3pBL1NqBANEnZR.e.y5b4VVU5NP0o3dqKCSccggYaUiKdRG\r\n\r\n                After logging in, please change your password as soon as possible.\r\n\r\n                Admin\r\n\r\n                University of Liverpool.', 0, 1, '2018-04-11 17:14:46'),
(91, '201012348', 'studentoffice@liverpool.ac.uk', '', '', 0, 1, '2018-04-18 19:11:47'),
(92, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-18 19:12:30'),
(93, 'd.jones2@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Test', 'Test email body', 0, 1, '2018-04-19 22:41:19'),
(94, 'd.jones2@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Test', 'Test email body', 0, 1, '2018-04-19 22:41:23'),
(95, 'd.jones2@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Test', 'Test email body', 0, 1, '2018-04-19 22:41:27'),
(96, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:00:07'),
(97, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:00:15'),
(98, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:00:20'),
(99, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:00:20'),
(100, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:00:20'),
(101, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:02:02'),
(102, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:02:30'),
(103, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:02:37'),
(104, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:02:52'),
(105, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:04:27'),
(106, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:05:38'),
(107, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:06:06'),
(108, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:06:28'),
(109, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:06:36'),
(110, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:09:14'),
(111, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:10:19'),
(112, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:10:49'),
(113, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:12:35'),
(114, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:13:13'),
(115, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:14:24'),
(116, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:16:12'),
(117, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:16:39'),
(118, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:17:18'),
(119, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:23:18'),
(120, '201012348', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:23:44'),
(121, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:37:45'),
(122, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:37:45'),
(123, 'Array', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:37:45'),
(124, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:38:37'),
(125, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:38:37'),
(126, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:38:37'),
(127, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:39:50'),
(128, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:39:50'),
(129, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', '\"	The Board of Examiners has determined that you have not met the requirements for progression into your nect year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 20:39:50'),
(130, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 20:45:22'),
(131, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 20:45:22'),
(132, '', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:04:37'),
(133, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:42:14'),
(134, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:47:12'),
(135, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:47:59'),
(136, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:56:41'),
(137, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 22:56:48'),
(138, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 22:56:48'),
(139, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 22:56:48'),
(140, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 23:00:02'),
(141, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-29 23:00:02'),
(142, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 23:00:02'),
(143, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-29 23:00:54'),
(144, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-30 00:09:40'),
(145, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-30 00:15:55'),
(146, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies<br>', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\n\nPlease seek to improve your attendance.<br>', 0, 1, '2018-04-30 00:15:55'),
(147, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.', 0, 1, '2018-04-30 00:56:19'),
(148, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-30 00:56:27'),
(149, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.', 0, 1, '2018-04-30 00:56:27'),
(150, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.81', 0, 1, '2018-04-30 01:05:24'),
(151, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:06:33'),
(152, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:09:31'),
(153, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:09:46'),
(154, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:10:35'),
(155, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:12:06'),
(156, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:12:36'),
(157, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:13:54'),
(158, '', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:13:54'),
(159, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:14:50'),
(160, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285781', 0, 1, '2018-04-30 01:14:50'),
(161, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285780', 0, 1, '2018-04-30 01:16:30'),
(162, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.64.285780', 0, 1, '2018-04-30 01:16:30'),
(163, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is:64.2857% which is below the threshold of: 80%.', 0, 1, '2018-04-30 01:17:21'),
(164, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is:64.2857% which is below the threshold of: 80%.', 0, 1, '2018-04-30 01:17:21'),
(165, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 79%.', 0, 1, '2018-04-30 01:19:16'),
(166, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 79%.', 0, 1, '2018-04-30 01:19:16'),
(167, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 85%.', 0, 1, '2018-04-30 01:19:41'),
(168, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 85%.', 0, 1, '2018-04-30 01:19:41'),
(169, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:33:12'),
(170, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:34:11'),
(171, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:35:31'),
(172, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:36:22');
INSERT INTO `commhistory` (`commHistId`, `recipient`, `sender`, `subject`, `body`, `read`, `confidential`, `dateTime`) VALUES
(173, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:36:35'),
(174, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.  with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:37:06'),
(175, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.FAILED Array with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:37:28'),
(176, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.FAILED Array with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:37:52'),
(177, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.FAILED COMP104 with an average mark of: 32.800000000000004\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:38:18'),
(178, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 76%.', 0, 1, '2018-04-30 01:39:52'),
(179, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 76%.', 0, 1, '2018-04-30 01:39:52'),
(180, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below.FAILED COMP104 with an average mark of: 33.\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:39:52'),
(181, 's.jones3@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 82%.', 0, 1, '2018-04-30 01:41:05'),
(182, 'dannyc179@gmail.com', 'studentoffice@liverpool.ac.uk', 'Poor Engagement with Studies', 'The Computer Science student office in the University of Liverpool has determined that you do not have an acceptable average attendance across all sessions you should be attending.\r\n\r\nPlease seek to improve your attendance.\r\n                    Your attendance is: 64% which is below the threshold of: 82%.', 0, 1, '2018-04-30 01:41:05'),
(183, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below. FAILED COMP104 with an average mark of: 33.\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:41:05'),
(184, 'j.jameson@student.liverpool.ac.uk', 'studentoffice@liverpool.ac.uk', ' Re-Sit of Failed Modules', 'The Board of Examiners has determined that you have not met the requirements for progression into your next year of study. In order to be able to progress into your next year of study you are required to resit all assessments listed below. FAILED COMP104 with an average mark of: 33.\r\n                    You will need to resit failed modules.', 0, 1, '2018-04-30 01:41:20');

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
--
-- Dumping data for table `degree`
--

INSERT INTO `degree` (`degreeCode`, `title`, `description`, `length`) VALUES
('G501', 'Computer Science with Software Development BSc (Hons)', 'Computer Science is a broad area which includes designing and building hardware and software systems for a wide range of purposes and processing, structuring and managing various kinds of information.\n\nCovering all aspects of computer science, including the underlying principles and theory, this programme will ensure that when you graduate you will know what is and isn?t possible with computers and be able to find solutions to the problems you will encounter in your professional life.\n\nYou can choose to maintain a mixture of modules throughout your degree or follow a specialist?s pathway in artificial intelligence, algorithms and optimisation or data science. Computer Science with Software Development (G610) is a pathway for those wanting to specialise in development, updating and widespread application of complex software.', 3),
('G502', 'Computer Science BSc (Hons)', 'Computer Science is a broad area which includes designing and building hardware and software systems for a wide range of purposes and processing, structuring and managing various kinds of information.\n\nCovering all aspects of computer science, including the underlying principles and theory, this programme will ensure that when you graduate you will know what is and isn?t possible with computers and be able to find solutions to the problems you will encounter in your professional life.\n\nYou can choose to maintain a mixture of modules throughout your degree or follow a specialist?s pathway in artificial intelligence, algorithms and optimisation or data science.', 3),
('G503', 'Computer Science with Year in Industry BSc (Hons)', 'Computer Science is a broad area which includes designing and building hardware and software systems for a wide range of purposes and processing, structuring and managing various kinds of information.\n\nCovering all aspects of computer science, including the underlying principles and theory, this programme will ensure that when you graduate you will know what is and isn?t possible with computers and be able to find solutions to the problems you will encounter in your professional life.\n\nYou can choose to maintain a mixture of modules throughout your degree or follow a specialist?s pathway in artificial intelligence, algorithms and optimisation or data science.\n\nOn G403 you spend a year on industrial placement acquiring experience and awareness of practical business and industrial environments.', 4),
('G520', 'Financial Computing BSc (Hons)', 'Financial Computing is at the very heart of the world?s global financial centres, from Wall Street to Chicago, London and Tokyo.\n\nTaught in conjunction with the Management School and bringing together finance, economics and computing, this dynamic programme will develop your knowledge and skills in aspects of financial services from understanding and creating algorithms; financial accounting; designing, implementing and evaluating software systems to analysing stock portfolios and operating financial markets.', 3);

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
  `assessId` varchar(5) NOT NULL,
  `attempt` tinyint(1) NOT NULL,
  `mark` varchar(5) NOT NULL DEFAULT '0',
  `markId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores uploaded marks from spreadsheets for each assessment student completes.';

--
-- Truncate table before insert `marks`
--

TRUNCATE TABLE `marks`;
--
-- Dumping data for table `marks`
--

INSERT INTO `marks` (`studentNo`, `assessId`, `attempt`, `mark`, `markId`) VALUES
(201012345, '104', 0, '70', 153),
(201012345, '104.1', 0, '60', 154),
(201012345, '104.2', 0, '50', 155),
(201012346, '104', 0, '70', 156),
(201012346, '104.1', 0, 'E', 157),
(201012346, '104.2', 0, '40', 158),
(201012347, '104', 0, '50', 159),
(201012347, '104.1', 0, '0', 160),
(201012347, '104.2', 0, '0', 161),
(201012348, '104', 0, '41', 162),
(201012348, '104.1', 0, '0', 163),
(201012348, '104.2', 0, '0', 164);

-- --------------------------------------------------------

--
-- Table structure for table `meetingnote`
--

DROP TABLE IF EXISTS `meetingnote`;
CREATE TABLE `meetingnote` (
  `studentNo` int(10) NOT NULL,
  `staffNo` int(5) NOT NULL,
  `content` text NOT NULL,
  `dateTime` datetime NOT NULL,
  `meetingNoteId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a history of lecturers meeting notes with student.';

--
-- Truncate table before insert `meetingnote`
--

TRUNCATE TABLE `meetingnote`;
--
-- Dumping data for table `meetingnote`
--

INSERT INTO `meetingnote` (`studentNo`, `staffNo`, `content`, `dateTime`, `meetingNoteId`) VALUES
(1, 1, 'Previous incidient regarding seating arrangements at 10/11/2017 lecture has now been sorted.', '2017-11-21 14:39:00', 1),
(1, 1, 'Student is displeased about seating arrangements at 10/11/2017 lecture.', '2017-11-16 09:21:00', 2),
(3, 3, 'Student unhappy with their extenuating circumstances.', '2016-12-02 11:31:00', 3),
(201012345, 4, 'dadasdasdadcd', '2018-04-22 02:18:58', 4),
(201012345, 4, 'Test\n\nMeeting\n\nNote', '2018-04-22 02:27:29', 5),
(201012345, 4, 'Test \n\nNumber 3', '2018-04-22 02:27:50', 6),
(201012345, 4, 'Test \n\nNumber 4', '2018-04-22 02:27:53', 7),
(201012345, 4, 'Test \n\nNumber 5', '2018-04-22 02:27:56', 8);

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
('COMP101', 'Foundations of Programming', 'z.chindu@liverpool.ac.uk', '1', 1, 2, 1, NULL, 15.00),
('COMP104', 'Computer Systems and Their \r\nImplementation', 'b.mixton@liverpool.ac.uk', '1', 1, 1, 1, NULL, 7.50),
('COMP110', 'Professional Skills in Computing', 'b.maddison@liverpool.ac.uk', '1', 1, 1, 0, 'COMP119', 15.00),
('COMP119', 'Algorithmic Foundations', 'j.argyle@liverpool.ac.uk', '1', 1, 2, 1, NULL, 7.50),
('COMP201', 'Database Development', 'm.harris@liverpool.ac.uk', '2', 2, 1, 1, NULL, 7.50),
('COMP205', 'Internet Principles', 'm.harris@liverpool.ac.uk', '2', 2, 1, 1, NULL, 7.50),
('COMP219', 'C++ Development', 'b.mixton@liverpool.ac.uk', '2', 2, 2, 1, NULL, 15.00),
('COMP304', 'Knowledge Representation and Reasoning', 'j.argyle@liverpool.ac.uk', '3', 3, 2, 1, NULL, 15.00),
('COMP305', 'Biocomputation', 'b.mixton@liverpool.ac.uk', '3', 3, 2, 1, NULL, 7.50);

-- --------------------------------------------------------

--
-- Table structure for table `page_restrictions`
--

DROP TABLE IF EXISTS `page_restrictions`;
CREATE TABLE `page_restrictions` (
  `page_name` varchar(30) NOT NULL,
  `oa` tinyint(1) DEFAULT NULL,
  `sa` tinyint(1) DEFAULT NULL,
  `s` tinyint(1) DEFAULT NULL,
  `l` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Permission access for web pages';

--
-- Truncate table before insert `page_restrictions`
--

TRUNCATE TABLE `page_restrictions`;
--
-- Dumping data for table `page_restrictions`
--

INSERT INTO `page_restrictions` (`page_name`, `oa`, `sa`, `s`, `l`) VALUES
('add_meeting_note', NULL, NULL, NULL, 1),
('edit_auto_letters', 1, NULL, NULL, NULL),
('generate_auto_letters', 1, NULL, NULL, NULL),
('manage_auto_letters', 1, NULL, NULL, NULL),
('manage_requests', 1, 1, NULL, NULL),
('upload_spreadsheet', 1, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration` (
  `studentNo` int(10) NOT NULL,
  `moduleCode` varchar(12) NOT NULL,
  `yearStudy` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `registrationId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores information about what module student is registered on. ';

--
-- Truncate table before insert `registration`
--

TRUNCATE TABLE `registration`;
--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`studentNo`, `moduleCode`, `yearStudy`, `status`, `registrationId`) VALUES
(201012345, 'COMP104', 1, 1, 1),
(201012345, 'COMP101', 1, 1, 2),
(201012347, 'COMP104', 1, 1, 3),
(201012347, 'COMP101', 1, 1, 4);

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
  `status` tinyint(1) DEFAULT '0',
  `updatedDatetime` timestamp NULL DEFAULT NULL,
  `updatedBy` varchar(70) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores current and past access requests to view confidential student information.';

--
-- Truncate table before insert `request`
--

TRUNCATE TABLE `request`;
--
-- Dumping data for table `request`
--

INSERT INTO `request` (`requestId`, `requester`, `student`, `title`, `description`, `dateTime`, `status`, `updatedDatetime`, `updatedBy`) VALUES
(1, 'm.harris@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', '', '2017-05-26 15:02:00', 1, '2018-04-22 23:09:29', 'i.bickerstaffee@liverpool.ac.uk'),
(2, 'b.mixton@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view student information.', '2017-05-27 18:02:00', 0, '2018-03-07 22:43:35', 'i.bickerstaffee@liverpool.ac.uk'),
(3, 'b.mixton@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'Please accept request, it is a matter of urgency.', '2017-05-28 15:52:00', 0, '2018-04-03 20:43:06', 'i.bickerstaffee@liverpool.ac.uk'),
(4, 'm.harris@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:52:00', 0, '2018-04-11 18:16:22', 'i.bickerstaffee@liverpool.ac.uk'),
(5, 'j.argyle@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:02:00', 0, '2018-04-03 20:45:09', 'i.bickerstaffee@liverpool.ac.uk'),
(6, 'j.argyle@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-30 15:02:00', 0, '2018-04-11 18:16:25', 'i.bickerstaffee@liverpool.ac.uk'),
(7, 'j.argyle@liverpool.ac.uk', 'dannyc179@gmail.com', 'Request to view all student information', 'Standard request sent by lecturer with no special requirements.', '2018-04-23 00:52:43', 1, '2018-04-22 23:53:19', 'i.bickerstaffee@liverpool.ac.uk');

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
(1, 'COMP104', 1, '2016-10-08', '11:00:00', ''),
(2, 'COMP104', 2, '2016-10-08', '14:00:00', ''),
(3, 'COMP104', 3, '2016-10-08', '11:00:00', ''),
(4, 'COMP104', 4, '2016-10-08', '14:00:00', ''),
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
  `mwsPassword` varchar(90) NOT NULL,
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
(2, 'Brian', 'Mixton', 'sgbmixton', 's1bm3', '$2y$10$knhaCM3pBL1NqBANEnZR.e.y5b4VVU5NP0o3dqKCSccggYaUiKdRG', 'b', 'b.mixton@liverpool.ac.uk', '6,Fron Hyfryd,Dyffryn Ardudwy,Dyffryn Ardudwy,,Gwynedd,Wales,LL44 2DH,United Kingdom', '078451324751', 'L'),
(3, 'Jenny', 'Argyle', 'sgjargyle1', 's1ja1', 'c', 'b', 'j.argyle@liverpool.ac.uk', '41,Dumbarton Road,London,London,,Greater London,England,SW2 5LX,United Kingdom', '078451324751', 'L'),
(4, 'Irene', 'Bickerstaffe', 'sgibicker', 's2ib', '$2y$10$7cIAl.LQQW/R8VTd3lfLeenX.wDMj9P87fJtiTulval6EVAmPjSLm', 'b', 'i.bickerstaffee@liverpool.ac.uk', '102,Leeds Road,Methley,Leeds,,West Yorkshire,England,LS26 9EP,United Kingdom', '078451324751', 'OA'),
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
  `admitYear` varchar(9) NOT NULL,
  `enrolled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Personal information about a student.';

--
-- Truncate table before insert `student`
--

TRUNCATE TABLE `student`;
--
-- Dumping data for table `student`
--

INSERT INTO `student` (`studentNo`, `forename`, `surname`, `mwsUser`, `csdUser`, `mwsPassword`, `csdPassword`, `email`, `prefEmail`, `permAddress`, `termAddress`, `phone`, `termPhone`, `advisor`, `degreeCode`, `yearStudy`, `admitYear`, `enrolled`) VALUES
(1, 'Daniel', 'Jones', 'sgdjones2', 'u5dj2', '$2y$10$ubOy6rUwqhUZiINyT74n9OMgzvXLvKDywsIXQr53bk0JyBCORjZ7C', 'b', 'd.jones2@student.liverpool.ac.uk', 'jones123@gmail.com', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '07845648754', '07845555698', 'm.harris@liverpool.ac.uk', 'G502', 2, '2016-17', 1),
(2, 'Olivia', 'Smith', 'sgosmith', 'u5os', 'wFzNErsV79SqU1o', 'b', 'o.smith@student.liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', '2,Oaktree Close,Tarporley,Tarporley,Cheshire West and Chester,England,CW6 0TZ,United Kingdom', '23A,Maristow Street,Westbury,Westbury,Wiltshire,England,BA13 3DN,United Kingdom', '07458452214', '07458452214', 'b.mixton@liverpool.ac.uk', 'G520', 1, '2017-18', 1),
(201012345, 'Daniel', 'Cox', 'sgdcox', 'u5dc', '$2y$10$wvkf5otJnKd.z8Dr/sZr.O2jtgOje9lZFmTy6bG5R6ecLY/JELzwy', '1234a', 'dannyc179@gmail.com', 'dannyc179@gmail.com', '4 Walnut Grove', '4 Walnut Grove', '07818506966', '07818506966', 'b.mixton@liverpool.ac.uk 	', 'G502', 3, '2016', 1),
(201012347, 'Smithy', 'Jones', 'sgsjones', 'u4sj3', 'a', 'b', 's.jones3@student.liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', '89,Okehampton Crescent,Welling,Welling,Greater London,England,DA16 1DQ,United Kingdom', '9,Glebe Road,Skelmersdale,Skelmersdale,,Lancashire,England,WN8 9JP,United Kingdom', '07884512365', '07884512365', 'j.argyle@liverpool.ac.uk', 'G501', 2, '2015-16', 1),
(201012348, 'Jeff', 'Jameson', 'sgjjames', 'u5jj', 'a', 'a', 'j.jameson@student.liverpool.ac.uk', 'j.jameson@student.liverpool.ac.uk', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '131,Regent Street,Church Gresley,Swadlincote,Derbyshire,England,DE11 9PH,United Kingdom', '07845356587', '07845356587', 'm.harris@liverpool.ac.uk', 'G502', 1, '2016-17', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`assessId`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendanceId`),
  ADD KEY `status` (`status`);

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
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`markId`);

--
-- Indexes for table `meetingnote`
--
ALTER TABLE `meetingnote`
  ADD PRIMARY KEY (`meetingNoteId`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`moduleCode`),
  ADD UNIQUE KEY `moduleCode_UNIQUE` (`moduleCode`);

--
-- Indexes for table `page_restrictions`
--
ALTER TABLE `page_restrictions`
  ADD PRIMARY KEY (`page_name`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`registrationId`);

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
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendanceId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `comm`
--
ALTER TABLE `comm`
  MODIFY `commId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `commhistory`
--
ALTER TABLE `commhistory`
  MODIFY `commHistId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;
--
-- AUTO_INCREMENT for table `marks`
--
ALTER TABLE `marks`
  MODIFY `markId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;
--
-- AUTO_INCREMENT for table `meetingnote`
--
ALTER TABLE `meetingnote`
  MODIFY `meetingNoteId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `registrationId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `requestId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
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
  MODIFY `studentNo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201012349;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
