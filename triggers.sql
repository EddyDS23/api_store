use storeDB;

DELIMITER //

-- Trigger para registrar en inventario movimiento "IN" y aumentar stock
CREATE TRIGGER add_record_inventary_IN
AFTER INSERT ON tbDetailsShopping
FOR EACH ROW
BEGIN
    UPDATE tbProducts 
    SET prod_stock = prod_stock + NEW.detshop_quantity
    WHERE prod_id = NEW.detshop_prod_id;

    INSERT INTO tbInventary(inv_prod_id, inv_mov_type, inv_mov_quantity, inv_reference_id)
    VALUES (NEW.detshop_prod_id, 'IN', NEW.detshop_quantity, NEW.detshop_shop_id); 
END //

-- Trigger para registrar factura por cada venta
CREATE TRIGGER add_invoice_after_sale
AFTER INSERT ON tbSales
FOR EACH ROW 
BEGIN

    INSERT INTO tbInvoice(invo_sale_id)
    VALUES (NEW.sale_id);

END //


-- Trigger para registrar en inventario movimiento "OUT", disminuir stock y agregar factura
CREATE TRIGGER add_record_inventary_OUT
AFTER INSERT ON tbDetailsSales
FOR EACH ROW
BEGIN
    UPDATE tbProducts
    SET prod_stock = prod_stock - NEW.detsale_quantity
    WHERE prod_id = NEW.detsale_prod_id;

    INSERT INTO tbInventary(inv_prod_id, inv_mov_type, inv_mov_quantity, inv_reference_id)
    VALUES (NEW.detsale_prod_id, 'OUT', NEW.detsale_quantity, NEW.detsale_sale_id); 

END //

-- Trigger para validar stock antes de venta
CREATE TRIGGER validate_stock 
BEFORE INSERT ON tbDetailsSales
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    SELECT prod_stock INTO current_stock 
    FROM tbProducts 
    WHERE prod_id = NEW.detsale_prod_id;

    IF current_stock < NEW.detsale_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No hay suficiente stock para producto";
    END IF;
END //

-- Trigger para registrar alerta cuando stock está bajo
CREATE TRIGGER add_alert_stock
AFTER UPDATE ON tbProducts
FOR EACH ROW 
BEGIN
    IF NEW.prod_stock < 6 AND NOT EXISTS (
        SELECT 1 FROM tbAlerts WHERE alert_prod_id = NEW.prod_id AND alert_seen = 0
    ) THEN
        INSERT INTO tbAlerts(alert_prod_id, alert_message)
        VALUES (NEW.prod_id, CONCAT("Stock crítico: ", NEW.prod_stock, " unidades disponibles"));
    END IF;
END //

DELIMITER ;
