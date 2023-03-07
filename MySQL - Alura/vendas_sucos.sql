-- criar o banco de dados
CREATE DATABASE vendas_sucos;

-- criar o banco de dados determinando o conjunto de caracteres
CREATE DATABASE vendas_sucos2 DEFAULT CHARACTER SET utf8;

-- se não existir o banco, crie-o
CREATE DATABASE IF NOT EXISTS vendas_sucos2;

-- se existir o banco, exclua
DROP DATABASE IF EXISTS vendas_sucos2;

-- selecionando o banco a ser usado
USE vendas_sucos;

-- se a tabela PRODUTOS não existir, crie
CREATE TABLE IF NOT EXISTS PRODUTOS(
	CODIGO VARCHAR(10) PRIMARY KEY,
    DESCRITOR VARCHAR(100),
    SABOR VARCHAR(50),
    TAMANHO VARCHAR(50),
    EMBALAGEM VARCHAR(50),
    PRECO_LISTA FLOAT
);

-- se a tabela VENDEDORES não existir, crie
CREATE TABLE IF NOT EXISTS VENDEDORES(
	MATRICULA VARCHAR(5) PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    BAIRRO VARCHAR(50) NOT NULL,
    COMISSAO FLOAT,
    DATA_ADMISSAO DATE,
    FERIAS BIT(1)
);

-- renomeando uma coluna
ALTER TABLE VENDEDORES RENAME COLUMN DATA_ADMISSAO TO DT_ADMISSAO;
ALTER TABLE TABELA_DE_CLIENTES RENAME COLUMN ENDERECO_1 TO ENDERECO;

-- excluindo uma coluna
ALTER TABLE TABELA_DE_CLIENTES DROP COLUMN ENDERECO_2;

-- se a tabela CLIENTE não existir, crie
CREATE TABLE IF NOT EXISTS CLIENTE(
	CPF VARCHAR(11) PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    ENDERECO VARCHAR(150) NOT NULL,
    BAIRRO VARCHAR(50) NOT NULL,
    CIDADE VARCHAR(50) NOT NULL,
    ESTADO VARCHAR(50) NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    DT_NASCIMENTO DATE,
    IDADE TINYINT,
    SEXO ENUM('M', 'F'),
    LIMITE_CREDITO FLOAT,
    VOLUME_COMPRA FLOAT,
    PRIMEIRA_COMPRA BIT(1)
);

-- criar a tabela de VENDAS
CREATE TABLE IF NOT EXISTS VENDAS(
	NUMERO VARCHAR(5) NOT NULL PRIMARY KEY,
    DATA_VENDA DATE,
    CPF VARCHAR(11) NOT NULL,
    MATRICULA VARCHAR(5) NOT NULL,
    IMPOSTO FLOAT
);

-- criar a tabela itens notas
CREATE TABLE IF NOT EXISTS ITENS_NOTAS(
	NUMERO VARCHAR(5) NOT NULL,
    CODIGO VARCHAR(10) NOT NULL,
    QUANTIDADE TINYINT,
    PRECO FLOAT,
    PRIMARY KEY(NUMERO, CODIGO)
);

-- criando o relacionamento entre a tabela de VENDAS e a tabela de CLIENTES pelo campo CPF
ALTER TABLE VENDAS
ADD CONSTRAINT FK_CLIENTES
FOREIGN KEY (CPF)
REFERENCES CLIENTE (CPF);

-- criando o relacionamento entre a tabela VENDAS e a tabela VENDEDORES pelo campo MATRICULA
ALTER TABLE VENDAS
ADD CONSTRAINT FK_VENDEDORES
FOREIGN KEY (MATRICULA)
REFERENCES VENDEDORES (MATRICULA);

-- criando o relacionamento entre a tabela PRODUTOS e a tabela VENDAS pelo campo CODIGO
ALTER TABLE ITENS_NOTAS
ADD CONSTRAINT FK_VENDAS
FOREIGN KEY (NUMERO)
REFERENCES VENDAS (NUMERO);

ALTER TABLE ITENS_NOTAS
ADD CONSTRAINT FK_PRODUTOS
FOREIGN KEY (CODIGO)
REFERENCES PRODUTOS (CODIGO);

-- renomeando as tabelas
ALTER TABLE VENDAS RENAME NOTAS;
ALTER TABLE CLIENTE RENAME CLIENTES;

-- usando o SELECT para ver registros de outro banco de dados
SELECT * FROM sucos_vendas.itens_notas_fiscais;

-- consulta para mostrar os valores sem se repetir caso haja na outra tabela
SELECT
CODIGO_DO_PRODUTO AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR,
EMBALAGEM, TAMANHO, SABOR, PRECO_DE_LISTA AS PRECO_LISTA
FROM sucos_vendas.tabela_de_produtos
WHERE CODIGO_DO_PRODUTO NOT IN (SELECT CODIGO FROM produtos);

-- inserindo os dados usando a consulta acima
INSERT INTO produtos
SELECT
CODIGO_DO_PRODUTO AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR,
SABOR, TAMANHO, EMBALAGEM, PRECO_DE_LISTA AS PRECO_LISTA
FROM sucos_vendas.tabela_de_produtos
WHERE CODIGO_DO_PRODUTO NOT IN (SELECT CODIGO FROM produtos);

INSERT INTO CLIENTES
SELECT
CPF, NOME, ENDERECO, BAIRRO, CIDADE, ESTADO, CEP,
DATA_DE_NASCIMENTO AS DT_NASCIMENTO, IDADE, SEXO,
LIMITE_DE_CREDITO AS LIMITE_CREDITO,
VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA
FROM sucos_vendas.tabela_de_clientes
WHERE CPF NOT IN (SELECT CPF FROM CLIENTES);

INSERT INTO VENDEDORES
SELECT
MATRICULA, NOME, BAIRRO,
PERCENTUAL_COMISSAO AS COMISSAO, DATA_ADMISSAO AS DT_ADMISSAO,
DE_FERIAS AS FERIAS
FROM sucos_vendas.tabela_de_vendedores
WHERE MATRICULA NOT IN (SELECT MATRICULA FROM VENDEDORES);

INSERT INTO NOTAS
SELECT
NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO
FROM sucos_vendas.notas_fiscais
WHERE CPF NOT IN (SELECT CPF FROM NOTAS);

INSERT INTO ITENS_NOTAS
SELECT
NUMERO, CODIGO_DO_PRODUTO AS CODIGO, QUANTIDADE, PRECO
FROM sucos_vendas.itens_notas_fiscais
WHERE CODIGO_DO_PRODUTO NOT IN (SELECT CODIGO FROM ITENS_NOTAS);