-- -----------------------------------------------------
-- Trans-Madeira DB - Igor Nunes
-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS transmadeira DEFAULT CHARACTER SET utf8 ;
USE transmadeira ;

-- -----------------------------------------------------
-- Table Rota
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Rota (
  idRota INT UNSIGNED NOT NULL ,
  dataCadastro DATE NOT NULL,
  PRIMARY KEY (idRota))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Estado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Estado (
  UF VARCHAR(2) NOT NULL,
  bandeira TEXT(300) NULL,
  nome TEXT NOT NULL,
  PRIMARY KEY (UF))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Municipio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Municipio (
  nome TEXT NOT NULL,
  bandeira TEXT(300) NULL,
  Estado_UF INT NOT NULL,
  PRIMARY KEY (nome),
  INDEX fk_Municipio_Estado1_idx (Estado_UF ),
  CONSTRAINT fk_Municipio_Estado1
    FOREIGN KEY (Estado_UF)
    REFERENCES Estado (UF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ROTA_POSSUI_ESTADO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ROTA_POSSUI_ESTADO (
  Estado_UF VARCHAR(2) NOT NULL,
  Rota_idRota INT NOT NULL,
  PRIMARY KEY (Estado_UF, Rota_idRota),
  INDEX fk_Estado_has_Rota_Rota1_idx (Rota_idRota ),
  INDEX fk_Estado_has_Rota_Estado_idx (Estado_UF ),
  CONSTRAINT fk_Estado_has_Rota_Estado
    FOREIGN KEY (Estado_UF)
    REFERENCES Estado (UF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Estado_has_Rota_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Pessoa_Fisica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pessoa_Fisica (
  CPF TEXT(11) NOT NULL,
  nome TEXT NOT NULL,
  dataNascimento DATE NOT NULL,
  dataCadastro DATE NOT NULL,
  sexo CHAR(1) NOT NULL,
  email TEXT NOT NULL,
  rg TEXT(10) NOT NULL,
  cidade TEXT NOT NULL,
  bairro TEXT NOT NULL,
  complemento TEXT NULL,
  numero INT NULL,
  rua TEXT NOT NULL,
  CEP VARCHAR(8) NOT NULL,
  UF VARCHAR(2) NOT NULL,
  pais TEXT NOT NULL,
  ultimoAcesso DATE NULL,
  senha TEXT(256) NULL,
  ultimoIPAcesso TEXT(15) NULL,
  login TEXT(30) NULL,
  PRIMARY KEY (CPF),
  UNIQUE INDEX email_UNIQUE (email ),
  UNIQUE INDEX rg_UNIQUE (rg ))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Telefone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Telefone (
  telefone TEXT(9) NOT NULL,
  Pessoa_Fisica_CPF TEXT(11) NOT NULL,
  PRIMARY KEY (telefone, Pessoa_Fisica_CPF),
  INDEX fk_Telefone_Pessoa_Fisica1_idx (Pessoa_Fisica_CPF ),
  CONSTRAINT fk_Telefone_Pessoa_Fisica1
    FOREIGN KEY (Pessoa_Fisica_CPF)
    REFERENCES Pessoa_Fisica (CPF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Empreendimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Empreendimento (
  CNPJ TEXT(15) NOT NULL,
  nomeFantasia TEXT NOT NULL,
  razaoSocial TEXT NOT NULL,
  PRIMARY KEY (CNPJ),
  UNIQUE INDEX razaoSocial_UNIQUE (razaoSocial ))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table CADASTRA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CADASTRA (
  Pessoa_Fisica_CPF TEXT(11) NOT NULL,
  Empreendimento_CNPJ TEXT(15) NOT NULL,
  PRIMARY KEY (Pessoa_Fisica_CPF, Empreendimento_CNPJ),
  INDEX fk_Pessoa_Fisica_has_Empreendimento_Empreendimento1_idx (Empreendimento_CNPJ ),
  INDEX fk_Pessoa_Fisica_has_Empreendimento_Pessoa_Fisica1_idx (Pessoa_Fisica_CPF ),
  CONSTRAINT fk_Pessoa_Fisica_has_Empreendimento_Pessoa_Fisica1
    FOREIGN KEY (Pessoa_Fisica_CPF)
    REFERENCES Pessoa_Fisica (CPF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pessoa_Fisica_has_Empreendimento_Empreendimento1
    FOREIGN KEY (Empreendimento_CNPJ)
    REFERENCES Empreendimento (CNPJ)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Veiculo_Rodoviario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo_Rodoviario (
  placa VARCHAR(7) NOT NULL,
  renavam VARCHAR(11) NOT NULL,
  qtdEixo INT NOT NULL,
  combustivel TEXT NOT NULL,
  marca TEXT NOT NULL,
  modelo TEXT NOT NULL,
  capacidade FLOAT NOT NULL,
  dataCadastro DATE NOT NULL,
  dataFabricacao YEAR NOT NULL,
  largura FLOAT NOT NULL,
  comprimento FLOAT NOT NULL,
  altura FLOAT NOT NULL,
  PRIMARY KEY (placa),
  UNIQUE INDEX renavam_UNIQUE (renavam ))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Veiculo_Fluvial
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo_Fluvial (
  IMO VARCHAR(10) NOT NULL,
  PES FLOAT NOT NULL,
  tipoEmbarcacao TEXT NOT NULL,
  combustivel TEXT NOT NULL,
  marca TEXT NOT NULL,
  modelo TEXT NOT NULL,
  capacidade FLOAT NOT NULL,
  dataCadastro DATE NOT NULL,
  dataFabricacao YEAR NOT NULL,
  largura FLOAT NOT NULL,
  comprimento FLOAT NOT NULL,
  altura FLOAT NOT NULL,
  PRIMARY KEY (IMO))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Veiculo_Maritimo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo_Maritimo (
  IMO VARCHAR(10) NOT NULL,
  PES FLOAT NOT NULL,
  tipoEmbarcacao TEXT NOT NULL,
  combustivel TEXT NOT NULL,
  marca TEXT NOT NULL,
  modelo TEXT NOT NULL,
  capacidade FLOAT NOT NULL,
  dataCadastro DATE NOT NULL,
  dataFabricacao YEAR NOT NULL,
  largura FLOAT NOT NULL,
  comprimento FLOAT NOT NULL,
  altura FLOAT NOT NULL,
  pais TEXT NOT NULL,
  PRIMARY KEY (IMO))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Veiculo_Ferroviario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo_Ferroviario (
  numero INT NOT NULL,
  qtdVagoes INT NOT NULL,
  Linha TEXT NOT NULL,
  combustivel TEXT NOT NULL,
  marca TEXT NOT NULL,
  modelo TEXT NOT NULL,
  capacidade FLOAT NOT NULL,
  dataCadastro DATE NOT NULL,
  dataFabricacao YEAR NOT NULL,
  largura FLOAT NOT NULL,
  comprimento FLOAT NOT NULL,
  altura FLOAT NOT NULL,
  PRIMARY KEY (numero))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_FERROVIARIO_POSSUI_ROTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_FERROVIARIO_POSSUI_ROTA (
  Veiculo_Ferroviario_numero INT NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (Veiculo_Ferroviario_numero, Rota_idRota),
  INDEX fk_Veiculo_Ferroviario_has_Rota_Rota1_idx (Rota_idRota ),
  INDEX fk_Veiculo_Ferroviario_has_Rota_Veiculo_Ferroviario1_idx (Veiculo_Ferroviario_numero ),
  CONSTRAINT fk_Veiculo_Ferroviario_has_Rota_Veiculo_Ferroviario1
    FOREIGN KEY (Veiculo_Ferroviario_numero)
    REFERENCES Veiculo_Ferroviario (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Ferroviario_has_Rota_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_FLUVIAL_POSSUI_ROTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_FLUVIAL_POSSUI_ROTA (
  Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (Veiculo_Fluvial_IMO, Rota_idRota),
  INDEX fk_Veiculo_Fluvial_has_Rota_Rota1_idx (Rota_idRota ),
  INDEX fk_Veiculo_Fluvial_has_Rota_Veiculo_Fluvial1_idx (Veiculo_Fluvial_IMO ),
  CONSTRAINT fk_Veiculo_Fluvial_has_Rota_Veiculo_Fluvial1
    FOREIGN KEY (Veiculo_Fluvial_IMO)
    REFERENCES Veiculo_Fluvial (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Fluvial_has_Rota_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_MARITIMO_POSSUI_ROTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_MARITIMO_POSSUI_ROTA (
  Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (Veiculo_Maritimo_IMO, Rota_idRota),
  INDEX fk_Veiculo_Maritimo_has_Rota_Rota1_idx (Rota_idRota ),
  INDEX fk_Veiculo_Maritimo_has_Rota_Veiculo_Maritimo1_idx (Veiculo_Maritimo_IMO ),
  CONSTRAINT fk_Veiculo_Maritimo_has_Rota_Veiculo_Maritimo1
    FOREIGN KEY (Veiculo_Maritimo_IMO)
    REFERENCES Veiculo_Maritimo (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Maritimo_has_Rota_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_RODOVIARIO_POSSUI_ROTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_RODOVIARIO_POSSUI_ROTA (
  Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (Veiculo_Rodoviario_placa, Rota_idRota),
  INDEX fk_Veiculo_Rodoviario_has_Rota_Rota1_idx (Rota_idRota ),
  INDEX fk_Veiculo_Rodoviario_has_Rota_Veiculo_Rodoviario1_idx (Veiculo_Rodoviario_placa ),
  CONSTRAINT fk_Veiculo_Rodoviario_has_Rota_Veiculo_Rodoviario1
    FOREIGN KEY (Veiculo_Rodoviario_placa)
    REFERENCES Veiculo_Rodoviario (placa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Rodoviario_has_Rota_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Guia_Transporte_Florestal_1
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Guia_Transporte_Florestal_1 (
  idGTF INT NOT NULL ,
  dataCadastro DATE NOT NULL,
  horaCadastro TIME NOT NULL,
  Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Veiculo_Ferroviario_numero INT NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (idGTF, Veiculo_Rodoviario_placa, Veiculo_Maritimo_IMO, Veiculo_Fluvial_IMO, Veiculo_Ferroviario_numero, Rota_idRota),
  INDEX fk_Guia_Transporte_Florestal_1_Veiculo_Rodoviario1_idx (Veiculo_Rodoviario_placa ),
  INDEX fk_Guia_Transporte_Florestal_1_Veiculo_Maritimo1_idx (Veiculo_Maritimo_IMO ),
  INDEX fk_Guia_Transporte_Florestal_1_Veiculo_Fluvial1_idx (Veiculo_Fluvial_IMO ),
  INDEX fk_Guia_Transporte_Florestal_1_Veiculo_Ferroviario1_idx (Veiculo_Ferroviario_numero ),
  INDEX fk_Guia_Transporte_Florestal_1_Rota1_idx (Rota_idRota ),
  CONSTRAINT fk_Guia_Transporte_Florestal_1_Veiculo_Rodoviario1
    FOREIGN KEY (Veiculo_Rodoviario_placa)
    REFERENCES Veiculo_Rodoviario (placa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_1_Veiculo_Maritimo1
    FOREIGN KEY (Veiculo_Maritimo_IMO)
    REFERENCES Veiculo_Maritimo (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_1_Veiculo_Fluvial1
    FOREIGN KEY (Veiculo_Fluvial_IMO)
    REFERENCES Veiculo_Fluvial (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_1_Veiculo_Ferroviario1
    FOREIGN KEY (Veiculo_Ferroviario_numero)
    REFERENCES Veiculo_Ferroviario (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_1_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Guia_Transporte_Florestal_2
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Guia_Transporte_Florestal_2 (
  idGTF INT NOT NULL ,
  dataCadastro DATE NOT NULL,
  horaCadastro TIME NOT NULL,
  Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Veiculo_Ferroviario_numero INT NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (idGTF, Veiculo_Rodoviario_placa, Veiculo_Maritimo_IMO, Veiculo_Fluvial_IMO, Veiculo_Ferroviario_numero, Rota_idRota),
  INDEX fk_Guia_Transporte_Florestal_2_Veiculo_Rodoviario1_idx (Veiculo_Rodoviario_placa ),
  INDEX fk_Guia_Transporte_Florestal_2_Veiculo_Maritimo1_idx (Veiculo_Maritimo_IMO ),
  INDEX fk_Guia_Transporte_Florestal_2_Veiculo_Fluvial1_idx (Veiculo_Fluvial_IMO ),
  INDEX fk_Guia_Transporte_Florestal_2_Veiculo_Ferroviario1_idx (Veiculo_Ferroviario_numero ),
  INDEX fk_Guia_Transporte_Florestal_2_Rota1_idx (Rota_idRota ),
  CONSTRAINT fk_Guia_Transporte_Florestal_2_Veiculo_Rodoviario1
    FOREIGN KEY (Veiculo_Rodoviario_placa)
    REFERENCES Veiculo_Rodoviario (placa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_2_Veiculo_Maritimo1
    FOREIGN KEY (Veiculo_Maritimo_IMO)
    REFERENCES Veiculo_Maritimo (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_2_Veiculo_Fluvial1
    FOREIGN KEY (Veiculo_Fluvial_IMO)
    REFERENCES Veiculo_Fluvial (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_2_Veiculo_Ferroviario1
    FOREIGN KEY (Veiculo_Ferroviario_numero)
    REFERENCES Veiculo_Ferroviario (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_2_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Madeira
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Madeira (
  nomeCientifico TEXT NOT NULL,
  nomePopular TEXT NOT NULL,
  cor TEXT NOT NULL,
  extincao TINYINT(1) NOT NULL,
  Guia_Transporte_Florestal_1_idGTF INT NOT NULL,
  Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero INT NOT NULL,
  Guia_Transporte_Florestal_1_Rota_idRota INT UNSIGNED NOT NULL,
  Guia_Transporte_Florestal_2_idGTF INT NOT NULL,
  Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero INT NOT NULL,
  Guia_Transporte_Florestal_2_Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (nomeCientifico, Guia_Transporte_Florestal_1_idGTF, Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa, Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO, Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO, Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero, Guia_Transporte_Florestal_1_Rota_idRota, Guia_Transporte_Florestal_2_idGTF, Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa, Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO, Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO, Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero, Guia_Transporte_Florestal_2_Rota_idRota),
  UNIQUE INDEX nomePopular_UNIQUE (nomePopular ),
  INDEX fk_Madeira_Guia_Transporte_Florestal_11_idx (Guia_Transporte_Florestal_1_idGTF , Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_1_Rota_idRota ),
  INDEX fk_Madeira_Guia_Transporte_Florestal_21_idx (Guia_Transporte_Florestal_2_idGTF , Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_2_Rota_idRota ),
  CONSTRAINT fk_Madeira_Guia_Transporte_Florestal_11
    FOREIGN KEY (Guia_Transporte_Florestal_1_idGTF , Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_1_Rota_idRota)
    REFERENCES Guia_Transporte_Florestal_1 (idGTF , Veiculo_Rodoviario_placa , Veiculo_Maritimo_IMO , Veiculo_Fluvial_IMO , Veiculo_Ferroviario_numero , Rota_idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Madeira_Guia_Transporte_Florestal_21
    FOREIGN KEY (Guia_Transporte_Florestal_2_idGTF , Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_2_Rota_idRota)
    REFERENCES Guia_Transporte_Florestal_2 (idGTF , Veiculo_Rodoviario_placa , Veiculo_Maritimo_IMO , Veiculo_Fluvial_IMO , Veiculo_Ferroviario_numero , Rota_idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_FERROVIARIO_TRANSPORTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_FERROVIARIO_TRANSPORTA (
  Veiculo_Ferroviario_numero INT NOT NULL,
  Madeira_nomeCientifico TEXT NOT NULL,
  PRIMARY KEY (Veiculo_Ferroviario_numero, Madeira_nomeCientifico),
  INDEX fk_Veiculo_Ferroviario_has_Madeira_Madeira1_idx (Madeira_nomeCientifico ),
  INDEX fk_Veiculo_Ferroviario_has_Madeira_Veiculo_Ferroviario1_idx (Veiculo_Ferroviario_numero ),
  CONSTRAINT fk_Veiculo_Ferroviario_has_Madeira_Veiculo_Ferroviario1
    FOREIGN KEY (Veiculo_Ferroviario_numero)
    REFERENCES Veiculo_Ferroviario (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Ferroviario_has_Madeira_Madeira1
    FOREIGN KEY (Madeira_nomeCientifico)
    REFERENCES Madeira (nomeCientifico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_FLUVIAL_TRANSPORTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_FLUVIAL_TRANSPORTA (
  Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Madeira_nomeCientifico TEXT NOT NULL,
  PRIMARY KEY (Veiculo_Fluvial_IMO, Madeira_nomeCientifico),
  INDEX fk_Veiculo_Fluvial_has_Madeira_Madeira1_idx (Madeira_nomeCientifico ),
  INDEX fk_Veiculo_Fluvial_has_Madeira_Veiculo_Fluvial1_idx (Veiculo_Fluvial_IMO ),
  CONSTRAINT fk_Veiculo_Fluvial_has_Madeira_Veiculo_Fluvial1
    FOREIGN KEY (Veiculo_Fluvial_IMO)
    REFERENCES Veiculo_Fluvial (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Fluvial_has_Madeira_Madeira1
    FOREIGN KEY (Madeira_nomeCientifico)
    REFERENCES Madeira (nomeCientifico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_MARITIMO_TRANSPORTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_MARITIMO_TRANSPORTA (
  Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Madeira_nomeCientifico TEXT NOT NULL,
  PRIMARY KEY (Veiculo_Maritimo_IMO, Madeira_nomeCientifico),
  INDEX fk_Veiculo_Maritimo_has_Madeira_Madeira1_idx (Madeira_nomeCientifico ),
  INDEX fk_Veiculo_Maritimo_has_Madeira_Veiculo_Maritimo1_idx (Veiculo_Maritimo_IMO ),
  CONSTRAINT fk_Veiculo_Maritimo_has_Madeira_Veiculo_Maritimo1
    FOREIGN KEY (Veiculo_Maritimo_IMO)
    REFERENCES Veiculo_Maritimo (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Maritimo_has_Madeira_Madeira1
    FOREIGN KEY (Madeira_nomeCientifico)
    REFERENCES Madeira (nomeCientifico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table VEICULO_RODOVIARIO_TRANSPORTA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VEICULO_RODOVIARIO_TRANSPORTA (
  Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Madeira_nomeCientifico TEXT NOT NULL,
  PRIMARY KEY (Veiculo_Rodoviario_placa, Madeira_nomeCientifico),
  INDEX fk_Veiculo_Rodoviario_has_Madeira_Madeira1_idx (Madeira_nomeCientifico ),
  INDEX fk_Veiculo_Rodoviario_has_Madeira_Veiculo_Rodoviario1_idx (Veiculo_Rodoviario_placa ),
  CONSTRAINT fk_Veiculo_Rodoviario_has_Madeira_Veiculo_Rodoviario1
    FOREIGN KEY (Veiculo_Rodoviario_placa)
    REFERENCES Veiculo_Rodoviario (placa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Veiculo_Rodoviario_has_Madeira_Madeira1
    FOREIGN KEY (Madeira_nomeCientifico)
    REFERENCES Madeira (nomeCientifico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Guia_Transporte_Florestal_3
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Guia_Transporte_Florestal_3 (
  idGTF INT NOT NULL ,
  dataCadastro DATE NOT NULL,
  horaCadastro TIME NOT NULL,
  Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Veiculo_Ferroviario_numero INT NOT NULL,
  Rota_idRota INT UNSIGNED NOT NULL,
  Madeira_nomeCientifico TEXT NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_idGTF INT NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero INT NOT NULL,
  Madeira_Guia_Transporte_Florestal_1_Rota_idRota INT UNSIGNED NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_idGTF INT NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa VARCHAR(7) NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO VARCHAR(10) NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO VARCHAR(10) NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero INT NOT NULL,
  Madeira_Guia_Transporte_Florestal_2_Rota_idRota INT UNSIGNED NOT NULL,
  PRIMARY KEY (idGTF, Veiculo_Rodoviario_placa, Veiculo_Maritimo_IMO, Veiculo_Fluvial_IMO, Veiculo_Ferroviario_numero, Rota_idRota, Madeira_nomeCientifico, Madeira_Guia_Transporte_Florestal_1_idGTF, Madeira_Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa, Madeira_Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO, Madeira_Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO, Madeira_Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero, Madeira_Guia_Transporte_Florestal_1_Rota_idRota, Madeira_Guia_Transporte_Florestal_2_idGTF, Madeira_Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa, Madeira_Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO, Madeira_Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO, Madeira_Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero, Madeira_Guia_Transporte_Florestal_2_Rota_idRota),
  INDEX fk_Guia_Transporte_Florestal_3_Veiculo_Rodoviario1_idx (Veiculo_Rodoviario_placa ),
  INDEX fk_Guia_Transporte_Florestal_3_Veiculo_Maritimo1_idx (Veiculo_Maritimo_IMO ),
  INDEX fk_Guia_Transporte_Florestal_3_Veiculo_Fluvial1_idx (Veiculo_Fluvial_IMO ),
  INDEX fk_Guia_Transporte_Florestal_3_Veiculo_Ferroviario1_idx (Veiculo_Ferroviario_numero ),
  INDEX fk_Guia_Transporte_Florestal_3_Rota1_idx (Rota_idRota ),
  INDEX fk_Guia_Transporte_Florestal_3_Madeira1_idx (Madeira_nomeCientifico , Madeira_Guia_Transporte_Florestal_1_idGTF , Madeira_Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa , Madeira_Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO , Madeira_Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO , Madeira_Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero , Madeira_Guia_Transporte_Florestal_1_Rota_idRota , Madeira_Guia_Transporte_Florestal_2_idGTF , Madeira_Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa , Madeira_Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO , Madeira_Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO , Madeira_Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero , Madeira_Guia_Transporte_Florestal_2_Rota_idRota ),
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Veiculo_Rodoviario1
    FOREIGN KEY (Veiculo_Rodoviario_placa)
    REFERENCES Veiculo_Rodoviario (placa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Veiculo_Maritimo1
    FOREIGN KEY (Veiculo_Maritimo_IMO)
    REFERENCES Veiculo_Maritimo (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Veiculo_Fluvial1
    FOREIGN KEY (Veiculo_Fluvial_IMO)
    REFERENCES Veiculo_Fluvial (IMO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Veiculo_Ferroviario1
    FOREIGN KEY (Veiculo_Ferroviario_numero)
    REFERENCES Veiculo_Ferroviario (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Rota1
    FOREIGN KEY (Rota_idRota)
    REFERENCES Rota (idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Guia_Transporte_Florestal_3_Madeira1
    FOREIGN KEY (Madeira_nomeCientifico , Madeira_Guia_Transporte_Florestal_1_idGTF , Madeira_Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa , Madeira_Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO , Madeira_Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO , Madeira_Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero , Madeira_Guia_Transporte_Florestal_1_Rota_idRota , Madeira_Guia_Transporte_Florestal_2_idGTF , Madeira_Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa , Madeira_Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO , Madeira_Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO , Madeira_Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero , Madeira_Guia_Transporte_Florestal_2_Rota_idRota)
    REFERENCES Madeira (nomeCientifico , Guia_Transporte_Florestal_1_idGTF , Guia_Transporte_Florestal_1_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_1_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_1_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_1_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_1_Rota_idRota , Guia_Transporte_Florestal_2_idGTF , Guia_Transporte_Florestal_2_Veiculo_Rodoviario_placa , Guia_Transporte_Florestal_2_Veiculo_Maritimo_IMO , Guia_Transporte_Florestal_2_Veiculo_Fluvial_IMO , Guia_Transporte_Florestal_2_Veiculo_Ferroviario_numero , Guia_Transporte_Florestal_2_Rota_idRota)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Guia_Arrecadacao_Estadual
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Guia_Arrecadacao_Estadual (
  numeroDAE INT NOT NULL,
  dataCadastro DATE NOT NULL,
  horaCadastro TIME NOT NULL,
  valor FLOAT NOT NULL,
  Guia_Transporte_Florestal_3_idGTF INT NOT NULL,
  PRIMARY KEY (numeroDAE),
  INDEX fk_Guia_Arrecadacao_Estadual_Guia_Transporte_Florestal_31_idx (Guia_Transporte_Florestal_3_idGTF ),
  CONSTRAINT fk_Guia_Arrecadacao_Estadual_Guia_Transporte_Florestal_31
    FOREIGN KEY (Guia_Transporte_Florestal_3_idGTF)
    REFERENCES Guia_Transporte_Florestal_3 (idGTF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATING USER

CREATE USER 'trans-madeira'@'localhost' IDENTIFIED BY 'senhadeteste';

-- CREATING SELECT PRIVILEGES

GRANT SELECT ON  transmadeira.Rota TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Pessoa_Fisica TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Telefone TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Estado TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Municipio TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Empreendimento TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Veiculo_Fluvial TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Veiculo_Ferroviario TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Veiculo_Maritimo TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Veiculo_Rodoviario TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Madeira TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Guia_Transporte_Florestal_1 TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Guia_Transporte_Florestal_2 TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Guia_Transporte_Florestal_3 TO 'trans-madeira'@'localhost';
GRANT SELECT ON  transmadeira.Guia_Arrecadacao_Estadual TO 'trans-madeira'@'localhost';

-- CREATING INSERT PRIVILEGES

GRANT INSERT ON  transmadeira.Rota TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Pessoa_Fisica TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Telefone TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Estado TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Municipio TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Empreendimento TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Veiculo_Fluvial TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Veiculo_Ferroviario TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Veiculo_Maritimo TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Veiculo_Rodoviario TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Madeira TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Guia_Transporte_Florestal_1 TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Guia_Transporte_Florestal_2 TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Guia_Transporte_Florestal_3 TO 'trans-madeira'@'localhost';
GRANT INSERT ON  transmadeira.Guia_Arrecadacao_Estadual TO 'trans-madeira'@'localhost';

-- CREATING DELETE PRIVILEGES

GRANT DELETE ON  transmadeira.Rota TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Pessoa_Fisica TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Telefone TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Estado TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Municipio TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Empreendimento TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Veiculo_Fluvial TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Veiculo_Ferroviario TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Veiculo_Maritimo TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Veiculo_Rodoviario TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Madeira TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Guia_Transporte_Florestal_1 TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Guia_Transporte_Florestal_2 TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Guia_Transporte_Florestal_3 TO 'trans-madeira'@'localhost';
GRANT DELETE ON  transmadeira.Guia_Arrecadacao_Estadual TO 'trans-madeira'@'localhost';

-- CREATING UPDATE PRIVILEGES

GRANT UPDATE ON  transmadeira.Rota TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Pessoa_Fisica TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Telefone TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Estado TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Municipio TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Empreendimento TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Veiculo_Fluvial TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Veiculo_Ferroviario TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Veiculo_Maritimo TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Veiculo_Rodoviario TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Madeira TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Guia_Transporte_Florestal_1 TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Guia_Transporte_Florestal_2 TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Guia_Transporte_Florestal_3 TO 'trans-madeira'@'localhost';
GRANT UPDATE ON  transmadeira.Guia_Arrecadacao_Estadual TO 'trans-madeira'@'localhost';

FLUSH PRIVILEGES;

-- INSERT UF

INSERT INTO transmadeira.Estado (UF,bandeira,nome) VALUES("SP",NULL,"Sao Paulo");
INSERT INTO transmadeira.Estado (UF,bandeira,nome) VALUES("MG",NULL,"Minas Gerais");
INSERT INTO transmadeira.Estado (UF,bandeira,nome) VALUES("SC",NULL,"Santa Catarina");
INSERT INTO transmadeira.Estado (UF,bandeira,nome) VALUES("BA",NULL,"Bahia");

-- INSERT MUNICIPIO

INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Ribeirão Preto",NULL,"SP");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Itapira",NULL,"SP");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Cruzeiro",NULL,"SP");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Campinas",NULL,"SP");

INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Crucilandia",NULL,"MG");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Caragua",NULL,"MG");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Belo Horizonte",NULL,"MG");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Lavras",NULL,"MG");

INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Florianopolis",NULL,"SC");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Joinville",NULL,"SC");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Blumenau",NULL,"SC");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Criciuma",NULL,"SC");

INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Salvador",NULL,"BA");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Porto Seguro",NULL,"BA");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Ilheus",NULL,"BA");
INSERT INTO transmadeira.Municipio (nome,bandeira,Estado_UF) VALUES("Vitoria da Conquista",NULL,"BA");

-- INSERT ROTA 

INSERT INTO transmadeira.Rota (idRota,dataCadastro) VALUES(19,"2018-05-08");
INSERT INTO transmadeira.Rota (idRota,dataCadastro) VALUES(32,"2017-03-12");
INSERT INTO transmadeira.Rota (idRota,dataCadastro) VALUES(11,"2001-08-09");
INSERT INTO transmadeira.Rota (idRota,dataCadastro) VALUES(40,"2007-11-10");
INSERT INTO transmadeira.Rota (idRota,dataCadastro) VALUES(8,"2005-12-01");


-- INSERT ROTA_POSSUI_ESTADO

INSERT INTO transmadeira.ROTA_POSSUI_ESTADO (Estado_UF,Rota_idRota) VALUES (32,"MG");
INSERT INTO transmadeira.ROTA_POSSUI_ESTADO (Estado_UF,Rota_idRota) VALUES (11,"SP");
INSERT INTO transmadeira.ROTA_POSSUI_ESTADO (Estado_UF,Rota_idRota) VALUES (8,"SC");
INSERT INTO transmadeira.ROTA_POSSUI_ESTADO (Estado_UF,Rota_idRota) VALUES (19,"BA");
INSERT INTO transmadeira.ROTA_POSSUI_ESTADO (Estado_UF,Rota_idRota) VALUES (40,"MG");

-- INSERT PESSOA_FISICA

INSERT INTO transmadeira.Pessoa_Fisica (CPF,nome,dataNascimento,dataCadastro,sexo,email,rg,cidade,bairro,
            complemento,numero,rua,CEP,UF,pais,ultimoAcesso,senha,ultimoIPAcesso,login) VALUES ("11111111111","Lucas",
            "1996-04-01","2007-10-03",'M',"lucas@company.com.br","MG11122233","Lavras","Centenario",NULL,NULL,"Rua Azevedo",
            "12345678","MG","Brasil","2018-05-10","teste","192.168.100.100");

INSERT INTO transmadeira.Pessoa_Fisica (CPF,nome,dataNascimento,dataCadastro,sexo,email,rg,cidade,bairro,
            complemento,numero,rua,CEP,UF,pais,ultimoAcesso,senha,ultimoIPAcesso,login) VALUES ("22222222222","Bruno",
            "1972-05-23","2010-11-02",'M',"bruno@company.com.br","MG11122234","Rio de Janeiro","Leblon","apt 222","220","Rua Morais",
            "12345671","RJ","Brasil",NULL,NULL,NULL);

INSERT INTO transmadeira.Pessoa_Fisica (CPF,nome,dataNascimento,dataCadastro,sexo,email,rg,cidade,bairro,
            complemento,numero,rua,CEP,UF,pais,ultimoAcesso,senha,ultimoIPAcesso,login) VALUES ("33333333333","Jose",
            "1983-01-11","2015-2-6",'M',"jose@company.com.br","MG11122235","Divinopolis","Bela Vista",NULL,NULL,"Rua Menicucci",
            "12345672","MG","Brasil",NULL,NULL,NULL);

INSERT INTO transmadeira.Pessoa_Fisica (CPF,nome,dataNascimento,dataCadastro,sexo,email,rg,cidade,bairro,
            complemento,numero,rua,CEP,UF,pais,ultimoAcesso,senha,ultimoIPAcesso,login) VALUES ("44444444444","Laura",
            "1995-08-25","2017-08-05",'F',"laura@company.com.br","MG11122236","Belo Horizonte","Prado","apt 1030","1438","Rua Olivia",
            "12345673","MG","Brasil",NULL,NULL,NULL);

-- INSERT TELEFONE

INSERT INTO transmadeira.Telefone (telefone,Pessoa_Fisica_CPF) VALUES ("1111-1111","11111111111");
INSERT INTO transmadeira.Telefone (telefone,Pessoa_Fisica_CPF) VALUES ("2222-2222","22222222222");
INSERT INTO transmadeira.Telefone (telefone,Pessoa_Fisica_CPF) VALUES ("3333-3333","33333333333");
INSERT INTO transmadeira.Telefone (telefone,Pessoa_Fisica_CPF) VALUES ("4444-4444","44444444444");

-- INSERT EMPREENDIMENTO
 
INSERT INTO transmadeira.Empreendimento (CNPJ,nomeFantasia,razaoSocial) VALUES ("111111111111111","Serv Lev","Serve Ja");
INSERT INTO transmadeira.Empreendimento (CNPJ,nomeFantasia,razaoSocial) VALUES ("222222222222222","Auto Vias","GOQ");
INSERT INTO transmadeira.Empreendimento (CNPJ,nomeFantasia,razaoSocial) VALUES ("333333333333333","Subway Lavras","Pazinee & Felicori");

-- INSERT CADASTRA

INSERT INTO transmadeira.CADASTRA (Pessoa_Fisica_CPF,Empreendimento_CNPJ) VALUES ("44444444444","333333333333333");
INSERT INTO transmadeira.CADASTRA (Pessoa_Fisica_CPF,Empreendimento_CNPJ) VALUES ("22222222222","111111111111111");
INSERT INTO transmadeira.CADASTRA (Pessoa_Fisica_CPF,Empreendimento_CNPJ) VALUES ("33333333333","222222222222222");

-- INSERT VEICULO_FLUVIAL

INSERT INTO transmadeira.Veiculo_Fluvial (IMO,PES,tipoEmbarcacao,combustivel,marca,modelo,dataCadastro,
                                          dataFabricacao,largura,comprimento,altura) VALUES ("1010101010",19.0,"Balsa","Diesel",
                                          "Vard Pro Mar", "Modelo","1996-02-13","1987-08-13",5.0,25.0,3.0);

-- INSERT VEICULO_MARITMO

INSERT INTO transmadeira.Veiculo_Maritimo (IMO,PES,tipoEmbarcacao,combustivel,marca,modelo,dataCadastro,
                                          dataFabricacao,largura,comprimento,altura,pais) VALUES ("2020202020",40.0,"Navio","Diesel",
                                          "Kyodo Senpaku Kaisha", "Nisshin Maru","2018-06-07","1987-04-01",20.0,129.58,30.0,"Japao");

-- INSERT VEICULO_FERROVIARIO

INSERT INTO transmadeira.Veiculo_Ferroviario (numero,qtdVagoes,combustivel,marca,modelo,capacidade,dataCadastro,dataFabricacao,largura,
                                              comprimento, altura) VALUES (420,25,"Carvao","Expresso Mogiana","2018-05-10","1942-12-25",
                                                                           1.5,10.0,2.0);

-- INSERT VEICULO_RODOVIARIO

INSERT INTO transmadeira.Veiculo_Rodoviario (placa,renavam,qtdEixo,marca,modelo,capacidade,dataCadastro,dataFabricacao,largura,
                                              comprimento, altura) VALUES ("CPI8216","11111111111",9,"Peter Bilt","389-2018","2018-03-9","2018-01-01",
                                                                           2.0,6.0,2.10);
-- INSERT VEICULO_FERROVIARIO_POSSUI_ROTA

INSERT INTO transmadeira.VEICULO_FERROVIARIO_POSSUI_ROTA (Veiculo_Ferroviario_numero,Rota_idRota) VALUES (420,32);

-- INSERT VEICULO_MARITIMO_POSSUI_ROTA

INSERT INTO transmadeira.VEICULO_MARITIMO_POSSUI_ROTA (Veiculo_Maritimo_IMO,Rota_idRota) VALUES ("2020202020",11);

-- INSERT VEICULO_RODOVIARIO_POSSUI_ROTA

INSERT INTO transmadeira.VEICULO_RODOVIARIO_POSSUI_ROTA (Veiculo_Rodoviario_placa,Rota_idRota) VALUES ("CPI8216",19);

-- INSERT GUIA_TRANSPORTE_FLORESTAL_1

INSERT INTO transmadeira.Guia_Transporte_Florestal_1 (idGTF,dataCadastro,horaCadastro,Veiculo_Rodoviario_placa,Veiculo_Maritimo_IMO,
                                                      Veiculo_Fluvial_IMO,Veiculo_Ferroviario_numero,Rota_idRota) VALUES (
                                                      1,"2018-02-18","13:52","CPI8216","2020202020","1010101010",420,19);

-- INSERT GUIA_TRANSPORTE_FLORESTAL_2

INSERT INTO transmadeira.Guia_Transporte_Florestal_2 (idGTF,dataCadastro,horaCadastro,Veiculo_Rodoviario_placa,Veiculo_Maritimo_IMO,
                                                      Veiculo_Fluvial_IMO,Veiculo_Ferroviario_numero,Rota_idRota) VALUES (
                                                      1,"2018-02-18","13:52","CPI8216","2020202020","1010101010",420,32);

