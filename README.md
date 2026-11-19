# RetailPro – Análisis de Datos

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos desarrollado en el marco del curso de **Data Analytics de Coderhouse**. Plantea el caso de una distribuidora de tecnología y recorre el camino técnico para analizar sus ventas: modelado, base de datos, consultas SQL y visualización.

Este repositorio contiene la parte de **SQL** del proyecto: la creación de la base `Ventas_Tech_DB` en SQL Server y las consultas de negocio sobre ella.

## Estructura del repositorio

```text
retailpro-data-analytics/
│
├── modulo-3/
│   └── ventas_tech_db.sql
│
├── modulo-4/
│   └── m4_consultas_negocio.sql
│
└── modulo-5/
    └── m5_consultas_joins.sql
```

## Contenido del proyecto

### Módulo 3 – Creación de la base de datos
Archivo: `modulo-3/ventas_tech_db.sql`

Crea las cuatro tablas de `Ventas_Tech_DB` y carga 25 registros de ejemplo:

* `categorias`: categorías de productos.
* `clientes`: datos de los clientes.
* `productos`: productos, precios y stock.
* `ventas`: registro de las operaciones de venta.

### Módulo 4 – Consultas de negocio
Archivo: `modulo-4/m4_consultas_negocio.sql`

Consultas de análisis comercial: resumen mensual, ranking de productos, clientes recurrentes y comparación contra el promedio. Se trabajan `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`, `ORDER BY`, `TOP`, `CASE WHEN` y `WITH`.

### Módulo 5 – Consultas con JOIN y UNION ALL
Archivo: `modulo-5/m5_consultas_joins.sql`

* `INNER JOIN` para armar una vista con cliente, producto y categoría.
* `LEFT JOIN` con `IS NULL` para detectar clientes y productos sin ventas.
* `UNION ALL` para consolidar ventas por período.

## Herramientas utilizadas

* **SQL Server**: creación y gestión de la base de datos.
* **SQL Server Management Studio (SSMS)**: desarrollo y ejecución de los scripts.
* **GitHub**: almacenamiento y seguimiento de versiones.
* **Power BI**: usado en otras etapas del curso (esos archivos no están en este repositorio).

## Cómo ejecutar el proyecto

Se necesita SQL Server y SSMS instalados.

**Paso 1 – Clonar el repositorio**

```bash
git clone https://github.com/julietayacante1-gif/retailpro-data-analytics.git
```

También se puede descargar desde GitHub con el botón **Code → Download ZIP**.

**Paso 2 – Crear la base de datos**

1. Abrir SSMS y conectarse a la instancia de SQL Server.
2. Abrir una consulta nueva y ejecutar:

```sql
CREATE DATABASE Ventas_Tech_DB;
GO
USE Ventas_Tech_DB;
GO
```

3. Con `Ventas_Tech_DB` seleccionada, abrir `modulo-3/ventas_tech_db.sql` y ejecutarlo. El script crea las tablas y carga los datos, y se puede ejecutar varias veces porque borra las tablas antes de crearlas.

**Paso 3 – Ejecutar las consultas de negocio**

1. Abrir `modulo-4/m4_consultas_negocio.sql`.
2. Verificar que la base seleccionada sea `Ventas_Tech_DB`.
3. Ejecutar las consultas.

**Paso 4 – Ejecutar las consultas con JOIN y UNION ALL**

1. Abrir `modulo-5/m5_consultas_joins.sql`.
2. Verificar la base seleccionada.
3. Ejecutar las consultas.

**Importante:** ejecutar en orden, empezando por el Módulo 3, porque los módulos siguientes usan la base creada al principio.

## Autora

Julieta Yacante. Proyecto desarrollado como parte del curso de Data Analytics de Coderhouse.
