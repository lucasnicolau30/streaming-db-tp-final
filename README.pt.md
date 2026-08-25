# Projeto Banco de Dados - Streaming

[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)

Leia em: [Português](README.pt.md) | [English](README.md)

## Descrição

Este é um projeto em MySQL desenvolvido como trabalho final da disciplina de Introdução a Banco de Dados. Ele modela os dados de um serviço de streaming de filmes (semelhante à Netflix), abrangendo clientes, planos de assinatura, filmes, disponibilidade por região, histórico de visualizações, favoritos e avaliações. O projeto inclui o schema do banco de dados, um script em Python para populá-lo com dados fictícios realistas e um conjunto de consultas SQL analíticas.

## Funcionalidades

- **Schema Relacional**: Tabelas de regiões, clientes, planos, filmes, assinaturas, disponibilidade regional, visualizações, favoritos e avaliações, conectadas por chaves estrangeiras.
- **População de Dados**: Um script em Python usando `Faker` gera dados aleatórios e realistas para todas as tabelas e os insere no banco.
- **Consultas Analíticas**: Um conjunto de consultas SQL prontas para uso, cobrindo perguntas de negócio comuns (filmes mais assistidos, tempo de visualização, favoritos, avaliações, popularidade de planos, qualidade de reprodução, etc.).

## Estrutura do Projeto

```
banco/       -> Schema do banco de dados (criação das tabelas)
seed/        -> Script de população do banco com dados fictícios
pesquisas/   -> Consultas SQL analíticas
```

### `banco/banco-streaming.sql`

Cria o banco de dados `streaming` e todas as suas tabelas:

- `regiao` — regiões geográficas
- `cliente` — clientes, vinculados a uma região
- `plano` — planos de assinatura (preço, limite de dispositivos, qualidade de reprodução)
- `filme` — filmes (título, ano, duração, gênero, classificação, estúdio, etc.)
- `assinatura` — assinaturas dos clientes, vinculadas a cliente e plano
- `disponibilidade` — disponibilidade regional de cada filme
- `visualizacao` — histórico de visualizações (cliente, filme, data/hora, duração, dispositivo)
- `favorito` — filmes favoritados pelos clientes
- `avaliacao` — avaliações dos clientes sobre os filmes (nota de 1 a 5)

### `seed/popular_banco.py`

Conecta ao banco de dados MySQL e popula todas as tabelas com dados fictícios, porém consistentes, usando a biblioteca `Faker` e uma seed fixa (`123`) para garantir reprodutibilidade.

### `pesquisas/`

Dez consultas SQL (`pesquisa-01.sql` a `pesquisa-10.sql`) respondendo perguntas analíticas como:

- Filmes disponíveis em cada região
- Filmes favoritos dos clientes
- Média de avaliação por filme
- Filmes nunca visualizados
- Total de visualizações e minutos assistidos por filme
- Horas assistidas por gênero
- Clientes ativos por plano
- Filmes mais assistidos
- Distribuição de qualidade de reprodução
- Histórico de assinaturas por cliente

## Como Executar

### Pré-requisitos

- MySQL Server
- Python 3 com os pacotes `mysql-connector-python` e `Faker`:

```bash
pip install mysql-connector-python Faker
```

### Configuração

1. Crie o schema:

```bash
mysql -u root -p < banco/banco-streaming.sql
```

2. Atualize as credenciais de conexão em `seed/popular_banco.py` (host, usuário, senha) e popule o banco:

```bash
python seed/popular_banco.py
```

3. Execute as consultas analíticas em `pesquisas/` contra o banco `streaming` usando o cliente MySQL de sua preferência.

## Autor

Lucas Nicolau — Estudante de Engenharia de Software na @UFAM
