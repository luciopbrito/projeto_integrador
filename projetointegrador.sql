-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2022 at 09:22 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projetointegrador`
--

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id_client` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `street` varchar(150) NOT NULL,
  `street_number` int(11) NOT NULL,
  `district` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id_client`, `name`, `phone`, `email`, `password`, `cpf`, `cep`, `street`, `street_number`, `district`, `city`) VALUES
(1, 'Lucio Pereira Brito', '11948190733', 'lucio@gmail.com', 'lucio', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos'),
(2, 'julio Pereira Brito', '11948190733', 'julio@gmail.com', 'julio', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos'),
(3, 'julia Pereira Brito', '11948190733', 'julia@gmail.com', 'julia', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos'),
(4, 'teste Pereira Brito', '11948190733', 'teste1@gmail.com', 'teste', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos'),
(5, 'nome sobrenome', '11948190733', 'lucio3@gmail.com', '12345', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos'),
(6, 'valber almeida', '1123123213', 'valber@gmail.com', 'valber', '53676591879', '07043050', 'Italiana', 142, 'Vila ', 'Guarulhos'),
(7, 'wagner pereira', '11948190733', 'wagner@gmail.com', 'wagner', '53676591879', '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos');

-- --------------------------------------------------------

--
-- Table structure for table `orcamentos`
--

CREATE TABLE `orcamentos` (
  `id_orcamento` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  `id_product` int(11) DEFAULT NULL,
  `id_service` int(11) DEFAULT NULL,
  `start_date` date NOT NULL,
  `due_date` date NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `local` int(11) DEFAULT NULL,
  `type_service` int(11) DEFAULT NULL,
  `cep` varchar(8) NOT NULL,
  `street` varchar(150) NOT NULL,
  `street_number` int(11) NOT NULL,
  `district` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `qtde_product` int(11) DEFAULT NULL,
  `qtde_service` int(11) DEFAULT NULL,
  `value_orcamento` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orcamentos`
--

INSERT INTO `orcamentos` (`id_orcamento`, `id_client`, `id_product`, `id_service`, `start_date`, `due_date`, `description`, `local`, `type_service`, `cep`, `street`, `street_number`, `district`, `city`, `qtde_product`, `qtde_service`, `value_orcamento`) VALUES
(8, 1, 7, NULL, '2022-12-20', '2022-12-28', 'testes', NULL, NULL, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', 2, NULL, 900),
(9, 1, 10, NULL, '2022-12-05', '2022-12-21', 'gafaegage', NULL, NULL, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', 3, NULL, 2220),
(10, 1, 12, NULL, '2022-12-19', '2022-12-28', 'testetsets', NULL, NULL, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', 2, NULL, 600),
(11, 1, NULL, 1, '2022-12-11', '2022-12-20', '5345353534', 1, 0, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', NULL, NULL, 120.34),
(12, 7, NULL, 5, '2022-12-11', '2022-12-28', 'twst43wt3', 0, 0, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', NULL, NULL, 200),
(13, 7, 11, NULL, '2022-12-11', '2022-12-19', '242342432', NULL, NULL, '07043050', 'Italiana', 153, 'Vila Endres', 'Guarulhos', 2, NULL, 220);

-- --------------------------------------------------------

--
-- Table structure for table `produtos`
--

CREATE TABLE `produtos` (
  `id_product` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `value` float DEFAULT NULL,
  `isPromotion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `produtos`
--

INSERT INTO `produtos` (`id_product`, `name`, `value`, `isPromotion`) VALUES
(7, 'Produto 1', 450, 1),
(8, 'Produto 2', 320, 1),
(9, 'Produto 3', 50, 0),
(10, 'Produto 4', 740, 1),
(11, 'Produto 5', 110, 0),
(12, 'Produto 6', 300, 0);

-- --------------------------------------------------------

--
-- Table structure for table `servicos`
--

CREATE TABLE `servicos` (
  `id_service` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `value` float DEFAULT NULL,
  `isPromotion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `servicos`
--

INSERT INTO `servicos` (`id_service`, `name`, `value`, `isPromotion`) VALUES
(1, 'servico 1', 120.34, 0),
(2, 'servico 2', 400, 1),
(3, 'servico 3', 120, 1),
(4, 'servico 4', 500, 0),
(5, 'servico 5', 200, 1),
(6, 'servico 6', 100, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_client`);

--
-- Indexes for table `orcamentos`
--
ALTER TABLE `orcamentos`
  ADD PRIMARY KEY (`id_orcamento`),
  ADD KEY `fk_client` (`id_client`),
  ADD KEY `fk_product` (`id_product`),
  ADD KEY `fk_service` (`id_service`);

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id_product`);

--
-- Indexes for table `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id_service`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orcamentos`
--
ALTER TABLE `orcamentos`
  MODIFY `id_orcamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id_service` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orcamentos`
--
ALTER TABLE `orcamentos`
  ADD CONSTRAINT `fk_client` FOREIGN KEY (`id_client`) REFERENCES `clientes` (`id_client`),
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`id_product`) REFERENCES `produtos` (`id_product`),
  ADD CONSTRAINT `fk_service` FOREIGN KEY (`id_service`) REFERENCES `servicos` (`id_service`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
