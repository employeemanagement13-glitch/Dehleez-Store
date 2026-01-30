-- Create Inquiries Table
CREATE TABLE IF NOT EXISTS inquiries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS for inquiries
ALTER TABLE inquiries ENABLE ROW LEVEL SECURITY;

-- Allow anyone to insert inquiries (public contact form)
CREATE POLICY "Anyone can insert inquiries" ON inquiries FOR INSERT WITH CHECK (true);

-- Allow admins to view inquiries
CREATE POLICY "Admins can view inquiries" ON inquiries FOR SELECT USING (auth.role() = 'service_role');


-- Shipping Cost Calculation Function
CREATE OR REPLACE FUNCTION calculate_shipping_cost()
RETURNS TRIGGER AS $$
DECLARE
    shipping_fee DECIMAL(10, 2);
    country_match BOOLEAN;
BEGIN
    -- Check if shipping address contains 'Pakistan' (case insensitive)
    -- This is a simple check. For more robust logic, we'd augment the address schema.
    IF NEW.shipping_address ILIKE '%Pakistan%' THEN
        shipping_fee := 0;
    ELSE
        shipping_fee := 10; -- $10 for international
    END IF;

    -- Update the shipping_cost and total
    NEW.shipping_cost := shipping_fee;
    NEW.total := NEW.subtotal + shipping_fee;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create Trigger for Orders
DROP TRIGGER IF EXISTS trigger_calculate_shipping_cost ON orders;

CREATE TRIGGER trigger_calculate_shipping_cost
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_shipping_cost();

-- Notify
DO $$
BEGIN
    RAISE NOTICE 'Inquiries table and Shipping Cost trigger created successfully.';
END $$;
