/*
============================================================
CREACIÓN DE USUARIOS
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
VERIFICAR QUE LOS USUARIOS EXISTEN
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
    'mago.conffi'
);


/*
============================================================
CREACIÓN DE ROLES
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
VERIFICAR QUE LOS ROLES EXISTEN
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
PRIVILEGIOS DE SUPER ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON *.*
TO 'super_admin'
WITH GRANT OPTION;


/*
============================================================
PRIVILEGIOS DE ADMIN
============================================================
*/

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'admin';


/*
============================================================
PRIVILEGIOS DE SELLER
============================================================
*/

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/*
============================================================
PRIVILEGIOS DE SUPPORT
============================================================

MAGO SOLO PUEDE TRABAJAR CON tb_users.

Puede:
- SELECT
- INSERT
- UPDATE

No puede:
- DELETE
- Acceder/modificar tb_products
============================================================
*/

GRANT SELECT, INSERT, UPDATE
ON db_test_7b.tb_user
TO 'support';


/*
============================================================
PRIVILEGIOS DE BUYER
============================================================
*/

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/*
============================================================
PRIVILEGIOS DE COMMON_USER
============================================================
*/

GRANT SELECT
ON db_test_7b.*
TO 'common_user';


/*
============================================================
ASIGNACIÓN DE ROLES A LOS USUARIOS
============================================================
*/


/*
SUPER ADMIN — DAMARI
*/

GRANT 'super_admin'
TO 'Damari'@'%';


/*
ADMIN — MARCO
*/

GRANT 'admin'
TO 'marco.ramirez'@'%';


/*
SELLER 1 — DIEGO
*/

GRANT 'seller'
TO 'Diego'@'%';


/*
SELLER 2 — MAY
*/

GRANT 'seller'
TO 'May'@'%';


/*
BUYER — JHONA
*/

GRANT 'buyer'
TO 'jhona.leal'@'%';


/*
COMMON USER — OLIVER
*/

GRANT 'common_user'
TO 'oliver.arrioja'@'%';


/*
SUPPORT — MAGO
*/

GRANT 'support'
TO 'mago.conffi'@'%';


/*
============================================================
ESTABLECER ROLES PREDETERMINADOS
============================================================
*/


/*
DAMARI — SUPER ADMIN
*/

SET DEFAULT ROLE 'super_admin'
TO 'Damari'@'%';


/*
MARCO — ADMIN
*/

SET DEFAULT ROLE 'admin'
TO 'marco.ramirez'@'%';


/*
DIEGO — SELLER
*/

SET DEFAULT ROLE 'seller'
TO 'Diego'@'%';


/*
MAY — SELLER
*/

SET DEFAULT ROLE 'seller'
TO 'May'@'%';


/*
JHONA — BUYER
*/

SET DEFAULT ROLE 'buyer'
TO 'jhona.leal'@'%';


/*
OLIVER — COMMON USER
*/

SET DEFAULT ROLE 'common_user'
TO 'oliver.arrioja'@'%';


/*
MAGO — SUPPORT
*/

SET DEFAULT ROLE 'support'
TO 'mago.conffi'@'%';


/*
============================================================
VERIFICACIÓN DE PRIVILEGIOS DE LOS USUARIOS
============================================================
*/

SHOW GRANTS FOR 'Damari'@'%';

SHOW GRANTS FOR 'marco.ramirez'@'%';

SHOW GRANTS FOR 'Diego'@'%';

SHOW GRANTS FOR 'May'@'%';

SHOW GRANTS FOR 'jhona.leal'@'%';

SHOW GRANTS FOR 'oliver.arrioja'@'%';

SHOW GRANTS FOR 'mago.conffi'@'%';


/*
============================================================
VERIFICACIÓN DE PRIVILEGIOS DE LOS ROLES
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
VERIFICACIÓN DE USUARIOS Y ROLES
============================================================
*/

SELECT
    TO_USER AS usuario,
    TO_HOST AS host,
    FROM_USER AS rol,
    FROM_HOST AS rol_host
FROM mysql.role_edges
WHERE TO_USER IN (
    'Damari',
    'marco.ramirez',
    'Diego',
    'May',
    'jhona.leal',
    'oliver.arrioja',
    'mago.conffi'
)
ORDER BY TO_USER, FROM_USER;


/*
============================================================
VERIFICAR ESPECÍFICAMENTE A MAGO
============================================================
*/

SHOW GRANTS FOR 'mago.conffi'@'%';


/*
============================================================
VERIFICAR LOS PRIVILEGIOS DE SUPPORT
============================================================
*/

SHOW GRANTS FOR 'support';


/*
============================================================
VERIFICAR QUE MAGO PUEDE TRABAJAR CON TB_USERS
============================================================

Debe tener:
SELECT
INSERT
UPDATE

============================================================
*/


/*
============================================================
VERIFICAR LA EXISTENCIA DE TB_USERS
============================================================
*/

SHOW TABLES
FROM db_test_7b;


/*
============================================================
MENSAJE DE CONFIRMACIÓN
============================================================
*/

SELECT
    'Los usuarios, roles y privilegios han sido creados correctamente. Mago tiene el rol support y acceso únicamente a tb_users.'
    AS mensaje;
