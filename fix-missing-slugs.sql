-- Fix missing slugs for existing categories
UPDATE categories
SET slug = lower(regexp_replace(name, '[^a-zA-Z0-9]+', '-', 'g'))
WHERE slug IS NULL OR slug = '';

-- Ensure slugs are unique (basic collision handling might be needed manually if this fails)
-- This script assumes names are distinct enough to generate distinct slugs.
