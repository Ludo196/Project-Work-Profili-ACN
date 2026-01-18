CREATE DATABASE  IF NOT EXISTS `profili_acn` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `profili_acn`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: profili_acn
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `acn_profilo`
--

DROP TABLE IF EXISTS `acn_profilo`;
/*!50001 DROP VIEW IF EXISTS `acn_profilo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `acn_profilo` AS SELECT 
 1 AS `IdAsset`,
 1 AS `Asset`,
 1 AS `Asset_Tipo`,
 1 AS `Asset_Classificazione`,
 1 AS `Asset_Stato`,
 1 AS `Asset_Livello_Rischio`,
 1 AS `IdServizio`,
 1 AS `Servizio`,
 1 AS `Servizio_Categoria`,
 1 AS `Servizio_Data_Erogazione`,
 1 AS `Responsabile`,
 1 AS `Fornitore`,
 1 AS `Fornitore_PIVA`,
 1 AS `Metadato_Codice`,
 1 AS `Metadato_Descrizione`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset` (
  `IdAsset` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Tipo` enum('hardware','software','dati','dispositivo','cloud') NOT NULL,
  `Classificazione` enum('critico','non critico','di supporto') NOT NULL,
  `Stato` enum('attivo','dismesso','in manutenzione') NOT NULL,
  `Livello_rischio` enum('alto','medio','basso') DEFAULT NULL,
  `IdAsset_padre` int DEFAULT NULL,
  `IdFornitore` int DEFAULT NULL,
  `IdResponsabile` int DEFAULT NULL,
  `IdMetadato` int DEFAULT NULL,
  PRIMARY KEY (`IdAsset`),
  KEY `IdAsset_padre` (`IdAsset_padre`),
  KEY `IdFornitore` (`IdFornitore`),
  KEY `IdResponsabile` (`IdResponsabile`),
  KEY `IdMetadato` (`IdMetadato`),
  KEY `idx_asset_nome` (`Nome`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`IdAsset_padre`) REFERENCES `asset` (`IdAsset`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `asset_ibfk_2` FOREIGN KEY (`IdFornitore`) REFERENCES `fornitore` (`IdFornitore`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `asset_ibfk_3` FOREIGN KEY (`IdResponsabile`) REFERENCES `responsabile` (`IdResponsabile`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `asset_ibfk_4` FOREIGN KEY (`IdMetadato`) REFERENCES `metadato` (`IdMetadato`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` VALUES (2,'Software per la gestione del sistema operativo Windows','software','critico','attivo','alto',NULL,9,6,6),(3,'Server Applicativo','hardware','critico','attivo','alto',NULL,6,3,1),(4,'Registro accesso dispositivi','dispositivo','di supporto','attivo','medio',NULL,10,1,3),(5,'Switch di accesso','hardware','di supporto','attivo','basso',NULL,10,2,5),(6,'Strutture dati','dati','non critico','in manutenzione','medio',NULL,1,5,4),(7,'Server Applicativo con specifiche avanzate','hardware','non critico','attivo','basso',3,9,7,11),(8,'Storage centrale','dati','critico','in manutenzione','basso',NULL,5,3,12),(9,'Switch di Rete Locale','dispositivo','non critico','dismesso','basso',NULL,8,10,13),(10,'Cluster Server Dinamico','cloud','critico','attivo','alto',NULL,9,1,15),(11,'Strutture dati di supporto','dati','non critico','attivo','medio',6,1,7,14);
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitore`
--

DROP TABLE IF EXISTS `fornitore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornitore` (
  `IdFornitore` int NOT NULL AUTO_INCREMENT,
  `Ragione_sociale` varchar(100) NOT NULL,
  `Indirizzo` varchar(100) DEFAULT NULL,
  `Partita_IVA` varchar(20) NOT NULL,
  `Contatto_telefonico` varchar(20) DEFAULT NULL,
  `Numero_iscrizione` varchar(30) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Sede_amministrativa` varchar(100) DEFAULT NULL,
  `Rappresentante_legale` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdFornitore`),
  UNIQUE KEY `Partita_IVA` (`Partita_IVA`),
  UNIQUE KEY `Numero_iscrizione` (`Numero_iscrizione`),
  KEY `idx_fornitore_ragione_sociale` (`Ragione_sociale`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitore`
--

LOCK TABLES `fornitore` WRITE;
/*!40000 ALTER TABLE `fornitore` DISABLE KEYS */;
INSERT INTO `fornitore` VALUES (1,'CyberItaly','Via Venezia 14','IT12345678901','0298765432','MI12345','cyberitaly@gmail.com','Milano','Tonino Ippolito'),(2,'Spazio SRL','Via Boccaccio 1','IT98765432109','0112233445','M124578','spaziosrl@gmail.com','Roma','Salvatore Dotto'),(3,'Palo Alto Networks','Via Palatucci 1','IT12345601109','0815566778','M345878','palo.networks@gmail.com','Venezia','Arianna Di Mascio'),(4,'Fortinet','Via Leopardi 13','IT23561245687','0511122334','M245879','fortinet@libero.it','Roma','Gianluca Giovanetti'),(5,'CrowdStrike','Via Aterno 12','IT14578126987','0114567890','MI52200','crowdstrike@outlook.it','Milano','Luca Pavone'),(6,'Zscaler','Corso Vittorio 4','IT78987521453','0212345678','MI78456','zscaler.info@gmail.com','Torino','Francesco Tranquilli'),(7,'Cisco','Corso Venezia 69','IT14752689745','0698765432','M0024581','cisco.net@libero.it','Terni','Sofia Folgarait'),(8,'Okta','Via Ferrante 6','IT10100045712','0624680135','MI45789','okta@outlook.com','Siena','Michela Orlando'),(9,'Microsoft','Via Pomezia 39','IT10035487925','0245782145','MI00234','microsoft.help@gmail.com','Avezzano','Antonio Faieta'),(10,'Akamai','Corso Firenze 2','IT98005400689','0635478512','M123548','akamai@gmail.com','Pescara','Sandra Colaiocco');
/*!40000 ALTER TABLE `fornitore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadato`
--

DROP TABLE IF EXISTS `metadato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadato` (
  `IdMetadato` int NOT NULL AUTO_INCREMENT,
  `Codice` varchar(50) NOT NULL,
  `Descrizione` varchar(500) NOT NULL,
  `Data_creazione` date NOT NULL,
  `Data_aggiornamento` date NOT NULL,
  PRIMARY KEY (`IdMetadato`),
  UNIQUE KEY `Codice` (`Codice`),
  CONSTRAINT `metadato_chk_1` CHECK ((`Data_aggiornamento` >= `Data_creazione`))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadato`
--

LOCK TABLES `metadato` WRITE;
/*!40000 ALTER TABLE `metadato` DISABLE KEYS */;
INSERT INTO `metadato` VALUES (1,'META001','Asset critici dell’infrastruttura centrale','2018-04-10','2022-05-12'),(2,'META002','Servizi essenziali per la business continuity','2021-02-01','2023-03-15'),(3,'META003','Asset di supporto wireless','2019-08-15','2021-08-15'),(4,'META004','Asset essenziali di struttura','2021-01-03','2024-07-22'),(5,'META005','Asset dinamici di supporto','2020-11-28','2025-02-08'),(6,'META006','Asset critici di software','2022-03-09','2024-12-02'),(7,'META007','Servizi di supporto di autenticazione','2023-02-11','2025-01-03'),(8,'META008','Servizi essenziali firewall','2015-12-22','2018-10-10'),(9,'META009','Servizi critici di dispositivi','2016-08-15','2019-07-08'),(10,'META0010','Servizi per la gestione di risorse','2022-09-12','2023-06-15'),(11,'META011','Specifiche Tecniche ','2013-11-12','2018-03-22'),(12,'META012','Cicli di vita degli asset','2017-04-22','2021-06-14'),(13,'META013','Configurazioni dispositivi rete locale','2018-05-19','2024-08-25'),(14,'META014','Asset di supporto infrastrutture','2022-01-23','2023-07-03'),(15,'META015','Asset dinamici lato server','2019-12-10','2025-04-28'),(16,'META016','Servizi di sicurezza','2024-08-10','2025-05-22'),(17,'META017','Normative gestionali','2021-02-18','2023-01-14'),(18,'META018','Servizi di architettura di livello','2016-09-14','2019-06-09'),(19,'META019','Requisitivi organizzativi','2022-09-06','2024-07-08'),(20,'META020','Servizi di cyber security','2025-03-11','2025-10-01');
/*!40000 ALTER TABLE `metadato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `profili_acn_asset`
--

DROP TABLE IF EXISTS `profili_acn_asset`;
/*!50001 DROP VIEW IF EXISTS `profili_acn_asset`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `profili_acn_asset` AS SELECT 
 1 AS `IdAsset`,
 1 AS `Nome`,
 1 AS `Tipo`,
 1 AS `Classificazione`,
 1 AS `Stato`,
 1 AS `Livello_rischio`,
 1 AS `Fornitore`,
 1 AS `Responsabile`,
 1 AS `Metadato_Codice`,
 1 AS `Metadato_Descrizione`,
 1 AS `Servizi_Associati`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `profili_acn_servizio`
--

DROP TABLE IF EXISTS `profili_acn_servizio`;
/*!50001 DROP VIEW IF EXISTS `profili_acn_servizio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `profili_acn_servizio` AS SELECT 
 1 AS `IdServizio`,
 1 AS `Nome`,
 1 AS `Descrizione`,
 1 AS `Categoria`,
 1 AS `Data_erogazione`,
 1 AS `Servizio_Padre`,
 1 AS `Fornitore`,
 1 AS `Responsabile`,
 1 AS `Metadato_Codice`,
 1 AS `Metadato_Descrizione`,
 1 AS `Asset_Associati`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `responsabile`
--

DROP TABLE IF EXISTS `responsabile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsabile` (
  `IdResponsabile` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `Codice_fiscale` varchar(16) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Data_nascita` date DEFAULT NULL,
  `Citta_nascita` varchar(50) DEFAULT NULL,
  `Matricola` varchar(20) DEFAULT NULL,
  `Contatto_telefonico` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`IdResponsabile`),
  UNIQUE KEY `Codice_fiscale` (`Codice_fiscale`),
  UNIQUE KEY `Matricola` (`Matricola`),
  KEY `idx_responsabile_nome_cognome` (`Nome`,`Cognome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsabile`
--

LOCK TABLES `responsabile` WRITE;
/*!40000 ALTER TABLE `responsabile` DISABLE KEYS */;
INSERT INTO `responsabile` VALUES (1,'Ludovico','Rossi','RSSLVC75R01E463N','ludovico.rossi@gmail.com','1975-10-01','La spezia','243542','3351234567'),(2,'Anna','Lodi','LDONNA61M47G438N','anna.lodi@gmail.com','1961-08-07','Penne','327896','3387654321'),(3,'VIncenzo','Loiacono','LCNVCN83M19F205I','vincenzo.loiacono@outlook.com','1983-08-19','Milano','356987','3205478931'),(4,'Francesca','Melozzi','MLZFNC96B60H501R','francesca.melozzi@gmail.com','1996-02-20','Roma','127845','3332197645'),(5,'Marta','Carota','CRTMRT90A71G811O','marta.carota@libero.it','1990-01-31','Pomezia','578965','3498712056'),(6,'Flaminio','Spina','SPNFMN77C11G482Z','flaminio.spina@gmail.com','1977-03-11','Pescara','415263','3406591238'),(7,'Lorenzo','Carusi','CRSLNZ82R12A515K','lorenzo.carusi@libero.it','1982-10-12','Avezzano','120354','3287749021'),(8,'Marco','Tozzi','TZZMRC95T28F839Z','marco.tozzi@gmail.com','1995-12-28','Napoli','740258','3473116859'),(9,'Veronica','Marchigiano','MRCVNC78B53H501Y','veronica.marchigiano@gmail.com','1978-02-13','Roma','249875','3394527804'),(10,'Annamaria','Vergato','VRGNMR65S65I754M','annamaria.vergato@outlook.it','1965-11-25','Siracusa','968745','3425689317');
/*!40000 ALTER TABLE `responsabile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servizio`
--

DROP TABLE IF EXISTS `servizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servizio` (
  `IdServizio` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Descrizione` varchar(500) NOT NULL,
  `Categoria` enum('essenziale','di supporto') NOT NULL,
  `Data_erogazione` date NOT NULL,
  `IdServizio_padre` int DEFAULT NULL,
  `IdFornitore` int DEFAULT NULL,
  `IdResponsabile` int DEFAULT NULL,
  `IdMetadato` int DEFAULT NULL,
  PRIMARY KEY (`IdServizio`),
  KEY `IdServizio_padre` (`IdServizio_padre`),
  KEY `IdFornitore` (`IdFornitore`),
  KEY `IdResponsabile` (`IdResponsabile`),
  KEY `IdMetadato` (`IdMetadato`),
  KEY `idx_servizio_nome` (`Nome`),
  CONSTRAINT `servizio_ibfk_1` FOREIGN KEY (`IdServizio_padre`) REFERENCES `servizio` (`IdServizio`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `servizio_ibfk_2` FOREIGN KEY (`IdFornitore`) REFERENCES `fornitore` (`IdFornitore`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `servizio_ibfk_3` FOREIGN KEY (`IdResponsabile`) REFERENCES `responsabile` (`IdResponsabile`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `servizio_ibfk_4` FOREIGN KEY (`IdMetadato`) REFERENCES `metadato` (`IdMetadato`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizio`
--

LOCK TABLES `servizio` WRITE;
/*!40000 ALTER TABLE `servizio` DISABLE KEYS */;
INSERT INTO `servizio` VALUES (1,'Servizio di continuità operativa','I sistemi informativi rimangano funzionanti durante interruzioni o guasti','essenziale','2018-08-17',NULL,9,4,2),(2,'Servizio Monitoraggio Endpoint','Monitora in modo continuo lo stato dei dispositivi rilevando anomalie se presenti','essenziale','2022-01-10',NULL,10,5,9),(3,'Servizio Firewall Perimetrale','Protegge la rete aziendale','essenziale','2010-11-24',NULL,6,2,8),(4,'Servizio Gestione Risorse IT','Coordina la gestione delle risorse informatiche','di supporto','2023-07-22',NULL,9,6,10),(5,'Servizio di Autenticazione','Gestisce l’autenticazione centralizzata','essenziale','2017-03-11',NULL,7,1,7),(6,'Servizio di Sicurezza Endpoint','ervizio dedicato alla protezione dei dispositivi aziendali','di supporto','2023-08-23',2,10,8,16),(7,'Servizio di Gestione Normativa Aziendale','Gestisce e applica le normative operative e documentali,','essenziale','2024-11-30',4,9,5,17),(8,'Servizio di Architettura Applicativa','Definisce e mantiene l’architettura dei sistemi','essenziale','2017-03-23',NULL,3,5,18),(9,'Servizio di Coordinamento Organizzativo','Supporta i processi interni per l’adeguamento operativo','di supporto','2019-12-03',1,9,8,19),(10,'Servizio di Cyber Defense','Specializzato nella prevenzione, monitoraggio e risposta agli incidenti','essenziale','2025-04-10',NULL,3,2,20);
/*!40000 ALTER TABLE `servizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servizio_asset`
--

DROP TABLE IF EXISTS `servizio_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servizio_asset` (
  `IdServizio_Asset` int NOT NULL AUTO_INCREMENT,
  `IdServizio` int NOT NULL,
  `IdAsset` int NOT NULL,
  PRIMARY KEY (`IdServizio_Asset`),
  UNIQUE KEY `unq_servizio_asset` (`IdServizio`,`IdAsset`),
  KEY `IdAsset` (`IdAsset`),
  CONSTRAINT `servizio_asset_ibfk_1` FOREIGN KEY (`IdServizio`) REFERENCES `servizio` (`IdServizio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `servizio_asset_ibfk_2` FOREIGN KEY (`IdAsset`) REFERENCES `asset` (`IdAsset`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servizio_asset`
--

LOCK TABLES `servizio_asset` WRITE;
/*!40000 ALTER TABLE `servizio_asset` DISABLE KEYS */;
INSERT INTO `servizio_asset` VALUES (1,1,2),(2,1,10),(3,2,7),(4,2,9),(5,3,3),(6,3,5),(7,4,4),(8,4,6),(9,5,3),(10,5,7),(11,6,4),(12,6,9),(13,7,6),(14,7,11),(15,8,7),(16,8,10),(17,10,5),(18,10,8);
/*!40000 ALTER TABLE `servizio_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storico_asset`
--

DROP TABLE IF EXISTS `storico_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storico_asset` (
  `IdStorico` int NOT NULL AUTO_INCREMENT,
  `IdAsset` int NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Tipo` enum('hardware','software','dati','dispositivo','cloud') DEFAULT NULL,
  `Classificazione` enum('critico','non critico','di supporto') DEFAULT NULL,
  `Stato` enum('attivo','dismesso','in manutenzione') DEFAULT NULL,
  `Livello_rischio` enum('alto','medio','basso') DEFAULT NULL,
  `IdAsset_padre` int DEFAULT NULL,
  `IdFornitore` int DEFAULT NULL,
  `IdResponsabile` int DEFAULT NULL,
  `IdMetadato` int DEFAULT NULL,
  `Operazione` enum('INSERIMENTO','AGGIORNAMENTO','CANCELLAZIONE') NOT NULL,
  `Data_operazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdStorico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storico_asset`
--

LOCK TABLES `storico_asset` WRITE;
/*!40000 ALTER TABLE `storico_asset` DISABLE KEYS */;
INSERT INTO `storico_asset` VALUES (1,1,'Asset di test','hardware','critico','attivo','alto',NULL,NULL,NULL,NULL,'AGGIORNAMENTO','2025-11-14 14:54:36'),(2,1,'Asset di test','hardware','critico','in manutenzione','alto',NULL,NULL,NULL,NULL,'CANCELLAZIONE','2025-11-14 14:54:52'),(3,1,'Server Principale','software','critico','attivo','alto',NULL,9,6,6,'CANCELLAZIONE','2025-11-25 09:17:10'),(4,7,'Server Applicativo con specifiche avanzate','hardware','non critico','attivo','basso',2,9,7,11,'AGGIORNAMENTO','2025-11-26 09:54:42');
/*!40000 ALTER TABLE `storico_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storico_servizio`
--

DROP TABLE IF EXISTS `storico_servizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storico_servizio` (
  `IdStorico` int NOT NULL AUTO_INCREMENT,
  `IdServizio` int NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Descrizione` varchar(500) NOT NULL,
  `Categoria` enum('essenziale','di supporto') DEFAULT NULL,
  `Data_erogazione` date DEFAULT NULL,
  `IdServizio_padre` int DEFAULT NULL,
  `IdFornitore` int DEFAULT NULL,
  `IdResponsabile` int DEFAULT NULL,
  `IdMetadato` int DEFAULT NULL,
  `Operazione` enum('INSERIMENTO','AGGIORNAMENTO','CANCELLAZIONE') NOT NULL,
  `Data_operazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdStorico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storico_servizio`
--

LOCK TABLES `storico_servizio` WRITE;
/*!40000 ALTER TABLE `storico_servizio` DISABLE KEYS */;
INSERT INTO `storico_servizio` VALUES (1,1,'Servizio di test','Gestione delle identità e autenticazione centralizzata','essenziale','2024-01-15',NULL,NULL,NULL,NULL,'AGGIORNAMENTO','2025-11-14 14:59:18'),(2,1,'Servizio di test','Gestione delle identità','di supporto','2024-01-15',NULL,NULL,NULL,NULL,'CANCELLAZIONE','2025-11-14 14:59:27');
/*!40000 ALTER TABLE `storico_servizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `acn_profilo`
--

/*!50001 DROP VIEW IF EXISTS `acn_profilo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `acn_profilo` AS select `a`.`IdAsset` AS `IdAsset`,`a`.`Nome` AS `Asset`,`a`.`Tipo` AS `Asset_Tipo`,`a`.`Classificazione` AS `Asset_Classificazione`,`a`.`Stato` AS `Asset_Stato`,`a`.`Livello_rischio` AS `Asset_Livello_Rischio`,`s`.`IdServizio` AS `IdServizio`,`s`.`Nome` AS `Servizio`,`s`.`Categoria` AS `Servizio_Categoria`,`s`.`Data_erogazione` AS `Servizio_Data_Erogazione`,concat(`r`.`Nome`,' ',`r`.`Cognome`) AS `Responsabile`,`f`.`Ragione_sociale` AS `Fornitore`,`f`.`Partita_IVA` AS `Fornitore_PIVA`,`m`.`Codice` AS `Metadato_Codice`,`m`.`Descrizione` AS `Metadato_Descrizione` from (((((`asset` `a` left join `servizio_asset` `sa` on((`a`.`IdAsset` = `sa`.`IdAsset`))) left join `servizio` `s` on((`sa`.`IdServizio` = `s`.`IdServizio`))) left join `responsabile` `r` on((`a`.`IdResponsabile` = `r`.`IdResponsabile`))) left join `fornitore` `f` on((`a`.`IdFornitore` = `f`.`IdFornitore`))) left join `metadato` `m` on((`a`.`IdMetadato` = `m`.`IdMetadato`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `profili_acn_asset`
--

/*!50001 DROP VIEW IF EXISTS `profili_acn_asset`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `profili_acn_asset` AS select `a`.`IdAsset` AS `IdAsset`,`a`.`Nome` AS `Nome`,`a`.`Tipo` AS `Tipo`,`a`.`Classificazione` AS `Classificazione`,`a`.`Stato` AS `Stato`,`a`.`Livello_rischio` AS `Livello_rischio`,`f`.`Ragione_sociale` AS `Fornitore`,concat(`r`.`Nome`,' ',`r`.`Cognome`) AS `Responsabile`,`m`.`Codice` AS `Metadato_Codice`,`m`.`Descrizione` AS `Metadato_Descrizione`,group_concat(`s`.`Nome` separator '; ') AS `Servizi_Associati` from (((((`asset` `a` left join `fornitore` `f` on((`a`.`IdFornitore` = `f`.`IdFornitore`))) left join `responsabile` `r` on((`a`.`IdResponsabile` = `r`.`IdResponsabile`))) left join `metadato` `m` on((`a`.`IdMetadato` = `m`.`IdMetadato`))) left join `servizio_asset` `sa` on((`sa`.`IdAsset` = `a`.`IdAsset`))) left join `servizio` `s` on((`s`.`IdServizio` = `sa`.`IdServizio`))) group by `a`.`IdAsset`,`a`.`Nome`,`a`.`Tipo`,`a`.`Classificazione`,`a`.`Stato`,`a`.`Livello_rischio`,`f`.`Ragione_sociale`,`r`.`Nome`,`r`.`Cognome`,`r`.`Email`,`m`.`Codice`,`m`.`Descrizione` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `profili_acn_servizio`
--

/*!50001 DROP VIEW IF EXISTS `profili_acn_servizio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `profili_acn_servizio` AS select `s`.`IdServizio` AS `IdServizio`,`s`.`Nome` AS `Nome`,`s`.`Descrizione` AS `Descrizione`,`s`.`Categoria` AS `Categoria`,`s`.`Data_erogazione` AS `Data_erogazione`,`sp`.`Nome` AS `Servizio_Padre`,`f`.`Ragione_sociale` AS `Fornitore`,concat(`r`.`Nome`,' ',`r`.`Cognome`) AS `Responsabile`,`m`.`Codice` AS `Metadato_Codice`,`m`.`Descrizione` AS `Metadato_Descrizione`,group_concat(`a`.`Nome` separator '; ') AS `Asset_Associati` from ((((((`servizio` `s` left join `servizio` `sp` on((`s`.`IdServizio_padre` = `sp`.`IdServizio`))) left join `fornitore` `f` on((`s`.`IdFornitore` = `f`.`IdFornitore`))) left join `responsabile` `r` on((`s`.`IdResponsabile` = `r`.`IdResponsabile`))) left join `metadato` `m` on((`s`.`IdMetadato` = `m`.`IdMetadato`))) left join `servizio_asset` `sa` on((`sa`.`IdServizio` = `s`.`IdServizio`))) left join `asset` `a` on((`a`.`IdAsset` = `sa`.`IdAsset`))) group by `s`.`IdServizio`,`s`.`Nome`,`s`.`Descrizione`,`s`.`Categoria`,`s`.`Data_erogazione`,`sp`.`Nome`,`f`.`Ragione_sociale`,`r`.`Nome`,`r`.`Cognome`,`r`.`Email`,`m`.`Codice`,`m`.`Descrizione` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-18 16:42:16
