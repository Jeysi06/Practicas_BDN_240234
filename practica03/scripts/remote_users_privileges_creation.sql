
/*
============================================================
CREACIÓN DE USUARIOS, ROLES Y PRIVILEGIOS
BASE DE DATOS: db_test_7b
============================================================
*/

USE db_test_7b;


/*
============================================================
1. CREACIÓN DE USUARIOS
============================================================
*/

CREATE USER IF NOT EXISTS 'Damari'@'%'
IDENTIFIED BY '240234';

CREATE USER IF NOT EXISTS 'marco.ramirez'@'%'
IDENTIFIED BY 'qwerty123';

CREATE USER IF NOT EXISTS 'Diego'@'%'
IDENTIFIED BY '240709';

CREATE USER IF NOT EXISTS 'May'@'%'
IDENTIFIED BY '240174';

CREATE USER IF NOT EXISTS 'jhona.leal'@'%'
IDENTIFIED BY '240603';

CREATE USER IF NOT EXISTS 'oliver.arrioja'@'%'
IDENTIFIED BY '240615';

CREATE USER IF NOT EXISTS 'mago.conffi'@'%'
IDENTIFIED BY '240242';


/*
============================================================
2. CREACIÓN DE USUARIOS PARA MIDDLEWARE
============================================================
*/

CREATE USER IF NOT EXISTS 'app_web'@'%'
IDENTIFIED BY 'web123';

CREATE USER IF NOT EXISTS 'app_mobile'@'%'
IDENTIFIED BY 'mobile890';


/*
============================================================
3. VERIFICAR QUE LOS USUARIOS EXISTEN
============================================================
*/

SELECT User, Host
FROM mysql.user
WHERE User IN (
    'Damari',
    'marco.ramirez',
    'Diego',
    'May',
    'jhona.leal',
    'oliver.arrioja',
    'mago.conffi',
    'app_web',
    'app_mobile'
);


/*
============================================================
4. CREACIÓN DE ROLES
============================================================
*/

CREATE ROLE IF NOT EXISTS 'super_admin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common_user';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/*
============================================================
5. VERIFICAR QUE LOS ROLES EXISTEN
============================================================
*/

SELECT User, Host
FROM mysql.user
WHERE User IN (
    'super_admin',
    'admin',
    'seller',
    'buyer',
    'support',
    'common_user',
    'user_not_registered'
);


/*
============================================================
6. PRIVILEGIOS DE SUPER ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON *.*
TO 'super_admin'
WITH GRANT OPTION;


/*
============================================================
7. PRIVILEGIOS DE ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'admin';


/*
============================================================
8. PRIVILEGIOS DE SELLER
============================================================
*/

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/*
============================================================
9. PRIVILEGIOS DE SUPPORT
============================================================

MAGO TIENE ACCESO A LAS TABLAS DE GESTIÓN DE USUARIOS,
PERSONAS, DIRECCIONES Y CATEGORÍAS.

PUEDE:
- SELECT
- INSERT
- UPDATE

NO PUEDE:
- DELETE
- MODIFICAR TB_PRODUCTS
============================================================
*/

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_users
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_people
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_user_addresses
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_categories
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_product_categories
TO 'support';


/*
============================================================
10. PRIVILEGIOS DE BUYER
============================================================
*/

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/*
============================================================
11. PRIVILEGIOS DE COMMON_USER
============================================================
*/

GRANT SELECT
ON db_test_7b.*
TO 'common_user';


/*
============================================================
12. PRIVILEGIOS DE USER_NOT_REGISTERED
============================================================

PUEDE:
- CONSULTAR PRODUCTOS.
- EJECUTAR EL PROCEDIMIENTO DE REGISTRO.

NO TIENE PERMISOS GENERALES DE INSERCIÓN,
ACTUALIZACIÓN O ELIMINACIÓN.
============================================================
*/

GRANT SELECT
ON db_test_7b.tb_products
TO 'user_not_registered';

GRANT EXECUTE
ON PROCEDURE db_test_7b.sp_register_new_user
TO 'user_not_registered';


/*
============================================================
13. ASIGNACIÓN DE ROLES A LOS USUARIOS
============================================================
*/


/* SUPER ADMIN — DAMARI */

GRANT 'super_admin'
TO 'Damari'@'%';


/* ADMIN — MARCO */

GRANT 'admin'
TO 'marco.ramirez'@'%';


/* SELLER 1 — DIEGO */

GRANT 'seller'
TO 'Diego'@'%';


/* SELLER 2 — MAY */

GRANT 'seller'
TO 'May'@'%';


/* BUYER — JHONA */

GRANT 'buyer'
TO 'jhona.leal'@'%';


/* COMMON USER — OLIVER */

GRANT 'common_user'
TO 'oliver.arrioja'@'%';


/* SUPPORT — MAGO */

GRANT 'support'
TO 'mago.conffi'@'%';


/*
============================================================
14. ASIGNACIÓN DE ROLES A LOS USUARIOS DE MIDDLEWARE
============================================================
*/

GRANT 'user_not_registered'
TO 'app_web'@'%';

GRANT 'user_not_registered'
TO 'app_mobile'@'%';


/*
============================================================
15. ESTABLECER ROLES PREDETERMINADOS
============================================================
*/


/* DAMARI — SUPER ADMIN */

SET DEFAULT ROLE 'super_admin'
TO 'Damari'@'%';


/* MARCO — ADMIN */

SET DEFAULT ROLE 'admin'
TO 'marco.ramirez'@'%';


/* DIEGO — SELLER */

SET DEFAULT ROLE 'seller'
TO 'Diego'@'%';


/* MAY — SELLER */

SET DEFAULT ROLE 'seller'
TO 'May'@'%';


/* JHONA — BUYER */

SET DEFAULT ROLE 'buyer'
TO 'jhona.leal'@'%';


/* OLIVER — COMMON USER */

SET DEFAULT ROLE 'common_user'
TO 'oliver.arrioja'@'%';


/* MAGO — SUPPORT */

SET DEFAULT ROLE 'support'
TO 'mago.conffi'@'%';


/* APP WEB — USER NOT REGISTERED */

SET DEFAULT ROLE 'user_not_registered'
TO 'app_web'@'%';


/* APP MOBILE — USER NOT REGISTERED */

SET DEFAULT ROLE 'user_not_registered'
TO 'app_mobile'@'%';


/*
============================================================
16. VERIFICACIÓN DE PRIVILEGIOS DE LOS USUARIOS
============================================================
*/

SHOW GRANTS FOR 'Damari'@'%';

SHOW GRANTS FOR 'marco.ramirez'@'%';

SHOW GRANTS FOR 'Diego'@'%';

SHOW GRANTS FOR 'May'@'%';

SHOW GRANTS FOR 'jhona.leal'@'%';

SHOW GRANTS FOR 'oliver.arrioja'@'%';

SHOW GRANTS FOR 'mago.conffi'@'%';

SHOW GRANTS FOR 'app_web'@'%';

SHOW GRANTS FOR 'app_mobile'@'%';


/*
============================================================
17. VERIFICACIÓN DE PRIVILEGIOS DE LOS ROLES
============================================================
*/

SHOW GRANTS FOR 'super_admin';

SHOW GRANTS FOR 'admin';

SHOW GRANTS FOR 'seller';

SHOW GRANTS FOR 'buyer';

SHOW GRANTS FOR 'support';

SHOW GRANTS FOR 'common_user';

SHOW GRANTS FOR 'user_not_registered';


/*
============================================================
18. VERIFICACIÓN DE USUARIOS Y ROLES ASIGNADOS
============================================================
*/

SELECT
    FROM_USER AS rol,
    FROM_HOST AS rol_host,
    TO_USER AS usuario,
    TO_HOST AS usuario_host
FROM mysql.role_edges
WHERE TO_USER IN (
    'Damari',
    'marco.ramirez',
    'Diego',
    'May',
    'jhona.leal',
    'oliver.arrioja',
    'mago.conffi',
    'app_web',
    'app_mobile'
)
ORDER BY TO_USER, FROM_USER;


/*
============================================================
19. VERIFICACIÓN DE ROLES PREDETERMINADOS
============================================================
*/

SELECT
    USER,
    HOST,
    DEFAULT_ROLE_USER,
    DEFAULT_ROLE_HOST
FROM mysql.default_roles
WHERE USER IN (
    'Damari',
    'marco.ramirez',
    'Diego',
    'May',
    'jhona.leal',
    'oliver.arrioja',
    'mago.conffi',
    'app_web',
    'app_mobile'
)
ORDER BY USER;


/*
============================================================
20. VERIFICACIÓN ESPECÍFICA DE MAGO
============================================================
*/

SHOW GRANTS FOR 'mago.conffi'@'%';


/*
============================================================
21. VERIFICACIÓN DE LOS PRIVILEGIOS DE SUPPORT
============================================================
*/

SHOW GRANTS FOR 'support';


/*
============================================================
22. VERIFICACIÓN DEL ROL USER_NOT_REGISTERED
============================================================
*/

SHOW GRANTS FOR 'user_not_registered';


/*
============================================================
23. VERIFICACIÓN DE LA EXISTENCIA DE LAS TABLAS
============================================================
*/

SHOW TABLES
FROM db_test_7b;


/*
============================================================
24. VERIFICACIÓN DEL PROCEDIMIENTO ALMACENADO
============================================================
*/

SHOW PROCEDURE STATUS
WHERE Db = 'db_test_7b'
AND Name = 'sp_register_new_user';


/*
============================================================
25. MENSAJE DE CONFIRMACIÓN
============================================================
*/

SELECT
    'Los usuarios, roles y privilegios han sido configurados. Se incorporaron los usuarios de middleware, el procedimiento de registro y los permisos adicionales de support.'
    AS mensaje;
