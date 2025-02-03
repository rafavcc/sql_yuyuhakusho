# 📌 Banco de Dados de Yu Yu Hakusho

Esse repositório contém um banco de dados inspirado no anime **Yu Yu Hakusho**. A ideia é modelar personagens, técnicas, torneios e lutas para praticar SQL de uma forma mais divertida!

---

## 📜 O que tem aqui?

Este projeto contém:

- **Tabela `personagens`**
- **Tabela `tecnicas`**
- **Tabela `torneio`**
- **Tabela `lutas`**

Com esses dados, dá para brincar bastante com consultas SQL e explorar a estrutura do banco de dados.

---

## 🔥 Comandos principais

### 📌 Inserindo dados

```sql
INSERT INTO personagens (nome, especie, nivel_poder, ranking_torneio) VALUES
('Yusuke Urameshi', 'Humano', 2000, 1),
('Kazuma Kuwabara', 'Humano', 1200, 4),
('Kurama', 'Youkai', 1800, 3),
('Hiei', 'Youkai', 1900, 2);
```

```sql
INSERT INTO tecnicas (nome, tipo, poder, personagem_id) VALUES
('Leigan', 'Espiritual', 2000, 1),
('Chicote de Rosa', 'Espiritual', 1800, 3),
('Kokuryuha', 'Espiritual', 2800, 4);
```

### 📌 Algumas consultas legais

✔️ **Personagens com nível de poder acima de 3000**
```sql
SELECT * FROM personagens WHERE nivel_poder > 3000;
```

✔️ **Técnicas de um personagem específico (ex: Yusuke)**
```sql
SELECT * FROM tecnicas WHERE personagem_id = 1;
```

✔️ **Vencedores de lutas e o total de público**
```sql
SELECT personagens.nome, SUM(lutas.publico) AS publico_total
FROM personagens
INNER JOIN lutas ON personagens.id = lutas.vencedor_luta
GROUP BY personagens.nome;
```

---

## 🚀 Como rodar o projeto

1️⃣ Clone este repositório:
```sh
git clone https://github.com/rafavcc/sql-yu-yu-hakusho.git
```

2️⃣ Entre na pasta do projeto:
```sh
cd sql-yu-yu-hakusho
```

3️⃣ Rode os scripts SQL no PostgreSQL ou outro banco compatível.

4️⃣ Teste as consultas e se divirta explorando os dados!

---

## 📌 Melhorias futuras
- Adicionar uma tabela para itens e artefatos.
- Criar mais relacionamentos entre torneios e times.
- Explorar triggers e stored procedures para automação de regras.

---

## 📜 Licença
Este projeto é livre para uso e colaboração! Se tiver sugestões ou quiser contribuir, manda ver. 😃

