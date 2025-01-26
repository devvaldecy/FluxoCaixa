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

-- Copiando dados para a tabela db_testes.usuarios: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`ID`, `usuarios`, `senha`) VALUES
	(1, 'Valdecy', _binary 0xd3f7fb3ab64cebaeeee482a5882e5416),
	(2, 'Daniel', _binary 0x6697b955e14e150ab1c356b7ec93027b),
	(3, 'Caio', _binary 0x5b36ce81032e7c8ec8f2dd34338e09cc),
	(4, 'Cibelly', _binary 0x5b36ce81032e7c8ec8f2dd34338e09cc),
	(5, 'Caio', _binary 0x0935e23a60cd9c5b2ea9678aac9b7e42),
	(6, 'Caio', _binary 0x0935e23a60cd9c5b2ea9678aac9b7e42),
	(7, 'Caio', _binary 0x748a92a9c7338da3ec83c859cedca053),
	(8, 'Caio', _binary 0x748a92a9c7338da3ec83c859cedca053),
	(9, 'Luziana', _binary 0x6e40afcc29b8048a2bf79ac22feed76f);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
