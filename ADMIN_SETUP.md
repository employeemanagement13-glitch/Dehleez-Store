# Admin Access Setup

## How to Add Admin Users

### Option 1: Using Supabase Table Editor (Recommended for Beginners)

1. Go to your Supabase project dashboard
2. Click on **Table Editor** in the left sidebar
3. Find and click on the **admins** table
4. Click **Insert** → **Insert row**
5. Fill in:
   - `email`: Your email address (must match Clerk login email)
   - `full_name`: Your full name
   - `is_active`: `true`
6. Click **Save**
7. Sign in to your store with that email at `/admin`

### Option 2: Using SQL Editor

1. Go to **SQL Editor** in Supabase
2. Run this query (replace with your email):

```sql
INSERT INTO admins (email, full_name, is_active) 
VALUES ('your-email@example.com', 'Your Name', true);
```

3. Click **Run**

## How It Works

1. User signs in with Clerk at `/admin`
2. Middleware extracts their email from Clerk session
3. Checks if email exists in `admins` table with `is_active = true`
4. If yes → Access granted to admin panel
5. If no → Redirected to homepage

## Managing Admin Access

### Add a New Admin
```sql
INSERT INTO admins (email, full_name, is_active) 
VALUES ('newadmin@example.com', 'New Admin Name', true);
```

### Deactivate an Admin (without deleting)
```sql
UPDATE admins 
SET is_active = false 
WHERE email = 'admin@example.com';
```

### Reactivate an Admin
```sql
UPDATE admins 
SET is_active = true 
WHERE email = 'admin@example.com';
```

### View All Admins
```sql
SELECT email, full_name, is_active, created_at 
FROM admins 
ORDER BY created_at DESC;
```

### Remove an Admin Permanently
```sql
DELETE FROM admins 
WHERE email = 'admin@example.com';
```

## Security Notes

- Only emails in the `admins` table can access `/admin/*` routes
- Inactive admins (`is_active = false`) cannot access admin panel
- The table uses Row Level Security (RLS)
- Only service role can modify the admins table

## Troubleshooting

**"Access Denied" even though email is in admins table:**
- Make sure the email in admins table exactly matches your Clerk login email (case-insensitive)
- Verify `is_active` is set to `true`
- Check Supabase logs for any errors

**Want to test with a different email:**
1. Sign out from Clerk
2. Sign up with a new email
3. Add that new email to admins table
4. Try accessing `/admin`
