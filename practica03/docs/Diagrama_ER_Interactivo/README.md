# Diagrama ER interactivo · db_test_7b

Reconstruido desde cero a partir de `respaldo1411_3.sql` (SHA-256 `61cbd9b1c8b2a87fdfe9b8e42f6a96dd077dc579a2ae78f5fba1dce6c4163956`).

## Abrir

Abre `index.html` con doble clic en cualquier navegador moderno. Es un solo archivo con los datos incluidos: no requiere servidor, conexión a base de datos ni dependencias externas.

## Contenido

- 25 tablas, 185 columnas y 32 claves foráneas.
- Cada tabla muestra en su encabezado el **número de registros** incluido en el respaldo; el panel lateral lista el conteo de todas las tablas (total 86,707), ordenable por registros o por nombre.
- Al seleccionar una tabla, el panel muestra su **descripción**, las descripciones de cada columna, índices, relaciones y restricciones CHECK.

## Controles

- Buscar por tabla o columna, filtrar por grupo (tb, tbc, tbd).
- Rueda del ratón y botones + / − para zoom; arrastrar el fondo para mover el lienzo; arrastrar el encabezado de una tabla para reubicarla.
- Clic en una tabla o en una relación para resaltarla; **Ajustar**, **Restablecer** y **Mostrar todas**.
- Pausar o reanudar la animación del flujo y ajustar su velocidad (se pausa sola si el sistema pide reducir movimiento).

## Alcance

Los conteos son las filas de las sentencias `INSERT` del respaldo, no una consulta en vivo. El respaldo no incluye `COMMENT`, así que las descripciones son editoriales, inferidas de nombres, tipos y relaciones. El SQL no se ejecutó.
