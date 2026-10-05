# Connecting Chemlux IT Inventory to Supabase

Your Vercel deployment needs its own database — it can't use Claude's
built-in storage. Supabase gives you that database for free. Takes about 5 minutes.

## 1. Create a Supabase project
1. Go to https://supabase.com → sign in → **New project**
2. Pick a name, a database password (save it somewhere), and a region close to you
3. Wait ~1–2 minutes for it to finish provisioning

## 2. Create the storage table
1. In your new project, open **SQL Editor** (left sidebar)
2. Click **New query**
3. Paste in the contents of `supabase-setup.sql` (included alongside this file)
4. Click **Run**

You should see "Success. No rows returned."

## 3. Get your API keys
1. Go to **Settings → API** (left sidebar, gear icon)
2. Copy the **Project URL** (looks like `https://xxxxxxxx.supabase.co`)
3. Copy the **anon public** key (a long string starting with `eyJ...`)
   — this is the public key, safe to use in the browser. Never use the
   `service_role` key in this file.

## 4. Paste them into the app
Open `chemlux-it-inventory.html` in a text editor and find these two lines
near the top of the `<script>` section:

```js
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Replace the placeholders with your actual values:

```js
const SUPABASE_URL = 'https://xxxxxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOi...(your long key)';
```

Save the file.

## 5. Push to GitHub → Vercel redeploys automatically
```bash
git add chemlux-it-inventory.html
git commit -m "Connect to Supabase"
git push
```
Vercel will pick up the push and redeploy automatically (check your Vercel
dashboard for the build status).

## 6. Test it
Open your Vercel URL, add/edit/delete something, then **refresh the page**.
The change should still be there. On first load, the app will automatically
copy in the starting inventory data (same as before) — this only happens once.

---

### Notes
- This is an internal tool with no login screen, so the Supabase table is set
  up to accept read/write from anyone who has the page open (via the public
  `anon` key). Don't share the Vercel link publicly if the data is sensitive.
- Multiple people can have the page open at once — changes sync live between
  them (via Supabase Realtime).
- The same HTML file still works fine if opened through the claude.ai
  artifact link — it automatically uses Claude's storage there instead, and
  only falls back to Supabase when Claude's storage isn't available (like on
  Vercel).
