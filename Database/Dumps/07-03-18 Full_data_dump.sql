-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2018 at 11:11 PM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `page_restrictions`
--
ALTER TABLE `page_restrictions`
  ADD PRIMARY KEY (`page_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
