# Práctica 02: Conexiones Remotas y Gestión de Datos en MySQL

**Base de datos:** `db_test_7b`  
**Motor de base de datos:** MySQL Server  
**Tipo de conexión:** Remota mediante TCP/IP  
**Rama de desarrollo:** `Practica02`  
**Identificador del proyecto:** `240234`

## 1. Descripción general

En esta práctica se realizaron actividades de configuración y administración de conexiones remotas a un servidor MySQL mediante el protocolo TCP/IP. Se trabajó con la creación de usuarios, asignación de roles y configuración de privilegios para controlar el acceso a la base de datos.

También se desarrollaron operaciones de manipulación y consulta de información, así como pruebas para verificar los permisos y el funcionamiento de los diferentes perfiles de acceso.

## 2. Actividades desarrolladas

- **Configuración de conexiones remotas:** establecimiento de conexiones TCP/IP para acceder al servidor MySQL desde diferentes equipos.
- **Creación de usuarios:** registro de cuentas destinadas a la administración y manipulación de la información.
- **Administración de roles:** definición de perfiles con distintos niveles de acceso, de acuerdo con las responsabilidades de cada usuario.
- **Asignación de privilegios:** configuración de permisos para controlar las operaciones de consulta, inserción, actualización y eliminación.
- **Gestión de tablas:** trabajo con las tablas principales de la base de datos, incluyendo `tb_users`, `tb_products` y `tb_logs`.
- **Administración de usuarios:** configuración y comprobación de las cuentas creadas para los diferentes perfiles.
- **Gestión de productos:** inserción, consulta y actualización de registros mediante los permisos asignados.
- **Carga masiva de productos:** incorporación de 5,000 registros mediante el usuario vendedor correspondiente y preparación de operaciones complementarias para el segundo vendedor.
- **Auditoría de operaciones:** revisión de los registros generados en `tb_logs` para identificar las modificaciones realizadas.
- **Pruebas de acceso:** comprobación de la identidad de conexión, los roles activos y los privilegios disponibles para cada usuario.

## 3. Resultados

Se configuró un entorno de trabajo con conexiones remotas a MySQL y diferentes perfiles de acceso. Se realizaron pruebas de administración de usuarios, asignación de privilegios y manipulación de productos, incluyendo la carga masiva de información.

Además, se verificó el comportamiento de los permisos mediante consultas y operaciones de prueba, fortaleciendo el control de acceso y la administración de los datos almacenados en `db_test_7b`.
