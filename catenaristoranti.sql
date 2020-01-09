SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

SET foreign_key_checks = 0 ;


CREATE DATABASE IF NOT EXISTS `catenaristoranti` DEFAULT CHARACTER SET latin1 COLLATE latin1_bin;
USE `catenaristoranti`;

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Cognome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Citta` varchar(255) COLLATE latin1_bin NOT NULL,
  `Indirizzo` varchar(255) COLLATE latin1_bin NOT NULL,
  `Sesso` varchar(1) COLLATE latin1_bin NOT NULL,
  `Bandito` int(1) NOT NULL,
  PRIMARY KEY (`CodFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `adopera`;
CREATE TABLE IF NOT EXISTS `adopera` (
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdIngrediente` varchar(255) COLLATE latin1_bin NOT NULL,
  `FunzioneNellaPietanza` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRicetta`,`IdIngrediente`),
  CONSTRAINT fk_adopera_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_adopera_ingrediente
    FOREIGN KEY (`IdIngrediente`)
    REFERENCES  `ingrediente`(`IdIngrediente`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `comanda`;
CREATE TABLE IF NOT EXISTS `comanda` (
  `IdComanda` varchar(255) COLLATE latin1_bin NOT NULL,
  `Stato` varchar(255) COLLATE latin1_bin NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IdTavolo` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdComanda`),
  CONSTRAINT fk_comanda_tavolo
    FOREIGN KEY (`IdTavolo`)
    REFERENCES  `tavolo`(`IdTavolo`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `comandatakeaway`;
CREATE TABLE IF NOT EXISTS `comandatakeaway` (
  `IdComandaTakeAway` varchar(255) COLLATE latin1_bin NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Stato` varchar(255) COLLATE latin1_bin NOT NULL,
  `TimestampPartenza` timestamp NULL ,
  `TimestampConsegna` timestamp NULL ,
  `TimestampRientro` timestamp NULL ,
  `IdPony` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdComandaTakeAway`),
  CONSTRAINT fk_comandaTA_pony
    FOREIGN KEY (`IdPony`)
    REFERENCES  `pony`(`IdPony`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_comandaTA_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `comparenel`;
CREATE TABLE IF NOT EXISTS `comparenel` (
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdMenu` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRicetta`,`IdMenu`),
  CONSTRAINT fk_compare_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_compare_menu
    FOREIGN KEY (`IdMenu`)
    REFERENCES  `menu`(`IdMenu`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `confezione`;
CREATE TABLE IF NOT EXISTS `confezione` (
  `IdConfezione` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodiceLotto` varchar(255) COLLATE latin1_bin NOT NULL,
  `PrezzoAcquisto` varchar(255) COLLATE latin1_bin NOT NULL,
  `DataAcquisto` date NOT NULL,
  `Peso` int(11) NOT NULL,
  `Aspetto` varchar(255) COLLATE latin1_bin NOT NULL,
  `IndicatoreCollocazione` int(11) NOT NULL,
  `Stato` varchar(255) COLLATE latin1_bin NOT NULL,
  `DataScadenza` date NOT NULL,
  `DataArrivo` date NOT NULL,
  `IdMagazzino` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdIngrediente` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdConfezione`),
  CONSTRAINT fk_confezione_magazzino
    FOREIGN KEY (`IdMagazzino`)
    REFERENCES  `magazzino`(`IdMagazzino`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_confezione_ingrediente
    FOREIGN KEY (`IdIngrediente`)
    REFERENCES  `ingrediente`(`IdIngrediente`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `domanda`;
CREATE TABLE IF NOT EXISTS `domanda` (
  `IdDomanda` varchar(255) COLLATE latin1_bin NOT NULL,
  `Testo` varchar(20000) COLLATE latin1_bin NOT NULL,
  `IdQuestionario` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdDomanda`),
  CONSTRAINT fk_domanda_questionario
    FOREIGN KEY (`IdQuestionario`)
    REFERENCES  `questionario`(`IdQuestionario`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `fasepreparazione`;
CREATE TABLE IF NOT EXISTS `fasepreparazione` (
  `IdFase` varchar(255) COLLATE latin1_bin NOT NULL,
  `Durata` varchar(255) COLLATE latin1_bin NOT NULL,
  `Dose` varchar(255) NOT NULL,
  `Manovra` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdMacchina` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdIngrediente` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdFase`),
  CONSTRAINT fk_fasepreparazione_macchinario
    FOREIGN KEY (`IdMacchina`)
    REFERENCES  `macchinarioattrezzatura`(`IdMacchina`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_fasepreparazione_ingrediente
    FOREIGN KEY (`IdIngrediente`)
    REFERENCES  `ingrediente`(`IdIngrediente`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_fasepreparazione_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `formata`;
CREATE TABLE IF NOT EXISTS `formata` (
  `IdRecensione` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdRisposta` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRecensione`,`IdRisposta`),
  CONSTRAINT fk_formata_risposta
    FOREIGN KEY (`IdRisposta`)
    REFERENCES  `risposta`(`IdRisposta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_formata_recensione
    FOREIGN KEY (`IdRecensione`)
    REFERENCES  `recensione`(`IdRecensione`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `funzione`;
CREATE TABLE IF NOT EXISTS `funzione` (
  `IdFunzione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Descrizione` varchar(20000) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdFunzione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `ingrediente`;
CREATE TABLE IF NOT EXISTS `ingrediente` (
  `IdIngrediente` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Genere` varchar(255) COLLATE latin1_bin NOT NULL,
  `Provenienza` varchar(255) COLLATE latin1_bin NOT NULL,
  `TipoProduzione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Allergene` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdIngrediente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `macchinarioattrezzatura`;
CREATE TABLE IF NOT EXISTS `macchinarioattrezzatura` (
  `IdMacchina` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Tipologia` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdMacchina`),
  CONSTRAINT fk_macchinario_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES  `sede`(`IdSede`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `magazzino`;
CREATE TABLE IF NOT EXISTS `magazzino` (
  `IdMagazzino` varchar(255) COLLATE latin1_bin NOT NULL,
  `Indirizzo` varchar(255) COLLATE latin1_bin NOT NULL,
  `Città` varchar(255) COLLATE latin1_bin NOT NULL,
  `CAP` int(5) NOT NULL,
  `NumeroTelefono` varchar(10) NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdMagazzino`),
  CONSTRAINT fk_magazzino_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES `sede`(`IdSede`) 
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `IdMenu` varchar(255) COLLATE latin1_bin NOT NULL,
  `DataInizio` date NOT NULL,
  `DataFine` text COLLATE latin1_bin NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdMenu`),
  CONSTRAINT fk_menu_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES `sede`(`IdSede`) 
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `piattoordinato`;
CREATE TABLE IF NOT EXISTS `piattoordinato` (
  `IdPiatto` varchar(255) COLLATE latin1_bin NOT NULL,
  `Stato` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdComanda` varchar(255) COLLATE latin1_bin NULL,
  `IdComandaTakeAway` varchar(255) COLLATE latin1_bin NULL,
  PRIMARY KEY (`IdPiatto`),
  CONSTRAINT fk_piattoordinato_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_piattoordinato_comanda
    FOREIGN KEY (`IdComanda`)
    REFERENCES  `comanda`(`IdComanda`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_piattoordinato_comandaTA
    FOREIGN KEY (`IdComandaTakeAway`)
    REFERENCES  `comandatakeaway`(`IdComandaTakeAway`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `pony`;
CREATE TABLE IF NOT EXISTS `pony` (
  `IdPony` varchar(255) COLLATE latin1_bin NOT NULL,
  `TipologiaMezzo` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdPony`),
  CONSTRAINT fk_pony_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES  `sede`(`IdSede`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `prenotazione`;
CREATE TABLE IF NOT EXISTS `prenotazione` (
  `IdPrenotazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `NumeroPersone` int(50) NOT NULL,
  `Data` date NOT NULL,
  `Ora` varchar(255) NOT NULL,
  `NumeroTelefono` int(10) NOT NULL,
  `Allestimenti` text NULL COLLATE latin1_bin,
  `Rispettata` varchar(2) NOT NULL,
  `IdTavolo` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdPrenotazione`),
  CONSTRAINT fk_prenotazione_tavolo
    FOREIGN KEY (`IdTavolo`)
    REFERENCES  `tavolo`(`IdTavolo`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_prenotazione_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `questionario`;
CREATE TABLE IF NOT EXISTS `questionario` (
  `IdQuestionario` varchar(255) COLLATE latin1_bin NOT NULL,
  `Autore` varchar(255) COLLATE latin1_bin NOT NULL,
  `DataCreazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `InUso` varchar(2) NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdRicetta` varchar(255) COLLATE latin1_bin NULL,
  PRIMARY KEY (`IdQuestionario`),
  CONSTRAINT fk_questionario_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES  `sede`(`IdSede`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_questionario_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `recensione`;
CREATE TABLE IF NOT EXISTS `recensione` (
  `IdRecensione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Testo` text COLLATE latin1_bin NOT NULL,
  `GiudizioGlobale` int(11) NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRecensione`),
  CONSTRAINT fk_recensione_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES  `sede`(`IdSede`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_recensione_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `ricetta`;
CREATE TABLE IF NOT EXISTS `ricetta` (
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Testo` text COLLATE latin1_bin NOT NULL,
  `Descrizione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Prezzo` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRicetta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `riguarda`;
CREATE TABLE IF NOT EXISTS `riguarda` (
  `IdVariazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdPiatto` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdVariazione`,`IdPiatto`),
  CONSTRAINT fk_riguarda_variazione
    FOREIGN KEY (`IdVariazione`)
    REFERENCES  `variazione`(`IdVariazione`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
   CONSTRAINT fk_riguarda_piattoordinato
    FOREIGN KEY (`IdPiatto`)
    REFERENCES  `piattoordinato`(`IdPiatto`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `risposta`;
CREATE TABLE IF NOT EXISTS `risposta` (
  `IdRisposta` varchar(255) COLLATE latin1_bin NOT NULL,
  `PunteggioEfficienza` int(11) NOT NULL,
  `IdDomanda` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdRisposta`),
  CONSTRAINT fk_risposta_domanda
    FOREIGN KEY (`IdDomanda`)
    REFERENCES  `domanda`(`IdDomanda`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `sede`;
CREATE TABLE IF NOT EXISTS `sede` (
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Indirizzo` varchar(255) COLLATE latin1_bin NOT NULL,
  `Città` varchar(255) COLLATE latin1_bin NOT NULL,
  `CAP` int(5) NOT NULL,
  `NumeroTelefono` varchar(10) NOT NULL,
  PRIMARY KEY (`IdSede`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `seratatemaproposta`;
CREATE TABLE IF NOT EXISTS `seratatemaproposta` (
  `IdSerata` varchar(255) COLLATE latin1_bin NOT NULL,
  `Allestimenti` text COLLATE latin1_bin NOT NULL,
  `Data` date NOT NULL,
  `NumeroPersone` int(50) NOT NULL,
  `Approvata` varchar(2) NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdSerata`),
  CONSTRAINT fk_seratatema_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `svolge`;
CREATE TABLE IF NOT EXISTS `svolge` (
  `IdFunzione` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdMacchina` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdFunzione`,`IdMacchina`),
  CONSTRAINT fk_svolge_funzione
    FOREIGN KEY (`IdFunzione`)
    REFERENCES  `funzione`(`IdFunzione`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_svolge_macchinario
    FOREIGN KEY (`IdMacchina`)
    REFERENCES  `macchinarioattrezzatura`(`IdMacchina`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `tavolo`;
CREATE TABLE IF NOT EXISTS `tavolo` (
  `IdTavolo` varchar(255) COLLATE latin1_bin NOT NULL,
  `NumeroPosti` int(11) NOT NULL,
  `Sala` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdSede` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdTavolo`),
  CONSTRAINT fk_tavolo_sede
    FOREIGN KEY (`IdSede`)
    REFERENCES  `sede`(`IdSede`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `valutazione`;
CREATE TABLE IF NOT EXISTS `valutazione` (
  `IdValutazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Punteggio` int(11) NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  `IdVariante` varchar(255) COLLATE latin1_bin NULL,
  `IdVariantePiatto` varchar(255) COLLATE latin1_bin NULL,
  PRIMARY KEY (`IdValutazione`),
  CONSTRAINT fk_valutazione_variante
    FOREIGN KEY (`IdVariante`)
    REFERENCES  `variante`(`IdVariante`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_valutazione_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_valutazione_variantepiatto
    FOREIGN KEY (`IdVariantePiatto`)
    REFERENCES  `variantepiatto`(`IdVariantePiatto`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `valutazionerecensione`;
CREATE TABLE IF NOT EXISTS `valutazionerecensione` (
  `IdValutazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Testo` text COLLATE latin1_bin NOT NULL,
  `GradoAccuratezza` varchar(255) COLLATE latin1_bin NOT NULL,
  `GradoVeridicità` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdRecensione` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdValutazione`),
  CONSTRAINT fk_valutazionerecensione_recensione
    FOREIGN KEY (`IdRecensione`)
    REFERENCES  `recensione`(`IdRecensione`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_valutazionerecensione_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `variante`;
CREATE TABLE IF NOT EXISTS `variante` (
  `IdVariante` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Descrizione` varchar(255) COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdVariante`),
  CONSTRAINT fk_variante_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_variante_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `variantepiatto`;
CREATE TABLE IF NOT EXISTS `variantepiatto` (
  `IdVariantePiatto` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Ricetta` text COLLATE latin1_bin NOT NULL,
  `CodFiscale` varchar(16) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`IdVariantePiatto`),
  CONSTRAINT fk_variantepiatto_account
    FOREIGN KEY (`CodFiscale`)
    REFERENCES  `account`(`CodFiscale`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

DROP TABLE IF EXISTS `variazione`;
CREATE TABLE IF NOT EXISTS `variazione` (
  `IdVariazione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Nome` varchar(255) COLLATE latin1_bin NOT NULL,
  `Descrizione` varchar(255) COLLATE latin1_bin NOT NULL,
  `Tipologia` varchar(255) COLLATE latin1_bin NOT NULL,
  `Durata` varchar(255) COLLATE latin1_bin NOT NULL,
  `Prezzo` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdMacchina` varchar(255) COLLATE latin1_bin  NULL,
  `IdRicetta` varchar(255) COLLATE latin1_bin NOT NULL,
  `IdIngrediente` varchar(255) COLLATE latin1_bin NULL,
  `IdFase` varchar(255) COLLATE latin1_bin NULL,
  PRIMARY KEY (`IdVariazione`),
  CONSTRAINT fk_variazione_macchinario
    FOREIGN KEY (`IdMacchina`)
    REFERENCES  `macchinarioattrezzatura`(`IdMacchina`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_variazione_ricetta
    FOREIGN KEY (`IdRicetta`)
    REFERENCES  `ricetta`(`IdRicetta`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_variazione_ingrediente
    FOREIGN KEY (`IdIngrediente`)
    REFERENCES  `ingrediente`(`IdIngrediente`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION ,
  CONSTRAINT fk_variazione_fasepreparazione
    FOREIGN KEY (`IdFase`)
    REFERENCES  `fasepreparazione`(`IdFase`)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;


INSERT INTO account
VALUES ( 'aaa1','Tommaso','Gatti','Pisa','Via Verdi 2','M', 0 ),
       ( 'bbb2','Maria','Cani','Bologna','Via Gialli 15','F', 1 ),
       ( 'ccc3','Ultima','Gallina','Firenze','Via Martiri 28','F', 0 ),
       ( 'ddd4','Maria Rita','Cinghiali','Cagliari','Via Gramsci 6','F', 0 ),
       ( 'eee5','Vivetta','Giaguaro','Roma','Via Marino 45','F', 0 ),
       ( 'fff6','Renzo','Capra','Como','Via Lucia 3','M', 1 ),
       ( 'ggg7','Ampelia','Sorci','Grosseto','Via Ratti 1','F', 0 ),
       ( 'hhh8','Edoardo','Lepre','Siena','Via Gigli 44','M', 1 ),
       ( 'iii9','Osvaldo','Facoceri','Milano','Via Guelfi 33','M', 0 ),
       ( 'lll1','Giacomo','Tordi','Roma','Via Alighieri 33','M',0 );

INSERT INTO adopera
VALUES ( 'ric1','ingr2','principale'),
       ( 'ric4','ingr5','secondario'),
       ( 'ric2','ingr1','secondario'),
       ( 'ric12','ingr1','principale'),
       ( 'ric5','ingr6','principale'),
       ( 'ric2','ingr3','secondario'),
       ( 'ric7','ingr4','principale'),
       ( 'ric12','ingr2','principale'),
       ( 'ric1','ingr1','secondario'),
       ( 'ric5','ingr2','principale');

INSERT INTO comanda
VALUES ( 'com1','nuova','2015-09-01 15:00:00','tav7'),
       ( 'com2','parziale','2015-09-01 15:01:00','tav3'),
       ( 'com3','parziale','2015-09-01 15:02:00','tav2'),
       ( 'com4','evasa','2015-09-01 15:02:14','tav8'),
       ( 'com5','evasa','2015-09-01 15:03:00','tav9'),
       ( 'com6','parziale','2015-09-01 15:21:00','tav1'),
       ( 'com7','nuova','2015-09-01 15:30:00','tav5'),
       ( 'com8','nuova','2015-09-01 15:40:00','tav10'),
       ( 'com9','nuova','2015-09-01 15:43:21','tav11'),
       ( 'com10','nuova','2015-09-01 15:53:21','tav16');

INSERT INTO comandatakeaway
VALUES ( 'comtk1','2015-09-01 15:00:00','consegna','2015-09-01 15:10:55',NULL, NULL,'pony333','aaa1'),
       ( 'comtk2','2015-09-01 15:01:00','consegna','2015-09-01 15:11:00','2015-09-01 15:17:00',NUll,'pony2','iii9'),
       ( 'comtk3','2015-09-01 15:02:00','consegna','2015-09-01 15:22:00',NULL,NULL,'pony34','bbb2'),
       ( 'comtk4','2015-09-01 15:02:14','consegna','2015-09-01 15:22:00','2015-09-01 15:25:00', NULL,'pony2','ggg7'),
       ( 'comtk5','2015-09-01 15:03:00','consegna','2015-09-01 15:13:00','2015-09-01 15:23:00','2015-09-01 15:28:00','pony78','fff6'),
       ( 'comtk6','2015-09-01 15:21:00','nuova',NULL,NULL,NULL,'','aaa1'),
       ( 'comtk7','2015-09-01 15:30:00','nuova',NULL,NULL,NULL,'','bbb2'),
       ( 'comtk8','2015-09-01 15:40:00','nuova',NULL,NULL,NULL,'','ccc3'),
       ( 'comtk9','2015-09-01 15:43:21','nuova',NULL,NULL,NULL,'','ddd4'),
       ( 'comtk10','2015-09-01 15:47:51','nuova',NULL,NULL,NULL,'','eee5');

INSERT INTO comparenel
VALUES ( 'ric1','menu1'),
       ( 'ric4','menu1'),
       ( 'ric2','menu2'),
       ( 'ric12','menu5'),
       ( 'ric5','menu6'),
       ( 'ric2','menu4'),
       ( 'ric7','menu1'),
       ( 'ric12','menu3'),
       ( 'ric1','menu8'),
       ( 'ric1','menu5');

INSERT INTO confezione
VALUES ( 'conf1','cl001','12','2015-09-01', 1,'buono',3,'completa','2016-01-01','2015-09-01','mgz1','ing01'),
       ( 'conf2','cl002','5','2015-09-01', 1,'rovinato',3,'completa','2016-01-01','2015-09-01','mgz2','ing01'),
       ( 'conf3','cl003','3','2015-09-01', 1,'ottimo',3,'completa','2016-01-01','2015-09-01','mgz2','ing02'),
       ( 'conf4','cl004','10','2015-09-01', 1,'ottimo',3,'parziale','2016-01-01','2015-09-01','mgz1','ing03'),
       ( 'conf5','cl005','22','2015-09-01', 1,'ottimo',3,'in uso','2016-01-01','2015-09-01','mgz1','ing04'),
       ( 'conf6','cl006','3,5','2012-02-21', 1,'ottimo',3,'in uso','2016-01-01','2012-02-23','mgz2','ing05'),
       ( 'conf7','cl007','2,1','2012-09-15', 1,'ottimo',3,'in uso','2016-01-01','2012-09-16','mgz3','ing05'),
       ( 'conf8','cl008','9','2013-06-22', 1,'ottimo',3,'in uso','2016-01-01','2013-09-21','mgz3','ing01'),
       ( 'conf9','cl009','6','2014-05-01', 1,'ottimo',3,'in uso','2016-01-01','2014-06-06','mgz3','ing02'),
       ( 'conf10','cl009','6','2013-05-01', 1,'ottimo',3,'in uso','2015-01-01','2014-06-06','mgz6','ing02');

INSERT INTO domanda
VALUES ( 'dom1','Il piatto è arrivato in condizioni:','qst1'),
       ( 'dom2','Il piatto è stato preparato in tempi:','qst1'),
       ( 'dom3','Il locale presentava condizioni igienico-sanitarie:','qst1'),
       ( 'dom4','Il tavolo prenotato risultava:','qst1'),
       ( 'dom5','Il menu è stato composto in maniera:','qst1'),
       ( 'dom6','Il personale è risultato:','qst1'),
       ( 'dom7','Il prezzo pagato le è sembrato:','qst1'),
       ( 'dom8','La qualità del cibo è risultata:','qst1'),
       ( 'dom9','Le dimensioni del tavolo, in rapporto ai presenti, sono state:','qst1'),
       ( 'dom10','La velocità dei tablet ai tavoli è stata: ','qst1');

INSERT INTO fasepreparazione
VALUES ( 'fase01','0 minuti','1 litro','aggiungere','macch02','ingr7', 'ric3' ),
       ( 'fase02','0 minuti','1 chilo','aggiungere','macch02','ingr3','ric3'),
       ( 'fase03','0 minuti','0.5 litri','aggiungere','macch02','ingr4','ric3'),
       ( 'fase04','5 minuti','0','impastare','macch02','','ric3'),
       ( 'fase05','30 minuti','0','cuocere','macch05','','ric3'),
       ( 'fase06','6 minuti','0','raffreddare','','','ric3'),
       ( 'fase07','1 minuto','300 grammi','aggiungere','ingr2','','ric3'),
       ( 'fase08','1 minuto','300 grammi','aggiungere','ingr5','','ric3'),
       ( 'fase09','0 minuti','0','impiattare','macch04','','ric3'),
       ( 'fase10','45 minuti','0','lavare','macch06','','ric3');

INSERT INTO formata
VALUES ( 'rec1','risp1'),
       ( 'rec1','risp2'),
       ( 'rec1','risp3'),
       ( 'rec1','risp4'),
       ( 'rec1','risp5'),
       ( 'rec1','risp6'),
       ( 'rec1','risp7'),
       ( 'rec1','risp8'),
       ( 'rec1','risp9'),
       ( 'rec1','risp10');

INSERT INTO funzione
VALUES ( 'funz01','Cuocere'),
       ( 'funz02','Impastare'),
       ( 'funz03','Cuocere'),
       ( 'funz04','Cuocere'),
       ( 'funz05','Riscaldare'),
       ( 'funz06','Lavare le stoviglie'),
       ( 'funz07','Preparare caffe'),
       ( 'funz08','Schiacciare le noci'),
       ( 'funz09','Spremere agrumi'),
       ( 'funz10','Cuocere');

INSERT INTO ingrediente
VALUES ( 'ingr1','Burro','Grassi e oli','Italia','Biologica','si'),
       ( 'ingr2','Marmellata di prugne','Frutta','Italia','Biologica','si'),
       ( 'ingr3','Farina','Cereali e derivati','Italia','Biologica','si'),
       ( 'ingr4','Lievito di birra','Lieviti','Italia','Biologica','si'),
       ( 'ingr5','Marmellata di albicocche','Frutta','Italia','Biologica','si'),
       ( 'ingr6','Olio','Grassi e oli','Italia','Biologica','si'),
       ( 'ingr7','Latte','Latte e derivati','Italia','Biologica','si'),
       ( 'ingr8','Acqua','Bevanda','Italia','Biologica','si'),
       ( 'ingr9','Limone','Frutta','Italia','Biologica','si'),
       ( 'ingr10','Ananas','Frutta','Italia','Biologica','si');

INSERT INTO macchinarioattrezzatura
VALUES ( 'macch01','Forno a legna','Macchinario','sede3'),
       ( 'macch02','Impastatrice','Macchinario','sede1'),
       ( 'macch03','Lavello','Attrezzatura','sede1'),
       ( 'macch04','Piatto per dessert','Attrezzatura','sede1'),
       ( 'macch05','Forno Elettrico','Macchinario','sede1'),
       ( 'macch06','Lavastoviglie','Macchinario','sede4'),
       ( 'macch07','Macchina del caffe','Macchinario','sede6'),
       ( 'macch08','Sac à poche','Attrezzatura','sede1'),
       ( 'macch09','Freezer','Attrezzatura','sede1'),
       ( 'macch10','Frigo','Attrezzatura','sede1');

INSERT INTO magazzino
VALUES ( 'magz1','Via Verdi 5','Genova','16100','0342929293','sede1'),
       ( 'magz2','Via Eco 44','Savona','17100','0201390123','sede1'),
       ( 'magz3','Via Pirandello 23','Genova','17100','0100100000','sede1'),
       ( 'magz4','Via Gramsci 12','Genova','17100','0782113121','sede1'),
       ( 'magz5','Via Fermi 1','Milano','17100','0673727271','sede2'),
       ( 'magz6','Via S.Mario 64','Bologna','17100','0000922102','sede4'),
       ( 'magz7','Via Leopardi 8','Bologna','17100','8888888888','sede4'),
       ( 'magz8','Via Da Vinci','Bologna','17100','9821738292','sede4'),
       ( 'magz9','Via Orwell','Londra','17100','1011984101','sede3'),
       ( 'magz10','Via Huxley','Londra','17100','1014891101','sede3');

INSERT INTO menu
VALUES ( 'menu1','2015-12-25','2016-01-15','sede1'),
       ( 'menu2','2015-12-25','2016-01-15','sede2'),
       ( 'menu3','2015-12-25','2016-01-15','sede3'),
       ( 'menu4','2015-12-25','2016-01-15','sede4'),
       ( 'menu5','2015-12-25','2016-01-15','sede5'),
       ( 'menu6','2015-12-25','2016-01-15','sede6'),
       ( 'menu7','2015-12-25','2016-01-15','sede7'),
       ( 'menu8','2015-12-25','2016-01-15','sede8'),
       ( 'menu9','2015-12-25','2016-01-15','sese9'),
       ( 'menu10','2015-12-25','2016-01-15','sede10');

INSERT INTO piattoordinato
VALUES ( 'piatto1','in preparazione','ric01',NULL,'comtk1'),
       ( 'piatto2','in preparazione','ric02','com5',NULL),
       ( 'piatto3','in preparazione','ric03','com4',NULL),
       ( 'piatto4','in preparazione','ric04','com3',NULL),
       ( 'piatto5','in preparazione','ric05','com1',NULL),
       ( 'piatto6','in preparazione','ric06','com5',NULL),
       ( 'piatto7','in preparazione','ric07','com5',NULL),
       ( 'piatto8','in preparazione','ric08',NULL,'comtk6'),
       ( 'piatto9','in preparazione','ric09',NULL,'comtk1'),
       ( 'piatto10','in preparazione','ric10',NULL,'comtk9');

INSERT INTO pony
VALUES ( 'pony1','Due Ruote','sede1'),
       ( 'pony2','Quattro Ruote','sede2'),
       ( 'pony3','Due Ruote','sede1'),
       ( 'pony4','Quattro Ruota','sede1'),
       ( 'pony5','Quattro Ruote','sede3'),
       ( 'pony6','Due Ruote','sede4'),
       ( 'pony7','Quattro Ruote','sede2'),
       ( 'pony8','Due Ruote','sede2'),
       ( 'pony9','Due Ruote','sede2'),
       ( 'pony10','Due Ruote','sede3');

INSERT INTO prenotazione
VALUES ( 'pren1',5,'2016-01-15','20:00','1234567890','','si','tav01','lll0'),
       ( 'pren2',10,'2016-01-15','20:00','1234567890','','si','tav001','iii9'),
       ( 'pren3',20,'2016-01-15','20:00','1234567890','','no','tav0001','bbb2'),
       ( 'pren4',2,'2016-01-15','20:00','1234567890','','si','tav02','ggg7'),
       ( 'pren5',3,'2016-01-15','20:00','1234567890','','si','tav002','eee5'),
       ( 'pren6',6,'2016-01-15','20:00','1234567890','','no','tav0002','fff6'),
       ( 'pren7',12,'2016-01-15','20:00','1234567890','','si','tav03','ddd4'),
       ( 'pren8',8,'2016-01-15','20:00','1234567890','','si','tav003','ccc3'),
       ( 'pren9',4,'2016-01-15','20:00','1234567890','','no','tav004','hhh8'),
       ( 'pren10',4,'2016-01-15','20:00','1234567890','','si','tav05','aaa1');

INSERT INTO questionario
VALUES ( 'quest1','Mario Rossi','2016-01-15','si','sede1','ric1'),
       ( 'quest2','Mario Rossi','2016-01-15','si','sede2','ric2'),
       ( 'quest3','Mario Rossi','2016-01-15','si','sed3','ric3'),
       ( 'quest4','Mario Rossi','2016-01-15','si','sede4','ric4'),
       ( 'quest5','Luca Verdi','2016-01-15','si','sede5','ric5'),
       ( 'quest6','Luca Verdi','2016-01-15','si','sede6','ric6'),
       ( 'quest7','Luca Verdi','2016-01-15','si','sede7','ric7'),
       ( 'quest8','Anna Gialli','2016-01-15','si','sede8','ric8'),
       ( 'quest9','Anna Gialli','2016-01-15','si','sede9','ric9'),
       ( 'quest10','Anna Gialli','2016-01-15','si','sede10','ric10');

INSERT INTO recensione
VALUES ( 'rece1','Ottimo servizio, consigliato!',100,'sede1','aaa1'),
       ( 'rece2','RistoranteA+++++++',100,'sede2','bbb2'),
       ( 'rece3','Ristoratore scorretto',30,'sed3','ccc3'),
       ( 'rece4','Prezzi esagerati',60,'sede4','ddd4'),
       ( 'rece5','Buono',75,'sede5','eee5'),
       ( 'rece6','Soddisfatto e rimborsato',100,'sede6','fff6'),
       ( 'rece7','Great food!',70,'sede7','ggg7'),
       ( 'rece8','Bello, ma difficile da raggiungere',85,'sede8','hhh8'),
       ( 'rece9','',100,'sede9','iii9'),
       ( 'rece10','Cortesia e qualità impagabili',100,'sede10','lll0');


INSERT INTO ricetta
VALUES ( 'ric1','Torta alle mele','','','10 euro'),
       ( 'ric2','Torta al cioccolato','','','10 euro'),
       ( 'ric3','Test fase preparazione','','','0 euro'),
       ( 'ric4','Pasta al sugo','','','7 euro'),
       ( 'ric5','Lasagne','','','25 euro'),
       ( 'ric6','Bistecca','','','50 euro'),
       ( 'ric7','Pasta al pesto','','','70 euro'),
       ( 'ric8','Patate arrosto','','','10 euro'),
       ( 'ric9','Pizza Margherita','','','5 euro'),
       ( 'ric10','Spiedini Flambè','','','200 euro');


INSERT INTO riguarda
VALUES ( 'var1','piatto4'),
       ( 'var2','piatto5'),
       ( 'var3','piatto3'),
       ( 'var4','piatto4'),
       ( 'var5','piatto2'),
       ( 'var6','piatto2'),
       ( 'var7','piatto2'),
       ( 'var8','piatto5'),
       ( 'var9','piatto1'),
       ( 'var10','piatto2');

INSERT INTO risposta
VALUES ( 'risp1',100,'dom4'),
       ( 'risp2',70,'dom5'),
       ( 'risp3',65,'dom3'),
       ( 'risp4',90,'dom4'),
       ( 'risp5',88,'dom2'),
       ( 'risp6',45,'dom2'),
       ( 'risp7',20,'dom2'),
       ( 'risp8',10,'dom5'),
       ( 'risp9',100,'dom1'),
       ( 'risp10',100,'dom2');

INSERT INTO sede
VALUES ( 'sede1','A','Via Verdi 5','Genova','16100','0342929293'),
       ( 'sede2','B','Via Eco 44','Savona','17100','0201390123'),
       ( 'sede3','C','Via Pirandello 23','Genova','16100','0100100000'),
       ( 'sede4','D','Via Gramsci 12','Genova','16100','0782113121'),
       ( 'sede5','E','Via Fermi 1','Milano','17100','0673727271'),
       ( 'sede6','F','Via S.Mario 64','Bologna','17100','0000922102'),
       ( 'sede7','G','Via Leopardi 8','Bologna','17100','8888888888'),
       ( 'sede8','H','Via Da Vinci','Bologna','17100','9821738298'),
       ( 'sede9','I','Via Orwell','Londra','17100','1011984101'),
       ( 'sede10','L','Via Huxley','Londra','17100','1014891101');

INSERT INTO seratatemaproposta
VALUES ( 'serata1','A','2015-12-25',20,'no','aaa1'),
       ( 'serata2','B','2014-12-25',25,'no','aaa1'),
       ( 'serata3','C','2013-12-25',50,'no','aaa1'),
       ( 'serata4','D','2012-12-25',133,'no','aaa1'),
       ( 'serata5','E','2011-12-25',15,'no','aaa1'),
       ( 'serata6','F','2010-12-25',24,'no','aaa1'),
       ( 'serata7','G','2009-12-25',8,'no','aaa1'),
       ( 'serata8','H','2008-12-25',60,'no','aaa1'),
       ( 'serata9','I','2007-12-25',111,'no','aaa1'),
       ( 'serata10','L','2006-12-25',220,'no','aaa1');


INSERT INTO svolge
VALUES ( 'funz1','macch4'),
       ( 'funz2','macch5'),
       ( 'funz3','macch3'),
       ( 'funz4','macch4'),
       ( 'funz5','macch2'),
       ( 'funz6','macch2'),
       ( 'funz7','macch2'),
       ( 'funz8','macch5'),
       ( 'funz9','macch1'),
       ( 'funz10','macch2');


INSERT INTO tavolo
VALUES ( 'tav1',4,'sala1','sede1'),
       ( 'tav2',5,'sala1','sede1'),
       ( 'tav3',7,'sala1','sede1'),
       ( 'tav4',2,'sala1','sede1'),
       ( 'tav5',4,'sala1','sede1'),
       ( 'tav6',4,'sala1','sede1'),
       ( 'tav7',4,'sala1','sede1'),
       ( 'tav8',4,'sala1','sede1'),
       ( 'tav9',4,'sala1','sede1'),
       ( 'tav10',4,'sala1','sede1');


INSERT INTO valutazione
VALUES ( 'valut1',80,'aaa1',NULL,'variantep1'),
       ( 'valut2',100,'bbb2','variante1',NULL),
       ( 'valut3',70,'ccc3',NULL,'variantep2'),
       ( 'valut4',20,'ddd4','variante2',NULL),
       ( 'valut5',40,'eee5','variante2',NULL),
       ( 'valut6',30,'fff6',NULL,'variantep3'),
       ( 'valut7',100,'ggg7','variante3',NULL),
       ( 'valut8',60,'hhh8','variante5',NULL),
       ( 'valut9',80,'iii9','variante5',NULL),
       ( 'valut10',80,'lll0',NULL,'variantep5');

INSERT INTO valutazionerecensione
VALUES ( 'valutR1','',80,80,'rece1','aaa1'),
       ( 'valutR2','',100,100,'rece1','bbb2'),
       ( 'valutR3','',70,70,'rece1','ccc3'),
       ( 'valutR4','',20,20,'rece1','ddd4'),
       ( 'valutR5','',40,40,'rece1','eee5'),
       ( 'valutR6','',30,30,'rece1','fff6'),
       ( 'valutR7','',100,100,'rece1','ggg7'),
       ( 'valutR8','',60,60,'rece1','hhh8'),
       ( 'valutR9','',80,80,'rece1','iii9'),
       ( 'valutR10','',80,80,'rece1','lll0');

INSERT INTO variante
VALUES ( 'var1','Variante1','','aaa1','ric1'),
       ( 'var2','Variante2','','aaa1','ric2'),
       ( 'var3','Variante3','','aaa1','ric3'),
       ( 'var4','Variante4','','aaa1','ric4'),
       ( 'var5','Variante5','','aaa1','ric5'),
       ( 'var6','Variante6','','aaa1','ric6'),
       ( 'var7','Variante7','','aaa1','ric7'),
       ( 'var8','Variante8','','aaa1','ric8'),
       ( 'var9','Variante9','','aaa1','ric9'),
       ( 'var10','Variante10','','aaa1','ric10');

INSERT INTO variantePiatto
VALUES ( 'varp1','Torta alle mele','','aaa1'),
       ( 'varp2','Torta al cioccolato','','aaa1'),
       ( 'varp3','Test fase preparazione','','aaa1'),
       ( 'varp4','Pasta al sugo','','aaa1'),
       ( 'varp5','Lasagne','','aaa1'),
       ( 'varp6','Bistecca','','aaa1'),
       ( 'varp7','Pasta al pesto','','aaa1'),
       ( 'varp8','Patate arrosto','','aaa1'),
       ( 'varp9','Pizza Margherita','','aaa1'),
       ( 'varp10','Spiedini Flambè','','aaa1');

INSERT INTO variazione
VALUES ( 'var1','Variazione1','Aggiunta olio aromatizzato ','aggiunta','0','0',NULL,'ric12','ingr50',NULL),
       ( 'var2','Variazione2','Al sangue','cottura','5 min','0',NULL,'ric12',NULL,'fase8'),
       ( 'var3','Variazione3','Ben cotta','cottura','10 min','0',NULL,'ric12',NULL,'fase8'),
       ( 'var4','Variazione4','Doppia Farcitura','aggiunta','0','5 euro',NULL,'ric15','ingr15',NULL),
       ( 'var5','Variazione5','Impasto a mano','preparazione','0','10 euro',NULL,'ric13',NULL,'fase5'),
       ( 'var6','Variazione6','Cottura in forno a legna','cottura','15 min','15 euro','macch10','ric20',NULL,'fase9'),
       ( 'var7','Variazione7','Aggiunta pomodorini','aggiunta','0','3 euro',NULL,'ric25','ingr43',NULL),
       ( 'var8','Variazione8','Aggiunta verdure ','aggiunta','0','7 euro',NULL,'ric25','ingr30',NULL),
       ( 'var9','Variazione9','Aggiunta patate lesse','aggiunta','0','5 euro',NULL,'ric32','ingr23',NULL),
       ( 'var10','Variazione10','Senza Formaggio','rimozione','0','-1.5 euro',NULL,'ric25','ingr20','fase10');




/* Massimo 3 variazioni */

DELIMITER $$

CREATE TRIGGER treVariazioni 
BEFORE INSERT ON Riguarda 
FOR EACH ROW
BEGIN

  DECLARE numeroVar INTEGER ;

  SELECT COUNT(*) into numeroVar 
  FROM   Riguarda R 
  WHERE  R.IdPiatto = NEW.IdPiatto ;
    
  IF ( @numeroVar =3 ) THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Si possono inserire al massimo 3 variazioni' ;
  END IF ;

END $$ 

DELIMITER ;



/* Stato comanda */

DELIMITER $$

CREATE TRIGGER statoComanda 
AFTER UPDATE ON PiattoOrdinato 
FOR EACH ROW
BEGIN

  DECLARE quanti INTEGER ;
  DECLARE totali INTEGER ;

  IF( NEW.IdComanda IS NOT NULL ) THEN
    BEGIN

    SELECT COUNT(*) into quanti
    FROM   PiattoOrdinato PO
    WHERE  PO.IdComanda = NEW.IdComanda
           AND PO.Stato = 'servizio' ;
    
    SELECT COUNT(*) into totali
    FROM   PiattoOrdinato PO
    WHERE  PO.IdComanda = NEW.IdComanda ;


    IF ( quanti = totali ) THEN
      UPDATE Comanda C
      SET    C.Stato = 'evasa'
      WHERE  C.IdComanda = NEW.IdComanda ;
    ELSEIF ( new.stato = 'in preparazione') THEN
      UPDATE Comanda C
      SET    C.Stato = 'parziale'
      WHERE  C.IdComanda = NEW.IdComanda ;
    END IF ;


    END ;
  ELSE
    
    BEGIN
       
      SELECT COUNT(*) into quanti
      FROM   PiattoOrdinato PO
      WHERE  PO.IdComandaTakeAway = NEW.IdComandaTakeAway
             AND PO.Stato = 'servizio' ;
      
      SELECT COUNT(*) into totali
      FROM   PiattoOrdinato PO
      WHERE  PO.IdComandaTakeAway = NEW.IdComandaTakeAway ;    
      
          
      IF ( NEW.Stato = 'in preparazione') THEN
        UPDATE Comanda C
        SET    C.Stato = 'parziale'
        WHERE  C.IdComandaTakeAway = NEW.IdComandaTakeAway ;
      ELSEIF quanti = totali THEN
        UPDATE Comanda C
        SET    C.Stato = 'evasa'
        WHERE  C.IdComandaTakeAway = NEW.IdComandaTakeAway ;
      END IF ;

    END ;

  END IF;
    
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER prenotazioniAnticipo 
BEFORE INSERT ON Prenotazione 
FOR EACH ROW 
BEGIN

  IF( TIMESTAMPDIFF( HOUR, NEW.Data, CURRENT_TIMESTAMP ) < 48 ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ci sono meno di 48 ore tra ora e il momento della prenotazione' ;    
  END IF ;

END $$

DELIMITER ;



