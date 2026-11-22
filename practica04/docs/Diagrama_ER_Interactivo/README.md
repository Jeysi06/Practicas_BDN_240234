# Diagrama ER interactivo · db_test_7b

Actualizado **a partir del proyecto original** usando el respaldo `respaldo211126_reducido_11000.sql` (SHA-256 `a806c706ba8270da62cd0a1f814a798e4d8bb3dda1f602811831ea396163d759`).

## Abrir

Abre `index.html` con doble clic en un navegador moderno. No requiere MySQL en ejecución ni conexión a internet.

## Contenido

- 25 tablas, 189 columnas, 36 claves foráneas, 41 vistas, 72 triggers y 3 procedimientos.
- 78,854 registros de muestra contenidos en el respaldo.
- Se preservó el diseño original y las herramientas de consulta y navegación.
- Se actualizaron las columnas, claves primarias, foráneas y compuestas, índices, restricciones y los conteos.
- El SQL no fue ejecutado ni se modificó la base de datos.

## Archivos

- `data/schema.json`: metadatos estructurados derivados del respaldo.
- `index.html`: visualización con el mismo diseño de la versión original.

## Controles

Búsqueda, agrupación, zoom, arrastre, resaltado de relaciones y animación: se conservan los controles originales.

## Auditoría y productos

- `tb_logs` se enlaza **lógicamente** con las tablas auditables; **no se añadieron FOREIGN KEY**. En el diagrama, las líneas doradas discontinuas representan esta auditoría y pueden ocultarse desde la barra de herramientas.
- Catálogo reducido a **11,000 productos** preservando todos los identificadores utilizados en los casos 1–5 (incluido el producto 11540).
- Las asociaciones de categorías de los productos retirados se eliminaron del respaldo de prueba; las operaciones de auditoría históricas se conservaron.
- La información procede exclusivamente de `respaldo211126_reducido_11000.sql`, no de consultas en vivo.
