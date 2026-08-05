-- 物品管家：在 Supabase SQL Editor 中完整运行。
create extension if not exists pgcrypto;
create table if not exists public.item_manager_items (
 id text not null default gen_random_uuid()::text, user_id uuid not null references auth.users(id) on delete cascade,
 name text not null, category text not null default '其他', location text not null default '',
 quantity numeric not null default 0 check(quantity>=0), unit text not null default '件', min_quantity numeric not null default 0 check(min_quantity>=0),
 production_date date, shelf_days integer check(shelf_days is null or shelf_days>0), expiry_date date,
 no_expiry boolean not null default false, note text not null default '', created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
 primary key(user_id,id));
create index if not exists item_manager_items_user_idx on public.item_manager_items(user_id);
create index if not exists item_manager_items_expiry_idx on public.item_manager_items(user_id,expiry_date);
create table if not exists public.item_manager_settings (
 user_id uuid primary key references auth.users(id) on delete cascade,
 categories jsonb not null default '["食品","药品","护肤美妆","清洁用品","宠物用品","日常用品","其他"]'::jsonb,
 notice_days integer not null default 7 check(notice_days between 0 and 3650), updated_at timestamptz not null default now());
alter table public.item_manager_items enable row level security;
alter table public.item_manager_settings enable row level security;
drop policy if exists "item manager select own items" on public.item_manager_items;
create policy "item manager select own items" on public.item_manager_items for select to authenticated using ((select auth.uid())=user_id);
drop policy if exists "item manager insert own items" on public.item_manager_items;
create policy "item manager insert own items" on public.item_manager_items for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists "item manager update own items" on public.item_manager_items;
create policy "item manager update own items" on public.item_manager_items for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
drop policy if exists "item manager delete own items" on public.item_manager_items;
create policy "item manager delete own items" on public.item_manager_items for delete to authenticated using ((select auth.uid())=user_id);
drop policy if exists "item manager select own settings" on public.item_manager_settings;
create policy "item manager select own settings" on public.item_manager_settings for select to authenticated using ((select auth.uid())=user_id);
drop policy if exists "item manager insert own settings" on public.item_manager_settings;
create policy "item manager insert own settings" on public.item_manager_settings for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists "item manager update own settings" on public.item_manager_settings;
create policy "item manager update own settings" on public.item_manager_settings for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
drop policy if exists "item manager delete own settings" on public.item_manager_settings;
create policy "item manager delete own settings" on public.item_manager_settings for delete to authenticated using ((select auth.uid())=user_id);
revoke all on public.item_manager_items from anon;
revoke all on public.item_manager_settings from anon;
grant select,insert,update,delete on public.item_manager_items to authenticated;
grant select,insert,update,delete on public.item_manager_settings to authenticated;
