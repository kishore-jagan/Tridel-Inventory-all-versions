-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2024 at 12:46 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bin`
--

CREATE TABLE `bin` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `returnable` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_remarks` varchar(255) NOT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `mos` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `vendor_remarks` text NOT NULL,
  `Stock_in_out` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bin`
--

INSERT INTO `bin` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `location`, `type`, `returnable`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(8, 'Finaltest', 'V32734', 'N2433', 'GeoScience', 'Office', 'Onfield', 'Stock', '', 5, 1000.00, 5000.00, 'ok', 'Nus', '107', '20789', 'A7388fkd', 'kishore', '2024-08-06', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1e188a0ffe'),
(8, 'sadas', 'sassa', 'aa', 'GeoEngineering', 'Electrical', 'Inhouse', 'Rental', '', 3, 100.00, 300.00, 's', 'PN10', 'Buoy', 'V3532', 'C2432', 'mumbai materials', '2024-08-21', 'Sks', 'ByAir', 'raj', 's', 'Stock In', '66c56cbe8f134');

-- --------------------------------------------------------

--
-- Table structure for table `boxdetails`
--

CREATE TABLE `boxdetails` (
  `id` int(11) NOT NULL,
  `billNo` varchar(255) NOT NULL,
  `poNo` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `supplierName` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `mos` varchar(255) NOT NULL,
  `remark` text DEFAULT NULL,
  `recieverName` varchar(255) NOT NULL,
  `products` varchar(500) NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boxdetails`
--

INSERT INTO `boxdetails` (`id`, `billNo`, `poNo`, `date`, `supplierName`, `location`, `mos`, `remark`, `recieverName`, `products`, `token`, `status`) VALUES
(1, 'weg', 'eqoif897', '2024-08-12', 'aedgf', 'Sks', 'ByShip', 'asgf', 'asfg', '[]', '1963d2e4edba58a322bae8a3426f053d', 1),
(2, 'egb', 'sfgbw', '2024-08-12', 'sdfb', 'Sks', 'ByShip', 'dfb', 'dfb', '[{\"name\":\"asfvg\",\"qty\":\"24\"},{\"name\":\"safbv\",\"qty\":\"24\"},{\"name\":\"safbrhnt\",\"qty\":\"24\"},{\"name\":\"sfabnhfgb\",\"qty\":\"24\"},{\"name\":\"sddfjh\",\"qty\":\"21\"}]', 'e3cf846a95000ef48167302ff976abda', 0),
(3, 'SDFNBD', 'dfbs', '2024-08-12', 'SGS', 'Sks', 'ByShip', 'ASFB', 'ASDVASF', '[]', '41a29f8e3846d656493e535520414e0b', 1),
(4, 'BILL 01', 'po001', '2024-08-13', 'draw', 'Sks', 'ByShip', 'none', 'Ganapathiu', '[]', '392348189a12cc0869daf33ca0499888', 1),
(5, 'one test', 'one', '2024-08-13', 'test', 'Sks', 'ByShip', 'none', 'Gana', '[]', 'd4f9ffca0d8e2723bd5996ea9c8bcab5', 1),
(6, '12434', '879', '2024-08-14', 'esds', 'Sks', 'ByShip', 'sdfsdfsd', 'dfdfgfd', '[{\"name\":\"sfdsdfsd\",\"qty\":\"4\"},{\"name\":\"asdaca\",\"qty\":\"8\"}]', 'd8d5434f8afed6e10e885f4470108db4', 0),
(7, '7563B12', '12345A', '2024-08-14', 'Jadesh', 'Sks', 'ByShip', 'ok', 'Mamba', '[{\"name\":\"Buoy 1\",\"qty\":\"1\"},{\"name\":\"Buoy 2\",\"qty\":\"3\"}]', '4f1aa6066c3c1e04a2a503a73fb437c7', 0),
(8, '5Vsdf', 'C425443', '2024-08-14', 'Mani', 'Sks', 'ByShip', 'ok', 'kishore', '[{\"name\":\"lap 1\",\"qty\":\"2\"},{\"name\":\"lap 2\",\"qty\":\"4\"}]', '6948b60bd1f6422433a143e2bf05133e', 0),
(9, 'C2432', 'V3532', '2024-08-14', 'mani', 'Sks', 'ByAir', 'ssa', 'raj', '[{\"name\":\"sadas\",\"qty\":\"3\"},{\"name\":\"sadas\",\"qty\":\"4\"},{\"name\":\"3232\",\"qty\":\"4\"},{\"name\":\"fsdfds\",\"qty\":\"6\"}]', '32aa24071f3addcd3f1221e46b1da95d', 0),
(10, 'B43544', 'V32432', '2024-08-16', 'Mercy electronics', 'Sks', 'ByAir', 'Ok', 'kishore', '[{\"name\":\"Winch\",\"qty\":\"2\"}]', '7ae2f944a0115e21814cb97e3b5ab52d', 0),
(11, 'V235545', 'X2343243', '2024-08-16', 'Kr info tech', 'Sks', 'ByAir', 'Ok', 'mani', '[{\"name\":\"Lap  1\",\"qty\":\"1\"},{\"name\":\"Lap 2\",\"qty\":\"1\"},{\"name\":\"Switch\",\"qty\":\"2\"}]', '87e177dc7aadbf997312eb960557b8a3', 0),
(12, 'M8675', 'C32345', '2024-08-19', 'Test A', 'Sks', 'ByAir', 'Ok', 'Test X', '[{\"name\":\"Item1\",\"qty\":\"1\"},{\"name\":\"Item 2\",\"qty\":\"3\"},{\"name\":\"Item 3\",\"qty\":\"4\"}]', 'affa40fd7f97a2014ded984f0a9f3d99', 0),
(13, 'V3454', 'X34324325', '2024-08-20', 'test', 'Sks', 'ByTrain', 'Received', 'receivetest', '[{\"name\":\"test 11\",\"qty\":\"4\"},{\"name\":\"test12\",\"qty\":\"1\"}]', 'be5be60ec0be60781ae51dfd77040d0b', 0),
(14, 'V893274', 'F324321', '2024-08-20', 'Test123', 'location1', 'ByTrain', 'ok', 'kishore', '[{\"name\":\"product1\",\"qty\":\"1\"}]', '3d18d5aa2f5633d91e9b6330c2f7e8fd', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dispatches`
--

CREATE TABLE `dispatches` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `project_no` varchar(255) NOT NULL,
  `mos` varchar(255) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `dispatch_remarks` varchar(255) NOT NULL,
  `products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`products`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dispatches`
--

INSERT INTO `dispatches` (`id`, `customer_name`, `invoice_no`, `project_no`, `mos`, `sender_name`, `dispatch_remarks`, `products`, `created_at`) VALUES
(28, 'Mercy electronics', '', '', '', '', '', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":4,\"price\":1000,\"total_price\":\"4000.0\"}]', '2024-07-29 09:14:00'),
(29, 'Gori', '', '', '', '', '', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":2,\"price\":1000,\"total_price\":\"2000.0\"}]', '2024-07-29 09:14:51'),
(30, 'kishore', '', '', '', '', '', '[{\"product_name\":\"Box\",\"serial_no\":\"J325454351\",\"model_no\":\"L231545\",\"category\":\"Mechanical\",\"quantity\":2,\"price\":2000,\"total_price\":\"4000.0\"}]', '2024-07-29 09:16:06'),
(31, 'kishore', '', '', '', '', '', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":1,\"price\":1000,\"total_price\":\"1000.0\"},{\"product_name\":\"poleeee\",\"serial_no\":\"QtYb123\",\"model_no\":\"D12345\",\"category\":\"Mechanical\",\"quantity\":2,\"price\":500,\"total_price\":\"1000.0\"},{\"product_name\":\"phones\",\"serial_no\":\"QtYb123\",\"model_no\":\"C12345\",\"category\":\"Electrical\",\"quantity\":1,\"price\":10000,\"total_price\":\"10000.0\"}]', '2024-07-30 03:56:47'),
(32, 'Ranjith', '', '', '', '', '', '[{\"product_name\":\"Charger\",\"serial_no\":\"QtYb123\",\"model_no\":\"J12345\",\"category\":\"Electrical\",\"quantity\":1,\"price\":200,\"total_price\":\"200.0\"},{\"product_name\":\"Rj235\",\"serial_no\":\"QtYb123\",\"model_no\":\"G12345\",\"category\":\"Mechanical\",\"quantity\":1,\"price\":5000,\"total_price\":\"5000.0\"},{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":1,\"price\":1000,\"total_price\":\"1000.0\"}]', '2024-08-03 04:52:45'),
(33, 'Kr info tech', '', '', '', '', '', '[{\"product_name\":\"Stabler\",\"serial_no\":\"QtYb123\",\"model_no\":\"F12345\",\"category\":\"Electrical\",\"quantity\":2,\"price\":20,\"total_price\":\"40.0\"},{\"product_name\":\"Laptop\",\"serial_no\":\"QtYb123\",\"model_no\":\"F12345\",\"category\":\"Mechanical\",\"quantity\":1,\"price\":50000,\"total_price\":\"50000.0\"},{\"product_name\":\"Cups\",\"serial_no\":\"L124465757\",\"model_no\":\"G123432413434\",\"category\":\"IT\",\"quantity\":4,\"price\":20,\"total_price\":\"80.0\"}]', '2024-08-05 05:24:55'),
(34, 'Mercy electronics', '', '', '', '', '', '[{\"product_name\":\"Finaltest\",\"serial_no\":\"V32734\",\"model_no\":\"N2433\",\"category\":\"Office\",\"quantity\":2,\"price\":1000,\"total_price\":\"2000.0\"}]', '2024-08-12 06:23:43'),
(35, 'Kr info tech', 'C5345', 'P89', 'ByRoad', 'Mani', 'Ok', '[{\"product_name\":\"Finaltest2\",\"serial_no\":\"V32734\",\"model_no\":\"N2433\",\"category\":\"Electrical\",\"quantity\":1,\"price\":1000,\"total_price\":\"1000.0\"},{\"product_name\":\"cell phone \",\"serial_no\":\"V472734\",\"model_no\":\"B3274\",\"category\":\"IT\",\"quantity\":1,\"price\":10000,\"total_price\":\"10000.0\"}]', '2024-08-14 11:50:15');

-- --------------------------------------------------------

--
-- Table structure for table `ess`
--

CREATE TABLE `ess` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `returnable` varchar(255) NOT NULL,
  `qty` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_remarks` varchar(255) NOT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `mos` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `vendor_remarks` text NOT NULL,
  `Stock_in_out` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ess`
--

INSERT INTO `ess` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `type`, `location`, `returnable`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(2, 'Finaltest2', 'V32734', 'N2433', 'Office', 'Finance', 'Assets', 'Warehouse', 'Returnable', '80', 1000.00, 8000.00, 'ok', 'Bms', '107', '20789', 'A7388fkd', 'IG solutions', '2024-08-06', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f6853742e'),
(3, 'asdaca', 'F35', 'V3445', 'ESS', 'Finance', 'Assets', 'Warehouse', 'NonReturnable', '8', 100.00, 800.00, 'fssf', 'Nus', 'P43', 'V234', 'C234', 'Elan', '2024-08-16', 'ware', 'ByAir', 'Ram', 'ok', 'Stock In', '66bee4b12cfe6'),
(5, 'Item1', 'V342', 'C3224', 'ESS', 'Accounts', 'Consumables', 'Warehouse', 'NonReturnable', '1', 100.00, 100.00, 'ok', 'Not assigned', 'Not assigned', 'C32345', 'M8675', 'Ritchi street', '2024-08-20', 'Sks', 'ByAir', 'Test X', 'ok', 'Stock In', '66c47d6ff1e45'),
(6, 'Winch', 'sassasa', 'asa', 'ESS', 'Accounts', 'Rental', 'Inhouse', 'NonReturnable', '2', 100.00, 200.00, 'as', 'Not assigned', 'Not assigned', 'V32432', 'B43544', 'mumbai materials', '2024-08-21', 'Sks', 'ByAir', 'kishore', 's', 'Stock In', '66c568be419bc'),
(7, 'sadas', 'sassa', 'aa', 'ESS', 'Accounts', 'Rental', 'Inhouse', 'Returnable', '3', 100.00, 300.00, 's', 'Not assigned', 'Not assigned', 'V3532', 'C2432', 'Ritchi street', '2024-08-21', 'Sks', 'ByAir', 'raj', 's', 'Stock In', '66c569c410080'),
(8, 'sadas', 'sassaa', 'aaa', 'ESS', 'Accounts', 'Rental', 'Inhouse', 'NonReturnable', '3', 100.00, 300.00, 's', 'PN10', 'Buoy', 'V3532', 'C2432', 'Ag traders', '2024-08-21', 'Sks', 'ByAir', 'raj', 's', 'Stock In', '66c56cf98dc43'),
(9, 'sadas', 'sassaaa', 'aaaaaa', 'ESS', 'Accounts', 'Rental', 'Inhouse', 'NonReturnable', '3', 100.00, 300.00, 's', 'PN10', 'Buoy', 'V3532', 'C2432', 'Elan', '2024-08-21', 'Sks', 'ByAir', 'raj', 's', 'Stock In', '66c56d70698c9'),
(10, 'sadas', 'sassaaaa', 'aaaaaaaa', 'ESS', 'Accounts', 'Rental', 'Inhouse', 'NonReturnable', '3', 100.00, 300.00, 's', 'PN10', 'Buoy', 'V3532', 'C2432', 'geoscience', '2024-08-21', 'Sks', 'ByAir', 'raj', 's', 'Stock In', '66c56dd8a9ae9'),
(11, 'wasdh', 'safg', 'asfgawr', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', '53', 10.00, 530.00, 'dafb', 'asfb', 'asfb', 'safb', 'asfb', 'sfb', '2024-08-12', 'asfb', 'ByRoad', 'asfb', 'asf', 'Stock In', '66b9e0aca3eb3');

-- --------------------------------------------------------

--
-- Table structure for table `geoengineering`
--

CREATE TABLE `geoengineering` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `returnable` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_remarks` varchar(255) NOT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `mos` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `vendor_remarks` text NOT NULL,
  `Stock_in_out` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `geoengineering`
--

INSERT INTO `geoengineering` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `type`, `location`, `returnable`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(5, 'Finaltest2', 'V32734', 'N2433', 'GeoEngineering', 'Electrical', 'Assets', 'Warehouse', 'Returnable', 9, 1000.00, 9000.00, 'ok', 'BMS', '107', '20789', 'A7388fkd', 'IG solutions', '2024-08-06', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f3ddc3012'),
(6, 'cell phone ', 'V472734', 'B3274', 'GeoInformatics', 'IT', 'Assets', 'Inhouse', 'NonReturnable', 4, 10000.00, 40000.00, 'ok', 'bms', '12ds', 'dsaf', 'sdaf', 'Ag traders', '2024-08-12', 'dddddd', 'ByRoad', 'karthi', 'dada', 'Stock In', '66b9db9ddace9'),
(7, 'Buoy 1', 'dasd', 'dsfdsf', 'GeoEngineering', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 'dasd', 'Not assigned', 'Not assigned', '12345A', '7563B12', 'Ritchi street', '2024-08-20', 'Sks', 'ByShip', 'Mamba', 'd', 'Stock In', '66c481ee73ca5');

-- --------------------------------------------------------

--
-- Table structure for table `geoinformatics`
--

CREATE TABLE `geoinformatics` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `returnable` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_remarks` varchar(255) NOT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `mos` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `vendor_remarks` text NOT NULL,
  `Stock_in_out` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `geoinformatics`
--

INSERT INTO `geoinformatics` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `type`, `location`, `returnable`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(5, 'Finaltest2', 'V32734', 'N2433', 'GeoInformatics', 'Mechanical', 'Stock', 'Onfield', 'NonReturnable', 60, 1000.00, 6000.00, 'ok', 'Nus', '107', '20789', 'A7388fkd', 'Mercy electronics', '2024-08-06', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f388acc01'),
(6, 'cell phone ', 'V472734', 'B3274', 'GeoInformatics', 'IT', 'Assets', 'Inhouse', 'Returnable', 50, 10000.00, 50000.00, 'ok', 'bms', '12ds', 'dsaf', 'sdaf', 'Ag traders', '2024-08-12', 'dddddd', 'ByRoad', 'karthi', 'dada', 'Stock In', '66b9db9ddace9'),
(7, 'asfvg', 'SADa', 'sadDD', 'GeoInformatics', 'General', 'Repair/Services', 'Warehouse', 'Returnable', 24, 100.00, 2400.00, 'llas', 'NUS', 'P123', 'sfgbw', 'egb', 'mumbai materials', '2024-08-20', 'Sks', 'ByShip', 'dfb', 'ok', 'Stock In', '66c46fe3bf2ce'),
(9, 'asdaca', 'SADaa', 'asfvg', 'GeoInformatics', 'IT', 'Consumables', 'Inhouse', 'NonReturnable', 8, 100.00, 800.00, 'sas', 'saasd', 'sda', '879', '12434', 'Ranjith', '2024-08-21', 'Sks', 'ByShip', 'dfdfgfd', 'asdasd', 'Stock In', '66c581d880b07');

-- --------------------------------------------------------

--
-- Table structure for table `geoscience`
--

CREATE TABLE `geoscience` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `returnable` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_remarks` varchar(255) NOT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_no` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `mos` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `vendor_remarks` text NOT NULL,
  `Stock_in_out` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `geoscience`
--

INSERT INTO `geoscience` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `type`, `location`, `returnable`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(8, 'Finaltest', 'V32734', 'N2433', 'GeoScience', 'Finance', 'Stock', 'Onfield', 'NonReturnable', 5, 1000.00, 5000.00, 'ok', 'Nus', '107', '20789', 'A7388fkd', 'kishore', '2024-08-06', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1e188a0ffe'),
(12, 'dsfdg', 'hg4et53', '53erg3', 'GeoScience', 'Consumables', 'Rental', 'Inhouse', 'NonReturnable', 23, 10.00, 230.00, 'dsgn', 'dg', 'adsgh', 'adh', 'sfg', 'dsf', '2024-08-12', 'safdb', 'ByRoad', 'asfb', 'dsf', 'Stock In', '66b9e4ca178b7'),
(13, 'eghdr', 'df', 'aehrte', 'GeoScience', 'Finance', 'Rental', 'Inhouse', 'NonReturnable', 46, 213.00, 9798.00, 'asfb', 'asfb', 'sfb', 'sfb', 'asdf', 'sfb', '2024-08-12', 'sFB', 'ByRoad', 'srgf', 'sfb', 'Stock In', '66b9e4e319008'),
(14, 'safhsd', 'ifdw69', 'ajodfy9', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'Returnable', 43, 10.00, 430.00, 'wsdg', 'wsdg', 'aegbf', 'asfb', 'asfba', 'ada', '2024-08-13', 'asfb', 'ByRoad', 'asfbd', 'asfb', 'Stock In', '66bae14d7f06a'),
(15, 'dsfb', 'wG24', 'QWRG2', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 34, 10.00, 340.00, 'ASFB', 'ASFB', 'ASFB', 'ASFB', 'ASFB', 'ASFB', '2024-08-13', 'ASFB', 'ByRoad', 'ASFB', 'ASFB', 'Stock In', '66bae19211c3e'),
(16, 'ntdngbr', 'wafgs', 'asfgb', 'GeoScience', 'Finance', 'Rental', 'Inhouse', 'NonReturnable', 68, 10.00, 680.00, 'safg', 'safgv', 'asv', 'asfv', 'safb', 'sfb', '2024-08-13', 'sfb', 'ByRoad', 'safb', 'safb', 'Stock In', '66bae20d6b07d'),
(17, 'dfb', 'safb', 'wsfgs', 'GeoScience', 'Consumables', 'Rental', 'Inhouse', 'NonReturnable', 21, 50.00, 1050.00, 'asfb', 'asv', 'asb', 'asfvdc', 'sadcv', 'asfbe', '2024-08-13', 'afsb', 'ByRoad', 'asfvd', 'asfb', 'Stock In', '66bae4a336497'),
(18, 'asfdbsdf', 'wafgh', 'asfhg', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 45, 1.00, 245.00, 'asfb', 'safbc ', 'asb', 'asfb', 'sfb', 'sfcb', '2024-08-13', 'sfba', 'ByRoad', 'safb', 'sfbv', 'Stock In', '66bae95e74cad'),
(19, 'one', 'serial1', 'model1', 'GeoScience', 'Consumables', 'Rental', 'Inhouse', 'NonReturnable', 1, 1.00, 1.00, 'none', 'project1', 'projectNameone', 'order1', 'number1', 'vendor1', '2024-08-13', 'location1', 'ByRoad', 'Ganapathi', 'none', 'Stock In', '66bae9b41fe3f'),
(20, 'abbon', 'test', 'test', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 12, 10.00, 120.00, 'none', 'test', 'test', 'test', 'test', 'test', '2024-08-13', 'test', 'ByRoad', 'test', 'test', 'Stock In', '66baea7bdfabb'),
(22, 'Lap 2', 'adgwsgfs', 'dvwsdf', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 1, 10.00, 10.00, 'fs', 'sdhu', 'sdv', 'X34324325', 'V3454', 'Ritchi street', '2024-08-20', 'Sks', 'ByTrain', 'receivetest', 'sfv', 'Stock In', '66c448e1e56c3'),
(23, 'Winch', 'sds', 'sa', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 2, 100.00, 200.00, 'zxc', 'Not assigned', 'Not assigned', 'V32432', 'B43544', 'Ritchi street', '2024-08-21', 'Sks', 'ByAir', 'kishore', 'ss', 'Stock In', '66c563df7dbe0'),
(24, 'lap 2', 'sas', 'sas', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 's', 's', 's', 'C425443', '5Vsdf', 'mumbai materials', '2024-08-21', 'Sks', 'ByShip', 'kishore', 's', 'Stock In', '66c56e1d38f3d'),
(25, 'lap 2', 'sasa', 'sasa', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 's', 's', 's', 'C425443', '5Vsdf', 'Lord', '2024-08-21', 'Sks', 'ByShip', 'kishore', 's', 'Stock In', '66c56e99cc3f4'),
(26, 'lap 2', 'sasas', 'sasas', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 's', 's', 's', 'C425443', '5Vsdf', 'mumbai materials', '2024-08-21', 'Sks', 'ByShip', 'kishore', 's', 'Stock In', '66c56fa4a5c2a'),
(27, 'lap 2', 'sasass', 'sasass', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 's', 's', 's', 'C425443', '5Vsdf', 'mumbai materials', '2024-08-21', 'Sks', 'ByShip', 'kishore', 's', 'Stock In', '66c56fdf130fc'),
(28, 'sadas', 'sassasa', 'sasasa', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 3, 100.00, 300.00, 'xxzxz', 'xxx', 'xccc', 'V3532', 'C2432', 'Elan', '2024-08-21', 'Sks', 'ByAir', 'raj', 'ccc', 'Stock In', '66c5702def6a5'),
(29, 'asdaca', 'sasazzzzzzzz', 'asazzzzzzzzz', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 8, 100.00, 800.00, 'zxzc', 'xzc', 'xcz', '879', '12434', 'mumbai materials', '2024-08-21', 'Sks', 'ByShip', 'dfdfgfd', 'xzx', 'Stock In', '66c571069c7e4'),
(30, 'Item 2', 'saasdsad', 'sasdfd', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'Returnable', 3, 100.00, 300.00, 'sad', 'sadsad', 'sadsa', 'C32345', 'M8675', 'sda', '2024-08-21', 'Sks', 'ByAir', 'Test X', 'fdfs', 'Stock In', '66c578b03f218'),
(31, '3232', 'sdadfafdsgh', 'aa', 'GeoScience', 'Electrical', 'Rental', 'Inhouse', 'NonReturnable', 4, 100.00, 400.00, 'ok', 'ssss', 'jjjj', 'V3532', 'C2432', 'Office', '2024-08-21', 'Sks', 'ByAir', 'raj', 'ok', 'Stock In', '66c57f2926f32');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `name` varchar(200) NOT NULL,
  `userName` varchar(200) NOT NULL,
  `phone_number` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `email_id` varchar(200) NOT NULL,
  `role` varchar(200) NOT NULL,
  `id` int(11) NOT NULL,
  `employee_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`name`, `userName`, `phone_number`, `password`, `email_id`, `role`, `id`, `employee_id`) VALUES
('kishore', 'kishore', '123456789', '98c3b24124499b152e7bdfedd8a38102', 'kishore@gmail.com', 'Admin', 14, '111111'),
('Gana', 'Gana', '123456789', 'd59901b35800e622044ac4125fbe03f7', 'gana@gmail.com', 'Admin', 15, '1002'),
('Kavi', 'kavi', '9600701788', '919d747e7bec6b5c2728be178f4ff06d', 'kavi@gmail.com', 'User', 16, '1003'),
('Garudan', 'garudan', '9876543210', 'f62934fa8cd6b6a19981d0d31a727372', 'garudan@gmail.com', 'User', 26, '1004'),
('Mani', 'mani', '13456765432', '6e61eb1c893167b00a1631e93d888c4f', 'mani@gmail.com', 'User', 27, '1000110'),
('Ravi', 'ravi', '124074803', '65c180032141e3ec72ed7b4c8064d53f', 'ravi@gmail.com', 'Manager', 28, '11902819048');

-- --------------------------------------------------------

--
-- Table structure for table `preproduct`
--

CREATE TABLE `preproduct` (
  `id` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stockout`
--

CREATE TABLE `stockout` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `serial_no` varchar(200) NOT NULL,
  `model_no` varchar(200) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(200) NOT NULL,
  `qty` varchar(200) NOT NULL,
  `price` longtext NOT NULL,
  `total_price` longtext NOT NULL,
  `stock` varchar(200) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stockout`
--

INSERT INTO `stockout` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `qty`, `price`, `total_price`, `stock`, `date`) VALUES
(2, 'Winch', 'QtYb123', 'B12345', 'GeoEngineering', 'Mechanical', '19', '100.00', '1900', 'Stock Out', '2024-07-05'),
(3, 'phones', 'QtYb123', 'C12345', 'GeoInformatics', 'Electrical', '7', '10000.00', '70000', 'Stock Out', '2024-07-30'),
(4, 'Electric wireee', 'QtYb123', 'A12345', 'GeoScience', 'Electrical', '23', '10.00', '230', 'Stock Out', '2024-07-29'),
(5, 'pole', 'QtYb123', 'D12345', 'GeoEngineering', 'Mechanical', '7', '500.00', '3500', 'Stock Out', '2024-07-30'),
(6, 'boxee', 'QtYb123', 'H12345', 'GeoScience', 'Electrical', '14', '5000.00', '5000', 'Stock Out', '2024-07-28'),
(7, 'Tap', 'QtYb123', 'L12345', 'ESS', 'Electrical', '9', '40.00', '120', 'Stock Out', '2024-07-29'),
(8, 'Charger', 'QtYb123', 'J12345', 'GeoEngineering', 'Mechanical', '10', '100.00', '800', 'Stock Out', '2024-08-03'),
(9, 'Notes', 'QtYb123', 'K12345', 'GeoScience', 'Mechanical', '20', '50.00', '100', 'Stock Out', '2024-07-15'),
(10, 'Rope', 'LFU466', 'X12345', 'GeoInformatics', 'IT', '30', '1000.00', '4000', 'Stock Out', '2024-07-30'),
(11, 'Laptop', 'QtYb123', 'F12345', 'GeoScience', 'Mechanical', '14', '50000.00', '200000', 'Stock Out', '2024-08-05'),
(12, 'Lan Cable', 'QtYb123', 'E12345', 'GeoEngineering', 'Electrical', '33', '100.00', '100', 'Stock Out', '2024-07-18'),
(13, 'Vessels', 'L122434254354', 'G123143353553', 'GeoScience', 'IT', '12', '200.00', '600', 'Stock Out', '2024-07-26'),
(14, 'Rj235', 'QtYb123', 'G12345', 'GeoScience', 'Mechanical', '18', '5000.00', '5000', 'Stock Out', '2024-07-26'),
(15, 'Sticks', 'D12424343432431', 'V21321424123', 'GeoEngineering', 'Electrical', '20', '50.00', '50', 'Stock Out', '2024-07-29'),
(16, 'Sandisk', 'G1233243545', 'H12321435354545', 'GeoScience', 'Mechanical', '12', '2000.00', '2000', 'Stock Out', '2024-07-29'),
(17, 'Switches', 'G12414541', 'J12343545', 'GeoInformatics', 'Mechanical', '8', '10.00', '10', 'Stock Out', '2024-07-29'),
(18, 'Box', 'J325454351', 'L231545', 'GeoScience', 'Mechanical', '5', '2000.00', '4000', 'Stock Out', '2024-07-29'),
(19, 'Cups', 'L124465757', 'G123432413434', 'GeoInformatics', 'IT', '3', '20.00', '80', 'Stock Out', '2024-08-05'),
(20, 'Finaltest', 'V32734', 'N2433', 'GeoEngineering', 'Finance', '11', '1000.00', '11000', 'Stock Out', '2024-08-14'),
(21, 'cell phone ', 'V472734', 'B3274', 'GeoInformatics', 'IT', '1', '10000.00', '10000', 'Stock Out', '2024-08-14'),
(22, 'hsgdfua', 'aiudsf687', 'skdhij', 'GeoScience', 'Electrical', '2', '30.00', '60', 'Stock Out', '2024-08-16'),
(23, 'dsfdg', 'hg4et53', '53erg3', 'GeoScience', 'Consumables', '2', '10.00', '20', 'Stock Out', '2024-08-19'),
(24, 'dfb', 'safb', 'wsfgs', 'ESS', 'Consumables', '3', '50.00', '150', 'Stock Out', '2024-08-20');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id` int(11) NOT NULL,
  `vendorName` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`id`, `vendorName`) VALUES
(1, 'Mercy electronics'),
(2, 'Ritchi street'),
(3, 'mumbai materials'),
(4, 'Ag traders'),
(5, 'Kr info tech'),
(6, 'IG solutions'),
(7, 'Elan'),
(8, 'Virus'),
(9, 'Lord'),
(10, 'Ranjith'),
(11, 'mani'),
(12, 'venus'),
(13, 'Raayan'),
(14, 'Gori'),
(15, 'kishore'),
(16, 'geoscience'),
(17, 'geoinfo'),
(18, 'geoEngi'),
(19, 'Office'),
(20, 'fjabf'),
(21, 'sfb'),
(22, 'dsf'),
(23, 'ada'),
(24, 'ASFB'),
(25, 'asfbe'),
(26, 'sfcb'),
(27, 'vendor1'),
(28, 'test'),
(29, 'adf'),
(30, 'sda'),
(31, 'sasa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `boxdetails`
--
ALTER TABLE `boxdetails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `dispatches`
--
ALTER TABLE `dispatches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ess`
--
ALTER TABLE `ess`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_no` (`model_no`);

--
-- Indexes for table `geoengineering`
--
ALTER TABLE `geoengineering`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_no` (`model_no`);

--
-- Indexes for table `geoinformatics`
--
ALTER TABLE `geoinformatics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_no` (`model_no`);

--
-- Indexes for table `geoscience`
--
ALTER TABLE `geoscience`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_no` (`model_no`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preproduct`
--
ALTER TABLE `preproduct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `stockout`
--
ALTER TABLE `stockout`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `boxdetails`
--
ALTER TABLE `boxdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `dispatches`
--
ALTER TABLE `dispatches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `ess`
--
ALTER TABLE `ess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `geoengineering`
--
ALTER TABLE `geoengineering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `geoinformatics`
--
ALTER TABLE `geoinformatics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `geoscience`
--
ALTER TABLE `geoscience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `preproduct`
--
ALTER TABLE `preproduct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stockout`
--
ALTER TABLE `stockout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `preproduct`
--
ALTER TABLE `preproduct`
  ADD CONSTRAINT `preproduct_ibfk_1` FOREIGN KEY (`token`) REFERENCES `boxdetails` (`token`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
