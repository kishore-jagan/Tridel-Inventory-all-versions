-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2024 at 11:03 AM
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
-- Database: `api`
--

-- --------------------------------------------------------

--
-- Table structure for table `dispatches`
--

CREATE TABLE `dispatches` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`products`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dispatches`
--

INSERT INTO `dispatches` (`id`, `customer_name`, `products`, `created_at`) VALUES
(28, 'Mercy electronics', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":4,\"price\":1000,\"total_price\":\"4000.0\"}]', '2024-07-29 09:14:00'),
(29, 'Gori', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":2,\"price\":1000,\"total_price\":\"2000.0\"}]', '2024-07-29 09:14:51'),
(30, 'kishore', '[{\"product_name\":\"Box\",\"serial_no\":\"J325454351\",\"model_no\":\"L231545\",\"category\":\"Mechanical\",\"quantity\":2,\"price\":2000,\"total_price\":\"4000.0\"}]', '2024-07-29 09:16:06'),
(31, 'kishore', '[{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":1,\"price\":1000,\"total_price\":\"1000.0\"},{\"product_name\":\"poleeee\",\"serial_no\":\"QtYb123\",\"model_no\":\"D12345\",\"category\":\"Mechanical\",\"quantity\":2,\"price\":500,\"total_price\":\"1000.0\"},{\"product_name\":\"phones\",\"serial_no\":\"QtYb123\",\"model_no\":\"C12345\",\"category\":\"Electrical\",\"quantity\":1,\"price\":10000,\"total_price\":\"10000.0\"}]', '2024-07-30 03:56:47'),
(32, 'Ranjith', '[{\"product_name\":\"Charger\",\"serial_no\":\"QtYb123\",\"model_no\":\"J12345\",\"category\":\"Electrical\",\"quantity\":1,\"price\":200,\"total_price\":\"200.0\"},{\"product_name\":\"Rj235\",\"serial_no\":\"QtYb123\",\"model_no\":\"G12345\",\"category\":\"Mechanical\",\"quantity\":1,\"price\":5000,\"total_price\":\"5000.0\"},{\"product_name\":\"Rope\",\"serial_no\":\"LFU466\",\"model_no\":\"X12345\",\"category\":\"IT\",\"quantity\":1,\"price\":1000,\"total_price\":\"1000.0\"}]', '2024-08-03 04:52:45'),
(33, 'Kr info tech', '[{\"product_name\":\"Stabler\",\"serial_no\":\"QtYb123\",\"model_no\":\"F12345\",\"category\":\"Electrical\",\"quantity\":2,\"price\":20,\"total_price\":\"40.0\"},{\"product_name\":\"Laptop\",\"serial_no\":\"QtYb123\",\"model_no\":\"F12345\",\"category\":\"Mechanical\",\"quantity\":1,\"price\":50000,\"total_price\":\"50000.0\"},{\"product_name\":\"Cups\",\"serial_no\":\"L124465757\",\"model_no\":\"G123432413434\",\"category\":\"IT\",\"quantity\":4,\"price\":20,\"total_price\":\"80.0\"}]', '2024-08-05 05:24:55'),
(34, 'Mercy electronics', '[{\"product_name\":\"Finaltest\",\"serial_no\":\"V32734\",\"model_no\":\"N2433\",\"category\":\"Office\",\"quantity\":2,\"price\":1000,\"total_price\":\"2000.0\"}]', '2024-08-12 06:23:43');

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
  `location` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
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

INSERT INTO `geoengineering` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `location`, `type`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(5, 'Finaltest3', 'V32734', 'N2433', 'GeoEngineering', 'Electrical', 'Warehouse', 'Assets', 10, 1000.00, 10000.00, 'ok', 'BMS', '107', '20789', 'A7388fkd', 'IG solutions', '2024-08-13', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f3ddc3012');

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
  `location` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
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

INSERT INTO `geoinformatics` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `location`, `type`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(5, 'Finaltest2', 'V32734', 'N2433', 'GeoInformatics', 'Mechanical', 'Onfield', 'Stock', 5, 1000.00, 5000.00, 'ok', 'Nus', '107', '20789', 'A7388fkd', 'Mercy electronics', '2024-08-11', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f388acc01'),
(6, 'cell phone ', 'V472734', 'B3274', 'GeoInformatics', 'IT', 'Inhouse', 'Assets', 4, 10000.00, 40000.00, 'ok', 'bms', '12ds', 'dsaf', 'sdaf', 'Ag traders', '2024-08-12', 'dddddd', 'ByRoad', 'karthi', 'dada', 'Stock In', '66b9db9ddace9');

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
  `location` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
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

INSERT INTO `geoscience` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `location`, `type`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(8, 'Finaltest', 'V32734', 'N2433', 'GeoScience', 'Office', 'Onfield', 'Stock', 5, 1000.00, 5000.00, 'ok', 'Nus', '107', '20789', 'A7388fkd', 'kishore', '2024-08-10', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1e188a0ffe');

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

CREATE TABLE `office` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `model_no` varchar(255) NOT NULL,
  `main_category` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
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
-- Dumping data for table `office`
--

INSERT INTO `office` (`id`, `name`, `serial_no`, `model_no`, `main_category`, `category`, `location`, `type`, `qty`, `price`, `total_price`, `item_remarks`, `project_name`, `project_no`, `purchase_order`, `invoice_no`, `vendor_name`, `date`, `place`, `mos`, `receiver_name`, `vendor_remarks`, `Stock_in_out`, `barcode`) VALUES
(2, 'test2', 'V32734', 'N2433', 'Office', 'Office', 'Warehouse', 'Assets', '8', 1000.00, 8000.00, 'ok', 'Bms', '107', '20789', 'A7388fkd', 'IG solutions', '2024-08-09', 'Sks warehouse', 'Truck', 'Ramki', 'booked by portal', 'Stock In', '66b1f6853742e');

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
('Mani', 'mani', '13456765432', '6e61eb1c893167b00a1631e93d888c4f', 'mani@gmail.com', 'User', 27, '1000110');

-- --------------------------------------------------------

--
-- Table structure for table `stockout`
--

CREATE TABLE `stockout` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `serial_no` varchar(200) NOT NULL,
  `model_no` varchar(200) NOT NULL,
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

INSERT INTO `stockout` (`id`, `name`, `serial_no`, `model_no`, `category`, `qty`, `price`, `total_price`, `stock`, `date`) VALUES
(2, 'Winch', 'QtYb123', 'B12345', 'mechanical', '19', '100.00', '1900', 'Stock Out', '2024-07-05'),
(3, 'phones', 'QtYb123', 'C12345', 'electrical', '7', '10000.00', '70000', 'Stock Out', '2024-07-30'),
(4, 'Electric wireee', 'QtYb123', 'A12345', 'electrical', '23', '10.00', '230', 'Stock Out', '2024-07-29'),
(5, 'pole', 'QtYb123', 'D12345', 'mechanical', '7', '500.00', '3500', 'Stock Out', '2024-07-30'),
(6, 'boxee', 'QtYb123', 'H12345', 'electrical', '14', '5000.00', '5000', 'Stock Out', '2024-06-28'),
(7, 'Tap', 'QtYb123', 'L12345', 'electrical', '9', '40.00', '120', 'Stock Out', '2024-07-29'),
(8, 'Charger', 'QtYb123', 'J12345', 'mechanical', '10', '100.00', '800', 'Stock Out', '2024-08-03'),
(9, 'Notes', 'QtYb123', 'K12345', 'mechanical', '20', '50.00', '100', 'Stock Out', '2024-07-15'),
(10, 'Rope', 'LFU466', 'X12345', 'IT', '30', '1000.00', '4000', 'Stock Out', '2024-07-30'),
(11, 'Laptop', 'QtYb123', 'F12345', 'mechanical', '14', '50000.00', '200000', 'Stock Out', '2024-08-05'),
(12, 'Lan Cable', 'QtYb123', 'E12345', 'electrical', '33', '100.00', '100', 'Stock Out', '2024-07-18'),
(13, 'Vessels', 'L122434254354', 'G123143353553', 'IT', '12', '200.00', '600', 'Stock Out', '2024-07-26'),
(14, 'Rj235', 'QtYb123', 'G12345', 'Mechanical', '18', '5000.00', '5000', 'Stock Out', '2024-07-26'),
(15, 'Sticks', 'D12424343432431', 'V21321424123', 'Electrical', '20', '50.00', '50', 'Stock Out', '2024-07-29'),
(16, 'Sandisk', 'G1233243545', 'H12321435354545', 'Mechanical', '12', '2000.00', '2000', 'Stock Out', '2024-07-29'),
(17, 'Switches', 'G12414541', 'J12343545', 'Mechanical', '8', '10.00', '10', 'Stock Out', '2024-07-29'),
(18, 'Box', 'J325454351', 'L231545', 'Mechanical', '5', '2000.00', '4000', 'Stock Out', '2024-07-29'),
(19, 'Cups', 'L124465757', 'G123432413434', 'IT', '3', '20.00', '80', 'Stock Out', '2024-08-05'),
(20, 'Finaltest', 'V32734', 'N2433', 'Office', '10', '1000.00', '2000', 'Stock Out', '2024-08-12');

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
(19, 'Office');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dispatches`
--
ALTER TABLE `dispatches`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model_no` (`model_no`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `dispatches`
--
ALTER TABLE `dispatches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `geoengineering`
--
ALTER TABLE `geoengineering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `geoinformatics`
--
ALTER TABLE `geoinformatics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `geoscience`
--
ALTER TABLE `geoscience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `office`
--
ALTER TABLE `office`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `stockout`
--
ALTER TABLE `stockout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
