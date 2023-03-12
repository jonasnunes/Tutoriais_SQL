-- visualizar as tabelas temporárias no disco
SHOW GLOBAL STATUS LIKE 'CREATED_TMP_TABLES_DISK';

-- visualizar as tabelas temporárias em memória
SHOW GLOBAL STATUS LIKE 'CREATED_TMP_TABLES';

-- tamanho máximo de tabelas temporárias antes de precisar rodá-las no disco
SHOW GLOBAL VARIABLES LIKE 'TMP_TABLE_SIZE';

-- aumentando a capacidade da variável TMP_TABLE_SIZE caso necessário
SET GLOBAL TMP_TABLE_SIZE = 20800338;

-- criando uma tabela qualquer sem especificar a engine que por padrão é InnoDB
CREATE TABLE TB_DEFAULT (ID INT, NOME VARCHAR(100));

-- alterando a engine para MyISAM
ALTER TABLE TB_DEFAULT ENGINE = MyISAM;

-- especificando a engine no ato de criação da tabela
CREATE TABLE TB_DEFAULT (
	ID INT,
    NOME VARCHAR(100)
) ENGINE = MEMORY;