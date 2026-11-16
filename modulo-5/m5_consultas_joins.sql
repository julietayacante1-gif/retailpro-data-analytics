-- Motor utilizado: SQL Server (SSMS)
-- Base de datos: Ventas_Tech_DB
-- Autora: Julieta Yacante
-- Pre-entrega 5: Consultas con JOINs

USE Ventas_Tech_DB;

-- === CONSULTA 1: VISTA BASE DEL PROYECTO (INNER JOIN) ===
-- Propósito: unir ventas con cliente, producto y categoría en una sola tabla,
-- que será la fuente de datos principal del dashboard en Power BI.
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre                         AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario   AS total_venta
FROM ventas v
INNER JOIN clientes c     ON v.id_cliente = c.id_cliente
INNER JOIN productos p    ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- Hallazgo: las 10 ventas cruzaron sin pérdidas con cliente, producto y categoría.
-- La categoría Computación (Laptop Pro 15 y Monitor 4K) concentra el 77% de lo
-- facturado (4950 de 6444), así que el dashboard debería filtrar por categoría.

-- === CONSULTA 2: CLIENTES SIN VENTAS (LEFT JOIN) ===
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM
-- los contacte.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: 0 de los 5 clientes registrados nunca compraron; todos tienen al menos
-- una venta. Para CRM no hay clientes inactivos que reactivar con esta base.

-- === CONSULTA 3: PRODUCTOS SIN VENTAS (LEFT JOIN) ===
-- Propósito: identificar productos del catálogo sin movimiento, para que el área
-- de producto decida si conviene promocionarlos o retirarlos.
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v        ON p.id_producto = v.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

-- Hallazgo: 0 de los 6 productos del catálogo quedaron sin ventas; todos tuvieron
-- movimiento. Para producto no hay artículos sin rotación que revisar, aunque el
-- Mouse Inalámbrico vende volumen con poco ingreso (13 unidades, 364 facturados).

-- === CONSULTA 4: CONSOLIDADO POR PERÍODO (UNION ALL) ===
-- Propósito: comparar lo facturado en la primera y en la segunda quincena de marzo,
-- creando la columna canal como valor fijo en cada SELECT.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Primera quincena' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Segunda quincena' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY canal
ORDER BY canal;

-- Hallazgo: la primera quincena de marzo facturó 3620 (56% del mes) y la segunda
-- 2824 (44%), con 5 pedidos en cada una. Las ventas se aflojaron en la segunda
-- mitad del mes, conviene revisar si hubo menos acciones comerciales.
