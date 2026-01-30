-- Add subscribers table
CREATE TABLE IF NOT EXISTS subscribers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;

-- Allow public to insert (subscribe)
CREATE POLICY "Anyone can subscribe" ON subscribers FOR INSERT WITH CHECK (true);

-- Allow admins to read subscribers
CREATE POLICY "Admins can read subscribers" ON subscribers FOR SELECT 
    USING (EXISTS (SELECT 1 FROM admins WHERE email = auth.jwt()->>'email' AND is_active = true));
