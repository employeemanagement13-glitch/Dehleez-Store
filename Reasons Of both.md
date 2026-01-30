# Analysis of Bugs

## 1. Category 404 Error (`/categories/jackets`)

**Behavior:** Accessing `/categories/jackets` returns a 404 or "Category Not Found".

**Potential Causes:**
1.  **Data Mismatch:** The database might not have a category with `slug = 'jackets'`, or it has trailing spaces, or case sensitivity issues.
2.  **Route Logic:** The `isUUID` check might be flagging 'jackets' incorrectly (unlikely, but possible).
3.  **Query Logic:** The database query might be failing silentely.
4.  **Middleware:** A middleware might be interfering with the route, though less likely for this path.

**Action Plan:**
- Add detailed console logging to `app/(customer)/categories/[slug]/page.tsx`.
- Log the received `slug`.
- Log the SQL query result.
- Verify if the `categories` table actually has the data using a verification script.

## 2. Admin Orders "Order not found" & Update Failure

**Behavior:**
- `/admin/orders/[id]` shows "Order not found".
- Updating status fails.

**Potential Causes:**
1.  **Authentication Failure (`checkIsAdmin`):** This is the most probable cause.
    - The logged-in Clerk user's email might not match any email in the `admins` table.
    - The `admins` table might be empty if the SQL script wasn't run or failed.
    - Email case sensitivity (Clerk email vs DB email).
2.  **API Route Path:** The frontend is calling `/api/admin/orders/[id]`. If this route doesn't exist or build failed, it returns 404.
3.  **RLS Policies:** Even with `supabaseAdmin`, if something is misconfigured in the client initialization, RLS might block access.

**Action Plan:**
- Add logging to `app/api/admin/orders/[id]/route.ts`.
- Log the `userId` from Clerk.
- Log the resolved `email` from Clerk.
- Log the result of the `admins` table lookup.
- This will definitively tell us if it's an Auth/Permission issue.
