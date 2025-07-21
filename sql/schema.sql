-- BASE DE DATOS PARA TIENDA
CREATE DATABASE IF NOT EXISTS storeDB
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE storeDB;

-- =====================
-- Tabla: Usuarios
-- =====================
CREATE TABLE tbUsers (
    user_id                  INT NOT NULL AUTO_INCREMENT,
    user_name                VARCHAR(100) NOT NULL,
    user_lastname_paternal   VARCHAR(100) NOT NULL,
    user_lastname_maternal   VARCHAR(100) NOT NULL,
    user_number              VARCHAR(20)  NOT NULL,
    user_email               VARCHAR(100) NOT NULL,
    user_password            VARCHAR(255) NOT NULL,
    user_address             VARCHAR(255) NULL,
    user_create              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_update              TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_status              TINYINT DEFAULT 1,
    CONSTRAINT pk_user_id PRIMARY KEY (user_id),
    CONSTRAINT unique_user_email UNIQUE (user_email)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Clientes
-- =====================
CREATE TABLE tbClients (
    cli_id                   INT NOT NULL AUTO_INCREMENT,
    cli_name                 VARCHAR(100) NOT NULL,
    cli_lastname_paternal    VARCHAR(100) NOT NULL, 
    cli_lastname_maternal    VARCHAR(100) NOT NULL,
    cli_number               VARCHAR(20)  NOT NULL,
    cli_email                VARCHAR(100) NOT NULL,
    cli_address              VARCHAR(255) NOT NULL,
    cli_create               TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cli_update               TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    cli_status               TINYINT DEFAULT 1,
    CONSTRAINT pk_cli_id PRIMARY KEY (cli_id),
    CONSTRAINT unique_cli_email UNIQUE (cli_email)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Proveedores
-- =====================
CREATE TABLE tbSuppliers (
    sup_id                  INT NOT NULL AUTO_INCREMENT,
    sup_name                VARCHAR(100) NOT NULL,
    sup_number              VARCHAR(20)  NOT NULL,
    sup_email               VARCHAR(100) NOT NULL,
    sup_contact             VARCHAR(100) NOT NULL,
    sup_address             VARCHAR(255) NULL,
    sup_create              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sup_update              TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    sup_status              TINYINT DEFAULT 1,
    CONSTRAINT pk_sup_id    PRIMARY KEY (sup_id),
    CONSTRAINT unique_sup_email UNIQUE (sup_email)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Categorías
-- =====================
CREATE TABLE tbCategories (
    cat_id                  INT NOT NULL AUTO_INCREMENT,
    cat_name                VARCHAR(150) NOT NULL,
    CONSTRAINT pk_cat_id    PRIMARY KEY (cat_id),
    CONSTRAINT unique_cat_name UNIQUE (cat_name)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Unidades de producto
-- =====================
CREATE TABLE tbProductUnits (
    produni_id             INT NOT NULL AUTO_INCREMENT,
    produni_name           VARCHAR(20) NOT NULL,
    CONSTRAINT pk_produni_id       PRIMARY KEY (produni_id),
    CONSTRAINT unique_produni_name UNIQUE (produni_name)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Productos
-- =====================
CREATE TABLE tbProducts (
    prod_id               INT NOT NULL AUTO_INCREMENT,
    prod_name             VARCHAR(100) NOT NULL,
    prod_description      VARCHAR(200) NULL,
    prod_price            DECIMAL(10,2) NOT NULL,
    prod_stock            INT NOT NULL,
    prod_produni_id       INT NOT NULL,
    prod_cat_id           INT NOT NULL,
    prod_create           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prod_update           TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    prod_status           TINYINT DEFAULT 1,
    CONSTRAINT pk_prod_id PRIMARY KEY (prod_id),
    CONSTRAINT fk_prod_cat_id     FOREIGN KEY (prod_cat_id) REFERENCES tbCategories (cat_id),
    CONSTRAINT fk_prod_produni_id FOREIGN KEY (prod_produni_id) REFERENCES tbProductUnits (produni_id),
    CONSTRAINT unique_prod_name   UNIQUE (prod_name),
    CONSTRAINT check_prod_stock   CHECK (prod_stock >= 0)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Inventario (Movimientos)
-- =====================
CREATE TABLE tbInventary (
    inv_id                INT NOT NULL AUTO_INCREMENT,
    inv_prod_id           INT NOT NULL,
    inv_mov_type          ENUM('IN','OUT') NOT NULL,
    inv_mov_quantity      INT NOT NULL,
    inv_reference_id      INT NOT NULL,
    inv_create            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_inv_id   PRIMARY KEY (inv_id),
    CONSTRAINT fk_inv_prod FOREIGN KEY (inv_prod_id) REFERENCES tbProducts (prod_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Ventas (cabecera)
-- =====================
CREATE TABLE tbSales (
    sale_id               INT NOT NULL AUTO_INCREMENT,
    sale_amount_total     DECIMAL(12,2) NOT NULL,
    sale_cli_id           INT NOT NULL,
    sale_create           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_sale_id     PRIMARY KEY (sale_id),
    CONSTRAINT fk_sale_cli_id FOREIGN KEY (sale_cli_id) REFERENCES tbClients (cli_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Detalle de ventas
-- =====================
CREATE TABLE tbDetailsSales (
    detsale_id            INT NOT NULL AUTO_INCREMENT,
    detsale_quantity      INT NOT NULL,
    detsale_unit_price    DECIMAL(10,2) NOT NULL,
    detsale_total         DECIMAL(10,2) NOT NULL,
    detsale_prod_id       INT NOT NULL,
    detsale_sale_id       INT NOT NULL,
    CONSTRAINT pk_detsale_id      PRIMARY KEY (detsale_id),
    CONSTRAINT fk_detsale_sale_id FOREIGN KEY (detsale_sale_id) REFERENCES tbSales (sale_id),
    CONSTRAINT fk_detsale_prod_id FOREIGN KEY (detsale_prod_id) REFERENCES tbProducts (prod_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Compras (cabecera)
-- =====================
CREATE TABLE tbShopping (
    shop_id               INT NOT NULL AUTO_INCREMENT,
    shop_amount_total     DECIMAL(12,2) NOT NULL,
    shop_sup_id           INT NOT NULL,
    shop_create           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_shop_id PRIMARY KEY (shop_id),
    CONSTRAINT fk_shop_sup_id FOREIGN KEY (shop_sup_id) REFERENCES tbSuppliers (sup_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Detalle de compras
-- =====================
CREATE TABLE tbDetailsShopping (
    detshop_id            INT NOT NULL AUTO_INCREMENT,
    detshop_unit_price    DECIMAL(10,2) NOT NULL,
    detshop_quantity      INT NOT NULL,
    detshop_total         DECIMAL(12,2) NOT NULL,
    detshop_prod_id       INT NOT NULL,
    detshop_shop_id       INT NOT NULL,
    CONSTRAINT pk_detshop_id PRIMARY KEY (detshop_id),
    CONSTRAINT fk_detshop_shop_id FOREIGN KEY (detshop_shop_id) REFERENCES tbShopping (shop_id),
    CONSTRAINT fk_detshop_prod_id FOREIGN KEY (detshop_prod_id) REFERENCES tbProducts (prod_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Facturas
-- =====================
CREATE TABLE tbInvoice (
    invo_id               INT NOT NULL AUTO_INCREMENT,
    invo_sale_id          INT NOT NULL,
    invo_create           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_invo_id       PRIMARY KEY (invo_id),
    CONSTRAINT fk_invo_sale_id  FOREIGN KEY (invo_sale_id) REFERENCES tbSales (sale_id),
    CONSTRAINT unique_invo_sale UNIQUE (invo_sale_id)
) ENGINE=InnoDB;

-- =====================
-- Tabla: Alertas de stock
-- =====================
CREATE TABLE tbAlerts (
    alert_id              INT NOT NULL AUTO_INCREMENT,
    alert_prod_id         INT NOT NULL,
    alert_message         VARCHAR(200) NOT NULL,
    alert_seen            TINYINT DEFAULT 0,
    alert_create          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_alert_id      PRIMARY KEY (alert_id),
    CONSTRAINT fk_alert_prod_id FOREIGN KEY (alert_prod_id) REFERENCES tbProducts (prod_id)
) ENGINE=InnoDB;
