-- E-Commerce Store Database Schema
-- Run this in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Catalogues Table
CREATE TABLE IF NOT EXISTS catalogues (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    gender VARCHAR(50),
    category_id UUID REFERENCES categories(id),
    is_featured BOOLEAN DEFAULT false,
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Product Images Table
CREATE TABLE IF NOT EXISTS product_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT false,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Product Variants Table
CREATE TABLE IF NOT EXISTS product_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    size VARCHAR(10),
    color VARCHAR(50),
    stock INT DEFAULT 0,
    price_adjustment DECIMAL(10, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Product Catalogues Junction Table
CREATE TABLE IF NOT EXISTS product_catalogues (
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    catalogue_id UUID REFERENCES catalogues(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, catalogue_id)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(50),
    shipping_address TEXT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    shipping_cost DECIMAL(10, 2) DEFAULT 0,
    total DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'cod',
    payment_status VARCHAR(50) DEFAULT 'pending',
    fulfillment_status VARCHAR(50) DEFAULT 'unfulfilled',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    size VARCHAR(10),
    color VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Admins Table (Email-based access control)
CREATE TABLE IF NOT EXISTS admins (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_gender ON products(gender);
CREATE INDEX IF NOT EXISTS idx_products_featured ON products(is_featured);
CREATE INDEX IF NOT EXISTS idx_product_images_product ON product_images(product_id);
CREATE INDEX IF NOT EXISTS idx_product_variants_product ON product_variants(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(fulfillment_status);
CREATE INDEX IF NOT EXISTS idx_orders_created ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_admins_email ON admins(email);
CREATE INDEX IF NOT EXISTS idx_admins_active ON admins(is_active);

-- Enable Row Level Security (RLS)
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE catalogues ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Public can read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public can read products" ON products FOR SELECT USING (true);
CREATE POLICY "Public can read product images" ON product_images FOR SELECT USING (true);
CREATE POLICY "Public can read product variants" ON product_variants FOR SELECT USING (true);
CREATE POLICY "Public can read active catalogues" ON catalogues FOR SELECT USING (is_active = true);

-- Create policies for orders (customers can create, admins can update)
CREATE POLICY "Anyone can create orders" ON orders FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can create order items" ON order_items FOR INSERT WITH CHECK (true);

-- Create policy for admins table (service role only)
CREATE POLICY "Service role can manage admins" ON admins
    USING (auth.role() = 'service_role');

-- Enable Realtime for specific tables
ALTER PUBLICATION supabase_realtime ADD TABLE products;
ALTER PUBLICATION supabase_realtime ADD TABLE orders;
ALTER PUBLICATION supabase_realtime ADD TABLE order_items;

-- Insert sample categories
INSERT INTO categories (name, slug, description) VALUES
    ('Jackets', 'jackets', 'Stylish jackets for all occasions'),
    ('Puffers', 'puffers', 'Warm puffer jackets for winter'),
    ('Leather Jackets', 'leather-jackets', 'Premium leather jackets'),
    ('Coats', 'coats', 'Elegant coats and overcoats'),
    ('Biker Jackets', 'biker-jackets', 'Edgy biker style jackets')
ON CONFLICT (slug) DO NOTHING;

-- Insert sample admin emails (REPLACE WITH YOUR ACTUAL EMAILS)
INSERT INTO admins (email, full_name, is_active) VALUES
    ('your-email@gmail.com', 'Admin User', true),
    ('admin@store.com', 'Store Admin', true)
ON CONFLICT (email) DO NOTHING;

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'Database schema created successfully!';
    RAISE NOTICE 'Tables created: categories, products, product_images, product_variants, catalogues, orders, order_items';
    RAISE NOTICE 'Sample categories inserted';
    RAISE NOTICE 'Real-time enabled for: products, orders, order_items';
END $$;
