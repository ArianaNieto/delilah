CREATE DATABASE delilah;
USE delilah;

CREATE TABLE usuarios (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre_usuario VARCHAR(45) NOT NULL,
apellido_usuario VARCHAR(45) NOT NULL,
email VARCHAR(60) NOT NULL UNIQUE,
usuario VARCHAR(45) NOT NULL UNIQUE,
password VARCHAR(100) NOT NULL,
telefono VARCHAR(45) NOT NULL,
domicilio VARCHAR(100) NOT NULL,
isAdmin BIT(1) NOT NULL
);

CREATE TABLE platos (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(9,2) NOT NULL,
url_imagen VARCHAR(100),
disponible BIT(1) NOT NULL
);

CREATE TABLE estados (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
estado VARCHAR(45) NOT NULL
);

INSERT INTO estados (estado) VALUES ('nuevo');
INSERT INTO estados (estado) VALUES ('confirmado');
INSERT INTO estados (estado) VALUES ('preparando');
INSERT INTO estados (estado) VALUES ('enviando');
INSERT INTO estados (estado) VALUES ('cancelado');
INSERT INTO estados (estado) VALUES ('entregado');

CREATE TABLE formas_de_pago (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
forma_pago VARCHAR(45) NOT NULL
);
INSERT INTO formas_de_pago  (forma_pago) VALUES ('efectivo');
INSERT INTO formas_de_pago  (forma_pago) VALUES ('crédito');
INSERT INTO formas_de_pago  (forma_pago) VALUES ('débito');

CREATE TABLE pedidos (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_usuarios INT NOT NULL,
id_forma_pago INT NOT NULL,
id_estado INT NOT NULL DEFAULT 1,
hora TIME,
precio_total DECIMAL (9,2) NOT NULL,
pagado BIT(1) DEFAULT 1
);
ALTER TABLE pedidos
ADD CONSTRAINT FK_PEDIDOS_USUARIOS
FOREIGN KEY (id_usuarios) REFERENCES usuarios(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE pedidos
ADD CONSTRAINT FK_PEDIDOS_FORMA_PAGO
FOREIGN KEY (id_forma_pago) REFERENCES formas_de_pago(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE pedidos
ADD CONSTRAINT FK_PEDIDOS_ESTADO
FOREIGN KEY (id_estado) REFERENCES estados(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE TABLE detalle_pedido(
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_pedidos INT NOT NULL,
id_plato INT NOT NULL,
cantidad INT NOT NULL,
precio_subtotal DECIMAL(9,2) NOT NULL
);
ALTER TABLE detalle_pedido
ADD CONSTRAINT FK_DETALLE_PEDIDO_PEDIDOS  
FOREIGN KEY (id_pedidos) REFERENCES pedidos(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE detalle_pedido
ADD CONSTRAINT FK_DETALLE_PEDIDO_PLATOS
FOREIGN KEY (id_plato) REFERENCES platos(id)
ON UPDATE CASCADE
ON DELETE CASCADE;