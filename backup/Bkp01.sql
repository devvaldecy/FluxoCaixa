-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.8.3-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para fluxo_caixa
CREATE DATABASE IF NOT EXISTS `fluxo_caixa` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `fluxo_caixa`;

-- Copiando estrutura para tabela fluxo_caixa.contas
CREATE TABLE IF NOT EXISTS `contas` (
  `id_conta` int(11) NOT NULL,
  `descricao` varchar(80) NOT NULL,
  `banco` varchar(80) DEFAULT NULL,
  `agencia` varchar(80) DEFAULT NULL,
  `conta` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_conta`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela fluxo_caixa.contas: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
INSERT INTO `contas` (`id_conta`, `descricao`, `banco`, `agencia`, `conta`) VALUES
	(1, 'BANCO SANTANDER ', '412', '4124', '412246564'),
	(2, 'BANCO DE BRASIL BB', '41526', '415267', '415263-1'),
	(3, 'CARTAO DE CREDITO CRED SHOP', '415263', '78941', '415278-9'),
	(4, 'PGTO DE CARTAO', '41', '415263', '78451-1'),
	(5, 'CAIXA ECONOMICA FEDERAL', '748596', '1284548-1', '004155620-14');
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;

-- Copiando estrutura para tabela fluxo_caixa.lancamentos
CREATE TABLE IF NOT EXISTS `lancamentos` (
  `conta` int(11) NOT NULL,
  `id_lcto` int(11) NOT NULL,
  `data_mvto` date NOT NULL,
  `plano` int(11) NOT NULL,
  `descricao` varchar(80) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`conta`,`id_lcto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela fluxo_caixa.lancamentos: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `lancamentos` DISABLE KEYS */;
INSERT INTO `lancamentos` (`conta`, `id_lcto`, `data_mvto`, `plano`, `descricao`, `valor`) VALUES
	(0, 1, '2024-09-28', 0, '', 0.00),
	(0, 2, '2024-10-01', 2, 'PAGAMENTO DE CARTAO', -469.90),
	(1, 1, '2024-09-23', 1, 'SALDO INICIO', 1000.00),
	(1, 2, '2024-09-24', 11, 'CONSERTO DO COMPUTADOR', 150.00),
	(1, 3, '2024-09-24', 4, 'PGTO DE FATURA DE ENERGIA', -200.00),
	(1, 4, '2024-09-24', 6, 'TESTE DE INCLUSAO', 250.00),
	(4, 1, '2024-10-01', 9, 'PGTO DE FAT HIPER CARD', -469.00);
/*!40000 ALTER TABLE `lancamentos` ENABLE KEYS */;

-- Copiando estrutura para tabela fluxo_caixa.planos
CREATE TABLE IF NOT EXISTS `planos` (
  `id_plano` int(11) NOT NULL,
  `descricao` varchar(80) NOT NULL,
  `tipo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_plano`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela fluxo_caixa.planos: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `planos` DISABLE KEYS */;
INSERT INTO `planos` (`id_plano`, `descricao`, `tipo`) VALUES
	(1, 'SALDO INICIAL', 'C'),
	(2, 'SALDO INICIAL NEGATIVO', 'D'),
	(3, 'SALARIO', 'C'),
	(4, 'PAGTO CONTA DE ENERGIA', 'D'),
	(5, 'PGTO DE CONTA AGUA E ESGOTO', 'D'),
	(6, 'PGTO FAT CARTAO', 'D'),
	(7, 'PGTO FATURA DE INTERNET', 'D'),
	(8, 'ADIANTAMENTO DO SALARIO', 'C'),
	(9, 'PGTO CARTAO HIPER', 'D'),
	(10, 'ATENDIMENTO TECNICO', 'C');
/*!40000 ALTER TABLE `planos` ENABLE KEYS */;

-- Copiando estrutura para tabela fluxo_caixa.teste
CREATE TABLE IF NOT EXISTS `teste` (
  `id_teste` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(30) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `observacao` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_teste`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela fluxo_caixa.teste: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `teste` DISABLE KEYS */;
INSERT INTO `teste` (`id_teste`, `descricao`, `data`, `email`, `observacao`) VALUES
	(1, 'Teste 01', '2024-09-13', 'teste01@teste.com.br', 'Teste 02 Ok.'),
	(2, 'Teste 02', '2024-09-13', 'teste02@teste.com.br', 'Teste 02 Ok.'),
	(3, 'Teste 02', '2024-09-13', 'teste03@teste.com.br', 'Teste 03 Ok.');
/*!40000 ALTER TABLE `teste` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
