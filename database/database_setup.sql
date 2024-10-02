CREATE DATABASE stepz;
USE stepz;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nome) VALUES ('Calçados'), ('Camisetas'), ('Bolsas');

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    tamanho VARCHAR(10),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    endereco TEXT NOT NULL,
    telefone VARCHAR(15)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalhes_pedido (
    id_detalhe INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE admins (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE carrinho (
    id_carrinho INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO produtos (nome, descricao, preco, estoque, id_categoria, tamanho)
VALUES
('Tênis Esportivo', 'Tênis esportivo confortável, tamanho 43', 299.90, 50, 1, '43'),  -- Categoria 1 = Calçados
('Camiseta Básica', 'Camiseta de algodão, tamanho M', 49.90, 100, 2, 'M'),           -- Categoria 2 = Camisetas
('Bolsa de Couro', 'Bolsa de couro tamanho único', 199.90, 20, 3, 'Único');          -- Categoria 3 = Bolsas

INSERT INTO clientes (nome, email, senha, endereco, telefone)
VALUES ('João Silva', 'joao.silva@example.com', 'senha_secreta', 'Rua Exemplo, 123, São Paulo, SP', '(11) 99999-9999');

INSERT INTO pedidos (id_cliente, total, status)
VALUES (1, 599.80, 'Pendente');  -- Total do pedido com dois pares de tênis é R$599,80

INSERT INTO detalhes_pedido (id_pedido, id_produto, quantidade, preco)
VALUES (1, 1, 2, 299.90);  -- Cliente comprou 2 pares de tênis (id_produto 1)

INSERT INTO admins (nome, email, senha)
VALUES ('Admin', 'admin@example.com', 'admin_senha');
