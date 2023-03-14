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

/*
	Simulando várias consultas em um banco ao mesmo tempo usando o mysqlslap
    
    mysqlslap -uroot -p --concurrency=100 --iterations=10 --create-schema=sucos_vendas --query="SELECT * FROM NOTAS_FISCAIS WHERE DATA_VENDA = '20170101'";
*/

/*
	- Criando um usuário
    
    CREATE USER 'user02'@'localhost' identified by 'user02';
    
    - Concedendo todos os privilégios
    
    GRANT ALL PRIVILEGES ON *.* TO 'admin01'@'localhost' WITH GRANT OPTION;
    
    - Excluindo um usuário
    
    DROP USER 'root'@'localhost';
    
    - Concedendo privilégios específicos ao usuário
    
    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE
    ON *.* TO 'admin02'@'localhost';
    
    - Privilégios para um usuário somente leitura
    
    GRANT SELECT, EXECUTE ON *.* TO 'user02'@'localhost';
    
    - Criando e dando privilégios para um usuário de backup
    
    CREATE USER 'backup01'@'localhost' identified by 'backup01';
    GRANT SELECT, RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'backup01'@'localhost';
    
    - Criando e dando privilégios para um usuário que poderá acessar o banco de qualquer servidor
    
    CREATE USER 'admin_generico'@'%' identified by 'admin_generico';
    GRANT ALL PRIVILEGES ON *.* TO 'admin_generico'@'%' WITH GRANT OPTION;
    
    - Criando, dando privilégios e limitando o total de bancos que o usuário pode ver
    
    CREATE USER 'user03'@'%' identified by 'user03';
    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE
    ON sucos_vendas.* TO 'user03'@'%'
    
    - Criando, dando privilégios, limitando o total de bancos e o acesso as tabelas que o usuário pode ver
    
    CREATE USER 'user04'@'%' identified by 'user04';
    GRANT SELECT, INSERT, UPDATE, DELETE ON sucos_vendas.tabela_de_clientes TO 'user04'@'%';
    GRANT SELECT ON sucos_vendas.tabela_de_produtos TO 'user04'@'%';
    
    - Revogando privilégios
    
    REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user02'@'localhost';
*/

-- visualizar todos os usuários do ambiente
SELECT * FROM mysql.user;

-- visualizar permissões específicas de cada usuário
SHOW GRANTS FOR 'user02'@'localhost';