-- Práctica 04 · Consultas de verificación (NO modifican la base de datos)
-- Ejecutar como Damari@localhost, rol super_admin, después de importar
-- el respaldo reducido en una base de pruebas.
USE db_test_7b;

-- Resumen de registros del respaldo reducido
SELECT 'tb_products' AS tabla, COUNT(*) AS registros FROM tb_products
UNION ALL SELECT 'tb_product_categories', COUNT(*) FROM tb_product_categories
UNION ALL SELECT 'tbd_order_items', COUNT(*) FROM tbd_order_items
UNION ALL SELECT 'tbd_carts_items', COUNT(*) FROM tbd_carts_items
UNION ALL SELECT 'tb_logs', COUNT(*) FROM tb_logs;

-- Debe devolver 0: asociaciones de categorías sin producto válido.
SELECT COUNT(*) AS categorias_huerfanas
FROM tb_product_categories pc LEFT JOIN tb_products p ON p.ID=pc.product_Id
WHERE p.ID IS NULL;

-- Debe devolver 0: artículos de carrito sin producto válido.
SELECT COUNT(*) AS carrito_productos_huerfanos
FROM tbd_carts_items ci LEFT JOIN tb_products p ON p.ID=ci.product_id
WHERE p.ID IS NULL;

-- Debe devolver 0: asociaciones de proveedores sin producto válido.
SELECT COUNT(*) AS proveedores_productos_huerfanos
FROM tbd_products_users_providers pp LEFT JOIN tb_products p ON p.ID=pp.product_ID
WHERE p.ID IS NULL;

-- Debe devolver 0: renglones de orden sin producto válido.
SELECT COUNT(*) AS pedidos_productos_huerfanos
FROM tbd_order_items oi LEFT JOIN tb_products p ON p.ID=oi.product_ID
WHERE p.ID IS NULL;

-- Presencia de todos los productos empleados en los casos de prueba.
SELECT ID, name, current_stock
FROM tb_products
WHERE ID IN (1,2,3,4,5,6,7,8,9,73,3262,5087,8179,10264,11540)
ORDER BY ID;

-- Resultados de los cinco casos: vistas ya incluidas en el respaldo.
SELECT * FROM vw_trazabilidad_caso1;
SELECT * FROM vw_trazabilidad_caso2;
SELECT * FROM vw_practica04_caso_3 ORDER BY log_ID;
SELECT * FROM vw_practica04_caso_4 ORDER BY log_ID;
SELECT * FROM vw_practica04_caso_5 ORDER BY log_ID;
