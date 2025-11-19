# 🎯 SQL DOJO - Desafio de Análise de Dados de Companhia Aérea

## 📋 Sobre o Projeto

Este repositório contém a resolução de 10 questões práticas de análise de dados utilizando SQL e PostgreSQL. O desafio simula situações reais enfrentadas por analistas de dados em uma companhia aérea, trabalhando com informações sobre voos, reservas, passageiros e aeronaves.

O banco de dados utilizado é o **Demo Database** disponibilizado pela comunidade PostgresPro, que representa um sistema completo de reservas de voos.

---

## 🔧  Instalação e Configuração do PostgreSQL

### O que é PostgreSQL?
PostgreSQL é um sistema de banco de dados gratuito e poderoso, usado por empresas do mundo todo para armazenar e organizar informações.

### Passo a Passo da Instalação

#### **Windows:**

1. **Baixe o PostgreSQL:**
   - Acesse: https://www.postgresql.org/download/windows/
   - Clique em "Download the installer"
   - Escolha a versão mais recente (recomendado: PostgreSQL 15 ou superior)

2. **Instale o PostgreSQL:**
   - Execute o arquivo baixado
   - Clique em "Next" nas primeiras telas
   - **IMPORTANTE:** Quando pedir a senha, crie uma senha e **ANOTE EM UM PAPEL** (você vai precisar!)
   - Deixe a porta como `5432` (padrão)
   - Continue clicando em "Next" até finalizar

3. **Verifique se instalou corretamente:**
   - Abra o menu iniciar
   - Procure por "pgAdmin 4"
   - Se abrir uma tela no navegador, está tudo certo! ✅

#### **Mac:**

1. **Baixe o PostgreSQL:**
   - Acesse: https://www.postgresql.org/download/macosx/
   - Ou use Homebrew (se tiver instalado): `brew install postgresql`

2. **Inicie o serviço:**
   ```bash
   brew services start postgresql
   ```

3. **Instale o pgAdmin:**
   - Baixe em: https://www.pgadmin.org/download/

#### **Linux (Ubuntu/Debian):**

```bash
# Atualize os pacotes
sudo apt update

# Instale o PostgreSQL
sudo apt install postgresql postgresql-contrib

# Instale o pgAdmin
sudo apt install pgadmin4
```

---

## 📦 Como Restaurar o Banco de Dados "Medium"

### O que é "restaurar um banco"?
Restaurar significa colocar informações prontas (já criadas por outra pessoa) no seu PostgreSQL. É como baixar um arquivo Excel já preenchido, mas para banco de dados.

### Passo a Passo:

#### **1. Baixe o arquivo do banco de dados:**

- Acesse: https://postgrespro.com/community/demodb
- Role a página até encontrar "Medium" (aproximadamente 70 MB)
- Clique em **"demo-medium-en.zip"** para baixar
- Descompacte o arquivo (clique com botão direito → Extrair aqui)
- Você terá um arquivo chamado **demo-medium-en-20170815.sql**

#### **2. Abra o pgAdmin 4:**

- Procure "pgAdmin 4" no menu iniciar
- Uma página vai abrir no seu navegador
- Digite a senha que você criou na instalação

#### **3. Crie um novo banco de dados:**

- No lado esquerdo, expanda "Servers" → "PostgreSQL 15"
- Clique com botão direito em "Databases"
- Selecione **"Create" → "Database"**
- Em "Database name", digite: **demo**
- Clique em "Save"

#### **4. Restaure o banco de dados:**

- Clique com botão direito no banco "demo" que você acabou de criar
- Selecione **"Restore"**
- Em "Filename", clique no ícone de pasta
- Navegue até onde você salvou o arquivo **demo-medium-en-20170815.sql**
- Selecione o arquivo
- Clique em "Restore"
- Aguarde alguns minutos (uma barra de progresso vai aparecer)
- Quando terminar, você verá uma mensagem de sucesso! ✅

#### **5. Verifique se funcionou:**

- Expanda "demo" → "Schemas" → "bookings" → "Tables"
- Você deve ver várias tabelas: flights, tickets, bookings, etc.
- Se vir essas tabelas, o banco foi restaurado com sucesso! 🎉

---

## 📝 Como Abrir e Executar Arquivos .sql no pgAdmin

### O que é um arquivo .sql?
É um arquivo de texto contendo comandos que "conversam" com o banco de dados. É como uma receita de bolo, mas para buscar ou modificar informações.

### Como Executar:

#### **Método 1: Abrir arquivo .sql direto**

1. No pgAdmin, clique em **"Tools"** (no menu superior)
2. Selecione **"Query Tool"** (ou pressione F5)
3. Uma tela em branco vai abrir
4. Clique no ícone de pasta 📁 (ou vá em File → Open)
5. Navegue até o arquivo .sql que você quer executar
6. Selecione o arquivo
7. Clique no botão ▶️ **"Execute"** (ou pressione F5)
8. Os resultados aparecem na parte inferior da tela

#### **Método 2: Copiar e colar o código**

1. Abra o arquivo .sql com Bloco de Notas ou qualquer editor de texto
2. Selecione todo o código (Ctrl+A) e copie (Ctrl+C)
3. No pgAdmin, abra o Query Tool (F5)
4. Cole o código (Ctrl+V)
5. Clique no botão ▶️ **"Execute"** (ou pressione F5)

#### **Dica importante:**
Sempre verifique se você está conectado ao banco correto! No canto superior esquerdo do Query Tool deve estar escrito **"demo"**.

---

## 🎓Explicação das Questões 
---

### **Questão 1: Quantos assentos, em média, estão ocupados em cada voo?**

#### **Por que a companhia aérea precisa disso?**
Imagine que você tem uma loja e quer saber quantos clientes, em média, visitam sua loja por dia. Aqui é a mesma coisa! A companhia aérea quer saber se seus aviões estão cheios ou vazios. Isso ajuda a:
- Decidir se vale a pena continuar operando aquela rota
- Planejar promoções para encher aviões mais vazios
- Entender quais voos são mais populares

#### **O que o código faz?**
Conta quantas pessoas embarcaram em cada voo e depois calcula a média.

```sql
-- QUESTÃO 1: Média de assentos ocupados por voo
SELECT
    f.flight_no,                          -- Número do voo (ex: PG0405)
    AVG(bp.assentos_ocupados) AS media_assentos_ocupados  -- Média de passageiros
FROM (
    -- Primeiro, conta quantas pessoas embarcaram em cada voo
    SELECT flight_id, COUNT(*) AS assentos_ocupados
    FROM boarding_passes                   -- Tabela de cartões de embarque
    GROUP BY flight_id                     -- Agrupa por voo
) bp
JOIN flights f ON f.flight_id = bp.flight_id  -- Conecta com a tabela de voos
GROUP BY f.flight_no;                      -- Agrupa pelo número do voo
```

**Em português simples:** "Me mostre cada número de voo e quantos passageiros, em média, viajam nele."

---

### **Questão 2: Há quantos dias cada reserva foi feita?**

#### **Por que a companhia aérea precisa disso?**
A empresa quer saber com quanto tempo de antecedência as pessoas compram passagens. Isso ajuda a:
- Planejar campanhas de marketing ("Compre com 30 dias de antecedência e ganhe desconto!")
- Entender o comportamento dos clientes (viagens de trabalho são compradas em cima da hora, férias com antecedência)
- Gerenciar preços dinamicamente (quanto mais próximo do voo, mais caro)

#### **O que o código faz?**
Calcula a diferença entre hoje e a data em que a reserva foi feita.

```sql
-- QUESTÃO 2: Diferença em dias entre a reserva e hoje
SELECT 
    book_ref,                                 -- Código da reserva
    book_date,                                -- Data em que foi feita a reserva
    EXTRACT(DAY FROM (CURRENT_DATE - book_date)) AS diferenca_dias  -- Quantos dias atrás
FROM bookings;                                -- Tabela de reservas
```

**Em português simples:** "Me mostre cada reserva e há quantos dias ela foi feita."

---

### **Questão 3: Quantos assentos disponíveis existem por classe em cada avião?**

#### **Por que a companhia aérea precisa disso?**
É como um hotel querendo saber quantos quartos tem de cada tipo (standard, luxo, suíte). A companhia precisa saber:
- Quantos assentos econômicos, executivos e de primeira classe cada avião tem
- Se vale a pena aumentar ou diminuir assentos de alguma classe
- Como distribuir os passageiros corretamente

#### **O que o código faz?**
Conta quantos assentos existem em cada avião, separados por classe.

```sql
-- QUESTÃO 3: Contagem de assentos por classe em cada aeronave
SELECT
    aircraft_code,              -- Código do avião (ex: 773, 321)
    fare_conditions,            -- Classe do assento (Economy, Business, Comfort)
    COUNT(*) AS assentos_disponiveis  -- Quantidade de assentos dessa classe
FROM seats                      -- Tabela de assentos
GROUP BY aircraft_code, fare_conditions  -- Agrupa por avião e classe
ORDER BY aircraft_code, fare_conditions; -- Ordena para facilitar leitura
```

**Em português simples:** "Me mostre, para cada modelo de avião, quantos assentos tem de cada classe."

---

### **Questão 4: Mudar a classe dos assentos de "Economy" para "Premium Economy" em aviões Cessna**

#### **Por que a companhia aérea precisa disso?**
A empresa decidiu melhorar o conforto em aviões menores (Cessna). É como renovar um produto: em vez de "classe econômica", agora será "econômica premium", com mais benefícios. Isso ajuda a:
- Justificar preços um pouco maiores
- Melhorar a satisfação dos clientes
- Se diferenciar da concorrência

#### **O que o código faz?**
Atualiza o nome da classe dos assentos, mas só nos aviões Cessna 208.

```sql
-- QUESTÃO 4: Atualizar classe para Premium Economy em aviões Cessna

-- Primeiro: aumenta o tamanho do campo para caber "Premium Economy"
ALTER TABLE seats
ALTER COLUMN fare_conditions TYPE VARCHAR(20);

-- Segundo: remove a restrição antiga (que não permitia "Premium Economy")
ALTER TABLE seats DROP CONSTRAINT seats_fare_conditions_check;

-- Terceiro: atualiza os assentos dos aviões Cessna
UPDATE seats
SET fare_conditions = 'Premium Economy'  -- Novo nome da classe
WHERE aircraft_code IN (
    SELECT aircraft_code
    FROM aircrafts
    WHERE model = 'Cessna 208 Caravan'   -- Só nos aviões Cessna
)
AND fare_conditions = 'Economy';         -- Só os que eram Economy

-- Quarto: cria nova restrição permitindo "Premium Economy"
ALTER TABLE seats
ADD CONSTRAINT seats_fare_conditions_check
CHECK (fare_conditions IN ('Economy', 'Comfort', 'Business', 'Premium Economy'));
```

**Em português simples:** "Mude o nome de 'Economy' para 'Premium Economy' em todos os assentos dos aviões Cessna."

---

### **Questão 5: Buscar informações de contato de clientes com telefone específico**

#### **Por que a companhia aérea precisa disso?**
Imagine que houve um problema com voos de uma região específica (código de área +703). A empresa precisa:
- Avisar esses passageiros rapidamente
- Enviar emails sobre mudanças ou compensações
- Entrar em contato por telefone se necessário

#### **O que o código faz?**
Busca passageiros com telefone que começa com +703 e mostra seu email (só o domínio, tipo @gmail.com) e último dígito do telefone.

```sql
-- QUESTÃO 5: Informações de contato de passageiros com telefone +703
SELECT 
    t.ticket_no,                                      -- Número do bilhete
    t.passenger_name,                                 -- Nome do passageiro
    split_part(t.contact_data ->> 'email', '@', 2) AS dominio_email,  -- Só a parte após @
    RIGHT(t.contact_data ->> 'phone', 1) AS ultimo_digito             -- Último número do telefone
FROM tickets t 
JOIN bookings b ON b.book_ref = t.book_ref            -- Conecta bilhetes com reservas
WHERE t.contact_data ->> 'phone' LIKE '+703%';        -- Só telefones que começam com +703
```

**Em português simples:** "Me mostre todos os passageiros que têm telefone começando com +703, com o domínio do email deles e o último dígito do telefone."

---

### **Questão 6: Passageiros com emails longos começando com "a"**

#### **Por que a companhia aérea precisa disso?**
Emails muito longos podem ter erros de digitação ou serem falsos. A empresa quer:
- Verificar se esses emails são válidos
- Entrar em contato para confirmar
- Limpar a base de dados de informações incorretas

#### **O que o código faz?**
Busca passageiros cujo email começa com "a" e tem mais de 40 caracteres.

```sql
-- QUESTÃO 6: Passageiros com emails longos começando com 'a'
SELECT
    t.ticket_no,                              -- Número do bilhete
    t.passenger_name,                         -- Nome do passageiro
    LENGTH(t.contact_data ->> 'email') AS tamanho_email  -- Tamanho do email
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref    -- Conecta com reservas
WHERE (t.contact_data ->> 'email') LIKE 'a%'  -- Email começa com 'a'
AND LENGTH(t.contact_data ->> 'email') > 40;  -- Tem mais de 40 caracteres
```

**Em português simples:** "Me mostre passageiros com email começando em 'a' e que seja muito longo (mais de 40 letras)."

---

### **Questão 7: Total de vendas por mês**

#### **Por que a companhia aérea precisa disso?**
É como uma loja querendo saber quanto vendeu em cada mês. A empresa precisa:
- Comparar se vendeu mais em dezembro (férias) ou julho (férias de inverno)
- Planejar o orçamento do próximo ano
- Identificar meses fracos para fazer promoções

#### **O que o código faz?**
Soma todo o dinheiro das reservas, mês a mês.

```sql
-- QUESTÃO 7: Total de vendas por mês e ano
SELECT
    date_trunc('month', b.book_date) AS mes_ano,  -- Agrupa por mês (ex: 2017-06-01)
    SUM(b.total_amount) AS total_vendas           -- Soma todo o dinheiro do mês
FROM bookings b
GROUP BY date_trunc('month', b.book_date)         -- Agrupa por mês
ORDER BY mes_ano;                                 -- Ordena cronologicamente
```

**Em português simples:** "Me mostre quanto a empresa vendeu em cada mês."

---

### **Questão 8: Criar identificação única para cada assento ocupado**

#### **Por que a companhia aérea precisa disso?**
Cada cartão de embarque precisa de um código único (como um RG). Antes, o código era só "12A" (assento), mas isso pode repetir em voos diferentes. Agora será algo como "PG0405_1_12A" (voo_sequência_assento), garantindo que nunca se repita.

#### **O que o código faz?**
Cria um novo código combinando: número do voo + ordem de embarque + assento.

```sql
-- QUESTÃO 8: Criar identificação única para assentos ocupados

-- Primeiro: aumenta o tamanho do campo para caber o novo formato
ALTER TABLE boarding_passes ALTER COLUMN seat_no TYPE VARCHAR(100);

-- Segundo: gera e atualiza os novos códigos
WITH seq AS (
    SELECT
        bp.ticket_no,
        bp.flight_id,
        bp.seat_no,
        -- Cria um número sequencial para cada passageiro do voo
        ROW_NUMBER() OVER (
            PARTITION BY bp.flight_id          -- Reinicia contagem a cada voo
            ORDER BY bp.ticket_no, bp.flight_id -- Ordena por bilhete
        ) AS seq_num
    FROM boarding_passes bp
)
UPDATE boarding_passes bp
-- Novo formato: voo_sequência_assento (ex: 12345_1_12A)
SET seat_no = seq.flight_id || '_' || seq.seq_num || '_' || seq.seat_no
FROM seq
WHERE bp.flight_id = seq.flight_id
  AND bp.ticket_no = seq.ticket_no;

-- Verifica se funcionou
SELECT 
    flight_id,
    ticket_no,
    seat_no
FROM boarding_passes 
ORDER BY flight_id, ticket_no
LIMIT 20;
```

**Em português simples:** "Crie um código único para cada assento ocupado, combinando o número do voo, a ordem que a pessoa embarcou e o assento dela."

---

### **Questão 9: Quais aeroportos têm mais voos?**

#### **Por que a companhia aérea precisa disso?**
É como saber quais lojas de uma rede vendem mais. A empresa quer:
- Investir mais nos aeroportos movimentados (melhorar estrutura, contratar mais pessoas)
- Entender onde estão seus principais clientes
- Decidir onde abrir novas rotas

#### **O que o código faz?**
Conta quantos voos partem de cada aeroporto e ordena do mais movimentado para o menos.

```sql
-- QUESTÃO 9: Total de voos por aeroporto de partida
SELECT
    ad.airport_name->>'en' AS airport_name,  -- Nome do aeroporto em inglês
    f.departure_airport,                     -- Código do aeroporto (ex: SVO, LED)
    COUNT(*) AS total_voos                   -- Quantidade de voos
FROM flights f
JOIN airports_data ad ON f.departure_airport = ad.airport_code  -- Conecta voos com aeroportos
GROUP BY f.departure_airport, ad.airport_name  -- Agrupa por aeroporto
ORDER BY total_voos DESC;                      -- Mostra primeiro os mais movimentados
```

**Em português simples:** "Me mostre cada aeroporto e quantos voos partem de lá, começando pelos mais movimentados."

---

### **Questão 10: Quais aviões chegam em quais cidades?**

#### **Por que a companhia aérea precisa disso?**
A empresa quer saber quais modelos de avião estão operando em cada destino. Isso ajuda a:
- Planejar manutenção (aviões grandes precisam de hangares maiores)
- Entender se o avião é adequado para aquela rota (não faz sentido usar um Boeing 777 para voos curtos)
- Organizar a logística de aeroportos

#### **O que o código faz?**
Lista cada voo mostrando: modelo do avião, aeroporto de chegada, cidade e país.

```sql
-- QUESTÃO 10: Modelo do avião e destino de cada voo
SELECT
    ac.model AS modelo,                        -- Modelo do avião (ex: Boeing 777-300)
    ad.airport_name->>'en' AS nome_do_aeroporto,  -- Nome do aeroporto de chegada
    ad.city->>'en' AS cidade,                  -- Cidade de chegada
    'Rússia' AS regiao                         -- País (neste caso, todos na Rússia)
FROM flights f
JOIN aircrafts_data ac ON f.aircraft_code = ac.aircraft_code  -- Conecta com dados dos aviões
JOIN airports_data ad ON f.arrival_airport = ad.airport_code; -- Conecta com aeroportos de chegada
```

**Em português simples:** "Me mostre, para cada voo, qual modelo de avião está sendo usado e para qual cidade ele está indo."

---

## 🎯 Conclusão

Estas 10 questões demonstram como profissionais de dados trabalham no dia a dia, transformando perguntas de negócio em consultas técnicas. Cada análise ajuda a companhia aérea a:

✅ Tomar decisões mais inteligentes  
✅ Economizar dinheiro  
✅ Melhorar a experiência dos passageiros  
✅ Planejar o futuro com dados concretos  

---

## 📚 Recursos Adicionais

- **Documentação PostgreSQL:** https://www.postgresql.org/docs/
- **Demo Database:** https://postgrespro.com/community/demodb
- **Tutorial SQL:** https://www.w3schools.com/sql/

---

## 👤 Autor

Maicon Almeida
*Data Analyst | Data Engineer*

📧 Email: seu.email@exemplo.com  
💼 LinkedIn: https://www.linkedin.com/in/aparecidoaalmeida/

---

## 📄 Licença

Este projeto está sob a licença MIT. Sinta-se livre para usar, modificar e compartilhar.

---

⭐ Se este conteúdo foi útil, deixe uma estrela no repositório!