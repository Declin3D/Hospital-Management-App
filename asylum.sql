-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Cze 04, 2024 at 02:21 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `asylum`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1, 'admin', '$2b$12$AmMrgDTbjtclwhhDgQSYc.IZmhPNypOP/iaD/W.Ziqvfuu35Wc6Ra'),
(2, 'surykat11', '$2b$12$5L0IuhTkitRiuHx903Bqs.iMVfM.crN7bPJsEK2YJJ1HYGJzDIEXu'),
(3, 'Declin3D', '$2b$12$krYzVorIePLNs0bzMOoakuQYF45G29gdNmZP3SowXNN.JbfxEQure'),
(4, 'Mikołaj', '$2b$12$/mpVyWtOvA7kG3PKAKcjtugOQ1MWkZu4VGUYqIrXZj1f0EpptaUL.'),
(5, 'Rafal', '$2b$12$tP1XAveuItGdIBOHrpW9SeiL7BQLguBkttrdAetUWcKlYrDHSYKK2'),
(6, 'Nigeria', '$2b$12$hvq0UgY8QENJS0mlGsmIBOjdrSy1a38iHrpxngVXUVqxvLCiIosgm'),
(7, 'Adam', '$2b$12$2qpmMbFIn49K.WBeqaAaFuRB4l4RG2ZHVZyxqWQsikF1nCcSqZSR.'),
(8, 'Tasma', '$2b$12$OqHnUl3U35OR1b5qQB8a3.DJ79Pezy7b6VIY/3SXPzAO1utghvvLq'),
(9, 'Marek', '$2b$12$JUYfG/TOPCjwpYtAVsnvHuFP7N.z2VZUF7otg/rLmJITgPMVD54h.'),
(10, 'Tomasz', '$2b$12$Ra6mcbdejBDZi1/DYKLcPO4yTZdhjtjxN6mBs.o6BmPgYARuKeZ4u'),
(11, 'Piotr', '$2b$12$.rWeeTwjW5p3Ox5lwufuHe43S0PEt9TGZEvzLz5kLC/nN7oRzzc5C');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `pay` decimal(10,2) NOT NULL,
  `position` varchar(150) NOT NULL,
  `patients_served` int(11) DEFAULT 0,
  `success_rate` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `first_name`, `last_name`, `specialization`, `pay`, `position`, `patients_served`, `success_rate`) VALUES
(7, 'Christopher', 'Wilson', 'Psychiatrist', 73900.00, 'More Senior Doctor', 52, 0.84),
(8, 'Emily', 'Taylor', 'Endocrinologist', 8300.00, 'Senior Doctor', 58, 0.82),
(9, 'John', 'Jones', 'Orthopedic Surgeon', 8600.00, 'Senior Doctor', 62, 0.89),
(10, 'Amanda', 'Anderson', 'Urologist', 8400.00, 'Senior Doctor', 56, 0.83),
(14, 'Bartosz', 'Wasilkowski', 'Psychiatrist', 20.00, 'Head of Psychiatrics', 2, 0),
(15, 'Jayden', 'Lewis', 'Obstetrics and gynecology', 11946.06, 'Junior Resident', 96, 91),
(16, 'Leo', 'Powell', 'Internal medicine', 17934.08, 'Senior Doctor', 94, 97),
(17, 'Elizabeth', 'Cook', 'Nuclear medicine', 32420.25, 'Consultant', 92, 92),
(18, 'Eli', 'James', 'Pediatrics', 38656.14, 'Medical Director', 97, 98),
(19, 'Everett', 'Hayes', 'Physical medicine and rehabilitation', 34336.05, 'Medical Director', 98, 91);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `doctor_schedule`
--

CREATE TABLE `doctor_schedule` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `work_day` varchar(50) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_schedule`
--

INSERT INTO `doctor_schedule` (`id`, `doctor_id`, `work_day`, `start_time`, `end_time`) VALUES
(6, 9, 'Monday', '03:59:00', '04:10:00'),
(7, 14, 'friday', '09:00:00', '17:00:00'),
(8, 17, 'friday', '18:30:00', '18:40:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `finances`
--

CREATE TABLE `finances` (
  `id` int(11) NOT NULL,
  `month` varchar(50) NOT NULL,
  `budget` decimal(10,2) NOT NULL,
  `expenses` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `finances`
--

INSERT INTO `finances` (`id`, `month`, `budget`, `expenses`) VALUES
(1, 'January', 100000.00, 95000.00),
(2, 'February', 120000.00, 105000.00),
(3, 'March', 110000.00, 100000.00),
(4, 'April', 130000.00, 115000.00),
(5, 'May', 150000.00, 125000.00),
(6, 'June', 140000.00, 120000.00),
(7, 'July', 135000.00, 110000.00),
(8, 'August', 125000.00, 105000.00),
(9, 'September', 130000.00, 115000.00),
(10, 'October', 145000.00, 120000.00),
(11, 'November', 135000.00, 100000.00),
(12, 'December', 150000.00, 110000.00),
(13, 'January 2024', 160000.00, 115428.00),
(14, 'Februray 2024', 168969.00, 120412.00),
(15, 'March 2024', 189754.00, 216237.00),
(16, 'April 2024', 189754.00, 237095.00),
(17, 'May 2024', 182853.00, 256636.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `disease` varchar(100) NOT NULL,
  `checked_in` date DEFAULT NULL,
  `medical_history` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `first_name`, `last_name`, `disease`, `checked_in`, `medical_history`) VALUES
(9, 'Charlotte', 'Taylor', 'Depression', '2024-05-28', 'Loss of interest and sadness'),
(10, 'Benjamin', 'Anderson', 'Allergy', '2024-05-29', 'Allergic to peanuts'),
(23, 'Bartosz', 'Wasilkowski', 'Schizofrenia', '2024-06-02', 'Nieudane leczenia, wielokrotnie ucieczki z psychiatryka'),
(24, 'Adam', 'Bukowski', 'Nie umie w zegar', '2024-06-02', 'Nieudane leczenia, wielokrotnie ucieczki z psychiatryka'),
(25, 'Jarek', 'Psikuta', 'Schizofrenia', '2024-06-02', 'Nieudane leczenia, wielokrotnie ucieczki z psychiatryka'),
(26, 'Bartosz', 'Delekta', 'COVID-19', '2024-06-02', 'NIEUDANE WYLECZENIE'),
(27, 'Mikołaj', 'Perczytński', 'Speedruner', '2024-06-02', 'Nieudane leczenia, wielokrotnie ucieczki z psychiatryka'),
(28, 'Adam', 'Wasilkowski', 'COVID-19', '2024-06-02', 'No previous medical history.'),
(29, 'Rafał', 'Perczytński', 'COVID-19', '2024-06-02', 'NIEUDANE WYLECZENIE'),
(30, 'Tomasz', 'Ciba', 'Schizofrenia', '2024-06-02', 'No previous medical history.'),
(31, 'Adam', 'WASILKOWSKI', 'COVID-19', '2024-06-02', 'NIEUDANE WYLECZENIE');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `patient_schedule`
--

CREATE TABLE `patient_schedule` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_day` date NOT NULL,
  `appointment_time` time NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_schedule`
--

INSERT INTO `patient_schedule` (`id`, `patient_id`, `appointment_day`, `appointment_time`, `doctor_id`, `reason`) VALUES
(11, 25, '2044-07-03', '19:30:00', 14, NULL),
(12, 30, '2077-07-03', '17:00:00', 14, NULL),
(13, 31, '2025-03-03', '18:50:00', 14, NULL),
(14, 29, '2024-07-16', '15:30:00', 15, 'Zchizofrenia');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `threshold` int(11) NOT NULL,
  `price` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`id`, `name`, `quantity`, `threshold`, `price`) VALUES
(1, 'Syringes', 100, 20, 1.50),
(2, 'Bandages', 200, 50, 2.00),
(3, 'Medications', 50, 10, 10.00),
(4, 'Gloves', 420, 100, 0.75),
(5, 'Scalpels', 50, 10, 5.00),
(6, 'Stethoscopes', 20, 5, 15.00),
(7, 'X-ray Films', 100, 20, 3.00),
(8, 'Blood Pressure Monitors', 30, 10, 25.00),
(9, 'Ultrasound Machines', 5, 2, 500.00),
(10, 'MRI Machines', 2, 1, 1000.00),
(21, 'Resiprators', 20, 100, 1500.00),
(22, 'Brum', 20, 100, 50.00),
(23, 'Miotła', 20, 100, 5.00),
(24, 'Plaskacz', 20, 100, 2.00),
(25, 'Chusteczki', 20, 100, 5.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `pay` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `first_name`, `last_name`, `position`, `pay`) VALUES
(7, 'Daniel', 'Miller', 'Security Guard', 4000.00),
(8, 'Jessica', 'Davis', 'Pharmacist', 5500.00),
(9, 'Christopher', 'Wilson', 'Lab Technician', 4700.00),
(10, 'Amanda', 'Taylor', 'Accountant', 4800.00);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeksy dla tabeli `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `doctor_schedule`
--
ALTER TABLE `doctor_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indeksy dla tabeli `finances`
--
ALTER TABLE `finances`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `patient_schedule`
--
ALTER TABLE `patient_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `fk_doctor` (`doctor_id`);

--
-- Indeksy dla tabeli `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `doctor_schedule`
--
ALTER TABLE `doctor_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `finances`
--
ALTER TABLE `finances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `patient_schedule`
--
ALTER TABLE `patient_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_schedule`
--
ALTER TABLE `doctor_schedule`
  ADD CONSTRAINT `doctor_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `patient_schedule`
--
ALTER TABLE `patient_schedule`
  ADD CONSTRAINT `fk_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `patient_schedule_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
