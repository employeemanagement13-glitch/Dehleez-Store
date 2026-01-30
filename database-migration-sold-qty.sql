-- Add sold_quantity column to products table
ALTER TABLE products ADD COLUMN IF NOT EXISTS sold_quantity INT DEFAULT 0;

-- Function to update sold_quantity on order placement
CREATE OR REPLACE FUNCTION update_sold_quantity()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET sold_quantity = sold_quantity + NEW.quantity
    WHERE id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the function
DROP TRIGGER IF EXISTS trigger_update_sold_quantity ON order_items;
CREATE TRIGGER trigger_update_sold_quantity
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_sold_quantity();

-- Optional: Backfill logic (run manually if needed)
-- UPDATE products p
-- SET sold_quantity = (
--     SELECT COALESCE(SUM(quantity), 0)
--     FROM order_items oi
--     WHERE oi.product_id = p.id
-- );
