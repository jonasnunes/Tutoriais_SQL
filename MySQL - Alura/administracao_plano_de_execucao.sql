-- 3.65
SELECT A.NOME_DO_PRODUTO FROM TABELA_DE_PRODUTOS A;

-- 76838.03
SELECT A.NOME_DO_PRODUTO, C.QUANTIDADE
FROM TABELA_DE_PRODUTOS A 
INNER JOIN ITENS_NOTAS_FISCAIS C
ON A.CODIGO_DO_PRODUTO = C.CODIGO_DO_PRODUTO;

-- 167111.43
SELECT A.NOME_DO_PRODUTO, YEAR(B.DATA_VENDA) AS ANO, C.QUANTIDADE
FROM TABELA_DE_PRODUTOS A
INNER JOIN ITENS_NOTAS_FISCAIS C 
ON A.CODIGO_DO_PRODUTO = C.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS B
ON C.NUMERO = B.NUMERO;

-- 151895.83
SELECT A.NOME_DO_PRODUTO, YEAR(B.DATA_VENDA) AS ANO, SUM(C.QUANTIDADE)
FROM TABELA_DE_PRODUTOS A 
INNER JOIN ITENS_NOTAS_FISCAIS C
ON A.CODIGO_DO_PRODUTO = C.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS B 
ON C.NUMERO = B.NUMERO
GROUP BY 1, 2
ORDER BY 1, 2;