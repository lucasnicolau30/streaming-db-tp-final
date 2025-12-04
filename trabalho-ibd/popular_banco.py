from faker import Faker
import mysql.connector
import random
from datetime import datetime, timedelta

# ------------------------------
# CONFIGURAÇÃO DO BANCO
# ------------------------------
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Tu0238.na",
    database="streaming"
)

cursor = db.cursor()
fake = Faker()
Faker.seed(123)

# ------------------------------
# GERAR REGIÕES
# ------------------------------
def gerar_regioes():
    regioes = ["Europa", "Ásia", "América Central", "América do Norte", "América do Sul", "África"]
    sql = "INSERT INTO regiao (nome) VALUES (%s)"
    data = [(r,) for r in regioes]
    cursor.executemany(sql, data)
    db.commit()


# ------------------------------
# GERAR PLANOS
# ------------------------------
def gerar_planos():
    planos = [
        (19.90, 1, "SD"),
        (29.90, 2, "HD"),
        (39.90, 3, "Full HD"),
        (49.90, 4, "4K")
    ]

    sql = """
        INSERT INTO plano (preco, quantidade_max_dispositivos, qualidade_reproducao)
        VALUES (%s, %s, %s)
    """
    cursor.executemany(sql, planos)
    db.commit()


# ------------------------------
# GERAR CLIENTES
# ------------------------------
def gerar_clientes(qtd = 50):
    cursor.execute("SELECT regiao_id FROM regiao")
    lista_regioes = [row[0] for row in cursor.fetchall()]

    sql = """
        INSERT INTO cliente 
        (nome, email, data_cadastro, data_nascimento, pais, regiao_id)
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    clientes = []
    for _ in range(qtd):
        clientes.append((
            fake.name(),
            fake.unique.email(),
            fake.date_between(start_date = "-2y", end_date = "today"),
            fake.date_of_birth(minimum_age = 18, maximum_age = 70),
            fake.country(),
            random.choice(lista_regioes)  
        ))

    cursor.executemany(sql, clientes)
    db.commit()

# ------------------------------
# GERAR ASSINATURAS
# ------------------------------
def gerar_assinaturas():
    cursor.execute("SELECT cliente_id FROM cliente")
    clientes = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT plano_id FROM plano")
    planos = [row[0] for row in cursor.fetchall()]

    sql = """
        INSERT INTO assinatura
        (cliente_id, plano_id, data_inicio, data_fim, status)
        VALUES (%s, %s, %s, %s, %s)
    """

    assinaturas = []
    for cliente in clientes:
        inicio = fake.date_between(start_date = "-2y", end_date = "-1y")
        plano_atual = random.choice(planos)

        assinaturas.append((cliente, plano_atual, inicio, None, "ativo"))

    cursor.executemany(sql, assinaturas)
    db.commit()


# ------------------------------
# GERAR FILMES
# ------------------------------
def gerar_filmes(qtd = 40):
    generos = ["Ação", "Drama", "Comédia", "Terror", "Suspense", "Documentário", "Romance", "Ficção Científica"]

    sql = """
        INSERT INTO filme
        (titulo, ano_lancamento, duracao, genero, classificacao,
        estudio, idioma_original, sinopse)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    filmes = []
    for _ in range(qtd):
        filmes.append((
            fake.sentence(nb_words = 3),
            random.randint(1980, 2024),
            random.randint(80, 180),
            random.choice(generos),
            random.choice(["Livre", "10", "12", "14", "16", "18"]),
            fake.company(),
            random.choice(["Inglês", "Espanhol", "Francês", "Alemão", "Japonês"]),
            fake.text(max_nb_chars = 200)
        ))

    cursor.executemany(sql, filmes)
    db.commit()


# ------------------------------
# GERAR DISPONIBILIDADE FILME x REGIÃO
# ------------------------------
def gerar_disponibilidade():
    cursor.execute("SELECT filme_id FROM filme")
    filmes = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT regiao_id FROM regiao")
    regioes = [row[0] for row in cursor.fetchall()]

    sql = "INSERT IGNORE INTO disponibilidade (filme_id, regiao_id) VALUES (%s, %s)"

    registros = []
    for filme in filmes:
        qtd = random.randint(1, len(regioes))
        reg_escolhidas = random.sample(regioes, qtd)
        for r in reg_escolhidas:
            registros.append((filme, r))

    cursor.executemany(sql, registros)
    db.commit()


# ------------------------------
# GERAR VISUALIZAÇÕES
# ------------------------------
def gerar_visualizacoes(qtd = 200):
    cursor.execute("SELECT cliente_id FROM cliente")
    clientes = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT filme_id FROM filme")
    filmes = [row[0] for row in cursor.fetchall()]

    dispositivos = ["Smart TV", "Celular", "Tablet", "Notebook", "Console"]

    sql = """
        INSERT INTO visualizacao
        (cliente_id, filme_id, data_hora, duracao_minutos, dispositivo, qualidade_reproducao)
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    vis = []
    for _ in range(qtd):
        vis.append((
            random.choice(clientes),
            random.choice(filmes),
            fake.date_time_between(start_date = "-6M", end_date = "now"),
            random.randint(5, 120),
            random.choice(dispositivos),
            random.choice(["SD", "HD", "Full HD", "4K"])
        ))

    cursor.executemany(sql, vis)
    db.commit()


# ------------------------------
# GERAR FAVORITOS
# ------------------------------
def gerar_favoritos(qtd = 80):
    cursor.execute("SELECT cliente_id FROM cliente")
    clientes = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT filme_id FROM filme")
    filmes = [row[0] for row in cursor.fetchall()]

    sql = """
        INSERT IGNORE INTO favorito
        (cliente_id, filme_id, data_favorito)
        VALUES (%s, %s, %s)
    """

    fav = []
    for _ in range(qtd):
        fav.append((
            random.choice(clientes),
            random.choice(filmes),
            fake.date_time_between(start_date = "-1y", end_date = "now")
        ))

    cursor.executemany(sql, fav)
    db.commit()


# ------------------------------
# GERAR AVALIAÇÕES
# ------------------------------
def gerar_avaliacoes(qtd = 120):
    cursor.execute("SELECT cliente_id FROM cliente")
    clientes = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT filme_id FROM filme")
    filmes = [row[0] for row in cursor.fetchall()]

    sql = """
        INSERT INTO avaliacao
        (cliente_id, filme_id, nota, data_avaliacao)
        VALUES (%s, %s, %s, %s)
    """

    aval = []
    for _ in range(qtd):
        aval.append((
            random.choice(clientes),
            random.choice(filmes),
            random.randint(1, 5),
            fake.date_between(start_date = "-6M", end_date = "today")
        ))

    cursor.executemany(sql, aval)
    db.commit()


# ------------------------------
# EXECUÇÃO PRINCIPAL
# ------------------------------
if __name__ == "__main__":
    gerar_regioes()
    gerar_planos()
    gerar_clientes(50)
    gerar_assinaturas()
    gerar_filmes(40)
    gerar_disponibilidade()
    gerar_visualizacoes(200)
    gerar_favoritos(80)
    gerar_avaliacoes(120)

    cursor.close()
    db.close()
    print("Dados gerados com sucesso!")