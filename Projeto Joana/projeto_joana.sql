CREATE TABLE funcionario(
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL,
	sobrenome VARCHAR(30) NOT NULL,
	sexo ENUM('M', 'F') NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	dt_nascimento DATE NOT NULL
);

CREATE TABLE dependente(
	numero INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL,
	sobrenome VARCHAR(30) NOT NULL,
	dt_nascimento DATE NOT NULL,
	fk_funcionario_codigo INT NOT NULL,
	FOREIGN KEY (fk_funcionario_codigo) REFERENCES funcionario (codigo)
);

INSERT INTO funcionario (nome, sobrenome, sexo, cpf, dt_nascimento)
VALUES
('João', 'Silva', 'M', '12345678910', '1980-07-28'),
('Maria', 'Souza', 'F', '32145698701', '1987-02-25'),
('Marcos', 'Andrade', 'M', '12365487902', '1985-03-11');

INSERT INTO dependente (nome, sobrenome, dt_nascimento, fk_funcionario_codigo)
VALUES
('Joãozinho', 'Silva', '1998-05-27', 1),
('Mariazinha', 'Souza', '2002-06-12', 2),
('Marquinhos', 'Andrade', '2005-01-15', 3);

SELECT
funcionario.nome AS Funcionario, dependente.nome AS Dependente
FROM funcionario 
INNER JOIN dependente 
ON funcionario.codigo = dependente.fk_funcionario_codigo;