/* ============================================================
   CREACIÓN DE USUARIOS
============================================================ */

CREATE USER IF NOT EXISTS 'Damari'@'%' IDENTIFIED BY '240234';
CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER IF NOT EXISTS 'Diego'@'%' IDENTIFIED BY '240709';
CREATE USER IF NOT EXISTS 'May'@'%' IDENTIFIED BY '240174';
CREATE USER IF NOT EXISTS 'jhona.leal'@'%' IDENTIFIED BY '240603';
CREATE USER IF NOT EXISTS 'oliver.arrioja'@'%' IDENTIFIED BY '240615';
CREATE USER IF NOT EXISTS 'mago.conffi'@'%' IDENTIFIED BY '240242';


/* ============================================================
   CREACIÓN DE ROLES
============================================================ */

CREATE ROLE IF NOT EXISTS 'super_admin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common_user';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* ============================================================
   ROL: SUPER_ADMIN
============================================================ */

GRANT ALL PRIVILEGES ON *.* TO 'super_admin' WITH GRANT OPTION;


/* ============================================================
   ROL: ADMIN
============================================================ */

GRANT ALL PRIVILEGES ON db_test_7b.* TO 'admin';


/* ============================================================
   ROL: SELLER
============================================================ */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* ============================================================
   ROL: BUYER
============================================================ */

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/* ============================================================
   ROL: SUPPORT (SELECT, INSERT, UPDATE en las 3 tablas)
============================================================ */

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_user
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_categories
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_product_categories
TO 'support';


/* ============================================================
   ROL: COMMON_USER
============================================================ */

GRANT SELECT
ON db_test_7b.*
TO 'common_user';


/* ============================================================
   ASIGNACIÓN DE ROLES A USUARIOS
============================================================ */

GRANT 'super_admin' TO 'Damari'@'%';
GRANT 'admin' TO 'marco.ramirez'@'%';
GRANT 'seller' TO 'Diego'@'%';
GRANT 'seller' TO 'May'@'%';
GRANT 'buyer' TO 'jhona.leal'@'%';
GRANT 'common_user' TO 'oliver.arrioja'@'%';
GRANT 'support' TO 'mago.conffi'@'%';


/* ============================================================
   CONFIGURACIÓN DE ROLES PREDETERMINADOS
============================================================ */

SET DEFAULT ROLE 'super_admin' TO 'Damari'@'%';
SET DEFAULT ROLE 'admin' TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'seller' TO 'Diego'@'%';
SET DEFAULT ROLE 'seller' TO 'May'@'%';
SET DEFAULT ROLE 'buyer' TO 'jhona.leal'@'%';
SET DEFAULT ROLE 'common_user' TO 'oliver.arrioja'@'%';
SET DEFAULT ROLE 'support' TO 'mago.conffi'@'%';

FLUSH PRIVILEGES;


/* ============================================================
   VERIFICACIÓN DE USUARIOS Y ROLES
============================================================ */

SELECT User, Host FROM mysql.user
WHERE User IN (
    'Damari', 'marco.ramirez', 'Diego', 'May', 'jhona.leal', 'oliver.arrioja', 'mago.conffi',
    'super_admin', 'admin', 'seller', 'buyer', 'support', 'common_user', 'user_not_registered'
);


/* ============================================================
   VERIFICACIÓN DE PRIVILEGIOS DE USUARIOS Y ROLES
============================================================ */

SHOW GRANTS FOR 'Damari'@'%';
SHOW GRANTS FOR 'marco.ramirez'@'%';
SHOW GRANTS FOR 'Diego'@'%';
SHOW GRANTS FOR 'May'@'%';
SHOW GRANTS FOR 'jhona.leal'@'%';
SHOW GRANTS FOR 'oliver.arrioja'@'%';
SHOW GRANTS FOR 'mago.conffi'@'%';

SHOW GRANTS FOR 'super_admin'@'%';
SHOW GRANTS FOR 'admin'@'%';
SHOW GRANTS FOR 'seller'@'%';
SHOW GRANTS FOR 'buyer'@'%';
SHOW GRANTS FOR 'support'@'%';
SHOW GRANTS FOR 'common_user'@'%';
SHOW GRANTS FOR 'user_not_registered'@'%';


/* ============================================================
   VERIFICACIÓN DE ASIGNACIÓN DE ROLES EN LA BASE DE DATOS
============================================================ */

SELECT
    TO_USER AS usuario,
    TO_HOST AS host,
    FROM_USER AS rol,
    FROM_HOST AS rol_host
FROM mysql.role_edges
WHERE TO_USER IN (
    'Damari', 'marco.ramirez', 'Diego', 'May', 'jhona.leal', 'oliver.arrioja', 'mago.conffi'
)
ORDER BY TO_USER, FROM_USER;

SHOW TABLES FROM db_test_7b;

SELECT 'Configuración completada exitosamente. El rol support cuenta con SELECT, INSERT y UPDATE sobre tb_user, tb_categories y tb_product_categories.' AS mensaje;