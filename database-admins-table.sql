-- Admin Users Table
-- Add this to your existing database schema

-- Admins Table (for email-based access control)
CREATE TABLE IF NOT EXISTS admins (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Create index for faster email lookups
CREATE INDEX IF NOT EXISTS idx_admins_email ON admins(email);
CREATE INDEX IF NOT EXISTS idx_admins_active ON admins(is_active);

-- Enable Row Level Security
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- Create policy for admins table (only admins can read)
CREATE POLICY "Service role can manage admins" ON admins
    USING (auth.role() = 'service_role');

-- Insert sample admin emails (replace with your actual emails)
INSERT INTO admins (email, full_name, is_active) VALUES
    ('your-email@gmail.com', 'Admin User', true),
    ('usingantigravity@gmail.com', 'Admin User 2', true)
ON CONFLICT (email) DO NOTHING;

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'Admins table created successfully!';
    RAISE NOTICE 'Add your admin emails to grant access to the admin panel';
END $$;
