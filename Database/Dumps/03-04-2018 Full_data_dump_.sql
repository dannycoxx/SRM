-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2018 at 12:36 AM
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
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffNo`, `forename`, `surname`, `mwsUser`, `csdUser`, `mwsPassword`, `csdPassword`, `email`, `address`, `phone`, `userType`) VALUES
(1, 'Martin', 'Harris', 'sgmharris', 's1mh', 'a', 'b', 'm.harris@liverpool.ac.uk', '15,Hockley Court,Marston Moretaine,Bedford,,Central Bedfordshire,England,MK43 0GD,United Kingdom', '078451324751', 'L'),
(2, 'Brian', 'Mixton', 'sgbmixton', 's1bm3', 'b', 'b', 'b.mixton@liverpool.ac.uk', '6,Fron Hyfryd,Dyffryn Ardudwy,Dyffryn Ardudwy,,Gwynedd,Wales,LL44 2DH,United Kingdom', '078451324751', 'L'),
(3, 'Jenny', 'Argyle', 'sgjargyle1', 's1ja1', 'c', 'b', 'j.argyle@liverpool.ac.uk', '41,Dumbarton Road,London,London,,Greater London,England,SW2 5LX,United Kingdom', '078451324751', 'L'),
(4, 'Irene', 'Bickerstaffe', 'sgibicker', 's2ib', '$2y$10$7cIAl.LQQW/R8VTd3lfLeenX.wDMj9P87fJtiTulval6EVAmPjSLm', 'b', 'i.bickerstaffee@liverpool.ac.uk', '102,Leeds Road,Methley,Leeds,,West Yorkshire,England,LS26 9EP,United Kingdom', '078451324751', 'OA'),
(5, 'Hilton', 'Silver', 'sghsilver', 's3hs', 'e', 'b', 'h.silver@liverpool.ac.uk', '3,The Terrace,Harrowbarrow,Callington,,Cornwall,England,PL17 8JP,United Kingdom', '078451324751', 'SA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staffNo` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
