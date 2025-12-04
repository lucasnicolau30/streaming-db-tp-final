CREATE DATABASE IF NOT EXISTS streaming;
USE streaming;

CREATE TABLE regiao (
    regiao_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    data_cadastro DATE NOT NULL,
    data_nascimento DATE NOT NULL,
    pais VARCHAR(50) NOT NULL,
    regiao_id INT NOT NULL,
    FOREIGN KEY (regiao_id) REFERENCES regiao(regiao_id)
);

CREATE TABLE plano (
    plano_id INT AUTO_INCREMENT PRIMARY KEY,
    preco DECIMAL(5,2) NOT NULL,
    quantidade_max_dispositivos INT NOT NULL,
    qualidade_reproducao VARCHAR(10) NOT NULL
);

CREATE TABLE filme (
    filme_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    ano_lancamento INT NOT NULL,
    duracao INT NOT NULL,
    genero VARCHAR(50) NOT NULL,
    classificacao VARCHAR(20),
    estudio VARCHAR(100),
    idioma_original VARCHAR(50),
    sinopse TEXT
);

CREATE TABLE assinatura (
    assinatura_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    plano_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (plano_id) REFERENCES plano(plano_id)
);

CREATE TABLE disponibilidade (
    filme_id INT NOT NULL,
    regiao_id INT NOT NULL,
    PRIMARY KEY (filme_id, regiao_id),
    FOREIGN KEY (filme_id) REFERENCES filme(filme_id),
    FOREIGN KEY (regiao_id) REFERENCES regiao(regiao_id)
);

CREATE TABLE visualizacao (
    visualizacao_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    filme_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    duracao_minutos INT NOT NULL,
    dispositivo VARCHAR(50),
    qualidade_reproducao VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (filme_id) REFERENCES filme(filme_id)
);

CREATE TABLE favorito (
    cliente_id INT NOT NULL,
    filme_id INT NOT NULL,
    data_favorito DATETIME NOT NULL,
    PRIMARY KEY (cliente_id, filme_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (filme_id) REFERENCES filme(filme_id)
);

CREATE TABLE avaliacao (
    avaliacao_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    filme_id INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (filme_id) REFERENCES filme(filме_id)
);