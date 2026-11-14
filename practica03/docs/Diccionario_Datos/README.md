# Diccionario de Datos · db_test_7b

Documento reconstruido desde cero a partir de `respaldo1411_3.sql` (SHA-256 `61cbd9b1c8b2a87fdfe9b8e42f6a96dd077dc579a2ae78f5fba1dce6c4163956`).

## Contenido

- `index.html`: versión navegable e imprimible (no requiere servidor; abre con doble clic). Usa **Imprimir / guardar como PDF**.
- `Diccionario_de_Datos.md`: misma información en Markdown.
- `data/schema.json`: metadatos estructurados (columnas, claves, índices, relaciones, conteos).

## Qué incluye

- 25 tablas, 185 columnas, 32 claves foráneas, 37 vistas, 72 triggers y 3 procedimientos.
- Una **Descripción** por tabla y por columna.
- El **número de registros de cada tabla** (tabla resumen con total de 86,707 y una insignia en cada sección).

## Verificación

Los conteos son las filas de las sentencias `INSERT` del respaldo, contadas con un analizador que respeta cadenas y escapes, y contrastadas con un segundo método independiente (coinciden las 6 tablas con datos). No es una consulta en vivo y el SQL no se ejecutó. El respaldo no trae `COMMENT`, así que las descripciones son editoriales (inferidas de nombres, tipos y relaciones).
