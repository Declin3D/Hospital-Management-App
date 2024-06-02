-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Maj 31, 2024 at 07:46 PM
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
(1, 'admin', '$2b$12$AmMrgDTbjtclwhhDgQSYc.IZmhPNypOP/iaD/W.Ziqvfuu35Wc6Ra');

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
(1, 'Michael', 'Smith', 'Cardiologist', 8000.00, 'Senior Doctor', 50, 0.85),
(2, 'Jennifer', 'Johnson', 'Pediatrician', 7500.00, 'Senior Doctor', 40, 0.9),
(3, 'David', 'Williams', 'Neurologist', 8500.00, 'Senior Doctor', 60, 0.8),
(4, 'Jessica', 'Brown', 'Dermatologist', 7800.00, 'Senior Doctor', 55, 0.88),
(5, 'Daniel', 'Miller', 'Oncologist', 8200.00, 'Senior Doctor', 45, 0.86),
(6, 'Sarah', 'Davis', 'Gynecologist', 7700.00, 'Senior Doctor', 48, 0.87),
(7, 'Christopher', 'Wilson', 'Psychiatrist', 7900.00, 'Senior Doctor', 52, 0.84),
(8, 'Emily', 'Taylor', 'Endocrinologist', 8300.00, 'Senior Doctor', 58, 0.82),
(9, 'John', 'Jones', 'Orthopedic Surgeon', 8600.00, 'Senior Doctor', 62, 0.89),
(10, 'Amanda', 'Anderson', 'Urologist', 8400.00, 'Senior Doctor', 56, 0.83);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `doctorschedule`
--

CREATE TABLE `doctorschedule` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `work_day` varchar(50) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 4, 'Thursday ', '08:00:00', '15:30:00'),
(2, 5, 'Thursday ', '08:00:00', '15:30:00'),
(3, 7, 'Sunday', '08:30:00', '15:00:00');

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
(12, 'December', 150000.00, 110000.00);

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
(1, 'Emma', 'Wilson', 'Hypertension', '2024-05-20', 'Previous heart attack'),
(2, 'Noah', 'Smith', 'Asthma', '2024-05-21', 'Allergic to pollen'),
(3, 'Olivia', 'Johnson', 'Diabetes', '2024-05-22', 'Family history of diabetes'),
(4, 'Liam', 'Brown', 'Cancer', '2024-05-23', 'Undergoing chemotherapy'),
(5, 'Ava', 'Jones', 'Arthritis', '2024-05-24', 'Joint pain and inflammation'),
(6, 'William', 'Davis', 'Migraine', '2024-05-25', 'Frequent headaches'),
(8, 'James', 'Miller', 'Obesity', '2024-05-27', 'High BMI and unhealthy lifestyle'),
(9, 'Charlotte', 'Taylor', 'Depression', '2024-05-28', 'Loss of interest and sadness'),
(10, 'Benjamin', 'Anderson', 'Allergy', '2024-05-29', 'Allergic to peanuts'),
(11, 'Emma', 'Wilson', 'Hypertension', '2024-05-20', 'Previous heart attack'),
(12, 'Noah', 'Smith', 'Asthma', '2024-05-21', 'Allergic to pollen'),
(13, 'Olivia', 'Johnson', 'Diabetes', '2024-05-22', 'Family history of diabetes'),
(14, 'Liam', 'Brown', 'Cancer', '2024-05-23', 'Undergoing chemotherapy'),
(15, 'Ava', 'Jones', 'Arthritis', '2024-05-24', 'Joint pain and inflammation'),
(16, 'William', 'Davis', 'Migraine', '2024-05-25', 'Frequent headaches'),
(17, 'Sophia', 'Wilson', 'Anxiety', '2024-05-26', 'Panic attacks and insomnia'),
(18, 'James', 'Miller', 'Obesity', '2024-05-27', 'High BMI and unhealthy lifestyle'),
(19, 'Charlotte', 'Taylor', 'Depression', '2024-05-28', 'Loss of interest and sadness'),
(20, 'Benjamin', 'Anderson', 'Allergy', '2024-05-29', 'Allergic to peanuts');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `patientschedule`
--

CREATE TABLE `patientschedule` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_day` date NOT NULL,
  `appointment_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `patient_schedule`
--

CREATE TABLE `patient_schedule` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_day` date NOT NULL,
  `appointment_time` time NOT NULL,
  `doctor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_schedule`
--

INSERT INTO `patient_schedule` (`id`, `patient_id`, `appointment_day`, `appointment_time`, `doctor_id`) VALUES
(6, 8, '2024-06-10', '15:30:00', 5);

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
(4, 'Gloves', 320, 100, 0.75),
(5, 'Scalpels', 50, 10, 5.00),
(6, 'Stethoscopes', 20, 5, 15.00),
(7, 'X-ray Films', 100, 20, 3.00),
(8, 'Blood Pressure Monitors', 30, 10, 25.00),
(9, 'Ultrasound Machines', 5, 2, 500.00),
(10, 'MRI Machines', 2, 1, 1000.00);

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
(1, 'John', 'Doe', 'Manager', 5000.00),
(2, 'Jane', 'Smith', 'Assistant', 4000.00),
(3, 'Michael', 'Johnson', 'Technician', 4500.00),
(4, 'Emily', 'Williams', 'Nurse', 4200.00),
(5, 'David', 'Brown', 'Receptionist', 3800.00),
(6, 'Sarah', 'Jones', 'Janitor', 3500.00),
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
-- Indeksy dla tabeli `doctorschedule`
--
ALTER TABLE `doctorschedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_doctor_schedule_doctor_id` (`doctor_id`);

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
-- Indeksy dla tabeli `patientschedule`
--
ALTER TABLE `patientschedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `doctorschedule`
--
ALTER TABLE `doctorschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_schedule`
--
ALTER TABLE `doctor_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `finances`
--
ALTER TABLE `finances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `patientschedule`
--
ALTER TABLE `patientschedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_schedule`
--
ALTER TABLE `patient_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctorschedule`
--
ALTER TABLE `doctorschedule`
  ADD CONSTRAINT `fk_doctor_schedule_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `doctor_schedule`
--
ALTER TABLE `doctor_schedule`
  ADD CONSTRAINT `doctor_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `patientschedule`
--
ALTER TABLE `patientschedule`
  ADD CONSTRAINT `patientschedule_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

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
