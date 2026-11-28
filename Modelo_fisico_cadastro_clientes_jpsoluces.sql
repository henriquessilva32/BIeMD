-- =====================================================================
-- MODELO FÍSICO - CADASTRO DE CLIENTES (JP SOLUCOES)
-- Membros: Vinicius Emídio Alencar, Henrique Santos da Silva,
--          José Mario da Cruz Rebouças
-- SGBD: MySQL 8.x (script compatível com MariaDB)
-- =====================================================================

DROP DATABASE IF EXISTS cadastro_clientes;
CREATE DATABASE cadastro_clientes
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE cadastro_clientes;


-- ---------------------------------------------------------------------
-- Tabela CIDADE
-- ---------------------------------------------------------------------
CREATE TABLE cidade (
    id_cidade  INT           NOT NULL AUTO_INCREMENT,
    nome       VARCHAR(100)  NOT NULL,
    uf         CHAR(2)       NOT NULL,
    CONSTRAINT pk_cidade PRIMARY KEY (id_cidade),
    CONSTRAINT uq_cidade_nome_uf UNIQUE (nome, uf)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabela CLIENTE
-- ---------------------------------------------------------------------
CREATE TABLE cliente (
    id_cliente     INT           NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(150)  NOT NULL,
    cpf_cnpj       VARCHAR(18)   NOT NULL,
    email          VARCHAR(150)  NULL,
    telefone       VARCHAR(20)   NULL,
    data_cadastro  DATE          NOT NULL DEFAULT (CURRENT_DATE),
    situacao       VARCHAR(10)   NOT NULL DEFAULT 'ATIVO',
    id_cidade      INT           NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_cpf_cnpj UNIQUE (cpf_cnpj),
    CONSTRAINT ck_cliente_situacao CHECK (situacao IN ('ATIVO','INATIVO')),
    CONSTRAINT fk_cliente_cidade FOREIGN KEY (id_cidade)
        REFERENCES cidade (id_cidade)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_cliente_nome   ON cliente (nome);
CREATE INDEX idx_cliente_cidade ON cliente (id_cidade);

-- ---------------------------------------------------------------------
-- Dados de exemplo (opcional)
-- ---------------------------------------------------------------------
INSERT INTO cidade (nome, uf) VALUES
    ('Aguai', 'SP'),
    ('São Paulo', 'SP'),
    ('Mogi Guaçu', 'MG'),
    ('Campinas', 'SP'),
    ('Belo Horizonte', 'MG');

INSERT INTO cliente (nome, cpf_cnpj, email, telefone, data_cadastro, situacao, id_cidade) VALUES
    ('Mario Reboucas', '123.456.789-09', 'maria@email.com', '(19) 99999-0001', '2026-11-01', 'ATIVO', 1),
    ('Reboucas Tech', '12.345.678/0001-95', 'contato@xyz.com', '(19) 3333-0002', '2026-11-05', 'ATIVO', 2),
    ('Mario Reboucas', '123.456.789-00', 'mario@email.com', '(19) 99999-0001', '2026-11-05', 'ATIVO', 2),
    ('Reboucas Tech', '12.345.678/0001-96', 'contato@reboucastech.com', '(19) 3333-0002', '2026-11-06', 'ATIVO', 1),
    ('Ana Paula Souza', '987.654.321-00', 'ana@email.com', '(11) 99999-0003', '2026-11-07', 'ATIVO', 3),
    ('Alpha Solutions', '23.456.789/0001-86', 'contato@alpha.com', '(19) 3333-0004', '2026-11-08', 'ATIVO', 2),
    ('Carlos Eduardo Lima', '321.654.987-00', 'carlos@email.com', '(21) 99999-0005', '2026-11-09', 'INATIVO', 4),
    ('Nova Era Digital', '34.567.890/0001-77', 'suporte@novaera.com', '(11) 4444-0006', '2026-11-10', 'ATIVO', 1),
    ('Fernanda Oliveira', '456.789.123-00', 'fernanda@email.com', '(31) 99999-0007', '2026-11-11', 'ATIVO', 5),
    ('TechVision Ltda', '45.678.901/0001-68', 'contato@techvision.com', '(21) 5555-0008', '2026-11-12', 'ATIVO', 3),
    ('Roberto Santos', '654.321.987-00', 'roberto@email.com', '(41) 99999-0009', '2026-11-13', 'ATIVO', 2),
    ('Inova Sistemas', '56.789.012/0001-59', 'info@inovasistemas.com', '(31) 6666-0010', '2026-11-14', 'INATIVO', 4);

-- Consulta de verificação
SELECT c.id_cliente, c.nome, c.cpf_cnpj, c.situacao, ci.nome AS cidade, ci.uf
FROM cliente c
JOIN cidade ci ON ci.id_cidade = c.id_cidade;
