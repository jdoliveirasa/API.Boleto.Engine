-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 03-Fev-2018 às 22:16
-- Versão do servidor: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vixnu_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_temp_cabinets` (IN `cabinet_id` INT(11))  BEGIN
    DECLARE i INT DEFAULT 0; 
    DECLARE n INT DEFAULT 0; 
    SET i = 0;
    SELECT c.quantity FROM cabinets c WHERE c.id = cabinet_id INTO n; 
    WHILE i < n DO 
            INSERT INTO temp_cabinets (cabinet_id, cabinet, number, property, property_type, customer) 
            SELECT c.id, c.description, i + 1, p.description, pt.description, NULL 
            FROM cabinets c INNER JOIN propertys p 
                ON c.property_id = p.id INNER JOIN property_types pt 
                ON p.property_type_id = pt.id 
            WHERE c.id = cabinet_id; 
            UPDATE temp_cabinets AS tc 
            INNER JOIN cabinet_customers cc 
                ON cc.number = tc.number INNER JOIN cabinet_statuss cst 
                ON cc.cabinet_status_id = cst.id INNER JOIN customers cs 
                ON cc.customer_id = cs.id 
            SET tc.customer = cs.name, 
                tc.status = cst.description 
            WHERE cc.cabinet_id = cabinet_id; 
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `addresss`
--

CREATE TABLE `addresss` (
  `id` int(11) NOT NULL,
  `patio_type_id` int(11) DEFAULT NULL,
  `federative_unit_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `patio` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `complement` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighborhood` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `zip_code` int(11) NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `addresss`
--

INSERT INTO `addresss` (`id`, `patio_type_id`, `federative_unit_id`, `customer_id`, `patio`, `number`, `complement`, `neighborhood`, `city`, `zip_code`, `registration_date`, `modification_date`) VALUES
(1, 8, 13, 1, 'Lagoa da Prata', 667, NULL, 'Estrela do Oriente', 'Belo Horizonte', 32180930, '2016-08-15 02:27:11', '2016-08-29 11:10:30'),
(2, 57, 19, 1, 'Praia Grande', 410, 'cs2', 'Ipanema', 'Rio de Janeiro', 22340110, '2016-08-15 02:28:53', NULL),
(3, 57, 13, 3, 'Rodrigues Costa', 110, 'ap320', 'Candeias', 'Brumadinho', 32190310, '2016-08-15 03:00:27', NULL),
(7, 1, 13, 5, 'das Canoas III', 89, 'ap380', 'Cidade Nova', 'Passos', 88767543, '2016-08-29 11:00:21', '2016-08-29 11:04:30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `balance_types`
--

CREATE TABLE `balance_types` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `balance_types`
--

INSERT INTO `balance_types` (`id`, `description`) VALUES
(1, 'Entrada'),
(2, 'Saída');

-- --------------------------------------------------------

--
-- Estrutura da tabela `banks`
--

CREATE TABLE `banks` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `banks`
--

INSERT INTO `banks` (`id`, `description`) VALUES
(1, 'Banco do Brasil'),
(2, 'Bradesco'),
(3, 'Caixa Economica Federal'),
(4, 'HSBC'),
(5, 'Itaú'),
(6, 'Santander');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cabinets`
--

CREATE TABLE `cabinets` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cabinets`
--

INSERT INTO `cabinets` (`id`, `property_id`, `quantity`, `description`, `registration_date`, `modification_date`) VALUES
(1, 2, 12, 'Armario de ferro sem chave', '2016-08-15 02:44:02', NULL),
(2, 1, 16, 'Escaninho de madeira com chave', '2016-08-15 02:44:51', NULL),
(4, 5, 2, 'Guarda Roupa Marfin', '2016-08-29 12:52:37', '2016-08-29 12:57:42'),
(5, 5, 8, 'Armario grande de madeira', '2016-09-03 18:29:35', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cabinet_customers`
--

CREATE TABLE `cabinet_customers` (
  `id` int(11) NOT NULL,
  `cabinet_id` int(11) DEFAULT NULL,
  `cabinet_status_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cabinet_customers`
--

INSERT INTO `cabinet_customers` (`id`, `cabinet_id`, `cabinet_status_id`, `customer_id`, `number`, `registration_date`, `modification_date`) VALUES
(7, 2, 2, 1, 1, '2016-08-29 10:30:29', NULL),
(8, 2, 2, 1, 7, '2016-08-29 10:30:30', NULL),
(9, 2, 2, 1, 8, '2016-08-29 10:30:31', NULL),
(10, 2, 2, 1, 9, '2016-08-29 10:30:31', NULL),
(11, 2, 2, 1, 15, '2016-08-29 10:30:32', NULL),
(17, 1, 2, 1, 4, '2016-09-06 19:09:26', NULL),
(18, 1, 2, 1, 7, '2016-09-06 19:09:32', NULL),
(22, 1, 2, 3, 1, '2016-09-07 16:00:13', NULL),
(23, 1, 2, 3, 2, '2016-09-07 16:00:13', NULL),
(24, 1, 2, 3, 5, '2016-09-07 16:00:13', NULL),
(25, 1, 2, 3, 6, '2016-09-07 16:00:14', NULL),
(26, 1, 2, 3, 8, '2016-09-07 16:00:14', NULL),
(27, 1, 2, 3, 9, '2016-09-07 16:00:14', NULL),
(28, 1, 2, 3, 10, '2016-09-07 16:00:14', NULL),
(29, 1, 2, 3, 11, '2016-09-07 16:00:14', NULL),
(30, 1, 2, 3, 12, '2016-09-07 16:00:17', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `cabinet_select`
--
CREATE TABLE `cabinet_select` (
`id` int(11)
,`description` varchar(141)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cabinet_statuss`
--

CREATE TABLE `cabinet_statuss` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `is_busy` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cabinet_statuss`
--

INSERT INTO `cabinet_statuss` (`id`, `description`, `is_busy`) VALUES
(1, 'Livre', 0),
(2, 'Ocupado', 1),
(3, 'Reservado', 1),
(4, 'Com Defeito', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cashiers`
--

CREATE TABLE `cashiers` (
  `id` int(11) NOT NULL,
  `balance_type_id` int(11) DEFAULT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `details` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL,
  `value` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cashiers`
--

INSERT INTO `cashiers` (`id`, `balance_type_id`, `description`, `details`, `date`, `registration_date`, `modification_date`, `value`) VALUES
(8, 1, 'Informações do Novo Registro', 'Detalhes do Novo Registro', '2017-05-14 03:00:00', '2017-05-04 04:49:02', NULL, 3500.09),
(10, 1, 'Teste 51', 'Ok aqui vai um teste de mes anterior', '2017-04-29 03:00:00', '2017-05-07 05:32:03', NULL, 30000.97),
(11, 2, 'Saida de Março', 'Outro mês', '2017-03-15 03:00:00', '2017-05-07 05:34:10', NULL, 257.78),
(12, 1, 'Reembolso de 92', 'Reembolso antigo', '1992-12-22 02:00:00', '2017-05-07 05:35:32', NULL, 12500.67),
(17, 1, 'teste', 'teste', '2017-05-17 03:00:00', '2017-05-14 10:04:20', NULL, 3500),
(19, 2, 'teste', 'teste', '2017-05-10 03:00:00', '2017-05-14 10:05:50', NULL, 500),
(20, 1, 'teste', 'teste', '2017-05-10 03:00:00', '2017-05-14 10:12:05', NULL, 899),
(25, 1, 'teste 100', 'teste 100', '2017-05-10 03:00:00', '2017-05-14 20:40:25', NULL, 3000.01),
(27, 2, 'Teste', 'Teste', '2017-05-16 03:00:00', '2017-05-14 21:07:52', NULL, 1200),
(29, 1, 'Pagamento de Aluguel', 'Pagamento', '2018-01-28 02:00:00', '2018-01-28 13:09:22', NULL, 3000),
(30, 2, 'Comprei Material de Limpeza', 'Material de Limpeza', '2018-01-28 02:00:00', '2018-01-28 13:09:59', NULL, 150);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cedants`
--

CREATE TABLE `cedants` (
  `id` int(11) NOT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `document` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `identification` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cedant_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uf` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path_cedant_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agency` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agency_dv` int(11) DEFAULT NULL,
  `current_account` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `current_account_dv` int(11) DEFAULT NULL,
  `covenant_format` int(11) DEFAULT NULL,
  `convenant` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract_agreement` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wallet` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wallet_variation` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wallet_description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_code` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cedants`
--

INSERT INTO `cedants` (`id`, `bank_id`, `code`, `document`, `identification`, `cedant_name`, `address`, `city`, `uf`, `path_cedant_logo`, `agency`, `agency_dv`, `current_account`, `current_account_dv`, `covenant_format`, `convenant`, `contract_agreement`, `wallet`, `wallet_variation`, `wallet_description`, `customer_code`) VALUES
(1, 1, '001', '00.666.000/0000-66', 'Dell Inc.', 'João das Coves', 'Rua dos Quilobytes, 10101', 'Vila Velha', 'ES', '/img/cedant_logo/dell_logo.png', '1400', 1, '16611', 1, 7, '1105369', '017512813', '18', '-19', NULL, NULL),
(2, 2, '237', '00.777.000/0000-77', 'eBay.com', 'Fulano Felino', 'Alameda dos Megabytes, 101', 'São Paulo', 'SP', '/img/cedant_logo/ebay_logo.png', '2313', 2, '0026410', 5, NULL, NULL, NULL, '06', NULL, NULL, NULL),
(3, 3, '104', '00.111.000/0000-11', 'Intel Corp.', 'Beltrano Saliente', 'Rua dos Gigabytes, 666', 'Rio de Janeiro', 'RJ', '/img/cedant_logo/intel_logo.png', '1564', 0, '441530', 0, NULL, NULL, NULL, 'SR', NULL, NULL, NULL),
(4, 5, '341', '00.101.000/0000-13', 'Sony', 'John Doe', 'Av dos Terabytes, 177', 'Belo Horizonte', 'MG', '/img/cedant_logo/playstation_logo.png', '4536', NULL, '09053', 5, NULL, NULL, NULL, '175', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cleanings`
--

CREATE TABLE `cleanings` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `penalityValue` double NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cleaning_customers`
--

CREATE TABLE `cleaning_customers` (
  `id` int(11) NOT NULL,
  `cleaning_id` int(11) DEFAULT NULL,
  `cleaning_status_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `start` time NOT NULL,
  `end` time NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cleaning_statuss`
--

CREATE TABLE `cleaning_statuss` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `cleaning_statuss`
--

INSERT INTO `cleaning_statuss` (`id`, `description`) VALUES
(1, 'Executado'),
(2, 'Não Executado'),
(3, 'Pendente');

-- --------------------------------------------------------

--
-- Estrutura da tabela `credit_cards`
--

CREATE TABLE `credit_cards` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `flag` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `number` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `cvc2` int(11) NOT NULL,
  `result_code` int(11) NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `customer_type_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cpf` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `phone_1` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `phone_2` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `customers`
--

INSERT INTO `customers` (`id`, `customer_type_id`, `email`, `name`, `birth_date`, `gender`, `cpf`, `phone_1`, `phone_2`, `registration_date`, `modification_date`) VALUES
(1, 1, 'nando@gmail.com', 'Fernando Silva Bueno', '2016-08-06', 'M', '04567823312', '21987652432', '2132145655', '2016-08-15 02:20:50', '2016-08-29 10:05:59'),
(2, 1, 'trema@tutanota.com', 'Carlos Gramado Torres', '1992-08-14', 'M', '76731412245', '3133431233', '31987563312', '2016-08-15 02:23:11', NULL),
(3, 2, 'apmoreira@hotmail.com', 'Ana Paula Moreira Oliveira', '1997-08-14', 'F', '01575122325', '11988742930', '1133421231', '2016-08-15 02:24:29', '2016-08-15 02:59:31'),
(5, 2, 'triplex@gmail.ll', 'He Man II', '2016-08-10', 'M', '77788866677', '1123322345', NULL, '2016-08-28 08:01:21', '2016-08-29 10:50:28'),
(10, 2, 'triplex@gmail.ss', 'Renan Andrade', '2016-08-11', 'F', '55544433333', '1123322345', NULL, '2016-08-29 08:25:43', '2016-08-29 10:12:02'),
(11, 2, 'jdoliveirasa@gmail.com', 'Jonathan Oliveira', '2016-08-09', 'M', '99988877766', '21987652432', NULL, '2016-08-30 17:42:30', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `customer_types`
--

CREATE TABLE `customer_types` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `customer_types`
--

INSERT INTO `customer_types` (`id`, `description`) VALUES
(1, 'Morador'),
(2, 'Turista');

-- --------------------------------------------------------

--
-- Estrutura da tabela `federative_units`
--

CREATE TABLE `federative_units` (
  `id` int(11) NOT NULL,
  `acronym` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `federative_units`
--

INSERT INTO `federative_units` (`id`, `acronym`, `description`) VALUES
(1, 'AC', 'Acre'),
(2, 'AL', 'Alagoas'),
(3, 'AP', 'Amapá'),
(4, 'AM', 'Amazonas'),
(5, 'BA', 'Bahia'),
(6, 'CE', 'Ceará'),
(7, 'DF', 'Distrito Federal'),
(8, 'ES', 'Espírito Santo'),
(9, 'GO', 'Goiás'),
(10, 'MA', 'Maranhão'),
(11, 'MT', 'Mato Grosso'),
(12, 'MS', 'Mato Grosso do Sul'),
(13, 'MG', 'Minas Gerais'),
(14, 'PA', 'Pará'),
(15, 'PB', 'Paraíba'),
(16, 'PR', 'Paraná'),
(17, 'PE', 'Pernambuco'),
(18, 'PI', 'Piauí'),
(19, 'RJ', 'Rio de Janeiro'),
(20, 'RN', 'Rio Grande do Norte'),
(21, 'RS', 'Rio Grande do Sul'),
(22, 'RO', 'Rondônia'),
(23, 'RR', 'Roraima'),
(24, 'SC', 'Santa Catarina'),
(25, 'SP', 'São Paulo'),
(26, 'SE', 'Sergipe'),
(27, 'TO', 'Tocantins');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`version`) VALUES
('20100103040718'),
('20170502072721');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `access_token` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `scope` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`access_token`, `client_id`, `user_id`, `expires`, `scope`) VALUES
('0188d83aa301510cfaa4c5cf122d9114352789c2', 'administrador_client', 'oldabe', '2017-05-02 09:53:36', 'Administrador'),
('0791de804550338090c0caf70bd328bae4dd7c85', 'administrador_client', 'oldabe', '2017-05-07 00:29:43', 'Administrador'),
('0b9e9b3640d027ca4387fee2b3ee804943baccb4', 'administrador_client', 'oldabe', '2017-05-20 10:05:23', 'Administrador'),
('1f8b57d3f5e502ffb11e8f8722f0b85a254a2e0e', 'administrador_client', 'oldabe', '2017-05-02 04:30:47', 'Administrador'),
('237d6065ac8b67ac9b0d33a1a93d6345dea25642', 'administrador_client', 'oldabe', '2017-05-15 06:54:59', 'Administrador'),
('2433325ccdda17fa24b751a743a7ea3e616715b8', 'administrador_client', 'oldabe', '2017-05-20 12:19:02', 'Administrador'),
('2f75c2001645467e460a177f7e5655597d34ce59', 'administrador_client', 'oldabe', '2017-05-07 10:08:58', 'Administrador'),
('34e7cd1c6b55d01111433d0f9788a96c110d0408', 'administrador_client', 'oldabe', '2017-05-14 21:34:45', 'Administrador'),
('3df5d5a6127a4380374b83af194b94529c2e7d7e', 'administrador_client', 'oldabe', '2017-05-07 02:37:35', 'Administrador'),
('3e885e0aaac9e6bc00e5fbbdb327fbb873e1a421', 'administrador_client', 'oldabe', '2017-05-14 05:35:04', 'Administrador'),
('418fab0f8531c2ea8585980886e29c339fc6d1f7', 'administrador_client', 'oldabe', '2017-05-04 03:12:44', 'Administrador'),
('41f8c13120ab72325a149d0b3f94594894cb6d52', 'administrador_client', 'oldabe', '2018-01-28 13:53:37', 'Administrador'),
('44ddb55d43e5f58d805b5f9aa983a2de757111a1', 'administrador_client', 'oldabe', '2017-05-06 20:40:54', 'Administrador'),
('45212a4047b9f4cfd3aee22af88165a3aaabcecf', 'administrador_client', 'oldabe', '2017-06-28 05:17:49', 'Administrador'),
('64dbf564d480aa47d176b7b8bc809ee714bfa177', 'administrador_client', 'oldabe', '2017-05-07 20:16:21', 'Administrador'),
('6607a0e5856eccd21779388c6462ccc9076d2015', 'administrador_client', 'oldabe', '2017-05-04 04:17:12', 'Administrador'),
('69c550da930b5f2751ae6e87dded0b0f00d5a559', 'administrador_client', 'oldabe', '2017-05-20 12:27:59', 'Administrador'),
('6a459a3f0a6df60c171e0b6312a9dbdec093895a', 'administrador_client', 'oldabe', '2017-05-07 07:59:20', 'Administrador'),
('6a7a1024d59bd05e31d3047de294e827eeef065a', 'administrador_client', 'oldabe', '2017-09-10 04:37:00', 'Administrador'),
('6d6aa8e299a74afd29a7aabf9107d12c8786a5d2', 'administrador_client', 'oldabe', '2017-06-28 04:31:40', 'Administrador'),
('74122a976c2026cfd27c5ee8fffc49159052039b', 'administrador_client', 'oldabe', '2017-05-20 11:51:14', 'Administrador'),
('8df3c2b41c0840b5786fd7ffa9341d1948e17b47', 'administrador_client', 'oldabe', '2017-05-14 07:55:07', 'Administrador'),
('8fe8ed497e04853617621e2081b9e534464e5e3f', 'administrador_client', 'oldabe', '2017-05-20 09:04:14', 'Administrador'),
('929caab02a9af4d2e09dce24a24c76c6e9fc396e', 'administrador_client', 'oldabe', '2017-05-20 12:25:16', 'Administrador'),
('95e044f6fe61a0fc8620a592513405b6ec5bc6b4', 'administrador_client', 'oldabe', '2017-05-20 13:43:58', 'Administrador'),
('96f4ec15517cba9aeca1330578f3ef5ae0b604e1', 'administrador_client', 'oldabe', '2017-05-15 02:54:21', 'Administrador'),
('a4943c514b2d21ab5bcd79eb9e5d51e6e4bbd887', 'administrador_client', 'oldabe', '2017-05-15 04:26:45', 'Administrador'),
('ab914cadc465639b2b106dd3e90743bea03d20b2', 'administrador_client', 'oldabe', '2017-05-07 01:36:40', 'Administrador'),
('b30bb0fd63d6716cf7ec62bbdd50485709e2c540', 'administrador_client', 'oldabe', '2017-05-06 19:02:15', 'Administrador'),
('b30e2530f925026cb998714b05e38d50ab7b367c', 'administrador_client', 'oldabe', '2017-05-14 08:57:07', 'Administrador'),
('b8c0aa5da306ee679bb0f5000b400f80c7ae3b34', 'administrador_client', 'oldabe', '2017-05-07 09:07:28', 'Administrador'),
('c1da310313cd78e043a4e066c2159ed6704ed40f', 'administrador_client', 'oldabe', '2017-05-02 08:43:58', 'Administrador'),
('c3c5f9027b22d98aca0360a66f9b031cd82b25e9', 'administrador_client', 'oldabe', '2017-05-14 09:59:18', 'Administrador'),
('c446aa9b475480129e8fb9a45f949ed95666db90', 'administrador_client', 'oldabe', '2017-05-14 11:00:55', 'Administrador'),
('c773048a08926a1d9accdc392138f58dfa28d876', 'administrador_client', 'oldabe', '2017-05-02 07:30:50', 'Administrador'),
('cc8df53971970362d42a2169cfb27c2ae688b6d2', 'administrador_client', 'oldabe', '2010-01-07 01:54:14', 'Administrador'),
('dd5948d8aaaaa91d55140d75760a6d91b9df6d33', 'administrador_client', 'oldabe', '2017-05-04 05:19:41', 'Administrador'),
('dff16db0df817c7c8ca462ca6f3f9b47431d13cc', 'administrador_client', 'oldabe', '2017-05-07 06:54:07', 'Administrador'),
('e030295468da80bb70a127fd9d84ce4562af92e2', 'administrador_client', 'oldabe', '2017-05-14 06:52:40', 'Administrador'),
('e192dfdb190984cb8936530c09aad429932b2ec7', 'administrador_client', 'oldabe', '2017-05-07 03:40:15', 'Administrador'),
('e68d21a21add150b568364d37814d6a37e44b3b9', 'administrador_client', 'oldabe', '2017-05-04 07:29:30', 'Administrador'),
('f3681b8a46af7234f470995b00946d74f21e4690', 'administrador_client', 'oldabe', '2017-05-07 11:11:05', 'Administrador'),
('f4a2402fc90bbafe292ef7a38584359666f86f81', 'administrador_client', 'oldabe', '2017-05-15 08:49:05', 'Administrador'),
('f8a3f34ddf35cdced755dc9bd997fad25d2858ae', 'administrador_client', 'oldabe', '2017-05-07 05:41:44', 'Administrador'),
('fce5d1594269bf258a5322793cdcb88e4df89898', 'administrador_client', 'oldabe', '2018-02-03 21:00:06', 'Administrador');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_authorization_codes`
--

CREATE TABLE `oauth_authorization_codes` (
  `authorization_code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_uri` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime NOT NULL,
  `scope` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_token` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `client_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `client_secret` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uri` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `grant_types` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scope` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `oauth_clients`
--

INSERT INTO `oauth_clients` (`client_id`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`) VALUES
('administrador_client', '$2y$10$ydeHvD1EvVqyw4l/01k2ueVRhNwWNNyXtOsjM7DlY.gTn2UHILP4C', '', 'password', 'Administrador', NULL),
('cliente_client', '$2y$10$DsBexQ9I2CNDLHhUKP75pOIG8TkTY9kuMSpblz3K7XRqwzRP1gw0u', '', 'password', 'Cliente', NULL),
('funcionario_client', '$2y$10$NyVKQTTS8TKnu7TVrJgXy.DqAaUYlz1ZZ7Ts7zfWcHrL9Wlx1LN6u', '', 'password', 'Funcionario', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_jwt`
--

CREATE TABLE `oauth_jwt` (
  `client_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `public_key` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `refresh_token` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires` datetime NOT NULL,
  `scope` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`refresh_token`, `client_id`, `user_id`, `expires`, `scope`) VALUES
('08a1b5ca9e39f104ddd68d15a3c90ac8fbec722c', 'administrador_client', 'oldabe', '2017-05-28 10:00:55', 'Administrador'),
('09f723177f39d1fb49e1405efcc79eeaced5bb65', 'administrador_client', 'oldabe', '2017-05-29 07:49:05', 'Administrador'),
('12710aa4b34278180a4c67e3ec0ae7031495d934', 'administrador_client', 'oldabe', '2017-05-18 06:29:31', 'Administrador'),
('1307343c98875621746802221ec6110b5d389cd9', 'administrador_client', 'oldabe', '2017-05-28 05:52:40', 'Administrador'),
('133ab74d82d39adc0e73d443d79bbc3a73e1e3fe', 'administrador_client', 'oldabe', '2017-05-29 01:54:24', 'Administrador'),
('169b6b7901d79b9fc5ef1cc1ec51a4b9474a77f1', 'administrador_client', 'oldabe', '2017-05-29 05:49:33', 'Administrador'),
('195cb4d46dd607e1fa8893b51ef8343a755ce015', 'administrador_client', 'oldabe', '2017-05-21 06:59:20', 'Administrador'),
('1973bf1cb761c5ac4d608b37f437bcd026fda885', 'administrador_client', 'oldabe', '2017-07-09 05:30:39', 'Administrador'),
('1cf5838be17bbbbb5d8c2634e03c931700804656', 'administrador_client', 'oldabe', '2017-06-03 09:05:23', 'Administrador'),
('27689613b2ce922e920d1e218436d4e1f0788d9f', 'administrador_client', 'oldabe', '2017-05-28 08:59:20', 'Administrador'),
('2d33bb5c6ab4fdc7b562123f89e39422d2fa2e63', 'administrador_client', 'oldabe', '2018-02-11 12:53:37', 'Administrador'),
('31eb0f27137585e47863caab414da6a7406b0f83', 'administrador_client', 'oldabe', '2018-02-17 20:00:06', 'Administrador'),
('3b7a691273df832e3583a373372712c29048a1ce', 'administrador_client', 'oldabe', '2017-05-28 06:55:08', 'Administrador'),
('3d5de7bd9cf860eb337e8f1f9d0fb34c18c31c28', 'administrador_client', 'oldabe', '2017-05-29 05:32:22', 'Administrador'),
('3e1560d79df48e7c3639874dcae896b188a3f5e3', 'administrador_client', 'oldabe', '2017-05-28 20:34:45', 'Administrador'),
('40d7d378fd123de46a63fa07bf44093a7ea6b272', 'administrador_client', 'oldabe', '2017-06-03 11:28:00', 'Administrador'),
('445a97884f84c55d218c8761429a34e974d69e70', 'administrador_client', 'oldabe', '2017-05-28 04:35:05', 'Administrador'),
('45b4149f627203bac3c9c89a38ba513cafee6ee6', 'administrador_client', 'oldabe', '2017-05-16 03:30:48', 'Administrador'),
('4e05757e7a9aeb6cf5c6d443209dcdd79176ae36', 'administrador_client', 'oldabe', '2017-05-21 01:37:35', 'Administrador'),
('53adba2888635a5e3cf0b8e839b49c1152f8ec27', 'administrador_client', 'oldabe', '2017-05-18 03:17:13', 'Administrador'),
('5b59e17e59fe89e92192fd5ae99da079a9fb0fac', 'administrador_client', 'oldabe', '2017-05-21 04:41:44', 'Administrador'),
('5d9a5fb052b7f9c5ab544f2ffefdd3b4bf5f28ea', 'administrador_client', 'oldabe', '2017-09-24 03:37:00', 'Administrador'),
('68e01407ec1b57b5cc6cfd2935b82c95f8628f6a', 'administrador_client', 'oldabe', '2017-05-20 18:02:17', 'Administrador'),
('6e651ebc41994ed1f3f1bbbaf7c545a1993d5525', 'administrador_client', 'oldabe', '2017-05-21 08:07:29', 'Administrador'),
('739c611d6bac51896ea4c9ed70e578ce25f57ba9', 'administrador_client', 'oldabe', '2017-05-29 05:55:00', 'Administrador'),
('75129f7d16fc642122f62cb813320c19ffdb7ac4', 'administrador_client', 'oldabe', '2017-05-21 05:54:07', 'Administrador'),
('7757d7e096a792ac04510d7c472f2881e95fbfb0', 'administrador_client', 'oldabe', '2010-01-21 00:54:15', 'Administrador'),
('7c3902354bdd688d3b5e99eca7686f39e608af44', 'administrador_client', 'oldabe', '2017-06-03 10:32:57', 'Administrador'),
('7d8ea272f44acc93b8de1ecf4c3efccd7d914e59', 'administrador_client', 'oldabe', '2017-05-21 10:11:07', 'Administrador'),
('8315717d64fd3762c9f0a8013e92ef12310228a7', 'administrador_client', 'oldabe', '2017-06-03 08:04:16', 'Administrador'),
('86f6cd0cb3ef0dd4890aaae8d4ffa606c20a608c', 'administrador_client', 'oldabe', '2017-06-03 11:19:02', 'Administrador'),
('88544851f081a9e9bcaf1345e6dca11adb9e6acb', 'administrador_client', 'oldabe', '2017-05-16 07:43:59', 'Administrador'),
('8a4545f0d4b1666b22c315dc8ab731119c973423', 'administrador_client', 'oldabe', '2017-07-12 03:31:40', 'Administrador'),
('9026940b3b8b5670a9f201b69de338aacd3e037b', 'administrador_client', 'oldabe', '2017-05-16 06:30:50', 'Administrador'),
('9bb895f0d6206487f2b59c586f1dc165430c041b', 'administrador_client', 'oldabe', '2017-05-20 19:40:55', 'Administrador'),
('a552f20e02c8e2c36804d772429f5e70a422c9eb', 'administrador_client', 'oldabe', '2017-06-03 11:25:16', 'Administrador'),
('bd1e848995e4ba3a8bcadd31fc033324ab2a74c4', 'administrador_client', 'oldabe', '2017-05-20 23:29:43', 'Administrador'),
('bfaf65ed29329bc95c3102123ec979f7b4ea93ba', 'administrador_client', 'oldabe', '2017-06-03 12:43:59', 'Administrador'),
('c17dddb31f392570a3dc77c1b6f7dc1fb17bb508', 'administrador_client', 'oldabe', '2017-05-21 09:08:58', 'Administrador'),
('cab6748e9259020891dc2e1c8ca0427663a7775a', 'administrador_client', 'oldabe', '2017-07-12 04:17:50', 'Administrador'),
('cd558d5466a251f6d40f3f6d39bc376d344d4e63', 'administrador_client', 'oldabe', '2017-05-21 02:40:16', 'Administrador'),
('da63efb0a2500323eb00aabd10d9907ce64c7f37', 'administrador_client', 'oldabe', '2017-05-16 08:53:37', 'Administrador'),
('dd163f90117488989fa95027df853196584b00ce', 'administrador_client', 'oldabe', '2017-06-03 10:51:14', 'Administrador'),
('e3198a681f12f936417d939f5a8fbdba7d338997', 'administrador_client', 'oldabe', '2017-05-28 07:57:08', 'Administrador'),
('e373cc9cbf25656577e767ce6c5d6c7a7e1d2e25', 'administrador_client', 'oldabe', '2017-05-21 19:16:21', 'Administrador'),
('e3e7e8e44fc1c7ba196fc24fee09350f73a8b47d', 'administrador_client', 'oldabe', '2017-05-21 00:36:40', 'Administrador'),
('ea7df75049e39b613d15454f2c7e19118737c6aa', 'administrador_client', 'oldabe', '2017-05-18 04:19:44', 'Administrador'),
('f528af32ff4fa7bfecde2a6ac420424ba7a54be1', 'administrador_client', 'oldabe', '2017-05-29 03:26:45', 'Administrador'),
('f9fd598582b717cc0831dbe2fd60123e0a4bb98f', 'administrador_client', 'oldabe', '2017-05-18 02:12:46', 'Administrador');

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_scopes`
--

CREATE TABLE `oauth_scopes` (
  `id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'supported',
  `scope` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_id` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oauth_users`
--

CREATE TABLE `oauth_users` (
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recovery_password_token` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `oauth_users`
--

INSERT INTO `oauth_users` (`username`, `password`, `first_name`, `last_name`, `recovery_password_token`) VALUES
('apmoreira@hotmail.com', '$2y$10$rAVxOV9yEYm5A3MwEaMqm.XKbGrQFmgm68eDt331v3gNFp.1IrT9e', NULL, NULL, ''),
('benfrank', '$2y$10$JCbijEv9yj1bbfIbj2/Xr.WaH4Tu6.qNn1pkooBGsJSZbabyrq5O.', NULL, NULL, ''),
('cliente01', '$2y$10$8qP/whZqo9Ug9Y/7vp9WG.RO1E1x/0B0yMJQU6fBV9BYUpd0SscDe', NULL, NULL, NULL),
('cliente011', '$2y$10$WUh/1gq7wb2Qv61NHdy5CuBRMi8atfmdyOWY/sQn9DK1PIK6t9FGe', NULL, NULL, NULL),
('cliente012', '$2y$10$NIwdjweZdf.BODekL/EvceejJeNRRHNwOd4uFRSlh0l5yktVtoTga', NULL, NULL, NULL),
('cliente013', '$2y$10$/FAnu.gQGcKI.dpsr.K0eeswQP8x.1T9YsYWuEzdPFaCeUzP61.fG', NULL, NULL, NULL),
('cliente014', '$2y$10$9LzbZeBGRI24wPnnMlFFMeekYO15W3dq9geXNXoXbk4pzug.c53wO', NULL, NULL, NULL),
('cliente015', '$2y$10$NQkFNhi3pf7Oir5Ioao5E.ZmZGNXa5vnC9Z3iVdVV8dV2yP5//xYi', NULL, NULL, NULL),
('cliente02', '$2y$10$04NIA3NLIjmzIxO0wS8CFOqPROiHpP9kNc1bB1rjNoNWSwDEq7Yvy', NULL, NULL, NULL),
('cliente03', '$2y$10$s.tQGZSrfCsHOVnhhrHU0.NEt/U/JlEgKXMWtVDvrXSAjH.w5JFvm', NULL, NULL, NULL),
('cliente04', '$2y$10$P9YGDl5iKNl4aVpbDfRD/.lFNuyKOjxpLTScPWWXPpNEA.mrannca', NULL, NULL, NULL),
('cliente05', '$2y$10$qD.ho5oiNyI5Wm6xoLY3E.zxFe.nvK7gBYuLuIbfBCmen9ZWbFaP.', NULL, NULL, NULL),
('cliente06', '$2y$10$2AJQLybSiISb/QgdrvEgYOpGvCBKwBeaDFHSFRFsgOXGpXBUebBeu', NULL, NULL, NULL),
('clientex17', '$2y$10$ZiqbVL9Vdof9qr6HIyz2seufMgpJ3MXWHtyqzQv/CfwMrZK50X.H.', NULL, NULL, NULL),
('colonel.william', '$2y$10$xTr5u557T6fPG/q5MLbqJettKk2mP75nBF7Tw844zX2q98NwYOQKO', NULL, NULL, ''),
('felino', '$2y$10$Qmv/25hmYh3yaL.kKQ6LWOOx22ZiOEcn/77WPpzCvwniO.WiC6ACC', NULL, NULL, NULL),
('foreman', '$2y$10$NMpnMN3XmZxhyu0QAxIXFObNqjm1Lay16gA9eL8NCgrqI8F4SUN0W', NULL, NULL, NULL),
('jdoliveirasa@gmail.com', '$2y$10$l16FqAJ.ml2fPuUTsLDecOVIngl/k4A6du7IMHX82PTKMVmoxKHDC', NULL, NULL, NULL),
('jwbush', '$2y$10$nYUJXmgz.ghJ1DuoD8diD.TRrVrtEmPaqntvWun0RpBJ5YeNnTEeO', NULL, NULL, ''),
('mlkjunior', '$2y$10$RJ7rEVoaPsKXOSynMQpBV.HAZ8614gNV5/8wCwVz.Rm2Sum5N4Y4W', NULL, NULL, ''),
('nando@gmail.com', '$2y$10$lQ.yj/erIRraja98Kjx8KOXzAzgM1brQ01NRqAPSG/VdClN6CHaQO', NULL, NULL, ''),
('norton', '$2y$10$ytc1qcAirAj/7LFXQSYei.soafvs9kW.rVOkL1znItYHz3EWXG9pu', NULL, NULL, NULL),
('oldabe', '$2y$10$iCiFhdTDDISx0r7Jq0BgD.V2Ah.M31zcTDzcJuQbitFkizKWlnt6u', NULL, NULL, NULL),
('putlevel', '$2y$10$E.7GU/aIe42cyC0N9u4WL.aMDOyHvCO5meIzm7fkQpzLcuX9Kx6Ny', NULL, NULL, NULL),
('testuser', '$2y$10$XpnLZzlarxoa61dfWjGvW.JD3l7rzeAOn/Aanq7XHoPWPvRbzDg2e', NULL, NULL, ''),
('trema@tutanota.com', '$2y$10$spVD3Yhhsd2XZADOEdq0xeG2.MJ5DCeNRGacRfJF/DJTQCAhJXQ/C', NULL, NULL, ''),
('triplex@gmail.ll', '$2y$10$c3Ky52OLWAPVXb1IoFTmkeKL31nTnsSHMBXGKF9PC6TByS68zdesW', NULL, NULL, ''),
('triplex@gmail.ss', '$2y$10$RGaO1l..RyA9lLCscjyFdObz3s0T6xrFOTc.HjKuvLwQMHr5uuoyW', NULL, NULL, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `patio_types`
--

CREATE TABLE `patio_types` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `patio_types`
--

INSERT INTO `patio_types` (`id`, `description`) VALUES
(1, 'Acesso'),
(2, 'Adro'),
(3, 'Alameda'),
(4, 'Alto'),
(5, 'Atalho'),
(6, 'Avenida'),
(7, 'Balneario'),
(8, 'Belvedere'),
(9, 'Beco'),
(10, 'Bloco'),
(11, 'Bosque'),
(12, 'Boulevard'),
(13, 'Baixa'),
(14, 'Cais'),
(15, 'Caminho'),
(16, 'Chapadão'),
(17, 'Conjunto'),
(18, 'Colônia'),
(19, 'Corredor'),
(20, 'Campo'),
(21, 'Córrego'),
(22, 'Desvio'),
(23, 'Distrito'),
(24, 'Escada'),
(25, 'Estrada'),
(26, 'Estação'),
(27, 'Estádio'),
(28, 'Favela'),
(29, 'Fazenda'),
(30, 'Ferrovia'),
(31, 'Fonte'),
(32, 'Feira'),
(33, 'Forte'),
(34, 'Galeria'),
(35, 'Granja'),
(36, 'Ilha'),
(37, 'Jardim'),
(38, 'Ladeira'),
(39, 'Largo'),
(40, 'Lagoa'),
(41, 'Loteamento'),
(42, 'Morro'),
(43, 'Monte'),
(44, 'Paralela'),
(45, 'Passeio'),
(46, 'Pátio'),
(47, 'Praça'),
(48, 'Parada'),
(49, 'Praia'),
(50, 'Prolongamento'),
(51, 'Parque'),
(52, 'Passarela'),
(53, 'Passagem'),
(54, 'Ponte'),
(55, 'Quadra'),
(56, 'Quinta'),
(57, 'Rua'),
(58, 'Ramal'),
(59, 'Recanto'),
(60, 'Retiro'),
(61, 'Reta'),
(62, 'Rodovia'),
(63, 'Retorno'),
(64, 'Sítio'),
(65, 'Servidão'),
(66, 'Setor'),
(67, 'Subida'),
(68, 'Trincheira'),
(69, 'Terminal'),
(70, 'Trevo'),
(71, 'Travessa'),
(72, 'Via'),
(73, 'Viaduto'),
(74, 'Vila'),
(75, 'Viela'),
(76, 'Vale'),
(77, 'Zigue-zague'),
(78, 'Trecho'),
(79, 'Vereda'),
(80, 'Artéria'),
(81, 'Elevada'),
(82, 'Porto'),
(83, 'Balão'),
(84, 'Paradouro'),
(85, 'Área'),
(86, 'Jardinete'),
(87, 'Esplanada'),
(88, 'Quintas'),
(89, 'Rotula'),
(90, 'Marina'),
(91, 'Descida'),
(92, 'Circular'),
(93, 'Unidade'),
(94, 'Chácara'),
(95, 'Rampa'),
(96, 'Ponta'),
(97, 'Via de pedestre'),
(98, 'Condomínio'),
(99, 'Habitacional'),
(100, 'Residencial'),
(101, 'Canal'),
(102, 'Buraco'),
(103, 'Módulo'),
(104, 'Estância'),
(105, 'Lago'),
(106, 'Núcleo'),
(107, 'Aeroporto'),
(108, 'Passagem Subterrânea'),
(109, 'Complexo Viário'),
(110, 'Praça de Esportes'),
(111, 'Via Elevada'),
(112, 'Rotatória'),
(113, 'Travessa'),
(114, 'Alto'),
(115, 'Beco'),
(116, 'Paralela'),
(117, 'Subida'),
(118, 'Vila'),
(119, 'Parque'),
(120, 'Rua'),
(121, 'Estacionamento'),
(122, 'Vala'),
(123, 'Rua de Pedestre'),
(124, 'Túnel'),
(125, 'Variante'),
(126, 'Rodo Anel'),
(127, 'Travessa Particular'),
(128, 'Calçada'),
(129, 'Via de Acesso'),
(130, 'Entrada Particular'),
(131, 'Acampamento'),
(132, 'Via Expressa'),
(133, 'Estrada Municipal'),
(134, 'Avenida Contorno'),
(135, 'Entre-quadra'),
(136, 'Rua de Ligação'),
(137, 'Área Especial');

-- --------------------------------------------------------

--
-- Estrutura da tabela `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `payment_status_id` int(11) DEFAULT NULL,
  `property_customer_id` int(11) DEFAULT NULL,
  `value` double NOT NULL,
  `due_day_date` datetime NOT NULL,
  `pay_day_date` datetime DEFAULT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `payments`
--

INSERT INTO `payments` (`id`, `payment_type_id`, `payment_status_id`, `property_customer_id`, `value`, `due_day_date`, `pay_day_date`, `note`, `registration_date`, `modification_date`) VALUES
(1, 1, 3, 1, 305, '2016-09-15 03:00:00', '2016-10-22 02:00:00', NULL, '2016-08-15 02:46:49', NULL),
(2, 2, 3, 2, 210.55, '2016-09-15 03:00:00', '2016-08-28 03:00:00', NULL, '2016-08-15 02:57:33', '2016-08-28 13:43:03'),
(3, 2, 3, 3, 305, '2016-08-15 03:00:00', '2016-08-14 03:00:00', NULL, '2016-08-15 03:01:32', '2016-08-15 03:01:50'),
(4, 1, 3, 4, 40.55, '2016-09-02 03:00:00', '2016-10-22 02:00:00', NULL, '2016-08-28 13:16:28', NULL),
(5, 4, 1, 4, 40.55, '2016-08-12 03:00:00', NULL, NULL, '2016-08-29 04:29:50', NULL),
(6, 2, 3, 1, 305, '2016-08-06 03:00:00', '2016-08-31 03:00:00', NULL, '2016-08-29 04:30:26', '2016-08-29 04:32:15'),
(7, 1, 3, 5, 205, '2016-08-31 03:00:00', '2016-10-22 02:00:00', NULL, '2016-08-29 10:33:46', NULL),
(8, 3, 1, 5, 205, '2016-08-25 03:00:00', NULL, NULL, '2016-08-29 10:39:10', NULL),
(9, 2, 3, 5, 205, '2016-08-20 03:00:00', '2016-08-29 03:00:00', NULL, '2016-08-29 10:39:58', '2016-08-29 10:41:27'),
(10, 2, 3, 2, 210.55, '2016-10-30 03:00:00', '2016-08-30 03:00:00', NULL, '2016-08-29 10:44:32', '2016-08-29 10:46:51'),
(11, 1, 3, 6, 305, '2016-09-04 03:00:00', '2016-10-19 02:00:00', NULL, '2016-08-30 17:45:04', NULL),
(12, NULL, 3, NULL, 305, '2016-09-15 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-15 02:46:49', NULL),
(13, NULL, 3, NULL, 40.55, '2016-09-02 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-28 13:16:28', NULL),
(14, NULL, 3, NULL, 305, '2016-09-04 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-30 17:45:04', NULL),
(15, NULL, 3, NULL, 205, '2016-08-31 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-29 10:33:46', NULL),
(16, NULL, 3, NULL, 305, '2016-09-15 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-15 02:46:49', NULL),
(17, NULL, 3, NULL, 40.55, '2016-09-02 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-28 13:16:28', NULL),
(18, NULL, 3, NULL, 305, '2016-09-04 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-30 17:45:04', NULL),
(19, NULL, 3, NULL, 205, '2016-08-31 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-29 10:33:46', NULL),
(20, NULL, 3, NULL, 305, '2016-09-15 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-15 02:46:49', NULL),
(21, NULL, 3, NULL, 40.55, '2016-09-02 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-28 13:16:28', NULL),
(22, NULL, 3, NULL, 305, '2016-09-04 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-30 17:45:04', NULL),
(23, NULL, 3, NULL, 205, '2016-08-31 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-29 10:33:46', NULL),
(24, NULL, 3, NULL, 305, '2016-09-15 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-15 02:46:49', NULL),
(25, NULL, 3, NULL, 40.55, '2016-09-02 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-28 13:16:28', NULL),
(26, NULL, 3, NULL, 305, '2016-09-04 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-30 17:45:04', NULL),
(27, NULL, 3, NULL, 205, '2016-08-31 03:00:00', '1986-09-27 00:00:00', NULL, '2016-08-29 10:33:46', NULL),
(28, NULL, 3, NULL, 305, '2016-09-15 03:00:00', '1986-09-11 00:00:00', NULL, '2016-08-15 02:46:49', NULL),
(29, NULL, 3, NULL, 40.55, '2016-09-02 03:00:00', '1986-09-11 00:00:00', NULL, '2016-08-28 13:16:28', NULL),
(30, NULL, 3, NULL, 305, '2016-09-04 03:00:00', '1986-09-11 00:00:00', NULL, '2016-08-30 17:45:04', NULL),
(31, NULL, 3, NULL, 205, '2016-08-31 03:00:00', '1986-09-11 00:00:00', NULL, '2016-08-29 10:33:46', NULL),
(32, 1, 1, 1, 305, '2017-06-30 03:00:00', NULL, NULL, '2017-06-28 03:53:40', NULL),
(33, 1, 3, 4, 40.55, '2018-01-30 02:00:00', '2018-01-12 02:00:00', NULL, '2018-01-28 12:57:03', NULL),
(34, 2, 3, 1, 305, '2018-01-30 02:00:00', '2018-01-29 02:00:00', NULL, '2018-01-28 13:01:15', '2018-01-28 13:01:36');

-- --------------------------------------------------------

--
-- Estrutura da tabela `payment_slips`
--

CREATE TABLE `payment_slips` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `our_number` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `our_number_dv` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `our_number_formatted` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `payment_slips`
--

INSERT INTO `payment_slips` (`id`, `payment_id`, `bank_id`, `our_number`, `our_number_dv`, `our_number_formatted`, `registration_date`, `modification_date`) VALUES
(1, 1, 5, '1', NULL, '175/00000001-8', '2016-08-15 02:48:33', NULL),
(2, 4, 1, '4', NULL, '11053690000000004', '2016-08-28 13:43:24', NULL),
(3, 11, 3, '11', NULL, '24000000000000011P', '2016-08-30 17:46:41', NULL),
(4, 7, 2, '7', NULL, '06/00000000007-P', '2016-08-31 17:48:17', NULL),
(5, 32, 2, '32', NULL, '06/00000000032-0', '2017-06-28 03:54:00', NULL),
(6, 33, 2, '33', NULL, '06/00000000033-9', '2018-01-28 12:57:52', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `payment_statuss`
--

CREATE TABLE `payment_statuss` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `payment_statuss`
--

INSERT INTO `payment_statuss` (`id`, `description`) VALUES
(1, 'Pendente'),
(2, 'Vencido'),
(3, 'Liquidado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `payment_types`
--

CREATE TABLE `payment_types` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `payment_types`
--

INSERT INTO `payment_types` (`id`, `description`) VALUES
(1, 'Boleto'),
(2, 'Dinheiro'),
(3, 'Cartão de Crédito'),
(4, 'PayPal');

-- --------------------------------------------------------

--
-- Estrutura da tabela `paypals`
--

CREATE TABLE `paypals` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `pay_pal_payer_id` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `pay_pal_payment_id` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `result_code` int(11) NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `propertys`
--

CREATE TABLE `propertys` (
  `id` int(11) NOT NULL,
  `property_type_id` int(11) DEFAULT NULL,
  `patio_type_id` int(11) DEFAULT NULL,
  `federative_unit_id` int(11) DEFAULT NULL,
  `patio` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `complement` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `neighborhood` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `zip_code` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `square_meters` int(11) NOT NULL,
  `number_bedrooms` int(11) NOT NULL,
  `number_bathrooms` int(11) NOT NULL,
  `number_suites` int(11) NOT NULL,
  `number_rooms` int(11) NOT NULL,
  `daily_value` double NOT NULL,
  `weekly_value` double NOT NULL,
  `fortnightly_value` double NOT NULL,
  `monthly_value` double NOT NULL,
  `maintenance_fee_value` double NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `propertys`
--

INSERT INTO `propertys` (`id`, `property_type_id`, `patio_type_id`, `federative_unit_id`, `patio`, `number`, `complement`, `neighborhood`, `city`, `zip_code`, `description`, `square_meters`, `number_bedrooms`, `number_bathrooms`, `number_suites`, `number_rooms`, `daily_value`, `weekly_value`, `fortnightly_value`, `monthly_value`, `maintenance_fee_value`, `registration_date`, `modification_date`) VALUES
(1, 2, 14, 15, 'das Docas', 0, 's/n', 'Coqueiral', 'João Pessoa', 10280160, 'PENSAO 03 - IPIRANGA', 120, 3, 2, 0, 5, 30, 120, 200, 340, 10.55, '2016-08-15 02:36:24', '2016-08-29 12:41:18'),
(2, 1, 6, 13, 'Barbacena', 12, NULL, 'Casa Verde', 'Rio Pomba', 21456720, 'APTO GOLD 001', 40, 2, 1, 0, 5, 25, 100, 200, 300, 5, '2016-08-15 02:38:53', NULL),
(5, 3, 57, 13, 'Costa Aguiar', 320, NULL, 'Minas Caixa', 'Belo Horizonte', 32180580, 'KITNET 05', 20, 1, 1, 1, 2, 20, 180, 220, 350, 10, '2016-08-29 12:43:11', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `property_customers`
--

CREATE TABLE `property_customers` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `rental_agreement_id` int(11) DEFAULT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `property_customers`
--

INSERT INTO `property_customers` (`id`, `property_id`, `customer_id`, `rental_agreement_id`, `registration_date`, `modification_date`) VALUES
(1, 2, 1, 4, '2016-08-15 02:41:58', NULL),
(2, 1, 1, 3, '2016-08-15 02:56:14', NULL),
(3, 2, 3, 4, '2016-08-15 03:00:58', NULL),
(4, 1, 1, 1, '2016-08-28 12:53:40', NULL),
(5, 2, 1, 3, '2016-08-29 10:26:39', NULL),
(6, 2, 11, 4, '2016-08-30 17:44:07', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `property_types`
--

CREATE TABLE `property_types` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `property_types`
--

INSERT INTO `property_types` (`id`, `description`) VALUES
(1, 'Apartamento'),
(2, 'Casa'),
(3, 'Kitnet');

-- --------------------------------------------------------

--
-- Estrutura da tabela `rental_agreements`
--

CREATE TABLE `rental_agreements` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `rental_agreements`
--

INSERT INTO `rental_agreements` (`id`, `description`) VALUES
(1, 'Diário'),
(2, 'Semanal'),
(3, 'Quinzenal'),
(4, 'Mensal');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `registration_date` datetime NOT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `login`, `name`, `email`, `registration_date`, `modification_date`) VALUES
(1, 'oldabe', 'Abraham Lincoln', 'jdoliveirasa@gmail.com', '2016-08-15 02:03:40', '2016-09-13 05:42:27'),
(2, 'benfrank', 'Benjamin Franklin', 'benfrank@gmail.com', '2016-08-15 02:04:20', '2016-08-15 05:17:35'),
(4, 'mlkjunior', 'Martin Luther King Jr', 'mlkjunior@gmail.com', '2016-08-15 02:07:44', NULL),
(5, 'colonel.william', 'William F. Guile', 'colonel.william@tutanota.com', '2016-08-15 02:10:34', '2016-08-28 14:16:46'),
(8, 'jwbush', 'Jorge W. Bush II', 'jwbush@gmail.com', '2016-08-29 11:39:49', '2016-08-29 11:53:21'),
(9, 'cliente01', 'Cliente 01', 'cliente02@gmail.com.br', '2016-09-01 11:01:41', NULL),
(10, 'cliente02', 'Cliente 02', 'cliente02@gmail.com', '2016-09-01 11:02:14', NULL),
(11, 'cliente03', 'Cliente 03', 'cliente03@gmail.com', '2016-09-01 11:02:54', NULL),
(12, 'cliente04', 'Cliente 04', 'cliente04@gmail.com.br', '2016-09-01 11:03:32', NULL),
(13, 'cliente05', 'Cliente 05', 'cliente05@gmail.com', '2016-09-01 11:04:04', NULL),
(14, 'cliente06', 'cliente06', 'cliente06@gmail.com.br', '2016-09-01 11:04:40', NULL),
(15, 'cliente011', 'Cliente 011', 'cliente011@gmail.com.br', '2016-09-01 11:05:22', NULL),
(16, 'cliente012', 'Cliente 012', 'cliente012@gmail.com.br', '2016-09-01 11:05:46', NULL),
(17, 'cliente013', 'Cliente 013', 'cliente013@gmail.com.br', '2016-09-01 11:06:18', NULL),
(18, 'cliente014', 'Cliente 014', 'cliente014@gmail.com.br', '2016-09-01 11:06:54', NULL),
(19, 'cliente015', 'Cliente 015', 'cliente015@gmail.com', '2016-09-01 11:07:24', NULL),
(20, 'clientex17', 'Cliente X17', 'clientex17@gmail.com', '2016-09-01 11:08:53', NULL),
(21, 'felino', 'Fulano Felino', 'felino@gmail.com.br', '2016-09-03 16:07:21', NULL),
(22, 'norton', 'Norton City', 'norton@norton.com.br', '2016-09-03 16:08:02', NULL),
(23, 'foreman', 'George Foreman', 'foreman@gmail.com', '2016-09-03 16:08:37', NULL),
(24, 'putlevel', 'Put Level', 'put@putleve.com', '2016-09-03 16:09:10', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_groups`
--

CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `user_groups`
--

INSERT INTO `user_groups` (`id`, `description`) VALUES
(1, 'Administrador'),
(2, 'Funcionario'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_group_userss`
--

CREATE TABLE `user_group_userss` (
  `user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `user_group_userss`
--

INSERT INTO `user_group_userss` (`user_group_id`, `user_id`) VALUES
(1, 1),
(1, 8),
(2, 1),
(2, 4),
(2, 5),
(2, 8),
(3, 2),
(3, 5),
(3, 8);

-- --------------------------------------------------------

--
-- Structure for view `cabinet_select`
--
DROP TABLE IF EXISTS `cabinet_select`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cabinet_select`  AS  select `c`.`id` AS `id`,concat_ws(' - ',`p`.`description`,`pt`.`description`,`c`.`description`) AS `description` from ((`propertys` `p` join `property_types` `pt` on((`p`.`property_type_id` = `pt`.`id`))) join `cabinets` `c` on((`p`.`id` = `c`.`property_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresss`
--
ALTER TABLE `addresss`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_81BC32D23282E858` (`patio_type_id`),
  ADD KEY `IDX_81BC32D245EB235A` (`federative_unit_id`),
  ADD KEY `IDX_81BC32D29395C3F3` (`customer_id`);

--
-- Indexes for table `balance_types`
--
ALTER TABLE `balance_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cabinets`
--
ALTER TABLE `cabinets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D0239182549213EC` (`property_id`);

--
-- Indexes for table `cabinet_customers`
--
ALTER TABLE `cabinet_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_70D00EF7D351EC` (`cabinet_id`),
  ADD KEY `IDX_70D00EF77974406B` (`cabinet_status_id`),
  ADD KEY `IDX_70D00EF79395C3F3` (`customer_id`);

--
-- Indexes for table `cabinet_statuss`
--
ALTER TABLE `cabinet_statuss`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cashiers`
--
ALTER TABLE `cashiers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_EE44F633F1A7AE29` (`balance_type_id`);

--
-- Indexes for table `cedants`
--
ALTER TABLE `cedants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_50352C5A11C8FB41` (`bank_id`);

--
-- Indexes for table `cleanings`
--
ALTER TABLE `cleanings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_DF50E9EF549213EC` (`property_id`);

--
-- Indexes for table `cleaning_customers`
--
ALTER TABLE `cleaning_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8E9F9A428E5EB27B` (`cleaning_id`),
  ADD KEY `IDX_8E9F9A42873BD4DE` (`cleaning_status_id`),
  ADD KEY `IDX_8E9F9A429395C3F3` (`customer_id`);

--
-- Indexes for table `cleaning_statuss`
--
ALTER TABLE `cleaning_statuss`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `credit_cards`
--
ALTER TABLE `credit_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5CADD6534C3A3BB` (`payment_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_62534E213E3E11F0` (`cpf`),
  ADD KEY `IDX_62534E21D991282D` (`customer_type_id`),
  ADD KEY `IDX_62534E21E7927C74` (`email`);

--
-- Indexes for table `customer_types`
--
ALTER TABLE `customer_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `federative_units`
--
ALTER TABLE `federative_units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`access_token`);

--
-- Indexes for table `oauth_authorization_codes`
--
ALTER TABLE `oauth_authorization_codes`
  ADD PRIMARY KEY (`authorization_code`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `oauth_jwt`
--
ALTER TABLE `oauth_jwt`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`refresh_token`);

--
-- Indexes for table `oauth_scopes`
--
ALTER TABLE `oauth_scopes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_users`
--
ALTER TABLE `oauth_users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `patio_types`
--
ALTER TABLE `patio_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_65D29B32DC058279` (`payment_type_id`),
  ADD KEY `IDX_65D29B3228DE2F95` (`payment_status_id`),
  ADD KEY `IDX_65D29B322CF003C5` (`property_customer_id`);

--
-- Indexes for table `payment_slips`
--
ALTER TABLE `payment_slips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FFDCBAD44C3A3BB` (`payment_id`),
  ADD KEY `IDX_FFDCBAD411C8FB41` (`bank_id`);

--
-- Indexes for table `payment_statuss`
--
ALTER TABLE `payment_statuss`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_types`
--
ALTER TABLE `payment_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `paypals`
--
ALTER TABLE `paypals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_640054B24C3A3BB` (`payment_id`);

--
-- Indexes for table `propertys`
--
ALTER TABLE `propertys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7AEEC2C49C81C6EB` (`property_type_id`),
  ADD KEY `IDX_7AEEC2C43282E858` (`patio_type_id`),
  ADD KEY `IDX_7AEEC2C445EB235A` (`federative_unit_id`);

--
-- Indexes for table `property_customers`
--
ALTER TABLE `property_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_13BC4C9C549213EC` (`property_id`),
  ADD KEY `IDX_13BC4C9C9395C3F3` (`customer_id`),
  ADD KEY `IDX_13BC4C9CC09E3816` (`rental_agreement_id`);

--
-- Indexes for table `property_types`
--
ALTER TABLE `property_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rental_agreements`
--
ALTER TABLE `rental_agreements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1483A5E9AA08CB10` (`login`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_userss`
--
ALTER TABLE `user_group_userss`
  ADD PRIMARY KEY (`user_group_id`,`user_id`),
  ADD KEY `IDX_9186B2A01ED93D47` (`user_group_id`),
  ADD KEY `IDX_9186B2A0A76ED395` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresss`
--
ALTER TABLE `addresss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `balance_types`
--
ALTER TABLE `balance_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `cabinets`
--
ALTER TABLE `cabinets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `cabinet_customers`
--
ALTER TABLE `cabinet_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `cabinet_statuss`
--
ALTER TABLE `cabinet_statuss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `cashiers`
--
ALTER TABLE `cashiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `cedants`
--
ALTER TABLE `cedants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `cleanings`
--
ALTER TABLE `cleanings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cleaning_customers`
--
ALTER TABLE `cleaning_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cleaning_statuss`
--
ALTER TABLE `cleaning_statuss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `credit_cards`
--
ALTER TABLE `credit_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `customer_types`
--
ALTER TABLE `customer_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `federative_units`
--
ALTER TABLE `federative_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `oauth_scopes`
--
ALTER TABLE `oauth_scopes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `patio_types`
--
ALTER TABLE `patio_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `payment_slips`
--
ALTER TABLE `payment_slips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `payment_statuss`
--
ALTER TABLE `payment_statuss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `payment_types`
--
ALTER TABLE `payment_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `paypals`
--
ALTER TABLE `paypals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `propertys`
--
ALTER TABLE `propertys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `property_customers`
--
ALTER TABLE `property_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `property_types`
--
ALTER TABLE `property_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `rental_agreements`
--
ALTER TABLE `rental_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `addresss`
--
ALTER TABLE `addresss`
  ADD CONSTRAINT `FK_81BC32D23282E858` FOREIGN KEY (`patio_type_id`) REFERENCES `patio_types` (`id`),
  ADD CONSTRAINT `FK_81BC32D245EB235A` FOREIGN KEY (`federative_unit_id`) REFERENCES `federative_units` (`id`),
  ADD CONSTRAINT `FK_81BC32D29395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Limitadores para a tabela `cabinets`
--
ALTER TABLE `cabinets`
  ADD CONSTRAINT `FK_D0239182549213EC` FOREIGN KEY (`property_id`) REFERENCES `propertys` (`id`);

--
-- Limitadores para a tabela `cabinet_customers`
--
ALTER TABLE `cabinet_customers`
  ADD CONSTRAINT `FK_70D00EF77974406B` FOREIGN KEY (`cabinet_status_id`) REFERENCES `cabinet_statuss` (`id`),
  ADD CONSTRAINT `FK_70D00EF79395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `FK_70D00EF7D351EC` FOREIGN KEY (`cabinet_id`) REFERENCES `cabinets` (`id`);

--
-- Limitadores para a tabela `cashiers`
--
ALTER TABLE `cashiers`
  ADD CONSTRAINT `FK_EE44F633F1A7AE29` FOREIGN KEY (`balance_type_id`) REFERENCES `balance_types` (`id`);

--
-- Limitadores para a tabela `cedants`
--
ALTER TABLE `cedants`
  ADD CONSTRAINT `FK_50352C5A11C8FB41` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`);

--
-- Limitadores para a tabela `cleanings`
--
ALTER TABLE `cleanings`
  ADD CONSTRAINT `FK_DF50E9EF549213EC` FOREIGN KEY (`property_id`) REFERENCES `propertys` (`id`);

--
-- Limitadores para a tabela `cleaning_customers`
--
ALTER TABLE `cleaning_customers`
  ADD CONSTRAINT `FK_8E9F9A42873BD4DE` FOREIGN KEY (`cleaning_status_id`) REFERENCES `cleaning_statuss` (`id`),
  ADD CONSTRAINT `FK_8E9F9A428E5EB27B` FOREIGN KEY (`cleaning_id`) REFERENCES `cleanings` (`id`),
  ADD CONSTRAINT `FK_8E9F9A429395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Limitadores para a tabela `credit_cards`
--
ALTER TABLE `credit_cards`
  ADD CONSTRAINT `FK_5CADD6534C3A3BB` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Limitadores para a tabela `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `FK_62534E21D991282D` FOREIGN KEY (`customer_type_id`) REFERENCES `customer_types` (`id`),
  ADD CONSTRAINT `FK_62534E21E7927C74` FOREIGN KEY (`email`) REFERENCES `oauth_users` (`username`);

--
-- Limitadores para a tabela `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK_65D29B3228DE2F95` FOREIGN KEY (`payment_status_id`) REFERENCES `payment_statuss` (`id`),
  ADD CONSTRAINT `FK_65D29B322CF003C5` FOREIGN KEY (`property_customer_id`) REFERENCES `property_customers` (`id`),
  ADD CONSTRAINT `FK_65D29B32DC058279` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_types` (`id`);

--
-- Limitadores para a tabela `payment_slips`
--
ALTER TABLE `payment_slips`
  ADD CONSTRAINT `FK_FFDCBAD411C8FB41` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  ADD CONSTRAINT `FK_FFDCBAD44C3A3BB` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Limitadores para a tabela `paypals`
--
ALTER TABLE `paypals`
  ADD CONSTRAINT `FK_640054B24C3A3BB` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Limitadores para a tabela `propertys`
--
ALTER TABLE `propertys`
  ADD CONSTRAINT `FK_7AEEC2C43282E858` FOREIGN KEY (`patio_type_id`) REFERENCES `patio_types` (`id`),
  ADD CONSTRAINT `FK_7AEEC2C445EB235A` FOREIGN KEY (`federative_unit_id`) REFERENCES `federative_units` (`id`),
  ADD CONSTRAINT `FK_7AEEC2C49C81C6EB` FOREIGN KEY (`property_type_id`) REFERENCES `property_types` (`id`);

--
-- Limitadores para a tabela `property_customers`
--
ALTER TABLE `property_customers`
  ADD CONSTRAINT `FK_13BC4C9C549213EC` FOREIGN KEY (`property_id`) REFERENCES `propertys` (`id`),
  ADD CONSTRAINT `FK_13BC4C9C9395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `FK_13BC4C9CC09E3816` FOREIGN KEY (`rental_agreement_id`) REFERENCES `rental_agreements` (`id`);

--
-- Limitadores para a tabela `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_1483A5E9AA08CB10` FOREIGN KEY (`login`) REFERENCES `oauth_users` (`username`);

--
-- Limitadores para a tabela `user_group_userss`
--
ALTER TABLE `user_group_userss`
  ADD CONSTRAINT `FK_9186B2A01ED93D47` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`),
  ADD CONSTRAINT `FK_9186B2A0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
