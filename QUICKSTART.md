# Quick Start Guide

## 📋 Prerequisites Checklist

Before starting, make sure you have:
- [ ] Node.js 18 or higher installed
- [ ] A Supabase account (free tier works)
- [ ] A Clerk account (free tier works)
- [ ] Git installed (optional)

## 🚀 Step-by-Step Setup

### 1. Supabase Setup (Database)

1. Go to [supabase.com](https://supabase.com) and create a new project
2. Wait for the project to be ready (~2 minutes)
3. Go to **Project Settings** → **API**
4. Copy these values (you'll need them later):
   - `Project URL` → This is your `NEXT_PUBLIC_SUPABASE_URL`
   - `anon/public` key → This is your `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `service_role` key → This is your `SUPABASE_SERVICE_ROLE_KEY`
5. Go to **SQL Editor** and run the `database-schema.sql` file content
6. Wait for "Success" message
7. **IMPORTANT**: Replace the sample admin emails in the SQL with YOUR actual email:
   - Find the line: `INSERT INTO admins (email, full_name, is_active) VALUES`
   - Replace `'your-email@gmail.com'` with your actual Clerk login email
   - Or add your email later via Table Editor (see ADMIN_SETUP.md)

### 2. Clerk Setup (Authentication)

1. Go to [clerk.com](https://clerk.com) and create a new application
2. Choose **Email** and **Google** (optional) as sign-in options
3. Go to **API Keys**
4. Copy these values:
   - `Publishable key` → This is your `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`
   - `Secret key` → This is your `CLERK_SECRET_KEY`

### 3. Project Setup

1. Open terminal in the project folder
2. Install dependencies:
```bash
npm install
```

3. Create `.env.local` file and add your keys:
```env
# Clerk
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_your_key_here
CLERK_SECRET_KEY=sk_test_your_key_here

# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_here

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

4. Start the development server:
```bash
npm run dev
```

5. Open [http://localhost:3000](http://localhost:3000) in your browser

## 🎉 You're Done!

### Testing the Store

1. **Customer Side**:
   - Browse products at http://localhost:3000
   - Add items to cart
   - Complete checkout with COD

2. **Admin Side**:
   - Go to http://localhost:3000/admin
   - Sign up/Sign in with Clerk
   - View dashboard and manage orders

## 📝 Adding Products

Since you don't have products yet:

1. Go to **Supabase** → **Table Editor** → **products**
2. Click **Insert** → **Insert row**
3. Add a product manually:
   - name: "Premium Leather Jacket"
   - slug: "premium-leather-jacket"
   - base_price: 8999
   - gender: "men"
   - stock_quantity: 10
   - is_featured: true
4. Go to **product_images** table and add an image:
   - product_id: (select the product you just created)
   - image_url: "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800"
   - is_primary: true

Or use the generated product images in the artifacts folder!

## ❓ Troubleshooting

**Error: "Cannot find module..."**
```bash
npm install
```

**Error: "Supabase connection failed"**
- Check your `.env.local` file
- Make sure URLs don't have trailing slashes
- Verify keys are correct in Supabase dashboard

**Error: "Clerk NEXTPUBLIC_CLERK_PUBLISHABLE_KEY is missing"**
- Check `.env.local` file exists
- Restart the dev server after adding env variables

## 🎯 Next Steps

1. Add more products via Supabase or build the admin product form
2. Customize the color scheme in `tailwind.config.js`
3. Add your logo and branding
4. Test the complete flow from browsing to checkout

Need help? Check the main README.md or contact support!
