-- Beanne Fleet Logistics & EV Energy Network: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customers" (
  "customer_id" bigint NOT NULL,
  "account_ref" text NOT NULL,
  "display_name" text NOT NULL,
  CONSTRAINT "pk_customers" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customers_0" UNIQUE ("account_ref")
);
CREATE TABLE portfolio."vehicles" (
  "vehicle_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "vin" text NOT NULL,
  "model" text NOT NULL,
  "battery_kwh" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_vehicles" PRIMARY KEY ("vehicle_id"),
  CONSTRAINT "uq_vehicles_0" UNIQUE ("vin")
);
CREATE TABLE portfolio."stations" (
  "station_id" bigint NOT NULL,
  "station_code" text NOT NULL,
  "location" text NOT NULL,
  "connector_count" bigint NOT NULL,
  "max_kw" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_stations" PRIMARY KEY ("station_id"),
  CONSTRAINT "uq_stations_0" UNIQUE ("station_code")
);
CREATE TABLE portfolio."charging_sessions" (
  "session_id" bigint NOT NULL,
  "vehicle_id" bigint NOT NULL,
  "station_id" bigint NOT NULL,
  "started_at" timestamptz NOT NULL,
  "ended_at" timestamptz,
  "energy_kwh" numeric(18,2) NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_charging_sessions" PRIMARY KEY ("session_id")
);
ALTER TABLE portfolio."vehicles" ADD CONSTRAINT "fk_vehicles_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customers" ("customer_id");
ALTER TABLE portfolio."charging_sessions" ADD CONSTRAINT "fk_charging_sessions_0" FOREIGN KEY ("vehicle_id") REFERENCES portfolio."vehicles" ("vehicle_id");
ALTER TABLE portfolio."charging_sessions" ADD CONSTRAINT "fk_charging_sessions_1" FOREIGN KEY ("station_id") REFERENCES portfolio."stations" ("station_id");
ALTER TABLE portfolio."charging_sessions" ADD CONSTRAINT "session_energy_nonnegative" CHECK ("energy_kwh" >= 0);
CREATE UNIQUE INDEX "one_active_session_per_vehicle" ON portfolio."charging_sessions" ("vehicle_id") WHERE ("status" = 'active');
COMMIT;