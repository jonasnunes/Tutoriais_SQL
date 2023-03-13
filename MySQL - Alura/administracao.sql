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

-- mostrando as variáveis de ambiente que possuem DIR em seu nome
SHOW VARIABLES WHERE VARIABLE_NAME LIKE '%dir';

/*
	- Para alterar o diretório em que as bases de dados são salvas fisicamente por padrão,
    altere o caminho na variável de ambiente datadir que se encontra no arquivo my.ini
    - Pare o serviço do MySQL, reinice e depois feche o Workbencch e abra novamente para que as alterações tenham efeito
    - Também é necessário copiar a pasta Data do caminho original para novo caminho especificado
*/

/*
	- Realizando backup através de linha de comando no CMD do Windows
    - Primeiro navegue até a pasta onde está localizado o mysqldump
    - C:\Progam Files\MySQL\MySQL Server 8.0\bin (o diretório pode ser diferente em outra máquina)
    - C:\MySQL\UniServerZ\core\mysql\bin (outra opção de diretório)
    
    mysqldump -uroot -p --databases sucos_vendas > c:\mysqladmin\sucos_vendas_full.sql
    
    - Fazendo backup de apenas uma tabela da base de dados
    
    mysqldump -uroot -p --databases sucos_vendas --tables notas_fiscais > c:\mysqladmin\backup_notas_fiscais.sql
    
    - Fazendo backup de todas as tabelas mas excluindo uma em específico
    
    mysqldump -uroot -p --databases sucos_vendas --ignore-table sucos_vendas.notas_fiscais > c:\mysqladmin\ignore_notas_fiscais
    
    - Salvando os dados ignorando a estrutura da tabela
    
    mysqldump -uroot -p --databases sucos_vendas --no-create-db --no-create-info --complete-insert > c:\mysqladmin\apenas_dados.sql
*/

-- desligando o banco temporariamente para realizar um backup
LOCK INSTANCE FOR BACKUP;

-- liberando o banco
UNLOCK INSTANCE;

/*
	- Restaurando o banco de dados através da linha de comando
    
    mysql -uroot -p < c:\mysqladmin\sucos_vendas_full.sql
*/