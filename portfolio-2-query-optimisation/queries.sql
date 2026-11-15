-- Show related charging_sessions, vehicles, customers, stations records (up to 20).
SELECT t0."session_id" AS "charging_sessions_session_id",
       t0."started_at" AS "charging_sessions_started_at",
       t1."vehicle_id" AS "vehicles_vehicle_id",
       t1."vin" AS "vehicles_vin",
       t2."customer_id" AS "customers_customer_id",
       t2."account_ref" AS "customers_account_ref",
       t3."station_id" AS "stations_station_id",
       t3."station_code" AS "stations_station_code"
FROM portfolio."charging_sessions" t0
JOIN portfolio."vehicles" t1 ON t0."vehicle_id" = t1."vehicle_id"
JOIN portfolio."customers" t2 ON t1."customer_id" = t2."customer_id"
JOIN portfolio."stations" t3 ON t0."station_id" = t3."station_id"
ORDER BY t0."session_id", t1."vehicle_id", t2."customer_id", t3."station_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."session_id" AS "charging_sessions_session_id",
       t0."started_at" AS "charging_sessions_started_at",
       t1."vehicle_id" AS "vehicles_vehicle_id",
       t1."vin" AS "vehicles_vin",
       t2."customer_id" AS "customers_customer_id",
       t2."account_ref" AS "customers_account_ref",
       t3."station_id" AS "stations_station_id",
       t3."station_code" AS "stations_station_code"
FROM portfolio."charging_sessions" t0
JOIN portfolio."vehicles" t1 ON t0."vehicle_id" = t1."vehicle_id"
JOIN portfolio."customers" t2 ON t1."customer_id" = t2."customer_id"
JOIN portfolio."stations" t3 ON t0."station_id" = t3."station_id"
ORDER BY t0."session_id", t1."vehicle_id", t2."customer_id", t3."station_id"
LIMIT 20;

-- Find charging_sessions records where started_at matches "2026-11-14T09:00:00+00:00" (up to 20).
SELECT * FROM portfolio."charging_sessions"
WHERE "started_at" IS NOT DISTINCT FROM '2026-11-14T09:00:00+00:00'
ORDER BY "session_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."charging_sessions"
WHERE "started_at" IS NOT DISTINCT FROM '2026-11-14T09:00:00+00:00'
ORDER BY "session_id"
LIMIT 20;

-- Count charging_sessions records for each vehicle_id (up to 20 groups).
SELECT "vehicle_id", count(*) AS record_count
FROM portfolio."charging_sessions"
GROUP BY "vehicle_id"
ORDER BY record_count DESC, "vehicle_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "vehicle_id", count(*) AS record_count
FROM portfolio."charging_sessions"
GROUP BY "vehicle_id"
ORDER BY record_count DESC, "vehicle_id" NULLS LAST
LIMIT 20;