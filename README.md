# Base de Datos - Tienda (storeDB)

## Descripción

Este proyecto contiene el esquema de base de datos para una tienda que maneja módulos de:

- Usuarios (`tbUsers`)
- Clientes (`tbClients`)
- Proveedores (`tbSuppliers`)
- Productos (`tbProducts`)
- Categorías (`tbCategories`)
- Unidades de medida (`tbProductUnits`)
- Inventario (`tbInventary`)
- Compras (`tbShopping` y `tbDetailsShopping`)
- Ventas (`tbSales` y `tbDetailsSales`)
- Facturación (`tbInvoice`)
- Alertas (`tbAlerts`)

La base de datos está diseñada para MariaDB/MySQL usando el motor InnoDB, con integridad referencial mediante claves foráneas y lógica automatizada con triggers.

---

## Archivos SQL

- `schema.sql`  
  Define la estructura de las tablas, índices y relaciones.

- `triggers.sql`  
  Contiene triggers para actualizar stock e inventario automáticamente después de compras y ventas.

- `procedures.sql` *(opcional)*  
  Procedimientos almacenados para lógica compleja (si se implementan).

- `data.sql`  
  Inserción de datos iniciales y pruebas (clientes, productos, usuarios, etc).

---

## Estructura de tablas principales

### Usuarios (`tbUsers`)
- Información personal, contacto y estado.

### Clientes (`tbClients`)
- Datos de los clientes para ventas.

### Proveedores (`tbSuppliers`)
- Información de proveedores para compras.

### Productos (`tbProducts`)
- Detalles del producto, precio y stock actual.

### Inventario (`tbInventary`)
- Registros de movimientos de entrada (`IN`) y salida (`OUT`) de productos.

### Compras (`tbShopping` y `tbDetailsShopping`)
- Registro de compras y detalle por producto con precio y cantidad.

### Ventas (`tbSales` y `tbDetailsSales`)
- Registro de ventas y detalle por producto.

### Facturación (`tbInvoice`)
- Facturas generadas para ventas, vinculadas a clientes.

### Alertas (`tbAlerts`)
- Registro de alertas cuando un producto tenga un minimo de 5 de stock 

---

## Triggers 

- Después de insertar en `tbDetailsShopping`:
  - Aumenta stock en `tbProducts`.
  - Registra movimiento `IN` en `tbInventary`.

- Después de insertar en `tbDetailsSales`:
  - Disminuye stock en `tbProducts`.
  - Registra movimiento `OUT` en `tbInventary`.
  - Registra factura de venta en `tbInvoice`

- Antes de insertar en `tbDetailsSales`: 
  -Verifica el stock actual del producto.
  -Si no hay stock suficiente manda alerta. 

- Despues de actualizar en `tbProducts`:
  -Si algun producto tiene 5 piezas se registra una alerta en `tbAlerts`.

---

## Notas

- El stock se mantiene actualizado automáticamente mediante triggers.  
- Los movimientos en inventario permiten auditoría y control de existencias.  
- Se recomienda realizar backups frecuentes de la base de datos.

---