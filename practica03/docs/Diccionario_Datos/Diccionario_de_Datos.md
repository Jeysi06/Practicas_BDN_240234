# Diccionario de Datos — db_test_7b

**Motor:** MySQL 8.0.44 (mysqldump 10.13)  
**Respaldo de referencia:** `respaldo1411_3.sql`  
**SHA-256:** `61cbd9b1c8b2a87fdfe9b8e42f6a96dd077dc579a2ae78f5fba1dce6c4163956`  
**Charset / collation:** `utf8mb4` / `utf8mb4_0900_ai_ci`

**Resumen:** 25 tablas · 185 columnas · 32 claves foráneas · **86,707 registros** · 37 vistas · 72 triggers · 3 procedimientos.

## Alcance y verificación

Los **registros por tabla** son el número de filas incluidas en las sentencias `INSERT` del respaldo `respaldo1411_3.sql`, contadas fila por fila y verificadas con un segundo método independiente (coinciden las 6 tablas con datos). No es una consulta en vivo: una tabla con 0 no tiene filas en el respaldo. El respaldo no declara `COMMENT` en tablas ni columnas, por lo que las **descripciones** son redacciones editoriales a partir de los nombres, tipos, restricciones y relaciones; no son reglas de negocio confirmadas. El SQL no se ejecutó.

## Registros por tabla

| Tabla | Grupo | Columnas | Registros |
|---|---|---:|---:|
| [tb_logs](#tb_logs) | tb | 8 | 40,853 |
| [tb_product_categories](#tb_product_categories) | tb | 5 | 15,719 |
| [tb_products](#tb_products) | tb | 9 | 15,014 |
| [tb_users](#tb_users) | tb | 8 | 7,519 |
| [tb_people](#tb_people) | tb | 12 | 7,502 |
| [tbc_categories](#tbc_categories) | tbc | 7 | 100 |
| [tb_carts](#tb_carts) | tb | 5 | 0 |
| [tb_order_cancellations](#tb_order_cancellations) | tb | 7 | 0 |
| [tb_orders](#tb_orders) | tb | 8 | 0 |
| [tb_payment_methods](#tb_payment_methods) | tb | 6 | 0 |
| [tb_payment_transaction](#tb_payment_transaction) | tb | 7 | 0 |
| [tb_payments](#tb_payments) | tb | 7 | 0 |
| [tb_refunds](#tb_refunds) | tb | 6 | 0 |
| [tb_returns](#tb_returns) | tb | 7 | 0 |
| [tb_shipments](#tb_shipments) | tb | 8 | 0 |
| [tb_user_addresses](#tb_user_addresses) | tb | 9 | 0 |
| [tbc_payment_methods_types](#tbc_payment_methods_types) | tbc | 6 | 0 |
| [tbd_address_components](#tbd_address_components) | tbd | 8 | 0 |
| [tbd_cancellation_items](#tbd_cancellation_items) | tbd | 7 | 0 |
| [tbd_carts_items](#tbd_carts_items) | tbd | 7 | 0 |
| [tbd_order_items](#tbd_order_items) | tbd | 10 | 0 |
| [tbd_products_users_providers](#tbd_products_users_providers) | tbd | 8 | 0 |
| [tbd_return_items](#tbd_return_items) | tbd | 7 | 0 |
| [tbd_user_payment_methods](#tbd_user_payment_methods) | tbd | 8 | 0 |
| [tbd_users_wishlist_products](#tbd_users_wishlist_products) | tbd | 5 | 0 |
| **Total** | | **185** | **86,707** |

## Tablas y columnas

DEFAULT «—» significa que no se declara valor predeterminado. PK = clave primaria, FK = clave foránea, UQ = valor único.

### tb_carts

- **Descripción:** Carrito de compras de cada usuario; el índice único por usuario permite un solo carrito por cuenta.
- **Registros:** 0
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 8

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del carrito. |
| user_ID | int | No | — | FK · UQ | tb_users.ID | — | Usuario propietario del carrito (único por usuario). |
| status | bit(1) | Sí | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uk_cart_user (user_ID) UNIQUE  
**Claves foráneas:** tb_carts_ibfk_1: (user_ID) → tb_users(ID)  
**Triggers:** trg_tb_carts_ai, trg_tb_carts_au, trg_tb_carts_ad

### tb_logs

- **Descripción:** Bitácora de auditoría: registra las operaciones Create, Read, Update y Delete realizadas sobre las tablas, con el usuario de base de datos y la fecha.
- **Registros:** 40,853
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 79,730

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del registro de bitácora. |
| table_name | varchar(80) | No | — | — | — | — | Nombre de la tabla sobre la que se registró la operación. |
| record_id | int unsigned | Sí | NULL | — | — | — | ID del registro afectado en la tabla indicada; no tiene clave foránea porque apunta a distintas tablas. |
| table_operation | enum('Create','Read','Update','Delete') | Sí | NULL | — | — | — | Tipo de operación registrada: Create, Read, Update o Delete. |
| db_user | varchar(80) | No | — | — | — | — | Usuario de base de datos (y host) que ejecutó la operación. |
| table_description | text | No | — | — | — | — | Texto con el detalle de la operación registrada. |
| operation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora en que se registró la operación. |
| operation_status | bit(1) | Sí | b'1' | — | — | — | Estado de la operación registrada (1 por defecto). |

**Índices:** idx_logs_table_record_operation (table_name, record_id, table_operation); idx_logs_table_operation_date (table_name, table_operation, operation_date); idx_logs_db_user_date (db_user, operation_date)  
**Claves foráneas:** ninguna declarada.  
**Triggers:** 

### tb_order_cancellations

- **Descripción:** Solicitudes de cancelación de una orden, con el usuario que la pide, el motivo y el estado del trámite.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la solicitud de cancelación. |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden que se desea cancelar. |
| requested_by | int | No | — | FK | tb_users.ID | — | Usuario que solicita la cancelación. |
| reason | text | No | — | — | — | — | Motivo de la cancelación. |
| status | enum('Requested','Approved','Rejected','Completed') | No | 'Requested' | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_order_cancellations_order (order_ID); fk_order_cancellations_user (requested_by)  
**Claves foráneas:** fk_order_cancellations_order: (order_ID) → tb_orders(ID); fk_order_cancellations_user: (requested_by) → tb_users(ID)  
**Triggers:** trg_tb_order_cancellations_ai, trg_tb_order_cancellations_au, trg_tb_order_cancellations_ad

### tb_orders

- **Descripción:** Órdenes de venta de un vendedor, con subtotal, costo de envío y estado de cumplimiento.
- **Registros:** 0
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 2

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la orden. |
| seller_ID | int | No | — | FK | tb_users.ID | — | Usuario vendedor al que pertenece la orden. |
| subtotal | decimal(12,2) | No | '0.00' | — | — | — | Subtotal de la orden; no puede ser negativo. |
| shipping_cost | decimal(12,2) | No | '0.00' | — | — | — | Costo de envío de la orden; no puede ser negativo. |
| fulfillment_status | enum('Pending','Accepted','Preparing','Sent','Delivered','Canceled','Returned') | No | 'Pending' | — | — | — | Estado de cumplimiento: Pending, Accepted, Preparing, Sent, Delivered, Canceled o Returned. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** seller_ID (seller_ID)  
**Claves foráneas:** tb_orders_ibfk_1: (seller_ID) → tb_users(ID)  
**Restricciones CHECK:** tb_orders_chk_1 ((`subtotal` >= 0)); tb_orders_chk_2 ((`shipping_cost` >= 0))  
**Triggers:** trg_tb_orders_ai, trg_tb_orders_au, trg_tb_orders_ad

### tb_payment_methods

- **Descripción:** Catálogo general de métodos de pago, con nombre, descripción y estado.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del método de pago. |
| name | varchar(100) | No | — | — | — | — | Nombre del método de pago. |
| description | text | Sí | — | — | — | — | Descripción del método de pago. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** solo la clave primaria.  
**Claves foráneas:** ninguna declarada.  
**Triggers:** trg_tb_payment_methods_ai, trg_tb_payment_methods_au, trg_tb_payment_methods_ad

### tb_payment_transaction

- **Descripción:** Transacciones de pasarela asociadas a un pago: referencia externa y respuesta recibida.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la transacción. |
| payment_ID | int unsigned | No | — | FK | tb_payments.ID | — | Pago al que pertenece la transacción. |
| transaction_reference | varchar(255) | No | — | — | — | — | Referencia de la transacción en la pasarela de pago. |
| gateway_response | text | Sí | — | — | — | — | Respuesta recibida de la pasarela de pago. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_trans_payment (payment_ID)  
**Claves foráneas:** fk_trans_payment: (payment_ID) → tb_payments(ID)  
**Triggers:** trg_tb_payment_transaction_ai, trg_tb_payment_transaction_au, trg_tb_payment_transaction_ad

### tb_payments

- **Descripción:** Pagos aplicados a una orden, con el método de pago del usuario utilizado, el monto y el estado del pago.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del pago. |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden que se está pagando. |
| user_payment_method_ID | bigint unsigned | Sí | NULL | FK | tbd_user_payment_methods.ID | — | Método de pago del usuario utilizado (opcional). |
| amount | decimal(12,2) | No | — | — | — | — | Monto del pago. |
| payment_status | enum('Pending','Approved','Rejected','Refunded') | No | 'Pending' | — | — | — | Estado del pago: Pending, Approved, Rejected o Refunded. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_payments_order (order_ID); fk_payments_user_method (user_payment_method_ID)  
**Claves foráneas:** fk_payments_order: (order_ID) → tb_orders(ID); fk_payments_user_method: (user_payment_method_ID) → tbd_user_payment_methods(ID)  
**Triggers:** trg_tb_payments_ai, trg_tb_payments_au, trg_tb_payments_ad

### tb_people

- **Descripción:** Datos personales (nombres, fecha de nacimiento, género, país y teléfono) vinculados de forma opcional y única a un usuario.
- **Registros:** 7,502
- **Clave primaria:** person_ID · **Próximo AUTO_INCREMENT:** 7,503

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| person_ID | bigint unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la persona. |
| user_ID | int | Sí | NULL | FK · UQ | tb_users.ID | — | Usuario asociado a la persona (opcional y único: una persona por usuario). |
| courtesy_title | varchar(20) | Sí | NULL | — | — | — | Título de cortesía (por ejemplo, Sr. o Sra.). |
| given_names | varchar(150) | No | — | — | — | — | Nombre(s) de pila. |
| family_names | varchar(150) | Sí | NULL | — | — | — | Apellidos. |
| birth_date | date | Sí | NULL | — | — | — | Fecha de nacimiento. |
| gender | enum('Hombre','Mujer','Prefiero no decirlo') | No | 'Prefiero no decirlo' | — | — | — | Género declarado: Hombre, Mujer o Prefiero no decirlo (valor por defecto). |
| country_code | char(2) | Sí | NULL | — | — | — | Código de país de dos letras. |
| phone | varchar(25) | Sí | NULL | — | — | — | Número telefónico. |
| status | bit(1) | Sí | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | Sí | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** user_ID (user_ID) UNIQUE  
**Claves foráneas:** fk_people_users: (user_ID) → tb_users(ID)  
**Triggers:** trg_tb_people_ai, trg_tb_people_au, trg_tb_people_ad

### tb_product_categories

- **Descripción:** Tabla de asociación entre productos y categorías (relación muchos a muchos); su clave primaria es compuesta.
- **Registros:** 15,719
- **Clave primaria:** product_Id, category_Id

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| product_Id | int unsigned | No | — | PK · FK | tb_products.ID | — | Producto asociado; forma parte de la clave primaria compuesta. |
| category_Id | int unsigned | No | — | PK · FK | tbc_categories.ID | — | Categoría asociada; forma parte de la clave primaria compuesta. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | No | CURRENT_TIMESTAMP | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_pc_category_product (category_Id, product_Id)  
**Claves foráneas:** fk_pc_category: (category_Id) → tbc_categories(ID); fk_pc_product: (product_Id) → tb_products(ID)  
**Triggers:** trg_product_categories_after_insert, trg_product_categories_after_update, trg_product_categories_after_delete

### tb_products

- **Descripción:** Catálogo de productos con SKU, nombre, descripción, precio actual y existencias.
- **Registros:** 15,014
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 21,398

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del producto. |
| SKU | varchar(50) | No | — | UQ | — | — | Código SKU del producto; es único. |
| name | varchar(250) | No | — | — | — | — | Nombre del producto. |
| description | text | Sí | — | — | — | — | Descripción del producto. |
| current_price | decimal(10,2) | No | '0.00' | — | — | — | Precio vigente del producto (0.00 por defecto). |
| current_stock | int unsigned | No | '0' | — | — | — | Existencias disponibles (0 por defecto). |
| status | bit(1) | Sí | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** SKU (SKU) UNIQUE  
**Claves foráneas:** ninguna declarada.  
**Triggers:** trg_tb_products_after_insert, trg_tb_products_after_update, trg_tb_products_after_delete

### tb_refunds

- **Descripción:** Reembolsos emitidos sobre un pago, con monto y motivo.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del reembolso. |
| payment_ID | int unsigned | No | — | FK | tb_payments.ID | — | Pago sobre el que se emite el reembolso. |
| amount | decimal(12,2) | No | — | — | — | — | Monto reembolsado. |
| reason | text | Sí | — | — | — | — | Motivo del reembolso. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_refunds_payment (payment_ID)  
**Claves foráneas:** fk_refunds_payment: (payment_ID) → tb_payments(ID)  
**Triggers:** trg_tb_refunds_ai, trg_tb_refunds_au, trg_tb_refunds_ad

### tb_returns

- **Descripción:** Solicitudes de devolución de una orden, con el usuario solicitante, el motivo y el estado del trámite.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la solicitud de devolución. |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden a la que corresponde la devolución. |
| requested_by | int | No | — | FK | tb_users.ID | — | Usuario que solicita la devolución. |
| reason | text | No | — | — | — | — | Motivo de la devolución. |
| status | enum('Requested','Approved','Rejected','Completed') | No | 'Requested' | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_returns_order_hdr (order_ID); fk_returns_user (requested_by)  
**Claves foráneas:** fk_returns_order_hdr: (order_ID) → tb_orders(ID); fk_returns_user: (requested_by) → tb_users(ID)  
**Triggers:** trg_tb_returns_ai, trg_tb_returns_au, trg_tb_returns_ad

### tb_shipments

- **Descripción:** Envíos de una orden: número de rastreo, paquetería, estado y fechas de salida y entrega.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del envío. |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden que se envía. |
| tracking_number | varchar(100) | Sí | NULL | — | — | — | Número de rastreo del envío. |
| carrier | varchar(100) | Sí | NULL | — | — | — | Empresa de paquetería o transportista. |
| shipping_status | enum('Preparing','In_Transit','Delivered','Failed') | No | 'Preparing' | — | — | — | Estado del envío: Preparing, In_Transit, Delivered o Failed. |
| shipped_date | datetime | Sí | NULL | — | — | — | Fecha y hora de salida del envío. |
| delivered_date | datetime | Sí | NULL | — | — | — | Fecha y hora de entrega. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_shipments_order (order_ID)  
**Claves foráneas:** fk_shipments_order: (order_ID) → tb_orders(ID)  
**Triggers:** trg_tb_shipments_ai, trg_tb_shipments_au, trg_tb_shipments_ad

### tb_user_addresses

- **Descripción:** Direcciones de envío de los usuarios (calle, ciudad, estado, código postal y país). El esquema no declara una clave foránea para user_id.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la dirección. |
| user_id | int unsigned | No | — | — | — | — | Usuario dueño de la dirección; tiene índice pero no clave foránea declarada. |
| street | varchar(255) | No | — | — | — | — | Calle y número. |
| city | varchar(100) | No | — | — | — | — | Ciudad. |
| state | varchar(100) | No | — | — | — | — | Estado o provincia. |
| postal_code | varchar(20) | No | — | — | — | — | Código postal. |
| country | varchar(100) | No | — | — | — | — | País. |
| is_default | tinyint(1) | Sí | '0' | — | — | — | Indica si es la dirección predeterminada del usuario (1 = sí, 0 = no). |
| created_at | timestamp | Sí | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación de la dirección. |

**Índices:** idx_user_address (user_id)  
**Claves foráneas:** ninguna declarada.  
**Triggers:** trg_tb_user_addresses_ai, trg_tb_user_addresses_au, trg_tb_user_addresses_ad

### tb_users

- **Descripción:** Cuentas de usuario del sistema: correo, alias, contraseña, fechas de acceso y estado.
- **Registros:** 7,519
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 7,523

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del usuario. |
| email | varchar(100) | No | — | UQ | — | — | Correo electrónico del usuario; es único. |
| nick | varchar(50) | No | — | UQ | — | — | Alias o nombre de usuario; es único. |
| password | varchar(255) | No | — | — | — | — | Contraseña del usuario; el esquema no indica con qué algoritmo se protege el valor almacenado. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |
| last_login | datetime | Sí | NULL | — | — | — | Fecha y hora del último inicio de sesión. |
| status | bit(1) | Sí | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |

**Índices:** email (email) UNIQUE; nick (nick) UNIQUE  
**Claves foráneas:** ninguna declarada.  
**Triggers:** trg_users_after_insert, trg_users_after_update, trg_users_after_delete

### tbc_categories

- **Descripción:** Catálogo jerárquico de categorías de productos; la relación consigo misma representa categorías superiores y subcategorías.
- **Registros:** 100
- **Clave primaria:** ID · **Próximo AUTO_INCREMENT:** 108

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental de la categoría. |
| name | varchar(120) | No | — | UQ | — | — | Nombre de la categoría; es único. |
| description | text | Sí | — | — | — | — | Descripción de la categoría. |
| sup_id_category | int unsigned | Sí | NULL | FK | tbc_categories.ID | — | Categoría superior (autorreferencia); vacío en categorías de primer nivel. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** name (name) UNIQUE; fk_superior_category (sup_id_category)  
**Claves foráneas:** fk_superior_category: (sup_id_category) → tbc_categories(ID)  
**Triggers:** trg_tbc_categories_after_insert, trg_tbc_categories_after_update, trg_tbc_categories_after_delete

### tbc_payment_methods_types

- **Descripción:** Catálogo de tipos de método de pago, identificados por un código único.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del tipo de método de pago. |
| code | varchar(30) | No | — | UQ | — | — | Código del tipo de método de pago; es único. |
| description | text | No | — | — | — | — | Descripción del tipo de método de pago. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** code_UNIQUE (code) UNIQUE  
**Claves foráneas:** ninguna declarada.  
**Triggers:** trg_tbc_payment_methods_types_ai, trg_tbc_payment_methods_types_au, trg_tbc_payment_methods_types_ad

### tbd_address_components

- **Descripción:** Componentes de una dirección organizados en jerarquía (tipo y valor), ligados a una dirección de usuario.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | bigint unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del componente de dirección. |
| address_ID | int unsigned | No | — | FK | tb_user_addresses.ID | — | Dirección de usuario a la que pertenece el componente. |
| value | varchar(255) | No | — | — | — | — | Valor del componente (por ejemplo, el nombre de una colonia). |
| component_type | varchar(50) | No | — | — | — | — | Tipo de componente (por ejemplo, país, estado o ciudad). |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| address_sup_ID | bigint unsigned | Sí | NULL | — | — | — | Componente superior dentro de la jerarquía de la dirección; el esquema no la enlaza con una clave foránea propia (ver observaciones). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uk_address_component (address_ID, ID) UNIQUE; idx_address_parent (address_ID, address_sup_ID)  
**Claves foráneas:** fk_component_address: (address_ID) → tb_user_addresses(ID); fk_component_parent: (address_ID) → tb_user_addresses(ID)  
**Triggers:** trg_tbd_address_components_ai, trg_tbd_address_components_au, trg_tbd_address_components_ad

### tbd_cancellation_items

- **Descripción:** Detalle de una solicitud de cancelación: orden afectada, motivo y usuario solicitante.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del detalle de cancelación. |
| cancellation_ID | int unsigned | Sí | NULL | FK | tb_order_cancellations.ID | — | Solicitud de cancelación a la que pertenece el detalle (opcional). |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden afectada por la cancelación. |
| reason | text | No | — | — | — | — | Motivo de la cancelación. |
| requested_by | int | No | — | FK | tb_users.ID | — | Usuario que solicita la cancelación. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_cancellations_order (order_ID); fk_cancellations_user (requested_by); fk_cancellation_items_header (cancellation_ID)  
**Claves foráneas:** fk_cancellation_items_header: (cancellation_ID) → tb_order_cancellations(ID); fk_cancellations_order: (order_ID) → tb_orders(ID); fk_cancellations_user: (requested_by) → tb_users(ID)  
**Triggers:** trg_tbd_cancellation_items_ai, trg_tbd_cancellation_items_au, trg_tbd_cancellation_items_ad

### tbd_carts_items

- **Descripción:** Productos contenidos en un carrito, con la cantidad solicitada.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del renglón del carrito. |
| cart_id | int unsigned | No | — | FK | tb_carts.ID | — | Carrito al que pertenece el renglón. |
| product_id | int unsigned | No | — | FK | tb_products.ID | — | Producto agregado al carrito. |
| quantity | int unsigned | No | '1' | — | — | — | Cantidad solicitada (1 por defecto). |
| status | bit(1) | Sí | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_ci_cart (cart_id); idx_ci_product (product_id)  
**Claves foráneas:** fk_ci_carts: (cart_id) → tb_carts(ID); fk_ci_products: (product_id) → tb_products(ID)  
**Triggers:** trg_carts_items_after_insert, trg_carts_items_after_update, trg_carts_items_after_delete

### tbd_order_items

- **Descripción:** Renglones de una orden: producto, proveedor, nombre, cantidad, precio unitario y subtotal calculado.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del renglón de la orden. |
| seller_order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden a la que pertenece el renglón. |
| product_ID | int unsigned | No | — | FK | tbd_products_users_providers.product_ID | — | Producto vendido; junto con provider_ID referencia a tbd_products_users_providers. |
| provider_ID | int | No | — | FK | tbd_products_users_providers.user_ID | — | Usuario proveedor del producto; referencia a tbd_products_users_providers.user_ID. |
| product_name | varchar(255) | No | — | — | — | — | Nombre del producto al momento de la venta. |
| quantity | int unsigned | No | — | — | — | — | Cantidad vendida; debe ser mayor que cero. |
| unit_price | decimal(12,2) | No | — | — | — | — | Precio unitario; no puede ser negativo. |
| subtotal | decimal(12,2) | Sí | Generado: (`quantity` * `unit_price`) (STORED) | — | — | STORED | Columna generada y almacenada: cantidad × precio unitario. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** seller_order_ID (seller_order_ID); product_ID_provider_ID (product_ID, provider_ID)  
**Claves foráneas:** tbd_order_items_ibfk_1: (seller_order_ID) → tb_orders(ID); tbd_order_items_ibfk_2: (product_ID, provider_ID) → tbd_products_users_providers(product_ID, user_ID)  
**Restricciones CHECK:** tbd_order_items_chk_1 ((`quantity` > 0)); tbd_order_items_chk_2 ((`unit_price` >= 0))  
**Triggers:** trg_tbd_order_items_ai, trg_tbd_order_items_au, trg_tbd_order_items_ad

### tbd_products_users_providers

- **Descripción:** Relación entre productos y los usuarios que los proveen, con el tipo de titularidad (Owner, Reseller o Distributor).
- **Registros:** 0
- **Clave primaria:** user_ID, product_ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| user_ID | int | No | — | PK · FK | tb_users.ID | — | Usuario proveedor; forma parte de la clave primaria compuesta. |
| product_ID | int unsigned | No | — | PK · FK | tb_products.ID | — | Producto suministrado; forma parte de la clave primaria compuesta. |
| type_ownership | enum('Owner','Reseller','Distributor') | Sí | NULL | — | — | — | Tipo de titularidad: Owner, Reseller o Distributor. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| avalaible_date | datetime | No | — | — | — | — | Fecha desde la que el producto está disponible con este proveedor (el nombre de la columna se escribe así en el esquema). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora del último movimiento de la relación (valor por defecto: fecha actual). |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** uidx_product_user (product_ID, user_ID) UNIQUE  
**Claves foráneas:** fk_products2: (product_ID) → tb_products(ID); fk_user1: (user_ID) → tb_users(ID)  
**Triggers:** trg_tbd_products_users_providers_ai, trg_tbd_products_users_providers_au, trg_tbd_products_users_providers_ad

### tbd_return_items

- **Descripción:** Detalle de una solicitud de devolución: orden afectada, motivo y estado.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | int unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del detalle de devolución. |
| return_ID | int unsigned | Sí | NULL | FK | tb_returns.ID | — | Solicitud de devolución a la que pertenece el detalle (opcional). |
| order_ID | int unsigned | No | — | FK | tb_orders.ID | — | Orden afectada por la devolución. |
| reason | text | No | — | — | — | — | Motivo de la devolución. |
| status | enum('Requested','Approved','Rejected','Completed') | No | 'Requested' | — | — | — | Estado del trámite: Requested, Approved, Rejected o Completed. |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_returns_order (order_ID); fk_return_items_header (return_ID)  
**Claves foráneas:** fk_return_items_header: (return_ID) → tb_returns(ID); fk_returns_order: (order_ID) → tb_orders(ID)  
**Triggers:** trg_tbd_return_items_ai, trg_tbd_return_items_au, trg_tbd_return_items_ad

### tbd_user_payment_methods

- **Descripción:** Métodos de pago registrados por cada usuario, con su tipo, proveedor y número de cuenta enmascarado.
- **Registros:** 0
- **Clave primaria:** ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| ID | bigint unsigned | No | — | PK | — | AUTO_INCREMENT | Identificador único autoincremental del método de pago del usuario. |
| user_id | int | No | — | FK | tb_users.ID | — | Usuario dueño del método de pago. |
| payment_type_id | int unsigned | No | — | FK | tbc_payment_methods_types.ID | — | Tipo de método de pago (catálogo tbc_payment_methods_types). |
| provider | varchar(100) | Sí | NULL | — | — | — | Proveedor o emisor del método de pago. |
| account_number_masked | varchar(50) | Sí | NULL | — | — | — | Número de cuenta enmascarado (no completo). |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** idx_upm_user_id (user_id); idx_upm_payment_type_id (payment_type_id)  
**Claves foráneas:** fk_upm_payment_type: (payment_type_id) → tbc_payment_methods_types(ID); fk_upm_user: (user_id) → tb_users(ID)  
**Triggers:** trg_tbd_user_payment_methods_ai, trg_tbd_user_payment_methods_au, trg_tbd_user_payment_methods_ad

### tbd_users_wishlist_products

- **Descripción:** Lista de deseos: productos que cada usuario guarda para consultar después; su clave primaria es compuesta.
- **Registros:** 0
- **Clave primaria:** user_ID, product_ID

| Columna | Tipo | NULL | DEFAULT | Clave | Referencia | Extra | Descripción |
|---|---|---|---|---|---|---|---|
| user_ID | int | No | — | PK · FK | tb_users.ID | — | Usuario que guarda el producto; forma parte de la clave primaria compuesta. |
| product_ID | int unsigned | No | — | PK · FK | tb_products.ID | — | Producto guardado en la lista de deseos; forma parte de la clave primaria compuesta. |
| status | bit(1) | No | b'1' | — | — | — | Estado lógico del registro (1 = activo, valor por defecto; 0 = inactivo). |
| creation_date | datetime | No | CURRENT_TIMESTAMP | — | — | — | Fecha y hora de creación del registro. |
| last_update | datetime | Sí | NULL | — | — | ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de la última modificación del registro. |

**Índices:** fk_products3 (product_ID)  
**Claves foráneas:** fk_products3: (product_ID) → tb_products(ID); fk_user2: (user_ID) → tb_users(ID)  
**Triggers:** trg_tbd_users_wishlist_products_ai, trg_tbd_users_wishlist_products_au, trg_tbd_users_wishlist_products_ad

## Observaciones sobre el esquema

- **Doble clave foránea sobre la misma columna.** En `tbd_address_components`, las restricciones `fk_component_address` (ON DELETE RESTRICT) y `fk_component_parent` (ON DELETE CASCADE, ON UPDATE CASCADE) apuntan ambas a `tb_user_addresses.ID` desde `address_ID`. La segunda parece pensada para la jerarquía `address_sup_ID`, pero el esquema no la declara así; se documenta tal como está en el respaldo.
- **Sin clave foránea en `tb_user_addresses.user_id`.** Tiene índice (`idx_user_address`) pero no restricción hacia `tb_users.ID`; además el tipo es `int unsigned` mientras `tb_users.ID` es `int`.
- **Bitácora sin FK.** `tb_logs.record_id` no tiene clave foránea porque identifica registros de distintas tablas (junto con `table_name`).
- **Contadores AUTO_INCREMENT mayores que los registros incluidos.** `tb_carts`: contador 8, registros 0; `tb_logs`: contador 79,730, registros 40,853; `tb_orders`: contador 2, registros 0; `tb_people`: contador 7,503, registros 7,502; `tb_products`: contador 21,398, registros 15,014; `tb_users`: contador 7,523, registros 7,519; `tbc_categories`: contador 108, registros 100. Indica que el contador avanzó más allá de las filas presentes en el respaldo (por ejemplo, filas eliminadas o no incluidas).
- **Columna `avalaible_date`.** En `tbd_products_users_providers` el nombre se escribe así en el esquema (con «avalaible»); se conserva sin corregir.

## Vistas y procedimientos

**Vistas (37):** `vw_address_hierarchical_details`, `vw_people_details`, `vw_total_products_by_category`, `vw_trazabilidad_carts_items`, `vw_trazabilidad_categorias`, `vw_trazabilidad_categorizacion_productos`, `vw_trazabilidad_order_items`, `vw_trazabilidad_payment_methods_types`, `vw_trazabilidad_productos`, `vw_trazabilidad_productos_categorias`, `vw_trazabilidad_tb_carts`, `vw_trazabilidad_tb_order_cancellations`, `vw_trazabilidad_tb_orders`, `vw_trazabilidad_tb_payment_methods`, `vw_trazabilidad_tb_payment_transaction`, `vw_trazabilidad_tb_payments`, `vw_trazabilidad_tb_people`, `vw_trazabilidad_tb_products`, `vw_trazabilidad_tb_refunds`, `vw_trazabilidad_tb_returns`, `vw_trazabilidad_tb_shipments`, `vw_trazabilidad_tb_user_addresses`, `vw_trazabilidad_tb_users`, `vw_trazabilidad_tbc_categories`, `vw_trazabilidad_tbc_payment_methods_types`, `vw_trazabilidad_tbd_address_components`, `vw_trazabilidad_tbd_cancellation_items`, `vw_trazabilidad_tbd_cart_items`, `vw_trazabilidad_tbd_order_items`, `vw_trazabilidad_tbd_products_categories`, `vw_trazabilidad_tbd_return_items`, `vw_trazabilidad_tbd_user_payment_methods`, `vw_trazabilidad_user_addresses`, `vw_trazabilidad_user_payment_methods`, `vw_trazabilidad_usuarios`, `vw_user_default_shipping_addresses`, `vw_wishlist_carritos`

**Procedimientos (3):** `sp_register_new_user`, `sp_restore_product`, `sp_soft_delete_product`
