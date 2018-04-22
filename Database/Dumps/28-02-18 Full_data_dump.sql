-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2018 at 04:35 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `autocomm`
--

DROP TABLE IF EXISTS `autocomm`;
CREATE TABLE `autocomm` (
  `commHistId` int(6) NOT NULL,
  `sent` tinyint(1) NOT NULL,
  `dateTimeToSend` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores a list of letters/emails that have been or will be automatically sent to a student';

--
-- Truncate table before insert `autocomm`
--

TRUNCATE TABLE `autocomm`;
--
-- Dumping data for table `autocomm`
--

INSERT INTO `autocomm` (`commHistId`, `sent`, `dateTimeToSend`) VALUES
(9, 1, '0000-00-00 00:00:00'),
(10, 0, '2014-03-19 23:59:59'),
(11, 0, '2014-08-19 11:31:12');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
