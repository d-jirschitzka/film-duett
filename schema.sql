-- Supabase Schema für Film-Duett (mit Tim & erweiterten Feldern)
create extension if not exists "pgcrypto";

create table if not exists public.films (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  year text,
  runtime int,
  genres text,
  trailer_url text,
  providers_flatrate text,
  providers_rent text,
  providers_buy text,
  proposer text not null check (proposer in ('David','Tim')),
  yes_david boolean not null default false,
  yes_tim boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.films enable row level security;

drop policy if exists "films read" on public.films;
drop policy if exists "films write" on public.films;
drop policy if exists "films update" on public.films;
drop policy if exists "films delete" on public.films;

create policy "films read" on public.films for select using (true);
create policy "films write" on public.films for insert with check (true);
create policy "films update" on public.films for update using (true);
create policy "films delete" on public.films for delete using (true);
