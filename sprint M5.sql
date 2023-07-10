CREATE DATABASE rating;
USE rating;
CREATE USER 'admin'@'sprint_5' IDENTIFIED BY '123';
GRANT ALL ON en_que_puedo_ayudarte.* TO 'admin'@'sprint_5';

-- Creación de Tablas
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  edad TINYINT,
  correo_electronico VARCHAR(100) NOT NULL,
  veces_utilizada INT DEFAULT 1
);

CREATE TABLE operarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  edad TINYINT,
  correo_electronico VARCHAR(100) NOT NULL,
  veces_servido_soporte INT DEFAULT 1
);

CREATE TABLE soporte (
  id INT AUTO_INCREMENT PRIMARY KEY,
  operario_id INT,
  usuario_id INT,
  fecha DATE,
  calificacion TINYINT CHECK (calificacion >= 1 AND calificacion <= 7), -- De este modo se puede agregar un valor entre 1 y 7, de tipo entero. Generará un error si intenta agregar un valor no permitido en la restricción
  comentario VARCHAR(250),
  FOREIGN KEY (operario_id) REFERENCES operarios(id),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Insertar datos a las tablas
INSERT INTO usuarios (nombre, apellido, edad, correo_electronico, veces_utilizada)
VALUES
    ('Sofía', 'Hernández', 27, 'sofia@correo.com', 2),
    ('Carlos', 'González', 31, 'carlos@correo.com', 4),
    ('Laura', 'López', 29, 'laura@correo.com', 3),
    ('Andrés', 'Martínez', 22, 'andres@correo.com', 5),
    ('Marta', 'Pascal', 24, 'marta@correo.com', 1);

INSERT INTO operarios (nombre, apellido, edad, correo_electronico, veces_servido_soporte)
VALUES
    ('Luis', 'González', 19, 'luis@correo.com', 2),
    ('Ana', 'Sánchez', 30, 'ana@correo.com', 4),
    ('Pedro', 'Martínez', 25, 'pedro@correo.com', 1),
    ('María', 'López', 18, 'maria@correo.com', 1),
    ('Javier', 'Hernández', 27, 'javier@correo.com', 2);

INSERT INTO soporte (operario_id, usuario_id, fecha, calificacion, comentario)
VALUES
    (4, 5, "2023-06-15", 5, "Bien."),
    (2, 3, "2023-05-15", 6, "Muy amable."),
    (2, 2, "2023-03-12", 4, "No le entendía ni se escuchaba bien"),
    (1, 4, "2023-06-14", 7, "Super bien"),
    (5, 1, "2023-06-25", 3, "Mala atención"),
    (2, 5, "2023-06-21", 5, "Mas o menos."),
    (5, 4, "2023-06-22", 6, "Solucionó mi problema, pero muy lento"),
    (2, 2, "2023-05-22", 1, "Mal soporte."),
    (1, 3, "2023-03-11", 2, "No responde las dudas"),
    (3, 1, "2023-05-30", 7, "Solucionó mi problema");

-- Seleccione las 3 operaciones con mejor evaluación.
SELECT * FROM soporte
ORDER BY calificacion DESC
LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.
SELECT * from soporte
ORDER BY calificacion
LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.
SELECT * from operarios
ORDER BY veces_servido_soporte DESC
LIMIT 1;

-- Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT * from usuarios
ORDER BY veces_utilizada
LIMIT 1;

-- Agregue 10 años a los tres primeros usuarios registrados.
UPDATE usuarios
SET edad = edad + 10
LIMIT 3;

-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE usuarios
RENAME COLUMN correo_electronico TO email;

ALTER TABLE operarios
RENAME COLUMN correo_electronico TO email;

-- Seleccione solo los operarios mayores de 20 años.
SELECT * from operarios
WHERE edad > 20; 