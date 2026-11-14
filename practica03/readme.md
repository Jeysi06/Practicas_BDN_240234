# Práctica 03: Manipulación de Datos en Conexiones Remotas a Bases de Datos Relacionales

**Base de datos:** `db_test_7b`  
**Motor:** MySQL Server  
**Herramientas:** MySQL Workbench, Git, GitHub y Archify  
**Rama de desarrollo:** `Practica03`  
**Identificador del proyecto:** `240234`

## 1. Descripción general

En esta práctica se desarrolló la administración y manipulación de una base de datos relacional utilizando MySQL Server y conexiones remotas mediante TCP/IP.

El trabajo se enfocó en la implementación de una base de datos orientada a un entorno de comercio electrónico, incorporando estructuras para la gestión de usuarios, productos, categorías, vendedores, compradores, pedidos y demás operaciones relacionadas.

Asimismo, se implementaron mecanismos de seguridad, auditoría, automatización y generación de datos de prueba para comprobar el funcionamiento de la base de datos.

## 2. Actividades desarrolladas

- **Diseño y estructura de la base de datos:** creación e integración de tablas con sus respectivas claves primarias, claves foráneas, relaciones y restricciones.
- **Administración de usuarios y permisos:** creación de cuentas de acceso y configuración de roles para establecer distintos niveles de privilegios dentro de `db_test_7b`.
- **Control de acceso remoto:** configuración de usuarios y permisos para realizar operaciones mediante conexiones TCP/IP.
- **Auditoría de operaciones:** implementación de triggers para registrar las operaciones de inserción, actualización y eliminación en la tabla `tb_logs`.
- **Creación de vistas SQL:** desarrollo de vistas para consultar información de las entidades y facilitar el seguimiento de las operaciones realizadas en la base de datos.
- **Procedimientos almacenados y funciones:** implementación de rutinas para automatizar procesos, registrar información y generar datos de prueba.
- **Eventos programados:** configuración de eventos de MySQL para ejecutar tareas automatizadas cuando corresponda.
- **Carga masiva de información:** generación e inserción de datos de prueba para usuarios, productos y categorías, considerando la distribución de productos entre vendedores.
- **Validación de datos:** ejecución de consultas para comprobar registros, relaciones, permisos, operaciones de auditoría y funcionamiento de los objetos SQL.
- **Respaldos de la base de datos:** generación de copias de seguridad que permitan conservar la estructura, los registros y los objetos implementados.
- **Documentación técnica:** elaboración del Modelo Entidad-Relación Extendido (MERE) y del diccionario de datos mediante Archify.
- **Control de versiones:** organización y seguimiento de los archivos SQL y modificaciones del proyecto mediante Git y GitHub.

## 3. Organización del proyecto

La práctica se organiza mediante archivos SQL y recursos de documentación que permiten identificar y administrar los diferentes componentes de la base de datos.

Entre los elementos principales se consideran:

- Scripts de creación de tablas y relaciones.
- Scripts de creación de usuarios, roles y privilegios.
- Triggers y mecanismos de auditoría.
- Vistas para consultas y trazabilidad.
- Procedimientos almacenados y funciones.
- Eventos programados.
- Scripts de inserción y generación de datos.
- Consultas de validación.
- Respaldos de la base de datos.
- Documentación del MERE y diccionario de datos.

## 4. Documentación técnica

La documentación del proyecto se encuentra organizada para facilitar la consulta de la estructura y las características de la base de datos.

- **Modelo Entidad-Relación Extendido (MERE):** [Consultar diagrama de la base de datos](PEGA_AQUI_TU_ENLACE_DEL_MERE).
- **Diccionario de datos:** [Consultar diccionario de datos](PEGA_AQUI_TU_ENLACE_DEL_DICCIONARIO).
- **Repositorio de GitHub:** [Consultar código fuente y scripts SQL](PEGA_AQUI_TU_ENLACE_DE_GITHUB).


## 5. Resultados

Como resultado de la práctica, se desarrolló una base de datos relacional para un escenario de comercio electrónico, integrando mecanismos de administración de usuarios, control de privilegios, auditoría y automatización mediante objetos de MySQL.

También se trabajó con la carga masiva de datos de prueba, la administración de conexiones remotas y la validación de la información almacenada. Finalmente, se organizó el proyecto mediante control de versiones y documentación técnica, facilitando su mantenimiento y comprensión.

## 6. Tecnologías y herramientas utilizadas

| Tecnología o herramienta | Aplicación |
|---|---|
| MySQL Server | Administración y gestión de la base de datos |
| MySQL Workbench | Ejecución y validación de consultas SQL |
| Git | Control de versiones |
| GitHub | Almacenamiento y seguimiento del proyecto |
| Archify | Elaboración del MERE y diccionario de datos |
| TCP/IP | Conexiones remotas a MySQL |

---

**Proyecto académico:** Práctica 03 – Bases de Datos Relacionales  
**Base de datos:** `db_test_7b`  
**Identificador:** `240234`