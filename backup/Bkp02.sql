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

-- Copiando dados para a tabela fluxo_caixa.contas: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
INSERT INTO `contas` (`id_conta`, `descricao`, `banco`, `agencia`, `conta`) VALUES
	(1, 'BANCO SANTANDER ', '412452', '4124', '412246564'),
	(2, 'BANCO DE BRASIL BB', '415267', '415267', '415263-1'),
	(3, 'CARTAO DE CREDITO CRED SHOP', '415263', '78941', '415278-9'),
	(4, 'PGTO DE CARTAO', '414789', '415263', '78451-1'),
	(5, 'CAIXA ECONOMICA FEDERAL', '748596', '128454', '00415562'),
	(6, 'PAGTO COM PIX SANTANDER', '412541', '14215', '1234574-77'),
	(7, 'PGTO CARTAO CRED SHOP', '78964', '14253', '415263'),
	(8, 'PGTO PIX PIC PAY', '41526', '42264', '4123456-7');
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;

-- Copiando dados para a tabela fluxo_caixa.lancamentos: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `lancamentos` DISABLE KEYS */;
INSERT INTO `lancamentos` (`conta`, `id_lcto`, `data_mvto`, `plano`, `descricao`, `valor`) VALUES
	(0, 1, '2024-09-28', 0, '', 0.00),
	(0, 2, '2024-10-01', 2, 'PAGAMENTO DE CARTAO', -469.90),
	(0, 3, '2024-10-06', 11, 'PAGAMENTO DE COMPRAS NA ZELIA', -30.65),
	(1, 1, '2024-09-23', 1, 'SALDO INICIO', 1000.00),
	(1, 2, '2024-09-24', 11, 'CONSERTO DO COMPUTADOR', 150.00),
	(1, 3, '2024-09-24', 4, 'PGTO DE FATURA DE ENERGIA', -200.00),
	(1, 4, '2024-09-24', 6, 'TESTE DE INCLUSAO', 250.00),
	(1, 5, '2024-12-02', 14, 'PAGAMENTO 1 PARCELO DO 1 EMPRESTIMO', -202.89),
	(4, 1, '2024-10-01', 9, 'PGTO DE FAT HIPER CARD', -469.00),
	(7, 1, '2024-10-10', 12, 'COMPRA PETISCO E NESCAU', -7.50);
/*!40000 ALTER TABLE `lancamentos` ENABLE KEYS */;

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
	(10, 'ATENDIMENTO TECNICO', 'C'),
	(11, 'PGTO COM PIX SANTANDER COMPRAS', 'D'),
	(12, 'COMPRAS NA ZELIA COMERCIO CONTA', 'D'),
	(13, 'COMPRAS PARA CASA', 'D'),
	(14, 'EMPR. CONSIGUINADO SANT.', 'D'),
	(15, 'EMPRESTIMO CONS CONTA 2', 'D');
/*!40000 ALTER TABLE `planos` ENABLE KEYS */;

-- Copiando dados para a tabela fluxo_caixa.usuarios: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id_user`, `nome`, `login`, `senha`, `email`) VALUES
	(00000000001, 'ADMINISTRATOR', 'ADMIN', '12345', 'ADMIN@ADMIN.COM'),
	(00000000002, 'OPERADOR', 'OPERADOR', '050812228', 'operador@operador.com');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
