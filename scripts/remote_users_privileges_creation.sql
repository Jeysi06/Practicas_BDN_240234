CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER IF NOT EXISTS 'Jeysi.Lara'@'%' IDENTIFIED BY '240234';
CREATE USER IF NOT EXISTS 'Jhon.leal'@'%' IDENTIFIED BY '240603';
CREATE USER IF NOT EXISTS 'may.gayosso'@'%' IDENTIFIED BY '240174';

/* VERIFICAR QUE LOS USUARIOS EXISTEN */
SELECT User, Host
FROM mysql.user
WHERE User IN ('marco.ramirez', 'Jeysi.Lara', 'Jhon.leal', 'may.gayosso');

/* Asignar los privilegios de super usuario IMPORTANTE: SOLO USTEDES!! */
GRANT ALL PRIVILEGES ON *.* TO 'Jeysi.Lara'@'%';

/* ASIGNAR PRIVILEGIOS DE SELECCION,INSERCIÓN,ACTUALIZACIÓN Y ELIMINACIÓN AL USUARIO DE IZQUIERDA */
GRANT SELECT, UPDATE, INSERT, DELETE ON db_test.* TO 'may.gayosso'@'%';

/* CREACIÓN DE ROLES PARA EL SISTEMA DE ECOMERCE */
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'user_not_registered';

/* VERIFICAR QUE LOS ROLES EXISTEN */
SELECT User, Host
FROM mysql.user
WHERE User IN ('admin', 'seller', 'buyer', 'support', 'common', 'user_not_registered');

/* ASIGNAR PRIVILEGIOS A LOS ROLES CREADOS */
-- Admin
GRANT ALL PRIVILEGES ON db_test.* TO 'admin';

-- Support
GRANT SELECT, UPDATE, INSERT ON db_test.* TO 'support';

/* ASIGNAR ROLES A LOS USUARIOS CREADOS */
GRANT 'admin' TO 'Jhon.leal'@'%';

GRANT 'support' TO 'may.gayosso'@'%';

/* VERIFICAR LOS PRIVILEGIOS DE LOS USUARIOS */
SHOW GRANTS FOR 'Jeysi.Lara'@'%';
SHOW GRANTS FOR 'Jhon.leal'@'%';
SHOW GRANTS FOR 'may.gayosso'@'%';
SHOW GRANTS FOR 'marco.ramirez'@'%';

/* VERIFICAR LOS PRIVILEGIOS DE LOS ROLES */
SHOW GRANTS FOR 'admin';
SHOW GRANTS FOR 'support';