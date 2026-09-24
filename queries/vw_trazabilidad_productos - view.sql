CREATE
    ALGORITHM = UNDEFINED
    DEFINER = `root`@`localhost`
    SQL SECURITY DEFINER
VIEW `db_test_7b`.`vw_trazabilidad_productos` AS
    SELECT 
        `p`.`ID` AS `id`,
        `p`.`name` AS `name`,
        `p`.`description` AS `description`,
        `b`.`db_user` AS `inserted_by`,
        COALESCE(GROUP_CONCAT(DISTINCT `re`.`FROM_USER`
                ORDER BY `re`.`FROM_USER` ASC
                SEPARATOR ', '),
                'Sin rol') AS `roles`,
        `b`.`operation_description` AS `operation_description`,
        `b`.`operation_date` AS `operation_date`
    FROM
        ((`db_test_7b`.`tb_products` `p`
        JOIN `db_test_7b`.`tb_logs` `b` ON ((`b`.`operation_description` LIKE CONCAT('%ID=', `p`.`ID`, '.%'))))
        LEFT JOIN `mysql`.`role_edges` `re` ON ((`re`.`TO_USER` = SUBSTRING_INDEX(`b`.`db_user`, '@', 1))))
	WHERE
		((`b`.`table_operation` = 'Create')
		AND (`b`.`table_name` = 'tb_products'))
	GROUP BY `p`.`ID`, `p`.`name`, `p`.`description`, `b`.`db_user`, `b`.`operation_description`, `b`.`operation_date`