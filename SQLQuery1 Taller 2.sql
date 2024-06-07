CREATE DATABASE Libreria
GO

USE Libreria
GO

CREATE SCHEMA Catalogo
GO

CREATE SCHEMA Ventas
GO

CREATE TABLE Catalogo.Autores
(
	ID_Autor INT IDENTITY (1,5),
	Nombre_Autor VARCHAR (200),
	Apellido_Autor VARCHAR (200),
	CONSTRAINT PK_ID_AUTOR PRIMARY KEY (ID_Autor)
)
GO

CREATE TABLE Catalogo.Categorias
(
	ID_Categoria INT IDENTITY (2,4),
	Nombre_Categoria NVARCHAR (200) UNIQUE,
	CONSTRAINT PK_ID_CATEGORIA PRIMARY KEY (ID_Categoria)
)
GO

CREATE TABLE Catalogo.Libros
(
	ID_Libro INT IDENTITY (3,2),
	Titulo_Libro NVARCHAR (200),
	Autor_ID INT NOT NULL,
	Categoria_ID INT NOT NULL,
	Precio MONEY NOT NULL,
	CONSTRAINT PK_ID_LIBRO PRIMARY KEY (ID_Libro)
)
GO

CREATE TABLE Ventas.Clientes
(
	ID_Cliente INT IDENTITY (1,10),
	Nombre_Cliente VARCHAR (100),
	Apellido_Cliente VARCHAR (100),
	CORREO_Cliente NVARCHAR (200) UNIQUE,
	CONSTRAINT PK_ID_CLIENTE PRIMARY KEY (ID_Cliente)
)
GO

CREATE TABLE Ventas.Ventas
(
	ID_Venta INT IDENTITY (2,8),
	Cliente_ID INT NOT NULL,
	Fecha_Venta DATE NOT NULL,
	CONSTRAINT PK_ID_VENTA PRIMARY KEY (ID_Venta)
)
GO

CREATE TABLE Ventas.Detalle_Venta
(
	ID_Detalle INT IDENTITY (10,10),
	ID_Venta INT NOT NULL,
	ID_Libro INT NOT NULL,
	Cantidad_Venta INT NOT NULL,
	Precio_Venta MONEY NOT NULL,
	CONSTRAINT PK_ID_DETALLE PRIMARY KEY (ID_Detalle)
)
GO

----- DEFINIR RELACIONES

ALTER TABLE Catalogo.Libros
ADD CONSTRAINT FK_LIBRO_AUTOR FOREIGN KEY(Autor_ID)
REFERENCES Catalogo.Autores (ID_Autor)

ALTER TABLE Catalogo.Libros
ADD CONSTRAINT FK_CATEGORIAS FOREIGN KEY(Categoria_ID)
REFERENCES Catalogo.Categorias (ID_Categoria)

ALTER TABLE Ventas.Ventas
ADD CONSTRAINT FK_VENTAS_CLIENTES FOREIGN KEY(Cliente_ID)
REFERENCES Ventas.Clientes (ID_Cliente)

ALTER TABLE Ventas.Detalle_Venta
ADD CONSTRAINT FK_VENTAS_DETALLES FOREIGN KEY(ID_Venta)
REFERENCES Ventas.Ventas (ID_Venta)

ALTER TABLE Ventas.Detalle_Venta
ADD CONSTRAINT FK_LIBROS_DETALLES FOREIGN KEY(ID_Libro)
REFERENCES Catalogo.Libros (ID_Libro)

--- MODIFICAR NOMBRE DE COLUMNAS

SELECT * FROM Catalogo.Autores
SELECT * FROM Catalogo.Libros
SELECT * FROM Ventas.Detalle_Venta

EXEC sp_rename 'Catalogo.Autores.Apellido_Autor', 'Primer_Apellido_Autor', 'COLUMN';
EXEC sp_rename 'Catalogo.Autores.Nombre_Autor', 'Primer_Nombre_Autor', 'COLUMN';
EXEC sp_rename 'Catalogo.Libros.Precio', 'Valor_en_Pesos', 'COLUMN';

--- AÑADIR COLUMNAS A TABLAS

ALTER TABLE Catalogo.Autores
ADD Segundo_Nombre_Autor VARCHAR(200)

ALTER TABLE Catalogo.Autores
ADD Segundo_Apellido_Autor VARCHAR(200)

ALTER TABLE Ventas.Detalle_Venta
ADD Valor_Descuento Money

ALTER TABLE Ventas.Detalle_Venta
ADD Valor_Venta_Neta Money

--- AGREGAR DATOS A TABLAS

SELECT * FROM Catalogo.Autores
3
SELECT * FROM Catalogo.Categorias

SELECT * FROM Ventas.Clientes
SELECT * FROM Ventas.Detalle_Venta
SELECT * FROM Ventas.Ventas

INSERT INTO Catalogo.Autores (Primer_Nombre_Autor, Primer_Apellido_Autor, Segundo_Nombre_Autor, Segundo_Apellido_Autor)
VALUES
('Gabriel', 'Garcia', 'Jose', 'Marquez'),
('Jorge', 'Isaacs', 'Ricardo', 'Ferrer'),
('Jose', 'Pombo', 'Rafael', 'Rebolledo'),
('Jose', 'Rivera', 'Eustasio', 'Salas'),
('Marvel', 'Moreno', 'Luz', 'Abello'),
('Maria', 'Carranza', 'Mercedes', 'Coronado'),
('Evelio', 'Rosero', 'Jose', 'Diago'),
('Gloria', 'Esquivel', 'Susana', 'Gonzalez'),
('Maria', 'Restrepo', 'Cristina', 'Lopez'),
('Jose', 'Silva', 'Asuncion', 'Gomez')

INSERT INTO Catalogo.Categorias (Nombre_Categoria)
VALUES
('Narrativa'),
('Lirica'),
('Dramatica'),
('Periodismo'),
('Política'),
('Didactico'),
('Ensayos'),
('Infantil'),
('Academico'),
('Biografico')

INSERT INTO Catalogo.Libros (Titulo_Libro, Autor_ID, Categoria_ID, Valor_en_Pesos)
VALUES
('Cien años de soledad', 1, 2, 150000),
('Relato de un Naufrago', 1, 2, 120000),
('La Maria', 6, 10, 80000),
('Tierra de promision', 16, 6, 70000),
('La Voragine', 16, 2, 105000),
('Simon el bobito', 11, 30, 50000),
('Pelea en el parque', 31, 30, 80000),
('Vainas y otros poemas', 26,6, 92000),
('Jorge Isaacs', 41, 38, 70000),
('De Sobremesa', 46, 2, 95000)

INSERT INTO Ventas.Clientes(Nombre_Cliente, Apellido_Cliente, CORREO_Cliente)
VALUES
('Alejandro', 'Corredor', 'alejandro@gmail.com'),
('Daniela', 'Ardila', 'Daniela@gmail.com'),
('Laura', 'Gomez', 'laura@gmail.com'),
('Alba', 'Arias', 'alba@gmail.com'),
('Jorge', 'Landazabal', 'jorge@gmail.com'),
('Gloria', 'Estupiñan', 'gloria@gmail.com'),
('Carmen', 'Arciniegas', 'carmen@gmail.com'),
('Edgar', 'Corredor', 'edgar@gmail.com'),
('Jorge', 'Gavassa', 'gavassa@gmail.com'),
('Antonio', 'Hernandez', 'antonio@gmail.com')

INSERT INTO Ventas.Ventas (Cliente_ID, Fecha_Venta)
VALUES
(11, '2024-05-31'),
(21, '2024-06-01'),
(41, '2024-05-15'),
(1, '2024-05-25'),
(11, '2024-05-28'),
(21, '2024-05-16'),
(51, '2024-05-30'),
(1, '2024-05-21'),
(71, '2024-05-30'),
(61, '2024-06-01')

INSERT INTO Ventas.Detalle_Venta (ID_Venta, ID_Libro, Cantidad_Venta, Precio_Venta, Valor_Descuento, Valor_Venta_Neta)
VALUES
(2, 3, 4, 600000, 10000, 590000),
(10, 5, 3, 360000, 5000, 355000),
(18, 7, 10, 800000, 20000, 780000),
(26, 11, 2, 210000, 0, 210000),
(34, 3, 1, 150000, 0, 150000),
(42, 13, 5, 250000, 5000, 245000),
(50, 9, 20, 1400000, 50000, 1350000),
(58, 15, 10, 800000, 20000, 780000),
(66, 17, 4, 368000, 5000, 363000),
(74, 21, 1, 95000, 0, 95000)