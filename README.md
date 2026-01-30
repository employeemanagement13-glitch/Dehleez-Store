# Online Store - E-Commerce Platform

A modern, full-featured e-commerce platform for selling premium outerwear built with Next.js, TypeScript, Supabase, and Clerk.

## Features

### Customer Store
- 🏠 **Home Page** - Hero section, featured products, category showcases
- 🛍️ **Shop** - Product browsing with search, filters, and sorting
- 👔 **Collections** - Men's, Women's, Winter, and Summer collections
- 📦 **Product Details** - Image gallery, variant selection, add to cart
- 🛒 **Shopping Cart** - Full cart management with quantity controls
- 💰 **Checkout** - COD (Cash on Delivery) payment processing
- ✅ **Order Confirmation** - Order success page with tracking info

### Admin Panel
- 📊 **Dashboard** - Real-time stats and recent orders
- 📦 **Product Management** - CRUD operations for products
- 📋 **Order Management** - View and update order statuses in real-time
- 🔒 **Protected Routes** - Clerk authentication for admin access

## Tech Stack

- **Framework**: Next.js 16 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Clerk
- **State Management**: Zustand
- **Real-time**: Supabase Realtime

## Getting Started

### Prerequisites

- Node.js 18+ installed
- Supabase account
- Clerk account

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd "Online Store"
```

2. Install dependencies
```bash
npm install
```

3. Set up environment variables

Copy `.env.example` to `.env.local` and fill in your credentials:

```env
# Clerk
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
CLERK_SECRET_KEY=your_clerk_secret_key

# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

4. Set up Supabase database

Run the SQL schema from `/docs/database-schema.sql` in your Supabase SQL editor.

5. Run the development server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to see the store.

### Admin Access

To access the admin panel:
1. Sign up/Sign in using Clerk at `/admin`
2. Navigate to `/admin` to access the dashboard

## Project Structure

```
├── app/
│   ├── (customer)/          # Customer-facing pages
│   │   ├── page.tsx         # Home page
│   │   ├── shop/            # Shop page
│   │   ├── product/         # Product details
│   │   ├── cart/            # Shopping cart
│   │   └── checkout/        # Checkout page
│   ├── admin/               # Admin panel
│   │   ├── page.tsx         # Dashboard
│   │   ├── products/        # Product management
│   │   └── orders/          # Order management
│   └── api/                 # API routes
├── components/
│   ├── customer/            # Customer components
│   └── admin/               # Admin components
├── lib/
│   ├── supabase.ts          # Supabase client
│   ├── store.ts             # Zustand store
│   └── utils.ts             # Utility functions
└── types/
    └── index.ts             # TypeScript types
```

## Key Features

### Real-time Updates
- Orders appear instantly in admin dashboard
- Stock levels update in real-time across the store

### Cash on Delivery (COD)
- Simple checkout process
- No payment gateway integration needed
- Payment collected on delivery

### Responsive Design
- Mobile-first approach
- Works seamlessly on all devices

## Development

### Running in Development
```bash
npm run dev
```

### Building for Production
```bash
npm run build
npm run start
```

### Type Checking
```bash
npm run type-check
```

## Database Schema

The project uses the following main tables:
- **products** - Product catalog
- **product_images** - Product images
- **product_variants** - Size and color variants
- **categories** - Product categories
- **orders** - Customer orders
- **order_items** - Order line items

See implementation_plan.md for detailed schema.

## License

Private - All Rights Reserved

## Support

For support, email info@store.com
