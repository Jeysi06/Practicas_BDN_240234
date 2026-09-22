/* =========================================================
   CREACIÓN DE USUARIOS
   ========================================================= */

CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER IF NOT EXISTS 'Mayte.Gayosso'@'%' IDENTIFIED BY '240174';
CREATE USER IF NOT EXISTS 'Jeysi.Lara'@'%' IDENTIFIED BY '240234';
CREATE USER IF NOT EXISTS 'Diego_Garrido'@'%' IDENTIFIED BY '240080';


/* =========================================================
   VERIFICAR QUE LOS USUARIOS EXISTEN
   ========================================================= */

SELECT User, Host
FROM mysql.user
WHERE User IN (
    'marco.ramirez',
    'Mayte.Gayosso',
    'Jeysi.Lara',
    'Diego_Garrido'
);


/* =========================================================
   CREACIÓN DE ROLES
   ========================================================= */

CREATE ROLE IF NOT EXISTS 'super_admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* =========================================================
   VERIFICAR QUE LOS ROLES EXISTEN
   ========================================================= */

SELECT User, Host
FROM mysql.user
WHERE User IN (
    'super_admin',
    'seller',
    'buyer',
    'support',
    'common',
    'user_not_registered'
);


/* =========================================================
   PRIVILEGIOS DEL ROL SUPER ADMIN
   ========================================================= */

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'super_admin';


/* =========================================================
   PRIVILEGIOS DEL ROL SELLER
   ========================================================= */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* =========================================================
   PRIVILEGIOS DEL ROL SUPPORT
   ========================================================= */

GRANT SELECT, UPDATE, INSERT
ON db_test_7b.tb_users, db_test_7b.tb_products
TO 'support';


/* =========================================================
   PRIVILEGIOS DEL ROL BUYER
   ========================================================= */

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/* =========================================================
   PRIVILEGIOS DEL ROL COMMON
   ========================================================= */

GRANT SELECT
ON db_test_7b.tb_products
TO 'common';


/* =========================================================
   QUITAR PRIVILEGIOS DIRECTOS ANTERIORES
   ========================================================= */

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'Mayte.Gayosso'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'Jeysi.Lara'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'Diego_Garrido'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'marco.ramirez'@'%';


/* =========================================================
   ASIGNACIÓN DE ROLES A USUARIOS
   ========================================================= */

/* MAYTE = SUPER ADMIN */

GRANT 'super_admin'
TO 'Mayte.Gayosso'@'%';


/* DIEGO = SUPPORT */

GRANT 'support'
TO 'Diego_Garrido'@'%';


/* JEYSI = SELLER */

GRANT 'seller'
TO 'Jeysi.Lara'@'%';


/* =========================================================
   PERMISOS ADICIONALES PARA JEYSI
   ========================================================= */

/* JEYSI PUEDE CONSULTAR LOS LOGS */

GRANT SELECT
ON db_test_7b.tb_logs
TO 'Jeysi.Lara'@'%';


/* JEYSI PUEDE EJECUTAR PROCEDIMIENTOS */

GRANT EXECUTE
ON db_test_7b.*
TO 'Jeysi.Lara'@'%';


/* =========================================================
   ROLES POR DEFECTO
   ========================================================= */

SET DEFAULT ROLE 'super_admin'
TO 'Mayte.Gayosso'@'%';

SET DEFAULT ROLE 'support'
TO 'Diego_Garrido'@'%';

SET DEFAULT ROLE 'seller'
TO 'Jeysi.Lara'@'%';


/* =========================================================
   ACTUALIZAR PRIVILEGIOS
   ========================================================= */

FLUSH PRIVILEGES;


/* =========================================================
   COMPROBAR PRIVILEGIOS DE LOS USUARIOS
   ========================================================= */

SHOW GRANTS FOR 'Mayte.Gayosso'@'%';

SHOW GRANTS FOR 'Diego_Garrido'@'%';

SHOW GRANTS FOR 'Jeysi.Lara'@'%';

SHOW GRANTS FOR 'marco.ramirez'@'%';


/* =========================================================
   COMPROBAR PRIVILEGIOS DE LOS ROLES
   ========================================================= */

SHOW GRANTS FOR 'super_admin';

SHOW GRANTS FOR 'seller';

SHOW GRANTS FOR 'support';

SHOW GRANTS FOR 'buyer';

SHOW GRANTS FOR 'common';