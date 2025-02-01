-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2025 at 11:46 PM
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
-- Database: `voting_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `candidate_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `party_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `election_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`candidate_id`, `name`, `party_name`, `description`, `created_at`, `updated_at`, `election_id`) VALUES
(29, 'Anura Kumara Dissanayake', 'National People\'s Power (NPP)', 'A Marxist leader and former parliamentarian, Dissanayake emphasized anti-corruption, social reforms, and economic justice. He won with 42.31% of the vote.', '2025-02-01 19:25:19', '2025-02-01 19:25:19', 30),
(30, 'Sajith Premadasa', 'Samagi Jana Balawegaya (SJB)', 'Leader of the opposition, Premadasa is known for his progressive policies and focus on economic recovery. He secured 32.7% of the vote.', '2025-02-01 19:26:01', '2025-02-01 19:26:01', 30),
(31, 'Namal Rajapaksa', 'Sri Lanka Podujana Peramuna (SLPP)', 'Son of former President Mahinda Rajapaksa, Namal is a prominent figure known for his political legacy. He garnered 2.57% of the vote.', '2025-02-01 19:26:48', '2025-02-01 19:26:48', 30),
(33, 'Ranil Wickremesinghe', 'Independent', 'The incumbent president, Wickremesinghe focused on national stability but received 17.2% of the vote.', '2025-02-01 19:29:17', '2025-02-01 19:29:17', 30),
(34, 'Anura Kumara Dissanayake', 'National People\'s Power (NPP)', 'Leader of NPP, Dissanayake is a former parliamentarian with a Marxist background. He won a historic victory with his party securing 159 seats in Parliament.', '2025-02-01 19:55:05', '2025-02-01 19:55:05', 31),
(35, 'Sajith Premadasa', 'Samagi Jana Balawegaya (SJB)', 'Leader of the opposition, Sajith Premadasa is known for his progressive policies, economic recovery strategies, and social welfare focus.', '2025-02-01 19:55:54', '2025-02-01 19:55:54', 31),
(36, 'Mahinda Rajapaksa', 'Sri Lanka Podujana Peramuna (SLPP)', 'Former president and influential political figure, Mahinda Rajapaksaâs party secured a small number of seats in the new Parliament, reflecting a decline in support.', '2025-02-01 19:56:37', '2025-02-01 19:56:37', 31),
(37, 'R. Sampanthan', 'Ilankai Tamil Arasu Kachchi (ITAK)', 'A prominent Tamil nationalist leader, Sampanthanâs ITAK focuses on the Tamil communityâs rights and has a strong presence in Northern Sri Lanka.', '2025-02-01 19:57:18', '2025-02-01 19:57:18', 31),
(38, 'Mahinda Rajapaksa', 'Sri Lanka Podujana Peramuna (SLPP)', 'Former President, a dominant figure in Sri Lankaâs political landscape, promoting nationalism and development policies.', '2025-02-01 20:01:42', '2025-02-01 20:01:42', 32),
(39, 'Ravi Karunanayake', 'Independent', 'A former finance minister, Karunanayake is known for his focus on economic policies and governance reforms.', '2025-02-01 20:02:25', '2025-02-01 20:02:25', 32),
(40, 'K. Pathmanathan', 'Ilankai Tamil Arasu Kachchi (ITAK)', 'A Tamil nationalist leader, Pathmanathan advocates for Tamil rights and regional autonomy.', '2025-02-01 20:02:55', '2025-02-01 20:02:55', 32),
(41, 'Wimal Weerawansa', 'New Democratic Front (NDF)', 'A vocal critic of international influence in Sri Lanka, Weerawansa is known for his populist and nationalist stances.', '2025-02-01 20:03:34', '2025-02-01 20:03:34', 32),
(42, 'Dinesh Gunawardena', 'Sri Lanka Podujana Peramuna (SLPP)', 'A key political figure in the Rajapaksa camp, advocating for development, anti-corruption, and strong leadership.', '2025-02-01 20:04:12', '2025-02-01 20:04:12', 32),
(43, 'Tissa Attanayake', 'Samagi Jana Balawegaya (SJB)', 'A former UNP member who joined SJB, Attanayake focuses on policy reforms and governance transparency.', '2025-02-01 20:04:43', '2025-02-01 20:04:43', 32),
(44, 'M. A. Sumanthiran', 'Independent', 'A strong advocate for Tamil minority rights, Sumanthiran represents a significant voice for Tamil communities.', '2025-02-01 20:05:14', '2025-02-01 20:05:14', 32),
(45, 'Vasudeva Nanayakkara', 'Sri Lanka Podujana Peramuna (SLPP)', 'A senior member of the SLPP, known for his involvement in the political landscape, especially in Colombo.', '2025-02-01 20:08:44', '2025-02-01 20:08:44', 33),
(46, 'Ravi Karunanayake', 'National People\'s Power (NPP)', 'Former finance minister, active in local governance, focusing on urban development and policy reforms.', '2025-02-01 20:09:10', '2025-02-01 20:09:10', 33),
(47, 'Ranjith Madduma Bandara', 'Samagi Jana Balawegaya (SJB)', 'Senior member of the SJB, active in the Central and Western regions, advocating for transparency in local governance.', '2025-02-01 20:09:32', '2025-02-01 20:09:32', 33),
(48, 'Nimal Siripala de Silva', 'Sri Lanka Podujana Peramuna (SLPP)', 'Former cabinet minister, well-known for his political career in the Southern region.', '2025-02-01 20:10:02', '2025-02-01 20:10:02', 33),
(49, 'Chandrika Bandaranaike Kumaratunga', 'Sri Lanka Muslim Congress (SLMC)', 'Former President, active in regional development, particularly in the Western and Central provinces.', '2025-02-01 20:10:26', '2025-02-01 20:10:26', 33),
(50, 'Arumugam Thondaman', 'Independent', 'Prominent in the estate sector, advocating for the rights of Tamil-speaking workers and development of estate areas.', '2025-02-01 20:10:51', '2025-02-01 20:10:51', 33);

-- --------------------------------------------------------

--
-- Table structure for table `elections`
--

CREATE TABLE `elections` (
  `election_id` int(11) NOT NULL,
  `election name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elections`
--

INSERT INTO `elections` (`election_id`, `election name`, `description`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`) VALUES
(30, 'Presidential Election', 'The Presidential Elections Act, No. 15 of 1981 mandates that the Election Commission must conduct the Presidential election within a specific time frame. The election must be held no less than one month and no more than two months before the current Presidentâs term ends or in cases where the President announces their intention to hold a new election.', '2025-02-02 01:41:23', '2025-02-02 02:15:55', 'Ended', '2025-02-01 19:04:14', '2025-02-01 20:45:55'),
(31, 'Parliamentary Election ', 'Under the Parliamentary Elections Act, No. 1 of 1981, the President, in every Proclamation dissolving Parliament, specify the nomination period and the date on which the poll shall be taken and publishes a notice in the Gazette.', '2025-02-02 02:16:01', NULL, 'Started', '2025-02-01 19:04:55', '2025-02-01 20:46:01'),
(32, 'Provincial Council Elections ', 'According to the Provincial Councils Elections Act, No. 2 of 1988, within one week from the direction of the President by reason of the operation of Article 154E of the Constitution or by publishing the notice of nomination period by the Election Commission within one week from the dissolution of the Provincial Council by the Governor of the Province under Article 154B (8) (c) of the Constitution.', NULL, NULL, 'pending', '2025-02-01 19:05:48', '2025-02-01 19:05:48'),
(33, 'Local Authorities Election', 'As per the Local Authorities Elections Ordinance (Chapter 262), by publishing a notice by the Election Officer of the district (District Secretary/ Government Agent), within a period of six months preceding the date on which the term of office of the members (4 years) of a Local Authority is due to end, informing his intention to hold an election or by publishing the notice of election by the Election Officer after the dissolution of a Local Authority by the Minister of the central government, who is in charge of the subject of Local Government.', NULL, NULL, 'pending', '2025-02-01 19:06:27', '2025-02-01 19:06:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'voter',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES
(20, 'admin', '123', 'admin@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'admin', '2025-02-01 16:26:28', '2025-02-01 16:27:40'),
(21, 'Tharindu', 'Dilshan', 'tharindudilshan@gmail.com', '22dcf0b5cd454a39a2a7552abe14ead6', 'voter', '2025-02-01 18:26:08', '2025-02-01 18:26:08'),
(22, 'Dimuthu', 'Lakshan', 'dimuthulakshan@gmail.com', '4f23603c65b6dcbfea9c4fcbbadb828e', 'voter', '2025-02-01 18:26:55', '2025-02-01 18:26:55'),
(23, 'Kawishka', 'Sampath', 'kawishkasampath@gmail.com', 'dd54a443c7776cd881dd5130cf919f99', 'voter', '2025-02-01 18:27:37', '2025-02-01 18:27:37'),
(24, 'Chanuka', 'Isuru', 'chanukaisuru@gmail.com', 'c361a838b88ff7bc456a912ef9cdef7b', 'voter', '2025-02-01 18:30:37', '2025-02-01 18:30:37'),
(25, 'Kamal', 'Isura', 'kamalisuru@gmail.com', '7f58341b9dceb1f1edca80dae10b92bc', 'voter', '2025-02-01 18:32:51', '2025-02-01 18:32:51'),
(26, 'Amal', 'Pradip', 'amal@gmail.com', 'd62d41cf17704ddd6cb22c9688130f73', 'voter', '2025-02-01 18:33:20', '2025-02-01 18:33:20'),
(27, 'supun', 'Dilshan', 'dilshan@gmail.com', '0e27139a924aa42f36643b8c33c8e604', 'voter', '2025-02-01 18:33:51', '2025-02-01 18:33:51');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `vote_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `voter_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `voted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`vote_id`, `election_id`, `voter_id`, `candidate_id`, `voted_at`) VALUES
(27, 30, 27, 30, '2025-02-01 20:14:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`candidate_id`),
  ADD KEY `fk_election` (`election_id`);

--
-- Indexes for table `elections`
--
ALTER TABLE `elections`
  ADD PRIMARY KEY (`election_id`),
  ADD KEY `idx_status_dates` (`status`,`start_date`,`end_date`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`vote_id`),
  ADD UNIQUE KEY `unique_vote` (`election_id`,`voter_id`),
  ADD KEY `voter_id` (`voter_id`),
  ADD KEY `candidate_id` (`candidate_id`),
  ADD KEY `idx_election_voter` (`election_id`,`voter_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `candidate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `elections`
--
ALTER TABLE `elections`
  MODIFY `election_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidates`
--
ALTER TABLE `candidates`
  ADD CONSTRAINT `fk_election` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`) ON DELETE CASCADE;

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`voter_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_ibfk_3` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
