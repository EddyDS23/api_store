use storeDB;

-- Indexes para tbProducts
CREATE INDEX idx_prod_name ON tbProducts (prod_name);
CREATE INDEX idx_prod_cat ON tbProducts (prod_cat_id);
CREATE INDEX idx_prod_unit ON tbProducts (prod_produni_id);

-- Indexes para tbSales
CREATE INDEX idx_sale_client ON tbSales (sale_cli_id);
CREATE INDEX idx_sale_date ON tbSales (sale_create);

-- Indexes para tbDetailsSales
CREATE INDEX idx_detsale_sale ON tbDetailsSales (detsale_sale_id);
CREATE INDEX idx_detsale_prod ON tbDetailsSales (detsale_prod_id);

-- Indexes para tbShopping
CREATE INDEX idx_shop_supplier ON tbShopping (shop_sup_id);
CREATE INDEX idx_shop_date ON tbShopping (shop_create);

-- Indexes para tbDetailsShopping
CREATE INDEX idx_detshop_shop ON tbDetailsShopping (detshop_shop_id);
CREATE INDEX idx_detshop_prod ON tbDetailsShopping (detshop_prod_id);

-- Indexes para tbInventary
CREATE INDEX idx_inv_prod ON tbInventary (inv_prod_id);
CREATE INDEX idx_inv_prod_type ON tbInventary (inv_prod_id, inv_mov_type);
CREATE INDEX idx_inv_reference ON tbInventary (inv_reference_id);

-- Indexes para tbAlerts
CREATE INDEX idx_alerts_prod_seen ON tbAlerts (alert_prod_id, alert_seen);
