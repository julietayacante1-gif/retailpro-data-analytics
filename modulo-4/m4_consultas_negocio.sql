-- Motor utilizado: SQL Server (SSMS)
-- Base de datos: Ventas_Tech_DB
-- Autora: Julieta Yacante
-- Pre-entrega 4: Consultas SQL de negocio

USE Ventas_Tech_DB;

-- === CONSULTA 1: RESUMEN EJECUTIVO MENSUAL ===
SELECT
    MONTH(fecha_venta)                 AS mes,
    SUM(cantidad * precio_unitario)    AS total_facturado,
    COUNT(*)                           AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)    AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

-- === CONSULTA 2: RANKING DE PRODUCTOS (TOP 5) ===
SELECT TOP 5
    id_producto,
    SUM(cantidad)                      AS unidades_vendidas,
    SUM(cantidad * precio_unitario)    AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- === CONSULTA 3: CLIENTES RECURRENTES ===
SELECT
    id_cliente,
    COUNT(*)                           AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)    AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- === CONSULTA 4: PRODUCTOS POR ENCIMA / POR DEBAJO DEL PROMEDIO ===
WITH totales_por_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM totales_por_producto)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM totales_por_producto
ORDER BY total_facturado DESC;

-- === HALLAZGOS ===
-- 1. El producto 1 concentra el 56% de la facturación (3600 de 6444) y, junto
--    con el producto 3, llega al 77%. Conviene asegurar su stock y reducir la
--    dependencia de esos dos productos.
-- 2. El producto 2 es el más vendido en unidades (13) pero solo aporta el 6% de
--    lo facturado (364), porque su precio es bajo. Podría usarse como producto
--    de entrada para vender combos con productos de mayor valor.
-- 3. Todos los clientes compraron 2 veces, pero los clientes 1 y 5 explican el
--    74% de lo gastado. Conviene priorizarlos en acciones de fidelización.
