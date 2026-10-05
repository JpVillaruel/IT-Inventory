-- Chemlux IT Inventory — Supabase setup
-- Run this once in Supabase: Dashboard → SQL Editor → New query → paste → Run

create table if not exists records (
  id text primary key,
  collection text not null,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

create index if not exists records_collection_idx on records (collection);

-- Row Level Security
alter table records enable row level security;

-- This is an internal tool with no login screen, so we allow the anon key
-- (the public "anon" key, not a secret) full read/write access.
-- If you later add Supabase Auth / a login screen, tighten these policies
-- to check auth.uid() instead.
drop policy if exists "public read" on records;
create policy "public read" on records for select using (true);

drop policy if exists "public insert" on records;
create policy "public insert" on records for insert with check (true);

drop policy if exists "public update" on records;
create policy "public update" on records for update using (true);

drop policy if exists "public delete" on records;
create policy "public delete" on records for delete using (true);

-- Realtime: lets multiple people editing at once see each other's changes live
alter publication supabase_realtime add table records;
