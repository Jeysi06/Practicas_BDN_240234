# Práctica 04 — Simulación de compras en una base de datos E-Commerce

**Estudiante:** Jeysi Damari Lara Cruz  
**Matrícula:** `240234`  
**Rama de trabajo:** `practica04`  
**Base de datos:** `db_test_7b` (MySQL 8)  
**Herramientas:** MySQL CMD, MySQL Workbench, Visual Studio Code, Git y GitHub.  
**Repositorio:** [Practicas_BDN_240234](https://github.com/Jeysi06/Practicas_BDN_240234)

## 1. Descripción

Se documentaron cinco simulaciones de compras en una base de datos relacional: carritos, órdenes, proveedores, métodos de pago, transacciones, entregas, reclamaciones, reembolsos y cancelaciones por inventario insuficiente.

## 2. Casos de prueba

| Caso | Comprador | Carrito | Órdenes | Resultado |
|---|---:|---:|---|---|
| 1. Compra exitosa | 7524 | 9 | 3 | Pago aprobado, entrega completada |
| 2. Reclamación y reenvío | 3369 | 10 | 4, 5, 6 | Tres vendedores, 18 pagos y reenvío |
| 3. Cancelación parcial | 5953 | 11 | 7 | Reembolso de $1,699.00 y entrega |
| 4. Recolección | 1640 | 12 | 8 | DHL: intento fallido + recolección |
| 5. Inventario insuficiente | 3749 | 13 | 9 | Pago rechazado, orden cancelada |

**Caso 2 — ¿Por qué tres órdenes?** Hay un comprador (3369) y un carrito (10), pero sus diez productos corresponden a tres proveedores distintos (7525, 7526 y 7527). Se creó una orden por proveedor: 4 por $41,088.00; 5 por $12,253.45 y 6 por $1,407.00.

**Caso 3:** pago Spin por $5,294.00; cancelación de la webcam y reembolso de $1,699.00; subtotal final $3,595.00.  
**Caso 4:** pago SPEI de $25,194.00, entrega domiciliaria fallida y recolección simulada.  
**Caso 5:** producto 73 sin existencias, pago 22 rechazado, orden 9 cancelada, cupón 5 activo (esto no confirma saldo restituido).

## 3. Trazabilidad y auditoría

- [Vista del Caso 1](#consultas-de-verificación): `vw_trazabilidad_caso1`.
- [Vista del Caso 2](#consultas-de-verificación): `vw_trazabilidad_caso2`.
- Caso 3: `vw_practica04_caso_3` — 26 movimientos (`80016`–`80041`).
- Caso 4: `vw_practica04_caso_4` — 21 movimientos (`80042`–`80062`).
- Caso 5: `vw_practica04_caso_5` — 13 movimientos (`80063`–`80075`).

La tabla `tb_logs` guarda la tabla y el registro afectado mediante `table_name` y `record_id`. **No son claves foráneas**: en el diagrama se representan como **24 enlaces lógicos de auditoría**, con líneas doradas discontinuas que se pueden mostrar u ocultar. Las claves foráneas reales siguen siendo **36**.

Los roles y conexiones mostrados en las vistas documentan el procedimiento; algunos `db_user` guardados por los triggers aparecen como `root@localhost`, sin que ello pruebe la conexión usada originalmente.

## 4. Catálogo reducido para la documentación

Se creó una **copia de respaldo de prueba** con **11,000 productos**, reducida desde los 15,014 originales. Se eliminaron 4,014 productos no utilizados y 4,296 asociaciones dependientes en `tb_product_categories`, manteniendo los registros de todos los casos, incluidos los productos 73 y 11540.

El respaldo reducido conserva **25 tablas, 189 columnas, 36 claves foráneas, 41 vistas, 72 triggers, 3 procedimientos** y **78,854 registros de datos exportados**. La tabla `tbd_order_items` tiene 22 registros (dato corregido respecto a una versión anterior del diccionario).

El historial `tb_logs` se conserva íntegro: puede registrar operaciones históricas sobre productos que ya no forman parte del catálogo reducido. **No se cambió la base de datos MySQL instalada en tu equipo**.

## 5. Documentación y archivos

Los siguientes recursos permiten consultar la estructura y documentación de la base de datos `db_test_7b`, actualizada para la Práctica 04.

- [Diagrama Entidad-Relación Extendido (MERE)](https://jeysi06.github.io/Practicas_BDN_240234/practica04/docs/Diagrama_ER_Interactivo/)
- [Diccionario de datos](https://jeysi06.github.io/Practicas_BDN_240234/practica04/docs/Diccionario_Datos/)


**Nota de GitHub:** los archivos HTML se abren directamente en tu navegador o desde GitHub Pages. Al hacer clic en GitHub sobre `index.html` normalmente se muestra su código en vez de ejecutar el proyecto.

## 6. Consultas de verificación

```sql
SELECT * FROM db_test_7b.vw_trazabilidad_caso1;
SELECT * FROM db_test_7b.vw_trazabilidad_caso2;
SELECT * FROM db_test_7b.vw_practica04_caso_3 ORDER BY log_ID;
SELECT * FROM db_test_7b.vw_practica04_caso_4 ORDER BY log_ID;
SELECT * FROM db_test_7b.vw_practica04_caso_5 ORDER BY log_ID;
```

## 7. Resultados

Los cinco escenarios documentan el uso de usuarios, roles, proveedores, pagos, estados de órdenes y auditoría. Los envíos, métodos de pago y cupones son simulaciones académicas. Un pago rechazado no equivale a una deuda saldada, y un cupón activo no prueba devolución de saldo.
