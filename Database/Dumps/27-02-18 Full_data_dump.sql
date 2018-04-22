-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2018 at 10:39 PM
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
  `status` tinyint(1) DEFAULT NULL,
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
(1, 'm.harris@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', '', '2017-05-26 15:02:00', 0, NULL, NULL),
(2, 'b.mixton@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view student information.', '2017-05-27 18:02:00', 0, NULL, NULL),
(3, 'b.mixton@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'Please accept request, it is a matter of urgency.', '2017-05-28 15:52:00', 0, NULL, NULL),
(4, 'm.harris@liverpool.ac.uk', 's.jones3@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:52:00', 0, NULL, NULL),
(5, 'j.argyle@liverpool.ac.uk', 'd.jones2@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-29 15:02:00', 0, NULL, NULL),
(6, 'j.argyle@liverpool.ac.uk', 'o.smith@student.liverpool.ac.uk', 'Request to View Confidentials', 'I need to view this student\'s confidential information.', '2017-05-30 15:02:00', 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`requestId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `requestId` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
