DELIMITER //
DROP PROCEDURE IF EXISTS CURSOR_PRIMEIRO_CONTATO;
CREATE PROCEDURE `CURSOR_PRIMEIRO_CONTATO` ()
BEGIN
	DECLARE vNOME VARCHAR(50);
    DECLARE C CURSOR FOR SELECT NOME FROM TABELA_DE_CLIENTES LIMIT 4;
    
    OPEN C;
    
    FETCH C INTO vNOME;
    SELECT vNOME;
    FETCH C INTO vNOME;
    SELECT vNOME;
    FETCH C INTO vNOME;
    SELECT vNOME;
    FETCH C INTO vNOME;
    SELECT vNOME;
    
    CLOSE C;
END//

CALL CURSOR_PRIMEIRO_CONTATO;

SELECT NOME FROM TABELA_DE_CLIENTES LIMIT 4;

-- looping com cursor
DELIMITER //
DROP PROCEDURE IF EXISTS CURSOR_LOOPING;
CREATE PROCEDURE `CURSOR_LOOPING` ()
BEGIN
	DECLARE FIM_DO_CURSOR INT DEFAULT 0;
	DECLARE vNOME VARCHAR(50);
    DECLARE C CURSOR FOR SELECT NOME FROM tabela_de_clientes LIMIT 4;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM_DO_CURSOR = 1;
    
    OPEN C;
    
    WHILE FIM_DO_CURSOR = 0
    DO
		FETCH C INTO vNOME;
        -- sem esse IF o último nome será impresso na tela duas vezes
        IF FIM_DO_CURSOR = 0 THEN
			SELECT vNOME;
		END IF;
	END WHILE;
    
    CLOSE C;
END//

CALL CURSOR_LOOPING;

-- cursor acessando mais de um campo
DELIMITER //
DROP PROCEDURE IF EXISTS ACESSANDO_CAMPOS;
CREATE PROCEDURE `ACESSANDO_CAMPOS` ()
BEGIN
	DECLARE FIM_DO_CURSOR INT DEFAULT 0;
    DECLARE vNOME, vENDERECO, vBAIRRO, vCIDADE, vESTADO VARCHAR(100);
    DECLARE C CURSOR FOR SELECT NOME, ENDERECO, BAIRRO, CIDADE, ESTADO FROM TABELA_DE_CLIENTES LIMIT 4;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM_DO_CURSOR = 1;
    
    OPEN C;
    
    WHILE FIM_DO_CURSOR = 0
    DO
		FETCH C INTO vNOME, vENDERECO, vBAIRRO, vCIDADE, vESTADO;
        IF FIM_DO_CURSOR = 0 THEN
			SELECT vNOME, vENDERECO, vBAIRRO, vCIDADE, vESTADO;
		END IF;
	END WHILE;
    
    CLOSE C;
END//

CALL ACESSANDO_CAMPOS;

-- EXERCÍCIO
DELIMITER //
DROP PROCEDURE IF EXISTS LIMITE_CREDITOS;
CREATE PROCEDURE `LIMITE_CREDITOS` ()
BEGIN
	DECLARE FIM_DO_CURSOR INT DEFAULT 0;
    DECLARE vLIMITE FLOAT;
    DECLARE C CURSOR FOR SELECT LIMITE_DE_CREDITO FROM TABELA_DE_CLIENTES;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM_DO_CURSOR = 1;
    
    OPEN C;
    
    WHILE FIM_DO_CURSOR = 0
    DO
		FETCH C INTO vLIMITE;
        IF FIM_DO_CURSOR = 0 THEN
			SELECT vLIMITE
		END IF;
	END WHILE;
    
    CLOSE C;
END//

CALL LIMITE_CREDITOS;