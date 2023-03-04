-- criando um banco de dados
CREATE DATABASE hora_de_codar;

-- excluindo um banco de dados;
DROP DATABASE hora_de_codar;

-- selecionando o banco de dados que vai ser utilizado
USE hora_de_codar;

-- criando uma tabela
CREATE TABLE minha_tabela(
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE pessoas(
	nome VARCHAR(100),
	salario INT,
	data_nascimento DATE
);

-- excluindo uma tabela
DROP TABLE minha_tabela;
DROP TABLE pessoas;

-- alterando uma tabela
ALTER TABLE pessoas
ADD COLUMN profissao VARCHAR(255);

-- descrevendo uma tabela
DESC pessoas;

-- selecionado todos os campos da tabela pessoas
SELECT * FROM pessoas;
SELECT * FROM enderecos;

-- selecionando dados específicos de uma tabela
SELECT nome FROM pessoas;

-- consultas usando a cláusula WHERE
SELECT * FROM pessoas
WHERE salario > 5000;

SELECT * FROM pessoas
WHERE profissao = 'Programador';

-- inserindo dados em uma tabela
INSERT INTO pessoas (nome, salario, data_nascimento, profissao)
VALUES
('João', 3000, '1985-02-23', 'Programador');

INSERT INTO pessoas (nome, salario, data_nascimento, profissao)
VALUES
('Maria', 5500, '1990-11-03', 'Engenheira Civil'),
('Marcos', 2800, '1975-10-09', 'Construtor Civil'),
('João', 3500, '1990-01-31', 'Médico');

INSERT INTO enderecos (rua, numero, pessoa_id)
VALUES
('Rua Antônio Alves', '20', 1),
('Rua Maurício Aguiar', '1', 2),
('Rua Cláudio Quintanilha', '45', 3),
('Avenida Pedro Francisco Sanchez', '305b', 4);

-- atualizando registros da tabela
UPDATE pessoas
SET salario = 3000
WHERE nome = 'Marcos';

-- excluindo um registro da tabela
DELETE FROM pessoas
WHERE nome = 'Marcos';

-- recriando a tabela pessoas adicionando uma chave primária
CREATE TABLE pessoas(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nome VARCHAR(100),
	salario INT,
	data_nascimento DATE,
	profissao VARCHAR(255)
);

-- criando uma tabela adicionando uma chave estrangeira
CREATE TABLE enderecos(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	rua VARCHAR(255),
	numero VARCHAR(10),
	pessoa_id INT NOT NULL,
	FOREIGN KEY (pessoa_id) REFERENCES pessoas (id)
);

-- associando tabelas usando INNER JOIN
SELECT
pessoas.nome, pessoas.profissao, pessoas.salario,
CONCAT(enderecos.rua,' - ',enderecos.numero) AS endereço
FROM pessoas
INNER JOIN enderecos 
ON pessoas.id = enderecos.pessoa_id;

-- funções de agregação
SELECT SUM(salario) FROM pessoas;
SELECT AVG(salario) FROM pessoas;
SELECT MIN(salario) FROM pessoas;
SELECT MAX(salario) FROM pessoas;
SELECT COUNT(*) FROM pessoas;

-- GROUP BY
SELECT profissao, COUNT(*) AS Total
FROM pessoas 
GROUP BY profissao;

-- ORDER BY
SELECT * FROM pessoas 
ORDER BY salario;