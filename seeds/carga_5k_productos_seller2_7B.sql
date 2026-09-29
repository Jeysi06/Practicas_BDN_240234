LOAD DATA LOCAL INFILE '"C:\Users\larac\Documents\7  cuatri\marco\Practicas_BDN_240234\seeds\carga_5k_productos_seller2_7B.sql"'
INTO TABLE tb_products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    ID,
    SKU,
    name,
    description,
    current_price,
    current_stock,
    @status
)
SET
    status = IF(@status = 1, b'1', b'0'),
    creation_date = CURRENT_TIMESTAMP,
    last_update = CURRENT_TIMESTAMP;