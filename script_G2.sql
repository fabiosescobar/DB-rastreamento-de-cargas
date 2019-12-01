CREATE DATABASE G2CARGAS;
USE G2CARGAS;
CREATE TABLE CLIENTE (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	razao_social VARCHAR(45) NOT NULL,
	cnpj CHAR (18) NOT NULL,
	email VARCHAR(45),
	telefone CHAR(11) NOT NULL,
	endereco VARCHAR(45)
	);
CREATE TABLE CONTRATO (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	data_inicial DATE NOT NULL,
	data_final DATE NOT NULL,
	valor DOUBLE(10,2),
	cod_cliente INT NOT NULL,
	FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(codigo)
	);
CREATE TABLE CARGA (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	nro_cte VARCHAR(45),
	cod_contrato INT,
	FOREIGN KEY (cod_contrato) REFERENCES CONTRATO(codigo)
	);
CREATE TABLE MOTORISTA (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	nro_cnh CHAR(11) NOT NULL,
	categoria CHAR(2) NOT NULL,
	data_nascimento DATE NOT NULL
	);
CREATE TABLE EVENTO (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	data_hora DATETIME NOT NULL,
	tipo ENUM('Previsto','Imprevisto'),
	descricao TEXT(255)
	);
CREATE TABLE VEICULO (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	placa CHAR(8) NOT NULL,
	chassi CHAR(17) NOT NULL,
	km_revisao INT,
	capacidade INT,
	consumo_medio DOUBLE(3,1)
	);
CREATE TABLE REVISAO(
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	data DATE NOT NULL,
	descricao TEXT(255),
	km INT
	cod_veiculo INT,
	FOREIGN KEY (cod_veiculo) REFERENCES VEICULO(codigo)
	);
CREATE TABLE CIDADE(
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	uf CHAR(2) NOT NULL
	);
CREATE TABLE ROTA(
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	distancia INT NOT NULL,
	duracao TIME NOT NULL,
	cidade_origem INT,
	cidade_destino INT,
	FOREIGN KEY (cidade_origem) REFERENCES CIDADE(codigo),
	FOREIGN KEY (cidade_destino) REFERENCES CIDADE(codigo)
	);
CREATE TABLE MOTORISTA_CARGA (
	cod_motorista INT,
	cod_carga INT,
	FOREIGN KEY (cod_motorista) REFERENCES MOTORISTA(codigo),
	FOREIGN KEY (cod_carga) REFERENCES CARGA(codigo)
	);
CREATE TABLE EVENTO_CARGA (
	cod_evento INT,
	cod_carga INT,
	FOREIGN KEY (cod_evento) REFERENCES EVENTO(codigo),
	FOREIGN KEY (cod_carga) REFERENCES CARGA(codigo)
	);
CREATE TABLE VEICULO_CARGA (
	cod_veiculo INT,
	cod_carga INT,
	FOREIGN KEY (cod_veiculo) REFERENCES VEICULO(codigo),
	FOREIGN KEY (cod_carga) REFERENCES CARGA(codigo)
	);
CREATE TABLE ROTA_CARGA (
	cod_rota INT,
	cod_carga INT,
	FOREIGN KEY (cod_rota) REFERENCES ROTA(codigo),
	FOREIGN KEY (cod_carga) REFERENCES CARGA(codigo)
	);

INSERT INTO TABLE CLIENTE (razao_social, cnpj, email, telefone, endereco) VALUES
	('Arroz Parbo LTDA','01564223000225','arroz@parbo.com.br','5134718744', 'BR-116, km 380, Camaquã/RS'),
	('Cerâmica Brilhante LTDA' , '21050248000114', 'ceram.brilhante@gmail.com', '48988120155' 'BR-101, km 390, Criciúma/SC'),
	('Autopeças Start do Brasil SA' , '03654112000105' , 'autopecas.brasil@start.com' , '1125254000' 'Rodovia Ayrton Senna, 2500, São Paulo/SP' ),
	('Kabrinq LTDA' , '68445201000322' , 'kabrink@uol.com', '8532611566', 'Av. do Progresso, 1240, Fortaleza/CE' ),
	('Cosmeticos Rio SA' , '02477601000194', 'rio@cosmeticos.com.br', 'Av. Solar, 2570, Rio de Janeiro/RJ')
	);


