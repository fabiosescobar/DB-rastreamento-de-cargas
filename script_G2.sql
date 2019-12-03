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
	km INT,
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

INSERT INTO CLIENTE (razao_social, cnpj, email, telefone, endereco) VALUES 
	('Arroz Parbo LTDA','01564223000225','arroz@parbo.com.br','5134718744', 'BR-116, km 380, Camaquã/RS'),
	('Cerâmica Brilhante LTDA' , '21050248000114', 'ceram.brilhante@gmail.com', '48988120155' ,'BR-101, km 390, Criciúma/SC'),
	('Ágata Transps e Logística SA' , '03654112000105' , 'agata.transplog@gmail.com' , '1125254000' ,'Rodovia Ayrton Senna, 2500, São Paulo/SP' ),
	('A Jato Transportes Ltda' , '68445201000322' , 'ajato@uol.com', '8134631566', 'Av. do Progresso, 1240, Recife/PE' ),
	('Transportadora É Pra Ontem Ltda' , '02477601000194', 'epraontem@trasportadora.com.br', '2134391025' , 'Av. Solar, 2570, Rio de Janeiro/RJ')
	;

INSERT INTO CONTRATO (data_inicial, data_final, valor, cod_cliente) VALUES
	('2012-02-01','2014-01-31','120.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '01564223000225')),
	('2017-04-01','2019-03-31','180.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '01564223000225')),
	('2017-06-30','2019-05-31','200.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '21050248000114')),
	('2018-01-01','2020-12-31','350.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '68445201000322')),
	('2018-02-01','2020-01-31','300.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '03654112000105')),
	('2018-04-01','2020-03-31','300.00', (SELECT codigo FROM CLIENTE WHERE cnpj = '02477601000194'))
	;

INSERT INTO CARGA (nro_cte, cod_contrato) VALUES
	('7802', (SELECT codigo FROM CONTRATO WHERE (cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Arroz Parbo LTDA') AND data_final<'2016-12-31'))),
	('44583', (SELECT codigo FROM CONTRATO WHERE (cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Arroz Parbo LTDA') AND data_inicial>'2016-12-31'))),
	('44622', (SELECT codigo FROM CONTRATO WHERE (cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Arroz Parbo LTDA') AND data_inicial>'2016-12-31'))),
	('2561', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))),
	('2566', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))),
	('2571', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))),
	('30050', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))),
	('30085', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))),
	('30111', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))),
	('9744', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))),
	('9782', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))),
	('9799', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))),
	('12246', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))),
	('12281', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))),
	('12305', (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda')))
	;

INSERT INTO MOTORISTA (nome, nro_cnh, categoria, data_nascimento) VALUES 
	('Juremir Quaresma', '00254558140', 'E', '1962-06-20'),
	('Sandoval Brandão', '01502334208', 'D', '1965-11-05'),
	('Adamastor Botelho', '00278118404', 'E', '1961-02-13'),
	('Santiago Aleluia Mendez', '02587003450', 'E', '1974-08-29'),
	('Eurípedes Trancoso', '00486057224', 'D', '1971-05-22'),
	('Roberval Ferreira Filho', '02468871031', 'E', '1976-01-18'),
	('Santino Carparelli', '00350117212', 'D', '1965-10-27'),
	('Jacques dos Santos Alves', '02995610045', 'E', '1982-03-11'),
	('Florentino de Almeida Sampaio', '03052246092', 'E', '1980-07-22'),
	('Juvêncio Fontana Barbosa', '00144284394', 'E', '1967-08-12'),
	('José Carlos Torrentini', '03041807211', 'D', '1985-01-03'),
	('William Scherer Camargo', '00351224370', 'E', '1989-06-26')
	;

INSERT INTO EVENTO (data_hora, tipo, descricao) VALUES
	('2013-05-02 08:15:00','Previsto','Início do percurso'),
	('2013-05-02 12:30:00','Previsto','Repouso'),
	('2013-05-02 16:30:00','Previsto','Abastecimento'),
	('2013-05-02 20:30:00','Previsto','Repouso'),
	('2013-05-03 10:30:00','Previsto','Entrega da mercadoria'),
	('2018-01-18 08:15:00','Previsto','Início do percurso'),
	('2018-01-18 11:50:00','Imprevisto','Estouro do pneu'),
	('2018-01-18 17:20:00','Previsto','Abastecimento'),
	('2018-01-19 22:15:00','Previsto','Repouso'),
	('2018-01-19 11:15:00','Previsto','Entrega da mercadoria'),
	('2018-02-22 08:15:00','Previsto','Início do percurso'),
	('2018-02-22 11:45:00','Previsto','Repouso'),
	('2018-02-22 15:35:00','Previsto','Entrega da mercadoria'),
	('2018-03-10 18:30:00','Previsto','Início do percurso'),
	('2018-03-10 22:45:00','Previsto','Repouso'),
	('2018-03-11 03:10:00','Imprevisto','Roubo da mercadoria'),
	('2018-03-25 09:20:00','Previsto','Início do percurso'),
	('2018-03-25 12:30:00','Previsto','Repouso'),
	('2018-03-25 15:45:00','Imprevisto','Recusa da mercadoria'),
	('2018-04-02 08:40:00','Previsto','Início do percurso'),
	('2018-04-02 12:15:00','Previsto','Repouso'),
	('2018-04-02 17:25:00','Previsto','Abastecimento'),
	('2018-04-02 21:30:00','Previsto','Repouso'),
	('2018-04-03 09:15:00','Previsto','Entrega da mercadoria'),
	('2018-04-18 08:15:00','Previsto','Início do percurso'),
	('2018-04-18 11:50:00','Imprevisto','Pane mecânica'),
	('2018-04-18 17:20:00','Previsto','Abastecimento'),
	('2018-04-19 22:15:00','Previsto','Repouso'),
	('2018-04-19 10:15:00','Previsto','Entrega da mercadoria'),
	('2018-04-22 08:15:00','Previsto','Início do percurso'),
	('2018-04-22 11:50:00','Imprevisto','Acidente sem gravidade'),
	('2018-04-22 17:20:00','Previsto','Abastecimento'),
	('2018-04-22 22:15:00','Previsto','Repouso'),
	('2018-04-22 10:45:00','Previsto','Entrega da mercadoria'),
	('2018-04-25 08:40:00','Previsto','Início do percurso'),
	('2018-04-25 12:15:00','Previsto','Repouso'),
	('2018-04-25 17:25:00','Previsto','Abastecimento'),
	('2018-04-25 21:30:00','Previsto','Repouso'),
	('2018-04-26 11:00:00','Previsto','Entrega da mercadoria'),
	('2018-05-08 13:40:00','Previsto','Início do percurso'),
	('2018-05-08 17:20:00','Previsto','Entrega da mercadoria'),
	('2018-05-12 08:40:00','Previsto','Início do percurso'),
	('2018-05-12 12:15:00','Previsto','Repouso'),
	('2018-05-12 16:30:00','Previsto','Abastecimento'),
	('2018-05-12 18:30:00','Imprevisto','Engarrafamento'),
	('2018-05-12 23:00:00','Previsto','Repouso'),
	('2018-05-13 09:00:00','Previsto','Entrega da mercadoria'),
	('2018-05-27 08:30:00','Previsto','Início do percurso'),
	('2018-05-27 11:45:00','Previsto','Repouso'),
	('2018-05-27 15:10:00','Previsto','Entrega da mercadoria'),
	('2019-02-22 18:40:00','Previsto','Início do percurso'),
	('2019-02-22 22:30:00','Previsto','Repouso'),
	('2019-02-23 11:15:00','Previsto','Entrega da mercadoria'),
	('2019-07-08 08:30:00','Previsto','Início do percurso'),
	('2019-07-08 12:00:00','Previsto','Repouso'),
	('2019-07-08 16:15:00','Previsto','Abastecimento'),
	('2019-07-08 21:30:00','Previsto','Repouso'),
	('2019-07-09 08:40:00','Previsto','Entrega da mercadoria')
	('2019-07-15 09:15:00','Previsto','Início do percurso'),
	('2019-07-15 12:30:00','Previsto','Repouso'),
	('2019-07-15 17:10:00','Previsto','Entrega da mercadoria')
	;

	
INSERT INTO VEICULO (placa, chassi, km_revisao, capacidade, consumo_medio) VALUES
	('IJT1588','4DB88762773849905','10000','33','30.5'),
	('ILM2132','5DT11548866687595','15000','11','18.0'),
	('FMU8711','2DW25887990548547','15000','5','10.5'),
	('FKK9012','8DF84552339587741','10000','25','24.5'),
	('TPL4471','5DC27748569960521','10000','33','31.0'),
	('TSF6336','7DM60325584211044','15000','5','11.0'),
	('BHH1254','4DJ66320114528801','10000','33','32.0'),
	('BNV8874','3DA64585523001458','10000','25','25.0'),
	('GTT1006','1DK15558745201547','15000','11','19.5'),
	('GVB8863','3DP04552133985511','10000','33','32.0')
	;

INSERT INTO REVISAO (data, descricao, km, cod_veiculo) VALUES
	('2012-10-10','Troca das pastilhas de freio','65040',(SELECT codigo FROM VEICULO WHERE placa='IJT1588')),
	('2017-09-15','Substituição dos pneus','90120',(SELECT codigo FROM VEICULO WHERE placa='FMU8711')),
	('2017-11-19','Troca dos filtros de ar e óleo','30215',(SELECT codigo FROM VEICULO WHERE placa='TSF6336')),
	('2018-05-20','Reparos na carroceria','56850',(SELECT codigo FROM VEICULO WHERE placa='BHH1254')),
	('2018-10-05','Alinhamento da direção e balanceamento','70105',(SELECT codigo FROM VEICULO WHERE placa='GVB8863'))
	;

INSERT INTO CIDADE (nome, uf) VALUES
	('Camaquã','RS'),
	('Porto Alegre','RS'),
	('Canoas','RS'),
	('Criciúma','SC'),
	('Florianópolis','SC'),
	('São Paulo','SP'),
	('Rio de Janeiro','RJ'),
	('Belo Horizonte','MG'),
	('Recife','PE'),
	('Salvador','BA'),
	('Fortaleza','CE')
	;

INSERT INTO ROTA (distancia, duracao, cidade_origem, cidade_destino) VALUES 
	('1270','16:00:00',(SELECT codigo FROM CIDADE WHERE (nome='Camaquã' AND uf='RS')), (SELECT codigo FROM CIDADE WHERE (nome='São Paulo' AND uf='SP'))),
	('1700','21:00:00',(SELECT codigo FROM CIDADE WHERE (nome='Camaquã' AND uf='RS')), (SELECT codigo FROM CIDADE WHERE (nome='Rio de Janeiro' AND uf='RJ'))),
	('285','03:30:00',(SELECT codigo FROM CIDADE WHERE (nome='Criciúma' AND uf='SC')), (SELECT codigo FROM CIDADE WHERE (nome='Porto Alegre' AND uf='RS'))),
	('210','02:30:00',(SELECT codigo FROM CIDADE WHERE (nome='Criciúma' AND uf='SC')), (SELECT codigo FROM CIDADE WHERE (nome='Florianópolis' AND uf='SC'))),
	('1135','13:40:00',(SELECT codigo FROM CIDADE WHERE (nome='São Paulo' AND uf='SP')), (SELECT codigo FROM CIDADE WHERE (nome='Porto Alegre' AND uf='RS'))),
	('700','09:00:00',(SELECT codigo FROM CIDADE WHERE (nome='São Paulo' AND uf='SP')), (SELECT codigo FROM CIDADE WHERE (nome='Florianópolis' AND uf='SC'))),
	('440','05:30:00',(SELECT codigo FROM CIDADE WHERE (nome='São Paulo' AND uf='SP')), (SELECT codigo FROM CIDADE WHERE (nome='Rio de Janeiro' AND uf='RJ'))),
	('440','06:20:00',(SELECT codigo FROM CIDADE WHERE (nome='Rio de Janeiro' AND uf='RJ')), (SELECT codigo FROM CIDADE WHERE (nome='Belo Horizonte' AND uf='MG'))),
	('1135','13:50:00',(SELECT codigo FROM CIDADE WHERE (nome='Rio de Janeiro' AND uf='RJ')), (SELECT codigo FROM CIDADE WHERE (nome='Florianópolis' AND uf='SC'))),
	('433','05:20:00',(SELECT codigo FROM CIDADE WHERE (nome='Rio de Janeiro' AND uf='RJ')), (SELECT codigo FROM CIDADE WHERE (nome='São Paulo' AND uf='SP'))),
	('810','11:50:00',(SELECT codigo FROM CIDADE WHERE (nome='Recife' AND uf='PE')), (SELECT codigo FROM CIDADE WHERE (nome='Salvador' AND uf='BA'))),
	('800','10:45:00',(SELECT codigo FROM CIDADE WHERE (nome='Recife' AND uf='PE')), (SELECT codigo FROM CIDADE WHERE (nome='Fortaleza' AND uf='CE')))
	;
	
INSERT INTO MOTORISTA_CARGA (cod_motorista,cod_carga) VALUES
	((SELECT codigo FROM MOTORISTA WHERE (nome='Juremir Quaresma' AND nro_cnh='00254558140')), (SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Sandoval Brandão' AND nro_cnh= '01502334208')), (SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_inicial>'2016-12-31')))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Juremir Quaresma' AND nro_cnh= '00254558140')), (SELECT codigo FROM CARGA WHERE (nro_cte='44622' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA'AND data_inicial>'2016-12-31')))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Adamastor Botelho' AND nro_cnh= '00278118404')), (SELECT codigo FROM CARGA WHERE (nro_cte='2561' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Santiago Aleluia Mendez' AND nro_cnh ='02587003450')), (SELECT codigo FROM CARGA WHERE (nro_cte='2566' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Adamastor Botelho' AND nro_cnh= '00278118404')), (SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Eurípedes Trancoso' AND nro_cnh= '00486057224')), (SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Roberval Ferreira Filho' AND nro_cnh= '02468871031')), (SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Santino Carparelli' AND nro_cnh= '00350117212')), (SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Jacques dos Santos Alves' AND nro_cnh= '02995610045')), (SELECT codigo FROM CARGA WHERE (nro_cte='9744' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Florentino de Almeida Sampaio'AND nro_cnh= '03052246092')), (SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Jacques dos Santos Alves' AND nro_cnh= '02995610045')), (SELECT codigo FROM CARGA WHERE (nro_cte='9799' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='Juvêncio Fontana Barbosa' AND nro_cnh= '00144284394')), (SELECT codigo FROM CARGA WHERE (nro_cte='12246' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='José Carlos Torrentini' AND nro_cnh= '03041807211')), (SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	((SELECT codigo FROM MOTORISTA WHERE (nome='William Scherer Camargo' AND nro_cnh= '00351224370')), (SELECT codigo FROM CARGA WHERE (nro_cte='12305' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda')))))
	;
	INSERT INTO EVENTO_CARGA (cod_evento,cod_carga) VALUES
	('1',(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	('2',(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	('3',(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	('4',(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	('5',(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
	('6',(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('7',(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('8',(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('9',(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('10',(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('11',(SELECT codigo FROM CARGA WHERE (nro_cte='44622' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('12',(SELECT codigo FROM CARGA WHERE (nro_cte='44622' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('13',(SELECT codigo FROM CARGA WHERE (nro_cte='44622' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
	('14',(SELECT codigo FROM CARGA WHERE (nro_cte='2561' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('15',(SELECT codigo FROM CARGA WHERE (nro_cte='2561' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('16',(SELECT codigo FROM CARGA WHERE (nro_cte='2561' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('17',(SELECT codigo FROM CARGA WHERE (nro_cte='2566' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('18',(SELECT codigo FROM CARGA WHERE (nro_cte='2566' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('19',(SELECT codigo FROM CARGA WHERE (nro_cte='2566' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('20',(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('21',(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('22',(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('23',(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('24',(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
	('25',(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('26',(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('27',(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('28',(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('29',(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('30',(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('31',(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('32',(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('33',(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('34',(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('35',(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('36',(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('37',(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('38',(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('39',(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
	('40',(SELECT codigo FROM CARGA WHERE (nro_cte='9744' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('41',(SELECT codigo FROM CARGA WHERE (nro_cte='9744' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('42',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('43',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('44',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('45',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('46',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('47',(SELECT codigo FROM CARGA WHERE (nro_cte='9782' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('48',(SELECT codigo FROM CARGA WHERE (nro_cte='9799' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('49',(SELECT codigo FROM CARGA WHERE (nro_cte='9799' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('50',(SELECT codigo FROM CARGA WHERE (nro_cte='9799' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
	('51',(SELECT codigo FROM CARGA WHERE (nro_cte='12246' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('52',(SELECT codigo FROM CARGA WHERE (nro_cte='12246' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('53',(SELECT codigo FROM CARGA WHERE (nro_cte='12246' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('54',(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('55',(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('56',(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('57',(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('58',(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('59',(SELECT codigo FROM CARGA WHERE (nro_cte='12305' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('60',(SELECT codigo FROM CARGA WHERE (nro_cte='12305' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
	('61',(SELECT codigo FROM CARGA WHERE (nro_cte='12305' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda')))))
	;

	INSERT INTO VEICULO_CARGA (cod_veiculo, cod_carga) VALUES
		((SELECT codigo FROM VEICULO WHERE placa='IJT1588'),(SELECT codigo FROM CARGA WHERE (nro_cte='7802' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final<'2016-12-31')))))),
		((SELECT codigo FROM VEICULO WHERE placa='IJT1588'),(SELECT codigo FROM CARGA WHERE (nro_cte='44583' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
		((SELECT codigo FROM VEICULO WHERE placa='ILM2132'),(SELECT codigo FROM CARGA WHERE (nro_cte='44622' AND cod_contrato = (SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE (razao_social='Arroz Parbo LTDA' AND data_final>'2016-12-31')))))),
		((SELECT codigo FROM VEICULO WHERE placa='FMU8711'),(SELECT codigo FROM CARGA WHERE (nro_cte='2561' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='FKK9012'),(SELECT codigo FROM CARGA WHERE (nro_cte='2566' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='FMU8711'),(SELECT codigo FROM CARGA WHERE (nro_cte='2571' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Cerâmica Brilhante LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='TPL4471'),(SELECT codigo FROM CARGA WHERE (nro_cte='30050' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='TSF6336'),(SELECT codigo FROM CARGA WHERE (nro_cte='30085' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='TPL4471'),(SELECT codigo FROM CARGA WHERE (nro_cte='30111' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Ágata Transps e Logística SA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='BHH1254'),(SELECT codigo FROM CARGA WHERE (nro_cte='9744' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='BNV8874'),(SELECT codigo FROM CARGA WHERE (nro_cte='9782'AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='BHH1254'),(SELECT codigo FROM CARGA WHERE (nro_cte='9799' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='A Jato Transportes LTDA'))))),
		((SELECT codigo FROM VEICULO WHERE placa='GTT1006'),(SELECT codigo FROM CARGA WHERE (nro_cte='12246' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
		((SELECT codigo FROM VEICULO WHERE placa='GVB8863'),(SELECT codigo FROM CARGA WHERE (nro_cte='12281' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda'))))),
		((SELECT codigo FROM VEICULO WHERE placa='GTT1006'),(SELECT codigo FROM CARGA WHERE (nro_cte='12305' AND cod_contrato=(SELECT codigo FROM CONTRATO WHERE cod_cliente = (SELECT codigo FROM CLIENTE WHERE razao_social='Transportadora É Pra Ontem Ltda')))))
		;

	
