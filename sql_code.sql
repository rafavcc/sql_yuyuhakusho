-- Novo arquivo de queries
-- Deletar todas as tabelas para zerar o banco
DROP table IF EXISTS lutas;
DROP table IF EXISTS tecnicas;
DROP table IF EXISTS torneio;
DROP table IF EXISTS personagens;

-- Criar tabela personagens
CREATE TABLE personagens
(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(1024) NOT NULL UNIQUE,
    especie VARCHAR(1024),
    nivel_poder INTEGER,
    ranking_torneio INTEGER
);
-- Criando tabelas de técnicas dos personagens
CREATE TABLE tecnicas
(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(1024) NOT NULL UNIQUE,
    tipo VARCHAR(50),
    poder INTEGER,
    personagem_id INTEGER NOT NULL REFERENCES personagens(id)
);

-- Query para inserir vários personagens do anime Yu Yu Hakusho
INSERT INTO personagens (nome, especie, nivel_poder, ranking_torneio) VALUES
('Yusuke Urameshi', 'Humano', 2000, 1),
('Kazuma Kuwabara', 'Humano', 1200, 4),
('Kurama', 'Youkai', 1800, 3),
('Hiei', 'Youkai', 1900, 2),
('Genkai', 'Humano', 2200, NULL),
('Toguro (Jovem)', 'Youkai', 3000, 1),
('Toguro (Velho)', 'Youkai', 2500, NULL),
('Sensui', 'Humano', 3500, NULL),
('Mukuro', 'Youkai', 4000, NULL),
('Atsuko Urameshi', 'Humano', 10, NULL),  -- Mãe do Yusuke
('Raizen', 'Mazoku', 10000, NULL),
('Yomi', 'Youkai', 4500, NULL);

-- Query para inserir as técnicas
INSERT INTO tecnicas
(
    nome, tipo, poder, personagem_id
)
VALUES
('Leigan', 'Espiritual', 2000, 1),  -- Yusuke Urameshi
('Golpe Espiritual', 'Espiritual', 1300, 2),  -- Kuwabara
('Espada Dimensional', 'Espiritual', 1700, 2),  -- Kuwabara
('Chicote de Rosa', 'Espiritual', 1800, 3),  -- Kurama
('Forma Youko', 'Transformação', 2500, 3),  -- Kurama
('Jagan', 'Youkai', 1900, 4),  -- Hiei
('Kokuryuha', 'Espiritual', 2800, 4),  -- Hiei
('Técnica do Espírito Demoníaco', 'Espiritual', 3000, 6),  -- Toguro (Jovem)
('Rajada de Espírito', 'Espiritual', 3500, 8),  -- Sensui
('Manipulação do Espírito', 'Espiritual', 3800, 9),  -- Mukuro
('Golpe Sonoro', 'Espiritual', 4000, 10);  -- Yomi

-- Verificando como estão as tabelas de personagens e técnicas
SELECT * from personagens;
SELECT * from tecnicas;

-- Criar uma tabela temporária apenas com as técnicas do Yusuke Uramesh
create table tecnicas_yusuke (
    name VARCHAR (1024) NOT NULL,
    poder INTEGER
);

-- Adicionar mais poderes para o Yusuke
INSERT INTO tecnicas 
(
    nome, tipo, poder, personagem_id
) VALUES
('Leigan Duplo', 'Espiritual', 2500, 1),  -- Versão mais forte do Leigan
('Leigan Múltiplo', 'Espiritual', 2800, 1),  -- Dispara vários Leigans ao mesmo tempo
('Leigan Demoníaco', 'Espiritual', 3000, 1),  -- Aprimorado com o poder Mazoku
('Técnica do Raio Espiritual', 'Espiritual', 3200, 1);  -- Energia canalizada em uma grande rajada

-- Criar uma tabela apenas com os poderes do Yusukue
INSERT INTO tecnicas_yusuke
SELECT nome, poder from tecnicas where personagem_id = 1;

-- Limpar tabela com poderes do Yusuke
TRUNCATE TABLE tecnicas_yusuke;
DROP TABLE tecnicas_yusuke;

-- Atualizar os dados de uma tabela tecnicas
UPDATE tecnicas
SET poder = 10000
WHERE nome = 'Leigan';

-- Verificar a técnica que tem id = 15
DELETE from tecnicas
WHERE id = 15;

-- Selecionar todos os personagens com poder maior que 3000
SELECT *
FROM personagens
WHERE nivel_poder > 3000;

-- Seleciona todos os persosagens que não são humanos
SELECT *
FROM personagens
WHERE especie != 'Humano';

-- Criar tabela torneio, que vai conter várias lutas realizadas
DROP TABLE IF EXISTS torneio;
CREATE TABLE torneio(
    id SERIAL PRIMARY KEY,
    nome_torneio VARCHAR(255),
    vencedor_torneio INTEGER NOT NULL,
    lutas INTEGER,
    localidade VARCHAR(255)
);

DROP TABLE IF EXISTS lutas;
CREATE TABLE lutas(
    id SERIAL PRIMARY KEY,
    vencedor_luta INTEGER NOT NULL,
    data DATE DEFAULT (NOW()),
    FOREIGN KEY (vencedor_luta) REFERENCES personagens(id),
    publico INTEGER
);

-- Inserindo dados de lutas realizadas
INSERT INTO lutas
(vencedor_luta, publico)
VALUES
(1,10),(2,20),(3,30),(4,40),(1,50),(3,60),(1,70);

-- Inserindo dados de torneios realizadas
INSERT INTO torneio(nome_torneio, vencedor_torneio, lutas, localidade)
VALUES
('Primeiro Torneio', 1, 1, 'Mundo das Trevas'),
('Primeiro Torneio', 1, 2, 'Mundo das Trevas'),
('Primeiro Torneio', 1, 3, 'Mundo das Trevas');

-- Verificando como estão as tabelas de torneios e lutas.
SELECT * from torneio;
select * from lutas;

-- Testando INNER JOIN com personagens e lutas - PARTE 1
SELECT *
FROM
    personagens
    INNER JOIN lutas ON personagens.id = lutas.vencedor_luta
ORDER BY personagens.id

-- Testando INNER JOIN com personagens e lutas - PARTE 2
SELECT
    personagens.nome,
    lutas.publico
FROM
    personagens
    INNER JOIN lutas ON personagens.id = lutas.vencedor_luta
where personagens.especie = 'Humano'

-- Testando LEFT JOIN
-- Nesse caso aqui, mesmo lutadores que não tiveram lutas, ainda serão listados
-- Lutadores que lutaram, terão informações das lutas que ganharam (mesmo que mais de uma)

SELECT *
FROM
    personagens
    LEFT JOIN lutas ON personagens.id = lutas.vencedor_luta
ORDER BY personagens.id

-- Selecionar, através de Inner Join
SELECT
    torneio.nome_torneio,
    torneio.localidade,
    lutas.publico,
    personagens.nome
from
    torneio
    INNER JOIN lutas ON torneio.lutas = lutas.id
    INNER JOIN personagens ON lutas.vencedor_luta = personagens.id

-- Selecionar o nome de todas as personagens que ganharam alguma luta
-- E quantas lutas aquele lutador(a) venceu
SELECT
    personagens.nome,
    COUNT(*) as lutas_vencidas
FROM
    personagens
    INNER JOIN lutas ON personagens.id = lutas.vencedor_luta
GROUP BY
    personagens.nome

-- Soma o publico total das lutas vencidas por cada lutador
SELECT vencedor_luta, SUM(publico) as publico_total
FROM lutas
GROUP BY vencedor_luta
HAVING SUM(publico) > 100;

select * from lutas;
