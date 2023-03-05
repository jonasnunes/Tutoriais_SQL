-- criar a tabela projeto
CREATE TABLE projeto(
	codigo VARCHAR(20) PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL,
	descricao BLOB NOT NULL
);

-- inserir registros na tabela projeto
INSERT INTO projeto (codigo, tipo, descricao)
VALUES
('PRODATA', 'Análise de Dados', 'Desenvolvimento de Ambiente para Análise'),
('PROMED', 'Análise Clínica', 'Atendimento comunitário e vacinação');

-- criar a tabela categoria
CREATE TABLE categoria(
	categoria VARCHAR(10) PRIMARY KEY,
	salario INT NOT NULL
);

-- inserir registros na tabela categoria
INSERT INTO categoria (categoria, salario)
VALUES
('Adjunto', 6000),
('Titular', 16000);

-- criar a tabela docente
CREATE TABLE docente(
	codigo VARCHAR(20) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	categoria VARCHAR(10) NOT NULL,
	fk_categoria VARCHAR(10) NOT NULL
);

-- alterar a tabela docente inserindo uma chave estrangeira
ALTER TABLE docente ADD CONSTRAINT fk_categoria
FOREIGN KEY (fk_categoria)
REFERENCES categoria (categoria)
ON DELETE RESTRICT;

-- inserir registros na tabela docente
INSERT INTO docente (codigo, nome, categoria, fk_categoria)
VALUES
('DOC001', 'José', 'Adjunto', 'Adjunto'),
('DOC002', 'Luciano', 'Titular', 'Titular'),
('DOC003', 'Gilson', 'Adjunto', 'Adjunto'),
('DOC004', 'Marta', 'Titular', 'Titular'),
('DOC010', 'Maria', 'Adjunto', 'Adjunto');


-- criar a tabela projeto_docente
CREATE TABLE projeto_docente(
	fk_projeto_codigo VARCHAR(20),
	fk_docente_codigo VARCHAR(20),
	data_inicio DATE NOT NULL,
	tempo_meses VARCHAR(50) NOT NULL
);

-- alterar a tabela projeto_docente inserindo uma chave estrangeira
ALTER TABLE projeto_docente ADD CONSTRAINT fk_projeto_codigo
FOREIGN KEY (fk_projeto_codigo)
REFERENCES projeto (codigo)
ON DELETE RESTRICT;

ALTER TABLE projeto_docente ADD CONSTRAINT fk_docente_codigo
FOREIGN KEY (fk_docente_codigo)
REFERENCES docente (codigo)
ON DELETE RESTRICT;

-- inserindo registros na tabela projeto_docente
INSERT INTO projeto_docente (fk_projeto_codigo, fk_docente_codigo, data_inicio, tempo_meses)
VALUES
('PRODATA', 'DOC001', '2019-02-01', 16),
('PRODATA', 'DOC002', '2020-02-01', 4),
('PRODATA', 'DOC003', '2019-02-01', 16),
('PRODATA', 'DOC004', '2020-02-01', 4),
('PROMED', 'DOC001', '2019-02-01', 16),
('PROMED', 'DOC010', '2020-02-01', 0),
('PROMED', 'DOC004', '2020-02-01', 1);

-- consulta realizando INNER JOIN em 3 tabelas
SELECT 
projeto.codigo AS codigo_projeto, projeto.tipo AS tipo_projeto,
docente.nome AS nome, docente.categoria AS categoria,
projeto_docente.data_inicio AS data_inicio, projeto_docente.tempo_meses AS meses
FROM projeto
INNER JOIN projeto_docente
ON projeto.codigo = projeto_docente.fk_projeto_codigo
INNER JOIN docente 
ON docente.codigo = projeto_docente.fk_docente_codigo;