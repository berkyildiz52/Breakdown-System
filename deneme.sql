-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 23 Ağu 2022, 09:17:38
-- Sunucu sürümü: 10.4.24-MariaDB
-- PHP Sürümü: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `deneme`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `breakdown`
--

CREATE TABLE `breakdown` (
  `id` bigint(11) NOT NULL,
  `creationTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `machineId` bigint(11) NOT NULL,
  `type` varchar(256) NOT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `description` varchar(2048) NOT NULL,
  `estimatedDeadline` datetime NOT NULL,
  `remainingTime` time GENERATED ALWAYS AS (timediff(`estimatedDeadline`,current_timestamp())) VIRTUAL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `breakdown`
--

INSERT INTO `breakdown` (`id`, `creationTime`, `machineId`, `type`, `state`, `description`, `estimatedDeadline`) VALUES
(1, '2022-08-23 06:29:16', 1000, 'Hidrolik', 3, 'Su pompası arızası', '2022-08-30 09:25:08'),
(2, '2022-08-23 06:29:16', 1000, 'Elektronik', 2, 'Sigorta arızası', '2022-08-30 09:25:08'),
(3, '2022-08-23 06:29:16', 1001, 'Mekanik', 1, 'Havalandırma arızası', '2022-08-30 09:25:08'),
(4, '2022-08-23 06:29:16', 1002, 'Yazılım', 0, 'Program çalışmıyor', '2022-08-30 09:25:08');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `department`
--

CREATE TABLE `department` (
  `code` bigint(20) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `department`
--

INSERT INTO `department` (`code`, `name`) VALUES
(100, 'Üretim'),
(101, 'İhracat');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `history`
--

CREATE TABLE `history` (
  `id` bigint(11) NOT NULL,
  `breakdownId` bigint(11) NOT NULL,
  `process` varchar(256) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `history`
--

INSERT INTO `history` (`id`, `breakdownId`, `process`) VALUES
(1, 1, 'İptal edildi.'),
(2, 2, 'Malzeme sipariş edildi.'),
(3, 2, 'Devre elemanları değiştirildi.'),
(4, 3, 'Bakım ekibi arandı.');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `machine`
--

CREATE TABLE `machine` (
  `id` bigint(20) NOT NULL,
  `departmentCode` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `definition` varchar(2048) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `machine`
--

INSERT INTO `machine` (`id`, `departmentCode`, `status`, `definition`) VALUES
(1000, 100, 1, 'Hidrolik Pres'),
(1001, 100, 0, 'Klima'),
(1002, 101, 0, 'Bilgisayar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `material`
--

CREATE TABLE `material` (
  `id` bigint(11) NOT NULL,
  `breakdownId` bigint(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `material`
--

INSERT INTO `material` (`id`, `breakdownId`, `name`, `amount`) VALUES
(100, 2, 'kablo', 1),
(101, 3, 'vida m10x10', 15),
(102, 3, 'vida m20x20', 20);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `operator`
--

CREATE TABLE `operator` (
  `id` bigint(20) NOT NULL,
  `departmentCode` bigint(20) DEFAULT NULL,
  `fName` varchar(256) NOT NULL,
  `lName` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `operator`
--

INSERT INTO `operator` (`id`, `departmentCode`, `fName`, `lName`) VALUES
(10000, 100, 'Serdar', 'Dursun');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstname` varchar(256) NOT NULL,
  `lastname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(2048) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `role` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Tablo döküm verisi `user`
--

INSERT INTO `user` (`id`, `firstname`, `lastname`, `email`, `password`, `created`, `modified`, `role`) VALUES
(1234567890, 'Ali', 'Veli', 'aliveli@mail.com', '123456', '2022-07-19 05:00:30', '2022-07-19 06:00:30', 123123123),
(1234567891, 'Sude', 'Su', 'sudesu@mail.com\"', '123456', '2022-07-19 05:01:29', '2022-07-19 06:01:29', 123123124);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `breakdown`
--
ALTER TABLE `breakdown`
  ADD PRIMARY KEY (`id`,`creationTime`),
  ADD KEY `machineId` (`machineId`);

--
-- Tablo için indeksler `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`code`);

--
-- Tablo için indeksler `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `breakdownId` (`breakdownId`);

--
-- Tablo için indeksler `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departmentCode` (`departmentCode`);

--
-- Tablo için indeksler `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`),
  ADD KEY `breakdownId` (`breakdownId`);

--
-- Tablo için indeksler `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departmentCode` (`departmentCode`);

--
-- Tablo için indeksler `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `breakdown`
--
ALTER TABLE `breakdown`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `history`
--
ALTER TABLE `history`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `machine`
--
ALTER TABLE `machine`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1003;

--
-- Tablo için AUTO_INCREMENT değeri `material`
--
ALTER TABLE `material`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- Tablo için AUTO_INCREMENT değeri `operator`
--
ALTER TABLE `operator`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10001;

--
-- Tablo için AUTO_INCREMENT değeri `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1234567892;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `operator`
--
ALTER TABLE `operator`
  ADD CONSTRAINT `operator_ibfk_1` FOREIGN KEY (`departmentCode`) REFERENCES `department` (`code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
