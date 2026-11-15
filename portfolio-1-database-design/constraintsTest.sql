-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. customers duplicate primary key. Expected: pk_customers, SQLSTATE 23505.
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name")
VALUES (1001, 'ACCT-900001', 'Taylor Morgan');

-- 2. customers duplicate account ref. Expected: uq_customers_0, SQLSTATE 23505.
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name")
VALUES (900002, 'ACCT-1001', 'Taylor Morgan');

-- 3. customers missing customer id. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name")
VALUES (NULL, 'ACCT-900003', 'Taylor Morgan');

-- 4. customers missing account ref. Expected: account_ref, SQLSTATE 23502.
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name")
VALUES (900004, NULL, 'Taylor Morgan');

-- 5. customers missing display name. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."customers" ("customer_id", "account_ref", "display_name")
VALUES (900005, 'ACCT-900005', NULL);

-- 6. vehicles duplicate primary key. Expected: pk_vehicles, SQLSTATE 23505.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (2001, 1002, 'SYNTHVIN900006', 'Eon Compact', 58.5);

-- 7. vehicles duplicate vin. Expected: uq_vehicles_0, SQLSTATE 23505.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900007, 1001, 'SYNTHVIN000000001', 'Eon Compact', 58.5);

-- 8. vehicles missing customer. Expected: fk_vehicles_0, SQLSTATE 23503.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900008, 990008, 'SYNTHVIN900008', 'Eon Compact', 58.5);

-- 9. vehicles missing vehicle id. Expected: vehicle_id, SQLSTATE 23502.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (NULL, 1001, 'SYNTHVIN900009', 'Eon Compact', 58.5);

-- 10. vehicles missing customer id. Expected: customer_id, SQLSTATE 23502.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900010, NULL, 'SYNTHVIN900010', 'Eon Compact', 58.5);

-- 11. vehicles missing vin. Expected: vin, SQLSTATE 23502.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900011, 1001, NULL, 'Eon Compact', 58.5);

-- 12. vehicles missing model. Expected: model, SQLSTATE 23502.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900012, 1001, 'SYNTHVIN900012', NULL, 58.5);

-- 13. vehicles missing battery kwh. Expected: battery_kwh, SQLSTATE 23502.
INSERT INTO portfolio."vehicles" ("vehicle_id", "customer_id", "vin", "model", "battery_kwh")
VALUES (900013, 1001, 'SYNTHVIN900013', 'Eon Compact', NULL);

-- 14. stations duplicate primary key. Expected: pk_stations, SQLSTATE 23505.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (3001, 'STN-900014', 'East Depot', 3, 100);

-- 15. stations duplicate station code. Expected: uq_stations_0, SQLSTATE 23505.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (900015, 'STN-1001', 'East Depot', 3, 100);

-- 16. stations missing station id. Expected: station_id, SQLSTATE 23502.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (NULL, 'STN-900016', 'East Depot', 3, 100);

-- 17. stations missing station code. Expected: station_code, SQLSTATE 23502.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (900017, NULL, 'East Depot', 3, 100);

-- 18. stations missing location. Expected: location, SQLSTATE 23502.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (900018, 'STN-900018', NULL, 3, 100);

-- 19. stations missing connector count. Expected: connector_count, SQLSTATE 23502.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (900019, 'STN-900019', 'East Depot', NULL, 100);

-- 20. stations missing max kw. Expected: max_kw, SQLSTATE 23502.
INSERT INTO portfolio."stations" ("station_id", "station_code", "location", "connector_count", "max_kw")
VALUES (900020, 'STN-900020', 'East Depot', 3, NULL);

-- 21. sessions duplicate primary key. Expected: pk_charging_sessions, SQLSTATE 23505.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (4001, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 22. sessions missing vehicle. Expected: fk_charging_sessions_0, SQLSTATE 23503.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900022, 990022, 3001, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 23. sessions missing station. Expected: fk_charging_sessions_1, SQLSTATE 23503.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900023, 2002, 990023, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 24. sessions missing session id. Expected: session_id, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (NULL, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 25. sessions missing vehicle id. Expected: vehicle_id, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900025, NULL, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 26. sessions missing station id. Expected: station_id, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900026, 2002, NULL, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 27. sessions missing started at. Expected: started_at, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900027, 2002, 3002, NULL, '2026-11-14T12:30:00+00:00', 6, 2.4, 'completed');

-- 28. sessions missing energy kwh. Expected: energy_kwh, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900028, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', NULL, 2.4, 'completed');

-- 29. sessions missing amount. Expected: amount, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900029, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, NULL, 'completed');

-- 30. sessions missing status. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900030, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', 6, 2.4, NULL);

-- 31. sessions negative energy. Expected: session_energy_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900031, 2002, 3002, '2026-11-14T12:00:00+00:00', '2026-11-14T12:30:00+00:00', -1, 0, 'completed');

-- 32. sessions second active vehicle session. Expected: one_active_session_per_vehicle, SQLSTATE 23505.
INSERT INTO portfolio."charging_sessions" ("session_id", "vehicle_id", "station_id", "started_at", "ended_at", "energy_kwh", "amount", "status")
VALUES (900032, 2001, 3002, '2026-11-14T13:00:00+00:00', NULL, 3, 1.2, 'active');