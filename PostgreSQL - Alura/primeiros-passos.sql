-- selecionando o banco de dados pelo terminal
psql -U postgres alura -W

-- criando uma tabela
CREATE TABLE ALUNO(
	ID SERIAL,
	NOME VARCHAR(255),
	CPF CHAR(11),
	OBSERVACAO TEXT,
	DATA_NASCIMENTO DATE,
	MEDIA_NOTAS REAL,
	ATIVO BOOLEAN,
	MATRICULADO_EM TIMESTAMP
);

SELECT * FROM ALUNO;

-- inserindo dados
INSERT INTO ALUNO (NOME, CPF, OBSERVACAO, DATA_NASCIMENTO, MEDIA_NOTAS, ATIVO, MATRICULADO_EM);
VALUES
('Jonas', '19845674158', 'Aluno muito focado e com objetivo traçado', '1994-08-11', '8.75', TRUE, NOW());

-- alterando dados na tabela 
UPDATE ALUNO 
SET MEDIA_NOTAS = 9.15
WHERE ID = 1;

-- deletando dados
DELETE FROM ALUNO WHERE ID = 1;

-- selecionando campos específicos de uma tabela
SELECT NOME AS "NOME DO ALUNO", CPF, DATA_NASCIMENTO AS "DATA DE NASCIMENTO" FROM ALUNO;

-- filtrando registros
SELECT * FROM ALUNO WHERE NOME = 'Jonas';
SELECT * FROM ALUNO WHERE NOME != 'Jonas';
SELECT NOME FROM ALUNO WHERE MEDIA_NOTAS > 7;
SELECT NOME FROM ALUNO WHERE NOME LIKE 'J%';
SELECT NOME FROM ALUNO WHERE NOME LIKE 'Mar%';
SELECT NOME FROM ALUNO WHERE NOME LIKE '%a%';