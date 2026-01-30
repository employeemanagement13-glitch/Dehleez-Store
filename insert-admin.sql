-- Insert yourself as an admin
-- Replace 'usingantigravity@gmail.com' with your actual Clerk email if different
INSERT INTO admins (email, full_name, is_active)
VALUES ('usingantigravity@gmail.com', 'Super Admin', true)
ON CONFLICT (email) DO NOTHING;

-- Also verify if the table was empty
SELECT * FROM admins;
