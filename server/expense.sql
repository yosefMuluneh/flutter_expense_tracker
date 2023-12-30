-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2023 at 10:49 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `username`, `password`) VALUES
(21, 'mekdi', '$2a$08$wwsUnL5kAjEShvOKKT7qteKI84EUvjggmzg0NAeT9AF382MuPKwiC');

-- --------------------------------------------------------

--
-- Table structure for table `balance`
--

DROP TABLE IF EXISTS `balance`;
CREATE TABLE IF NOT EXISTS `balance` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `expense` int(11) NOT NULL DEFAULT '0',
  `income` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `balance`
--

INSERT INTO `balance` (`user_id`, `expense`, `income`) VALUES
(21, 13300, 12900);

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

DROP TABLE IF EXISTS `budget`;
CREATE TABLE IF NOT EXISTS `budget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` enum('yearly','monthly','daily') NOT NULL,
  `amount` float NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`id`, `user_id`, `type`, `amount`, `date`) VALUES
(20, 21, 'monthly', 1500, '2023-05-01'),
(19, 21, 'monthly', 1500, '2023-06-20'),
(18, 21, 'yearly', 12000, '2023-06-20'),
(21, 21, 'monthly', 800, '2023-05-18');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` enum('income','expense') NOT NULL,
  `category` varchar(255) NOT NULL,
  `amount` float NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `user_id`, `type`, `category`, `amount`, `date`) VALUES
(32, 21, 'expense', 'Health', 10000, '2023-06-20 00:00:00'),
(31, 21, 'income', 'Gifts', 500, '2023-06-18 00:00:00'),
(30, 21, 'income', 'Coupons', 200, '2023-06-18 00:00:00'),
(28, 21, 'income', 'Awards', 1000, '2023-06-20 01:20:01'),
(27, 21, 'income', 'Sale', 1000, '2023-06-19 00:00:00'),
(26, 21, 'income', 'Salary', 10000, '2023-06-10 00:00:00'),
(25, 21, 'expense', 'Transportation', 800, '2023-06-20 00:00:00'),
(24, 21, 'expense', 'Food', 500, '2023-06-20 00:00:00'),
(23, 21, 'expense', 'Clothing', 2000, '2023-06-20 00:46:33');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
