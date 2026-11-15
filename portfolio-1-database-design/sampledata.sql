-- Fictional sample records for Beanne Fleet Logistics & EV Energy Network.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name") VALUES (1001, 'ACCT-1001', 'Avery Chen');
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name") VALUES (1002, 'ACCT-1002', 'Jordan Lee');
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw") VALUES (3001, 'STN-1001', 'North Depot', 4, 150);
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw") VALUES (3002, 'STN-1002', 'South Depot', 2, 50);
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh") VALUES (2001, 1001, 'SYNTHVIN000000001', 'Eon Compact', 58.5);
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh") VALUES (2002, 1002, 'SYNTHVIN000000002', 'Eon Touring', 72);
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status") VALUES (4001, 2001, 3001, '2026-11-14T09:00:00+00:00', NULL, 12.4, 4.96, 'active');
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status") VALUES (4002, 2002, 3002, '2026-11-13T10:00:00+00:00', '2026-11-13T10:30:00+00:00', 8, 3.2, 'completed');
COMMIT;