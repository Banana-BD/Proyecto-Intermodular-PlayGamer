DROP DATABASE IF EXISTS  PlayGamer;
CREATE DATABASE IF NOT EXISTS PlayGamer;
USE PlayGamer;

CREATE TABLE Tienda (
                        ID_Tienda INT AUTO_INCREMENT,
                        Direccion VARCHAR(255) NOT NULL,
                        Horario VARCHAR(100),
                        PRIMARY KEY (ID_Tienda)
) ;

CREATE TABLE Categoria (
                           ID_Categoria INT AUTO_INCREMENT,
                           Nombre VARCHAR(100) NOT NULL,
                           Descripcion TEXT,
                           PRIMARY KEY (ID_Categoria)
) ;

CREATE TABLE Juegos (
                        Titulo VARCHAR(150),
                        Genero VARCHAR(100),
                        ID_Categoria INT,
                        Min_RAM VARCHAR(50),
                        PRIMARY KEY (Titulo),
                        FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
                            ON DELETE SET NULL ON UPDATE CASCADE
) ;

CREATE TABLE Equipos (
                         ID_Equipo INT AUTO_INCREMENT,
                         Nombre VARCHAR(100),
                         Plataforma VARCHAR(50),
                         Memoria_RAM VARCHAR(50),
                         Especialidad VARCHAR(100),
                         Precio_h DECIMAL(10, 2),
                         ID_Categoria INT,
                         ID_Tienda INT,
                         PRIMARY KEY (ID_Equipo),
                         FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
                             ON DELETE SET NULL ON UPDATE CASCADE,
                         FOREIGN KEY (ID_Tienda) REFERENCES Tienda(ID_Tienda)
                             ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE Empleados (
                           ID_Empleado INT AUTO_INCREMENT,
                           Nombre VARCHAR(100) NOT NULL,
                           Apellidos VARCHAR(150) NOT NULL,
                           DNI VARCHAR(20) UNIQUE NOT NULL,
                           Telefono VARCHAR(20),
                           N_Cuenta VARCHAR(30),
                           Puesto_De_Trabajo VARCHAR(100),
                           ID_Tienda INT,
                           PRIMARY KEY (ID_Empleado),
                           FOREIGN KEY (ID_Tienda) REFERENCES Tienda(ID_Tienda)
                               ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Cliente (
                         ID_Cliente INT AUTO_INCREMENT,
                         Nombre VARCHAR(100) NOT NULL,
                         Apellidos VARCHAR(150) NOT NULL,
                         IGN VARCHAR(100), -- In-Game Name / Nickname
                         Correo_Electronico VARCHAR(150) UNIQUE NOT NULL,
                         Contrasena VARCHAR(255) NOT NULL, -- Preparada para Hash (bcrypt/Argon2)
                         PRIMARY KEY (ID_Cliente)
);

CREATE TABLE Reservas (
                          ID_Reserva INT AUTO_INCREMENT,
                          ID_Cliente INT NOT NULL,
                          ID_Equipo INT NOT NULL,
                          Fecha_Reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          Horas_Reservadas INT NOT NULL DEFAULT 1,
                          Estado_Reserva VARCHAR(50) DEFAULT 'Activa', -- Ej: Activa, Completada, Cancelada
                          PRIMARY KEY (ID_Reserva),
                          FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
                              ON DELETE CASCADE ON UPDATE CASCADE,
                          FOREIGN KEY (ID_Equipo) REFERENCES Equipos(ID_Equipo)
                              ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Limpieza (
                          ID_Empleado INT,
                          Horario VARCHAR(100),
                          Equipo_Asociado_1 INT,
                          Equipo_Asociado_2 INT,
                          Equipo_Asociado_3 INT,
                          Limpia_Establecimiento_VF BOOLEAN, -- Representación de V/F (Verdadero/Falso)
                          Salario DECIMAL(10, 2),
                          PRIMARY KEY (ID_Empleado),
                          FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
                              ON DELETE CASCADE ON UPDATE CASCADE,
                          FOREIGN KEY (Equipo_Asociado_1) REFERENCES Equipos(ID_Equipo) ON DELETE SET NULL,
                          FOREIGN KEY (Equipo_Asociado_2) REFERENCES Equipos(ID_Equipo) ON DELETE SET NULL,
                          FOREIGN KEY (Equipo_Asociado_3) REFERENCES Equipos(ID_Equipo) ON DELETE SET NULL
);

CREATE TABLE Mantenimiento (
                               ID_Empleado INT,
                               Horario_Disponibilidad VARCHAR(100),
                               Plataforma_encargada VARCHAR(50),
                               Pago_Encargo DECIMAL(10, 2),
                               PRIMARY KEY (ID_Empleado),
                               FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
                                   ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla: Tienda
INSERT INTO Tienda (Direccion, Horario) VALUES
('Calle Gran Vía 45, Madrid', '10:00 - 22:00'),
('Avenida Diagonal 230, Barcelona', '12:00 - 00:00');

-- Tabla: Categoria
INSERT INTO Categoria (Nombre, Descripcion) VALUES
('Zona Pro Simulación', 'Simuladores de conducción con volantes Fanatec y asientos eSport.'),
('Zona PC Gaming', 'Ordenadores de gama alta equipados con RTX 4080 y pantallas de 240Hz.'),
('Zona Consolas', 'Puestos con PlayStation 5 y Xbox Series X en pantallas OLED de 55".');


-- ============================================================================
-- 2. INSERTS EN TABLAS CON DEPENDENCIAS SIMPLES
-- ============================================================================

-- Tabla: Juegos
INSERT INTO Juegos (Titulo, Genero, ID_Categoria, Min_RAM) VALUES
('Counter-Strike 2', 'Shooter / Competitivo', 2, '16GB'),
('Assetto Corsa Competizione', 'Simulación / Carreras', 1, '16GB'),
('EA Sports FC 26', 'Deportes', 3, '8GB');

-- Tabla: Equipos
-- Asignamos equipos a las tiendas (1 o 2) y a sus categorías correspondientes (1, 2 o 3)
INSERT INTO Equipos (Nombre, Plataforma, Memoria_RAM, Especialidad, Precio_h, ID_Categoria, ID_Tienda) VALUES
('Simulador Cockpit Alfa', 'PC', '32GB', 'Carreras / GT3', 7.50, 1, 1),
('PC Gaming Furia-01', 'PC', '32GB', 'eSports / FPS', 5.00, 2, 1),
('Puesto PS5 Ocupa-A', 'PS5', '16GB', 'Casual / Cooperativo', 4.00, 3, 2);

-- Tabla: Empleados
-- Empleados trabajando en la Tienda 1 o Tienda 2
INSERT INTO Empleados (Nombre, Apellidos, DNI, Telefono, N_Cuenta, Puesto_De_Trabajo, ID_Tienda) VALUES
('Carlos', 'Mendoza Ortiz', '12345678A', '+34600111222', 'ES2100491234567890123456', 'Supervisor Técnico', 1),
('Ana', 'Gómez Rovira', '87654321B', '+34600333444', 'ES2100499876543210987654', 'Personal de Limpieza', 1),
('David', 'López Vega', '45678912C', '+34600555666', 'ES2100494567891234567890', 'Técnico de Mantenimiento', 2);


-- ============================================================================
-- 3. INSERTS EN TABLAS CON RELACIONES ESPECIALES Y NUEVA ESTRUCTURA
-- ============================================================================

-- Tabla: Cliente
-- Las contraseñas están almacenadas usando hashes reales simulados de bcrypt
INSERT INTO Cliente (Nombre, Apellidos, IGN, Correo_Electronico, Contrasena) VALUES
('Alejandro', 'Ruiz Sanz', 'AlexPro99', 'alex.ruiz@email.com', '$2b$10$EpR7z74wBClp.1UExmbeI.9s8E2w6Nsh6GfW9k4T6g1vM0tL3Zp72'),
('Elena', 'Martínez Soler', 'Elenix', 'elena.mtz@email.com', '$2b$10$K7u8Hw2xMlO1zP9qR3sT5uVwXxYyZzAaBbCcDdEeFfGgHhIiJjKkL'),
('Marcos', 'Pérez Garrido', 'MarkShot', 'marcos.perez@email.com', '$2b$10$9zXyWvUtSrQpOnMlKjIhGfEdCbAnMzLxKyJxIxHxGxFxExDxCxBxA');

-- Tabla: Limpieza (Relación 1:1 con Empleados)
-- Ana Gómez (ID_Empleado: 2) se encarga de este rol
INSERT INTO Limpieza (ID_Empleado, Horario, Equipo_Asociado_1, Equipo_Asociado_2, Equipo_Asociado_3, Limpia_Establecimiento_VF, Salario) VALUES
(2, 'Mañana (08:00 - 14:00)', 1, 2, NULL, TRUE, 1250.00);

-- Tabla: Mantenimiento (Relación 1:1 con Empleados)
-- David López (ID_Empleado: 3) se encarga de este rol
INSERT INTO Mantenimiento (ID_Empleado, Horario_Disponibilidad, Plataforma_encargada, Pago_Encargo) VALUES
(3, 'Fines de semana / Tardes', 'PC / Servidores', 45.50);

-- Tabla: Reservas (La nueva tabla que creamos en el paso anterior)
INSERT INTO Reservas (ID_Cliente, ID_Equipo, Fecha_Reserva, Horas_Reservadas, Estado_Reserva) VALUES
(1, 1, '2026-06-05 17:00:00', 2, 'Activa'),      -- AlexPro99 reserva el simulador por 2 horas
(2, 3, '2026-06-05 18:30:00', 3, 'Activa'),      -- Elenix reserva la PS5 por 3 horas
(3, 2, '2026-06-04 10:00:00', 1, 'Completada');  -- MarkShot ya disfrutó de su hora en el PC Gaming