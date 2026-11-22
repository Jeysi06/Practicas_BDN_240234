# Diccionario de Datos — db_test_7b

**Motor:** MySQL 8.0.44 (mysqldump 10.13)  
**Respaldo de referencia:** `respaldo211126_reducido_11000.sql`  
**SHA-256:** `a806c706ba8270da62cd0a1f814a798e4d8bb3dda1f602811831ea396163d759`  
**Charset / collation:** `utf8mb4` / `utf8mb4_0900_ai_ci`

**Resumen:** 25 tablas · 189 columnas · 36 claves foráneas · **78,854 registros** · 41 vistas · 72 triggers · 3 procedimientos.

## Alcance y verificación

Los registros por tabla son las filas incluidas en las sentencias `INSERT` del respaldo `respaldo211126_reducido_11000.sql`. No son consultas en vivo. Las descripciones son editoriales y se conservaron del proyecto original cuando siguen aplicando; se ajustaron según los nombres y relaciones del respaldo. No se ejecutó SQL ni se modificó la base de datos.

## Registros por tabla

| Tabla | Grupo | Columnas | Registros |
|---|---|---:|---:|
| [tb_logs](#tb_logs) | tb | 8 | 41,161 |
| [tb_product_categories](#tb_product_categories) | tb | 5 | 11,423 |
| [tb_products](#tb_products) | tb | 9 | 11,000 |
| [tb_users](#tb_users) | tb | 8 | 7,523 |
| [tb_people](#tb_people) | tb | 12 | 7,506 |
| [tbc_categories](#tbc_categories) | tbc | 7 | 100 |
| [tb_payment_transaction](#tb_payment_transaction) | tb | 7 | 22 |
| [tb_payments](#tb_payments) | tb | 8 | 22 |
| [tbd_carts_items](#tbd_carts_items) | tbd | 7 | 22 |
| [tbd_order_items](#tbd_order_items) | tbd | 10 | 22 |
| [tbd_products_users_providers](#tbd_products_users_providers) | tbd | 8 | 12 |
| [tb_orders](#tb_orders) | tb | 11 | 7 |
| [tb_shipments](#tb_shipments) | tb | 8 | 7 |
| [tbc_payment_methods_types](#tbc_payment_methods_types) | tbc | 6 | 6 |
| [tb_carts](#tb_carts) | tb | 5 | 5 |
| [tb_user_addresses](#tb_user_addresses) | tb | 9 | 5 |
| [tbd_user_payment_methods](#tbd_user_payment_methods) | tbd | 8 | 5 |
| [tb_order_cancellations](#tb_order_cancellations) | tb | 7 | 2 |
| [tb_refunds](#tb_refunds) | tb | 6 | 1 |
| [tb_returns](#tb_returns) | tb | 7 | 1 |
| [tbd_cancellation_items](#tbd_cancellation_items) | tbd | 7 | 1 |
| [tbd_return_items](#tbd_return_items) | tbd | 7 | 1 |
| [tb_payment_methods](#tb_payment_methods) | tb | 6 | 0 |
| [tbd_address_components](#tbd_address_components) | tbd | 8 | 0 |
| [tbd_users_wishlist_products](#tbd_users_wishlist_products) | tbd | 5 | 0 |

**Total:** 25 tablas · 189 columnas · 78,854 registros.

## Vinculación lógica de la bitácora `tb_logs` (no es FOREIGN KEY)

La tabla `tb_logs` **no tiene claves foráneas**. Sus columnas `table_name` y `record_id` permiten identificar lógicamente el registro que originó un evento; el tipo de tabla de destino cambia de una fila a otra. Por ese motivo, no existe una única referencia declarable como `FOREIGN KEY`. El diagrama muestra **24 vínculos dorados discontinuos** como referencia de auditoría, separados de las **36 claves foráneas reales**. Las líneas no implican integridad referencial automática.

- `tb_logs.table_name`: tabla afectada.
- `tb_logs.record_id`: identificador del registro en esa tabla (habitualmente `ID`).
- `tb_logs.db_user`: usuario almacenado por la auditoría; puede reflejar el contexto del trigger.
- Los registros históricos pueden referirse a productos que ya no se incluyen en la copia reducida del catálogo.

## Tablas y columnas

DEFAULT «—» significa que no se declara valor predeterminado. PK = clave primaria, FK = clave foránea, UQ = valor único.

### tb_carts

- **Descripción:** Carrito de compras de cada usuario; el índice único por usuario permite un solo carrito por cuenta.
- **Registros:** 5
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 14

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del carrito. |
| user_ID | `int` | No | `—` | FK · UQ | tb_users.ID | — | Usuario propietario del carrito (único por usuario). |
| status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uk_cart_user (user_ID) UNIQUE; uk_cart_owner (user_ID, ID) UNIQUE  
**Claves foráneas:** tb_carts_ibfk_1: (user_ID) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_carts_ai, trg_tb_carts_au, trg_tb_carts_ad  

### tb_logs

- **Descripción:** Bitácora de auditoría: registra las operaciones Create, Read, Update y Delete realizadas sobre las tablas, con el usuario de base de datos y la fecha.
- **Registros:** 41,161
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 80076

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del registro de bitácora. |
| table_name | `varchar(80)` | No | `—` | — | — | — | Nombre de la tabla sobre la que se registró la operación. |
| record_id | `int unsigned` | Sí | `NULL` | — | — | — | ID del registro afectado en la tabla indicada; no tiene clave foránea porque apunta a distintas tablas. |
| table_operation | `enum('Create','Read','Update','Delete')` | Sí | `NULL` | — | — | — | Tipo de operación registrada: Create, Read, Update o Delete. |
| db_user | `varchar(80)` | No | `—` | — | — | — | Usuario de base de datos (y host) que ejecutó la operación. |
| table_description | `text` | No | `—` | — | — | — | Texto con el detalle de la operación registrada. |
| operation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora en que se registró la operación. |
| operation_status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado de la operación registrada (1 por defecto). |

**Índices:** idx_logs_table_record_operation (table_name, record_id, table_operation); idx_logs_table_operation_date (table_name, table_operation, operation_date); idx_logs_db_user_date (db_user, operation_date)  
**Claves foráneas:** ninguna declarada  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** ninguno  

### tb_order_cancellations

- **Descripción:** Solicitudes de cancelación de una orden, con el usuario que la pide, el motivo y el estado del trámite.
- **Registros:** 2
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 3

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la solicitud de cancelación. |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden que se desea cancelar. |
| requested_by | `int` | No | `—` | FK | tb_users.ID | — | Usuario que solicita la cancelación. |
| reason | `text` | No | `—` | — | — | — | Motivo de la cancelación. |
| status | `enum('Requested','Approved','Rejected','Completed')` | No | `'Requested'` | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_order_cancellations_order (order_ID); fk_order_cancellations_user (requested_by)  
**Claves foráneas:** fk_order_cancellations_order: (order_ID) → tb_orders(ID); fk_order_cancellations_user: (requested_by) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_order_cancellations_ai, trg_tb_order_cancellations_au, trg_tb_order_cancellations_ad  

### tb_orders

- **Descripción:** Órdenes de venta de un vendedor, con subtotal, costo de envío y estado de cumplimiento.
- **Registros:** 7
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 10

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la orden. |
| seller_ID | `int` | No | `—` | FK | tb_users.ID | — | Usuario vendedor al que pertenece la orden. |
| buyer_ID | `int` | No | `—` | FK | tb_user_addresses.user_id, tb_carts.user_ID | — | Identificador del usuario comprador asociado a la orden. |
| cart_ID | `int unsigned` | No | `—` | FK | tb_carts.ID | — | Carrito del comprador que originó esta orden. |
| shipping_address_ID | `int unsigned` | Sí | `NULL` | FK | tb_user_addresses.ID | — | Domicilio de entrega asociado a la orden, si fue registrado. |
| subtotal | `decimal(12,2)` | No | `'0.00'` | — | — | — | Subtotal de la orden; no puede ser negativo. |
| shipping_cost | `decimal(12,2)` | No | `'0.00'` | — | — | — | Costo de envío de la orden; no puede ser negativo. |
| fulfillment_status | `enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned')` | No | `'Pending'` | — | — | — | Estado de cumplimiento: Pending, Accepted, Preparing, Sent, Delivered, Canceled o Returned. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** seller_ID (seller_ID); fk_orders_buyer_cart (buyer_ID, cart_ID); fk_orders_buyer_address (buyer_ID, shipping_address_ID)  
**Claves foráneas:** fk_orders_buyer_address: (buyer_ID, shipping_address_ID) → tb_user_addresses(user_id, ID) ON DELETE RESTRICT ON UPDATE CASCADE; fk_orders_buyer_cart: (buyer_ID, cart_ID) → tb_carts(user_ID, ID) ON DELETE RESTRICT ON UPDATE CASCADE; tb_orders_ibfk_1: (seller_ID) → tb_users(ID)  
**Restricciones CHECK:** tb_orders_chk_1: ((`subtotal` >= 0)); tb_orders_chk_2: ((`shipping_cost` >= 0))  
**Triggers:** trg_tb_orders_ai, trg_tb_orders_au, trg_tb_orders_ad  

### tb_payment_methods

- **Descripción:** Catálogo general de métodos de pago, con nombre, descripción y estado.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del método de pago. |
| name | `varchar(100)` | No | `—` | — | — | — | Nombre del método de pago. |
| description | `text` | Sí | `—` | — | — | — | Descripción del método de pago. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** ninguno adicional  
**Claves foráneas:** ninguna declarada  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_payment_methods_ai, trg_tb_payment_methods_au, trg_tb_payment_methods_ad  

### tb_payment_transaction

- **Descripción:** Transacciones de pasarela asociadas a un pago: referencia externa y respuesta recibida.
- **Registros:** 22
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 23

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la transacción. |
| payment_ID | `int unsigned` | No | `—` | FK | tb_payments.ID | — | Pago al que pertenece la transacción. |
| transaction_reference | `varchar(255)` | No | `—` | — | — | — | Referencia de la transacción en la pasarela de pago. |
| gateway_response | `text` | Sí | `—` | — | — | — | Respuesta recibida de la pasarela de pago. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_trans_payment (payment_ID)  
**Claves foráneas:** fk_trans_payment: (payment_ID) → tb_payments(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_payment_transaction_ai, trg_tb_payment_transaction_au, trg_tb_payment_transaction_ad  

### tb_payments

- **Descripción:** Pagos aplicados a una orden, con el método de pago del usuario utilizado, el monto y el estado del pago.
- **Registros:** 22
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 23

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del pago. |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden que se está pagando. |
| user_payment_method_ID | `bigint unsigned` | Sí | `NULL` | FK | tbd_user_payment_methods.ID | — | Método de pago del usuario utilizado (opcional). |
| payment_type_id | `int unsigned` | Sí | `NULL` | FK | tbc_payment_methods_types.ID | — | Campo payment_type_id de tb_payments. Descripción inferida a partir del nombre y la definición SQL. |
| amount | `decimal(12,2)` | No | `—` | — | — | — | Monto del pago. |
| payment_status | `enum('Pending','Approved','Rejected','Refunded')` | No | `'Pending'` | — | — | — | Estado del pago: Pending, Approved, Rejected o Refunded. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_payments_order (order_ID); fk_payments_user_method (user_payment_method_ID); idx_payments_payment_type_id (payment_type_id)  
**Claves foráneas:** fk_payments_order: (order_ID) → tb_orders(ID); fk_payments_payment_type: (payment_type_id) → tbc_payment_methods_types(ID); fk_payments_user_method: (user_payment_method_ID) → tbd_user_payment_methods(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_payments_ai, trg_tb_payments_au, trg_tb_payments_ad  

### tb_people

- **Descripción:** Datos personales (nombres, fecha de nacimiento, género, país y teléfono) vinculados de forma opcional y única a un usuario.
- **Registros:** 7,506
- **Clave primaria:** person_ID · **Próximo AUTO_INCREMENT:** 7508

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| person_ID | `bigint unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la persona. |
| user_ID | `int` | Sí | `NULL` | FK · UQ | tb_users.ID | — | Usuario asociado a la persona (opcional y único: una persona por usuario). |
| courtesy_title | `varchar(20)` | Sí | `NULL` | — | — | — | Título de cortesía (por ejemplo, Sr. o Sra.). |
| given_names | `varchar(150)` | No | `—` | — | — | — | Nombre(s) de pila. |
| family_names | `varchar(150)` | Sí | `NULL` | — | — | — | Apellidos. |
| birth_date | `date` | Sí | `NULL` | — | — | — | Fecha de nacimiento. |
| gender | `enum('Hombre','Mujer','Prefiero no decirlo')` | No | `'Prefiero no decirlo'` | — | — | — | Género declarado: Hombre, Mujer o Prefiero no decirlo (valor por defecto). |
| country_code | `char(2)` | Sí | `NULL` | — | — | — | Código de país de dos letras. |
| phone | `varchar(25)` | Sí | `NULL` | — | — | — | Número telefónico. |
| status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | Sí | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** user_ID (user_ID) UNIQUE  
**Claves foráneas:** fk_people_users: (user_ID) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_people_ai, trg_tb_people_au, trg_tb_people_ad  

### tb_product_categories

- **Descripción:** Tabla de asociación entre productos y categorías (relación muchos a muchos); su clave primaria es compuesta.
- **Registros:** 11,423
- **Clave primaria:** product_Id, category_Id

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| product_Id | `int unsigned` | No | `—` | PK · FK | tb_products.ID | — | Producto asociado; forma parte de la clave primaria compuesta. |
| category_Id | `int unsigned` | No | `—` | PK · FK | tbc_categories.ID | — | Categoría asociada; forma parte de la clave primaria compuesta. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_pc_category_product (category_Id, product_Id)  
**Claves foráneas:** fk_pc_category: (category_Id) → tbc_categories(ID) ON DELETE RESTRICT ON UPDATE CASCADE; fk_pc_product: (product_Id) → tb_products(ID) ON DELETE RESTRICT ON UPDATE CASCADE  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_product_categories_after_insert, trg_product_categories_after_update, trg_product_categories_after_delete  

### tb_products

- **Descripción:** Catálogo de productos con SKU, nombre, descripción, precio actual y existencias.
- **Registros:** 11,000
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 11541

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del producto. |
| SKU | `varchar(50)` | No | `—` | UQ | — | — | Código SKU del producto; es único. |
| name | `varchar(250)` | No | `—` | — | — | — | Nombre del producto. |
| description | `text` | Sí | `—` | — | — | — | Descripción del producto. |
| current_price | `decimal(10,2)` | No | `'0.00'` | — | — | — | Precio vigente del producto (0.00 por defecto). |
| current_stock | `int unsigned` | No | `'0'` | — | — | — | Existencias disponibles (0 por defecto). |
| status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** SKU (SKU) UNIQUE  
**Claves foráneas:** ninguna declarada  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_products_after_insert, trg_tb_products_after_update, trg_tb_products_after_delete  

### tb_refunds

- **Descripción:** Reembolsos emitidos sobre un pago, con monto y motivo.
- **Registros:** 1
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 2

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del reembolso. |
| payment_ID | `int unsigned` | No | `—` | FK | tb_payments.ID | — | Pago sobre el que se emite el reembolso. |
| amount | `decimal(12,2)` | No | `—` | — | — | — | Monto reembolsado. |
| reason | `text` | Sí | `—` | — | — | — | Motivo del reembolso. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_refunds_payment (payment_ID)  
**Claves foráneas:** fk_refunds_payment: (payment_ID) → tb_payments(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_refunds_ai, trg_tb_refunds_au, trg_tb_refunds_ad  

### tb_returns

- **Descripción:** Solicitudes de devolución de una orden, con el usuario solicitante, el motivo y el estado del trámite.
- **Registros:** 1
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 2

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la solicitud de devolución. |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden a la que corresponde la devolución. |
| requested_by | `int` | No | `—` | FK | tb_users.ID | — | Usuario que solicita la devolución. |
| reason | `text` | No | `—` | — | — | — | Motivo de la devolución. |
| status | `enum('Requested','Approved','Rejected','Completed')` | No | `'Requested'` | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_returns_order_hdr (order_ID); fk_returns_user (requested_by)  
**Claves foráneas:** fk_returns_order_hdr: (order_ID) → tb_orders(ID); fk_returns_user: (requested_by) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_returns_ai, trg_tb_returns_au, trg_tb_returns_ad  

### tb_shipments

- **Descripción:** Envíos de una orden: número de rastreo, paquetería, estado y fechas de salida y entrega.
- **Registros:** 7
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 8

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del envío. |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden que se envía. |
| tracking_number | `varchar(100)` | Sí | `NULL` | — | — | — | Número de rastreo del envío. |
| carrier | `varchar(100)` | Sí | `NULL` | — | — | — | Empresa de paquetería o transportista. |
| shipping_status | `enum('Preparing','In_Transit','Delivered','Failed')` | No | `'Preparing'` | — | — | — | Estado del envío: Preparing, In_Transit, Delivered o Failed. |
| shipped_date | `datetime` | Sí | `NULL` | — | — | — | Fecha y hora de salida del envío. |
| delivered_date | `datetime` | Sí | `NULL` | — | — | — | Fecha y hora de entrega. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_shipments_order (order_ID)  
**Claves foráneas:** fk_shipments_order: (order_ID) → tb_orders(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_shipments_ai, trg_tb_shipments_au, trg_tb_shipments_ad  

### tb_user_addresses

- **Descripción:** Direcciones de envío de los usuarios (calle, ciudad, estado, código postal y país). El esquema no declara una clave foránea para user_id.
- **Registros:** 5
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 6

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la dirección. |
| user_id | `int` | No | `—` | FK | tb_users.ID | — | Usuario dueño de la dirección; tiene índice pero no clave foránea declarada. |
| street | `varchar(255)` | No | `—` | — | — | CHARACTER SET utf8mb4; COLLATE utf8mb4_unicode_ci | Calle y número. |
| city | `varchar(100)` | No | `—` | — | — | CHARACTER SET utf8mb4; COLLATE utf8mb4_unicode_ci | Ciudad. |
| state | `varchar(100)` | No | `—` | — | — | CHARACTER SET utf8mb4; COLLATE utf8mb4_unicode_ci | Estado o provincia. |
| postal_code | `varchar(20)` | No | `—` | — | — | CHARACTER SET utf8mb4; COLLATE utf8mb4_unicode_ci | Código postal. |
| country | `varchar(100)` | No | `—` | — | — | CHARACTER SET utf8mb4; COLLATE utf8mb4_unicode_ci | País. |
| is_default | `tinyint(1)` | Sí | `'0'` | — | — | — | Indica si es la dirección predeterminada del usuario (1 = sí, 0 = no). |
| created_at | `timestamp` | Sí | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación de la dirección. |

**Índices:** uk_user_address_id (user_id, ID) UNIQUE; idx_user_address (user_id)  
**Claves foráneas:** fk_user_addresses_user: (user_id) → tb_users(ID) ON DELETE RESTRICT ON UPDATE CASCADE  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tb_user_addresses_ai, trg_tb_user_addresses_au, trg_tb_user_addresses_ad  

### tb_users

- **Descripción:** Cuentas de usuario del sistema: correo, alias, contraseña, fechas de acceso y estado.
- **Registros:** 7,523
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 7528

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del usuario. |
| email | `varchar(100)` | No | `—` | UQ | — | — | Correo electrónico del usuario; es único. |
| nick | `varchar(50)` | No | `—` | UQ | — | — | Alias o nombre de usuario; es único. |
| password | `varchar(255)` | No | `—` | — | — | — | Contraseña del usuario; el esquema no indica con qué algoritmo se protege el valor almacenado. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |
| last_login | `datetime` | Sí | `NULL` | — | — | — | Fecha y hora del último inicio de sesión. |
| status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |

**Índices:** email (email) UNIQUE; nick (nick) UNIQUE  
**Claves foráneas:** ninguna declarada  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_users_after_insert, trg_users_after_update, trg_users_after_delete  

### tbc_categories

- **Descripción:** Catálogo jerárquico de categorías de productos; la relación consigo misma representa categorías superiores y subcategorías.
- **Registros:** 100
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 108

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la categoría. |
| name | `varchar(120)` | No | `—` | UQ | — | — | Nombre de la categoría; es único. |
| description | `text` | Sí | `—` | — | — | — | Descripción de la categoría. |
| sup_id_category | `int unsigned` | Sí | `NULL` | FK | tbc_categories.ID | — | Categoría superior (autorreferencia); vacío en categorías de primer nivel. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** name (name) UNIQUE; fk_superior_category (sup_id_category)  
**Claves foráneas:** fk_superior_category: (sup_id_category) → tbc_categories(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbc_categories_after_insert, trg_tbc_categories_after_update, trg_tbc_categories_after_delete  

### tbc_payment_methods_types

- **Descripción:** Catálogo de tipos de método de pago, identificados por un código único.
- **Registros:** 6
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 7

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del tipo de método de pago. |
| code | `varchar(30)` | No | `—` | UQ | — | — | Código del tipo de método de pago; es único. |
| description | `text` | No | `—` | — | — | — | Descripción del tipo de método de pago. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** code_UNIQUE (code) UNIQUE  
**Claves foráneas:** ninguna declarada  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbc_payment_methods_types_ai, trg_tbc_payment_methods_types_au, trg_tbc_payment_methods_types_ad  

### tbd_address_components

- **Descripción:** Componentes de una dirección organizados en jerarquía (tipo y valor), ligados a una dirección de usuario.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `bigint unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del componente de dirección. |
| address_ID | `int unsigned` | No | `—` | FK | tb_user_addresses.ID, tbd_address_components.address_ID | — | Dirección de usuario a la que pertenece el componente. |
| value | `varchar(255)` | No | `—` | — | — | — | Valor del componente (por ejemplo, el nombre de una colonia). |
| component_type | `varchar(50)` | No | `—` | — | — | — | Tipo de componente (por ejemplo, país, estado o ciudad). |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| address_sup_ID | `bigint unsigned` | Sí | `NULL` | FK | tbd_address_components.ID | — | Componente superior dentro de la jerarquía de la dirección; el esquema no la enlaza con una clave foránea propia (ver observaciones). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uk_address_component (address_ID, ID) UNIQUE; idx_address_parent (address_ID, address_sup_ID)  
**Claves foráneas:** fk_component_address: (address_ID) → tb_user_addresses(ID) ON DELETE CASCADE ON UPDATE CASCADE; fk_component_parent: (address_ID, address_sup_ID) → tbd_address_components(address_ID, ID) ON DELETE RESTRICT ON UPDATE CASCADE  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_address_components_ai, trg_tbd_address_components_au, trg_tbd_address_components_ad  

### tbd_cancellation_items

- **Descripción:** Detalle de una solicitud de cancelación: orden afectada, motivo y usuario solicitante.
- **Registros:** 1
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 2

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del detalle de cancelación. |
| cancellation_ID | `int unsigned` | Sí | `NULL` | FK | tb_order_cancellations.ID | — | Solicitud de cancelación a la que pertenece el detalle (opcional). |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden afectada por la cancelación. |
| reason | `text` | No | `—` | — | — | — | Motivo de la cancelación. |
| requested_by | `int` | No | `—` | FK | tb_users.ID | — | Usuario que solicita la cancelación. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_cancellations_order (order_ID); fk_cancellations_user (requested_by); fk_cancellation_items_header (cancellation_ID)  
**Claves foráneas:** fk_cancellation_items_header: (cancellation_ID) → tb_order_cancellations(ID); fk_cancellations_order: (order_ID) → tb_orders(ID); fk_cancellations_user: (requested_by) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_cancellation_items_ai, trg_tbd_cancellation_items_au, trg_tbd_cancellation_items_ad  

### tbd_carts_items

- **Descripción:** Productos contenidos en un carrito, con la cantidad solicitada.
- **Registros:** 22
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 29

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del renglón del carrito. |
| cart_id | `int unsigned` | No | `—` | FK | tb_carts.ID | — | Carrito al que pertenece el renglón. |
| product_id | `int unsigned` | No | `—` | FK | tb_products.ID | — | Producto agregado al carrito. |
| quantity | `int unsigned` | No | `'1'` | — | — | — | Cantidad solicitada (1 por defecto). |
| status | `bit(1)` | Sí | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_ci_cart (cart_id); idx_ci_product (product_id)  
**Claves foráneas:** fk_ci_carts: (cart_id) → tb_carts(ID) ON DELETE CASCADE ON UPDATE CASCADE; fk_ci_products: (product_id) → tb_products(ID) ON DELETE CASCADE ON UPDATE CASCADE  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_carts_items_after_insert, trg_carts_items_after_update, trg_carts_items_after_delete  

### tbd_order_items

- **Descripción:** Renglones de una orden: producto, proveedor, nombre, cantidad, precio unitario y subtotal calculado.
- **Registros:** 22
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 35

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del renglón de la orden. |
| seller_order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden a la que pertenece el renglón. |
| product_ID | `int unsigned` | No | `—` | FK | tbd_products_users_providers.product_ID | — | Producto vendido; junto con provider_ID referencia a tbd_products_users_providers. |
| provider_ID | `int` | No | `—` | FK | tbd_products_users_providers.user_ID | — | Usuario proveedor del producto; referencia a tbd_products_users_providers.user_ID. |
| product_name | `varchar(255)` | No | `—` | — | — | — | Nombre del producto al momento de la venta. |
| quantity | `int unsigned` | No | `—` | — | — | — | Cantidad vendida; debe ser mayor que cero. |
| unit_price | `decimal(12,2)` | No | `—` | — | — | — | Precio unitario; no puede ser negativo. |
| subtotal | `decimal(12,2)` | Sí | `—` | — | — | GENERATED ((`quantity` * `unit_price`)) STORED | Columna generada y almacenada: cantidad × precio unitario. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** seller_order_ID (seller_order_ID); product_ID_provider_ID (product_ID, provider_ID)  
**Claves foráneas:** tbd_order_items_ibfk_1: (seller_order_ID) → tb_orders(ID); tbd_order_items_ibfk_2: (product_ID, provider_ID) → tbd_products_users_providers(product_ID, user_ID)  
**Restricciones CHECK:** tbd_order_items_chk_1: ((`quantity` > 0)); tbd_order_items_chk_2: ((`unit_price` >= 0))  
**Triggers:** trg_tbd_order_items_ai, trg_tbd_order_items_au, trg_tbd_order_items_ad  

### tbd_products_users_providers

- **Descripción:** Relación entre productos y los usuarios que los proveen, con el tipo de titularidad (Owner, Reseller o Distributor).
- **Registros:** 12
- **Clave primaria:** user_ID, product_ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| user_ID | `int` | No | `—` | PK · FK | tb_users.ID | — | Usuario proveedor; forma parte de la clave primaria compuesta. |
| product_ID | `int unsigned` | No | `—` | PK · FK | tb_products.ID | — | Producto suministrado; forma parte de la clave primaria compuesta. |
| type_ownership | `enum('Owner','Reseller','Distributor')` | Sí | `NULL` | — | — | — | Tipo de titularidad: Owner, Reseller o Distributor. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| avalaible_date | `datetime` | No | `—` | — | — | — | Fecha desde la que el producto está disponible con este proveedor (el nombre de la columna se escribe así en el esquema). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora del último movimiento de la relación (valor por defecto: fecha actual). |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uidx_product_user (product_ID, user_ID) UNIQUE  
**Claves foráneas:** fk_products2: (product_ID) → tb_products(ID); fk_user1: (user_ID) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_products_users_providers_ai, trg_tbd_products_users_providers_au, trg_tbd_products_users_providers_ad  

### tbd_return_items

- **Descripción:** Detalle de una solicitud de devolución: orden afectada, motivo y estado.
- **Registros:** 1
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 2

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `int unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del detalle de devolución. |
| return_ID | `int unsigned` | Sí | `NULL` | FK | tb_returns.ID | — | Solicitud de devolución a la que pertenece el detalle (opcional). |
| order_ID | `int unsigned` | No | `—` | FK | tb_orders.ID | — | Orden afectada por la devolución. |
| reason | `text` | No | `—` | — | — | — | Motivo de la devolución. |
| status | `enum('Requested','Approved','Rejected','Completed')` | No | `'Requested'` | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_returns_order (order_ID); fk_return_items_header (return_ID)  
**Claves foráneas:** fk_return_items_header: (return_ID) → tb_returns(ID); fk_returns_order: (order_ID) → tb_orders(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_return_items_ai, trg_tbd_return_items_au, trg_tbd_return_items_ad  

### tbd_user_payment_methods

- **Descripción:** Métodos de pago registrados por cada usuario, con su tipo, proveedor y número de cuenta enmascarado.
- **Registros:** 5
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 6

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | `bigint unsigned` | No | `—` | PK | — | AUTO_INCREMENT | Identificador único autoincremental del método de pago del usuario. |
| user_id | `int` | No | `—` | FK | tb_users.ID | — | Usuario dueño del método de pago. |
| payment_type_id | `int unsigned` | No | `—` | FK | tbc_payment_methods_types.ID | — | Tipo de método de pago (catálogo tbc_payment_methods_types). |
| provider | `varchar(100)` | Sí | `NULL` | — | — | — | Proveedor o emisor del método de pago. |
| account_number_masked | `varchar(50)` | Sí | `NULL` | — | — | — | Número de cuenta enmascarado (no completo). |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_upm_user_id (user_id); idx_upm_payment_type_id (payment_type_id)  
**Claves foráneas:** fk_upm_payment_type: (payment_type_id) → tbc_payment_methods_types(ID) ON DELETE RESTRICT ON UPDATE CASCADE; fk_upm_user: (user_id) → tb_users(ID) ON DELETE RESTRICT ON UPDATE CASCADE  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_user_payment_methods_ai, trg_tbd_user_payment_methods_au, trg_tbd_user_payment_methods_ad  

### tbd_users_wishlist_products

- **Descripción:** Lista de deseos: productos que cada usuario guarda para consultar después; su clave primaria es compuesta.
- **Registros:** 0
- **Clave primaria:** user_ID, product_ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| user_ID | `int` | No | `—` | PK · FK | tb_users.ID | — | Usuario que guarda el producto; forma parte de la clave primaria compuesta. |
| product_ID | `int unsigned` | No | `—` | PK · FK | tb_products.ID | — | Producto guardado en la lista de deseos; forma parte de la clave primaria compuesta. |
| status | `bit(1)` | No | `b'1'` | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | `datetime` | No | `CURRENT_TIMESTAMP` | — | — | — | Fecha y hora de creación del registro. |
| last_update | `datetime` | Sí | `NULL` | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_products3 (product_ID)  
**Claves foráneas:** fk_products3: (product_ID) → tb_products(ID); fk_user2: (user_ID) → tb_users(ID)  
**Restricciones CHECK:** ninguna declarada  
**Triggers:** trg_tbd_users_wishlist_products_ai, trg_tbd_users_wishlist_products_au, trg_tbd_users_wishlist_products_ad  

## Vistas y procedimientos

**Vistas (41):** `vw_address_hierarchical_details`, `vw_people_details`, `vw_practica04_caso_3`, `vw_practica04_caso_4`, `vw_practica04_caso_5`, `vw_trazabilidad_carts_items`, `vw_trazabilidad_caso1`, `vw_trazabilidad_caso2`, `vw_trazabilidad_categorias`, `vw_trazabilidad_categorizacion_productos`, `vw_trazabilidad_order_items`, `vw_trazabilidad_payment_methods_types`, `vw_trazabilidad_productos`, `vw_trazabilidad_productos_categorias`, `vw_trazabilidad_tb_carts`, `vw_trazabilidad_tb_order_cancellations`, `vw_trazabilidad_tb_orders`, `vw_trazabilidad_tb_payment_methods`, `vw_trazabilidad_tb_payment_transaction`, `vw_trazabilidad_tb_payments`, `vw_trazabilidad_tb_people`, `vw_trazabilidad_tb_products`, `vw_trazabilidad_tb_refunds`, `vw_trazabilidad_tb_returns`, `vw_trazabilidad_tb_shipments`, `vw_trazabilidad_tb_user_addresses`, `vw_trazabilidad_tb_users`, `vw_trazabilidad_tbc_categories`, `vw_trazabilidad_tbc_payment_methods_types`, `vw_trazabilidad_tbd_address_components`, `vw_trazabilidad_tbd_cancellation_items`, `vw_trazabilidad_tbd_cart_items`, `vw_trazabilidad_tbd_order_items`, `vw_trazabilidad_tbd_products_categories`, `vw_trazabilidad_tbd_return_items`, `vw_trazabilidad_tbd_user_payment_methods`, `vw_trazabilidad_user_addresses`, `vw_trazabilidad_user_payment_methods`, `vw_trazabilidad_usuarios`, `vw_user_default_shipping_addresses`, `vw_wishlist_carritos`

**Procedimientos (3):** `sp_register_new_user`, `sp_restore_product`, `sp_soft_delete_product`

