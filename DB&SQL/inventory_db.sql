-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2024 at 12:12 PM
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
(1, 'IN001', 'PN001', '2024-08-28', 'Baroda Polyform', 'SK warehouse', 'ByRoad', 'None', 'Manimegalai', '[{\"name\":\"Product 1\",\"qty\":\"5\"},{\"name\":\"Product 2\",\"qty\":\"10\"}]', 'e8eb249a363eb79478695e11856aa626', 0);

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
('Kishore', 'kishore', '9600701778', '98c3b24124499b152e7bdfedd8a38102', 'kishore@trideltechnologies.com', 'Admin', 1, '035');

-- --------------------------------------------------------

--
-- Table structure for table `receiver`
--

CREATE TABLE `receiver` (
  `id` int(11) NOT NULL,
  `receiverName` varchar(255) NOT NULL
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

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id` int(11) NOT NULL,
  `vendorName` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `receiver`
--
ALTER TABLE `receiver`
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
-- AUTO_INCREMENT for table `boxdetails`
--
ALTER TABLE `boxdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dispatches`
--
ALTER TABLE `dispatches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ess`
--
ALTER TABLE `ess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `geoengineering`
--
ALTER TABLE `geoengineering`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `geoinformatics`
--
ALTER TABLE `geoinformatics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `geoscience`
--
ALTER TABLE `geoscience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `receiver`
--
ALTER TABLE `receiver`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stockout`
--
ALTER TABLE `stockout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
