-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2018 at 07:55 PM
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
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
CREATE TABLE `assessment` (
  `assessId` varchar(8) NOT NULL,
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
('1', 'COMP201', 0, 2, 'Attend lab based resit exam'),
('104', 'COMP104', 0, 1, 'Resit Exam'),
('104.1', 'COMP104', 0, 0, NULL),
('104.2', 'COMP104', 0, 0, NULL),
('2', 'COMP201', 0, 2, 'Attend lab based resit exam'),
('3', 'COMP205', 1, 0, NULL),
('4', 'COMP219', 0, 1, 'Resit exam'),
('5', 'COMP110', 0, 2, 'Complete final report.'),
('6', 'COMP110', 0, 2, 'Complete final report.'),
('7', 'COMP110', 0, 2, 'Complete final report.'),
('8', 'COMP110', 0, 2, 'Complete final report.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`assessId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
