// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("charging_session_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("charging_session_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "session_started",
                    "meter_reading_recorded"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "charging_sessions"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "session_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("charging_session_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "session_started",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "charging_sessions",
            "key": {
                "session_id": 4001
            },
            "snapshot": {
                "session_id": 4001,
                "vehicle_id": 2001,
                "station_id": 3001,
                "started_at": "2026-11-14T09:00:00+00:00",
                "ended_at": null,
                "energy_kwh": 12.4,
                "amount": 4.96,
                "status": "active"
            }
        },
        "embedded": {
            "vehicles": [
                {
                    "key": {
                        "vehicle_id": 2001
                    },
                    "snapshot": {
                        "vehicle_id": 2001,
                        "customer_id": 1001,
                        "vin": "SYNTHVIN000000001",
                        "model": "Eon Compact",
                        "battery_kwh": 58.5
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles"
                    ]
                }
            ],
            "stations": [
                {
                    "key": {
                        "station_id": 3001
                    },
                    "snapshot": {
                        "station_id": 3001,
                        "station_code": "STN-1001",
                        "location": "North Depot",
                        "connector_count": 4,
                        "max_kw": 150
                    },
                    "via": [
                        "charging_sessions.station_id → stations"
                    ]
                }
            ]
        },
        "references": {
            "customers": [
                {
                    "key": {
                        "customer_id": 1001
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "meter_reading_recorded",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "charging_sessions",
            "key": {
                "session_id": 4001
            },
            "snapshot": {
                "session_id": 4001,
                "vehicle_id": 2001,
                "station_id": 3001,
                "started_at": "2026-11-14T09:00:00+00:00",
                "ended_at": null,
                "energy_kwh": 12.4,
                "amount": 4.96,
                "status": "active"
            }
        },
        "embedded": {
            "vehicles": [
                {
                    "key": {
                        "vehicle_id": 2001
                    },
                    "snapshot": {
                        "vehicle_id": 2001,
                        "customer_id": 1001,
                        "vin": "SYNTHVIN000000001",
                        "model": "Eon Compact",
                        "battery_kwh": 58.5
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles"
                    ]
                }
            ],
            "stations": [
                {
                    "key": {
                        "station_id": 3001
                    },
                    "snapshot": {
                        "station_id": 3001,
                        "station_code": "STN-1001",
                        "location": "North Depot",
                        "connector_count": 4,
                        "max_kw": 150
                    },
                    "via": [
                        "charging_sessions.station_id → stations"
                    ]
                }
            ]
        },
        "references": {
            "customers": [
                {
                    "key": {
                        "customer_id": 1001
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "meter_payload": "illustrative meter_payload",
                "tariff_snapshot": "illustrative tariff_snapshot",
                "grid_context": "illustrative grid_context"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "session_started",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "charging_sessions",
            "key": {
                "session_id": 4002
            },
            "snapshot": {
                "session_id": 4002,
                "vehicle_id": 2002,
                "station_id": 3002,
                "started_at": "2026-11-13T10:00:00+00:00",
                "ended_at": "2026-11-13T10:30:00+00:00",
                "energy_kwh": 8,
                "amount": 3.2,
                "status": "completed"
            }
        },
        "embedded": {
            "vehicles": [
                {
                    "key": {
                        "vehicle_id": 2002
                    },
                    "snapshot": {
                        "vehicle_id": 2002,
                        "customer_id": 1002,
                        "vin": "SYNTHVIN000000002",
                        "model": "Eon Touring",
                        "battery_kwh": 72
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles"
                    ]
                }
            ],
            "stations": [
                {
                    "key": {
                        "station_id": 3002
                    },
                    "snapshot": {
                        "station_id": 3002,
                        "station_code": "STN-1002",
                        "location": "South Depot",
                        "connector_count": 2,
                        "max_kw": 50
                    },
                    "via": [
                        "charging_sessions.station_id → stations"
                    ]
                }
            ]
        },
        "references": {
            "customers": [
                {
                    "key": {
                        "customer_id": 1002
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "meter_reading_recorded",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "charging_sessions",
            "key": {
                "session_id": 4002
            },
            "snapshot": {
                "session_id": 4002,
                "vehicle_id": 2002,
                "station_id": 3002,
                "started_at": "2026-11-13T10:00:00+00:00",
                "ended_at": "2026-11-13T10:30:00+00:00",
                "energy_kwh": 8,
                "amount": 3.2,
                "status": "completed"
            }
        },
        "embedded": {
            "vehicles": [
                {
                    "key": {
                        "vehicle_id": 2002
                    },
                    "snapshot": {
                        "vehicle_id": 2002,
                        "customer_id": 1002,
                        "vin": "SYNTHVIN000000002",
                        "model": "Eon Touring",
                        "battery_kwh": 72
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles"
                    ]
                }
            ],
            "stations": [
                {
                    "key": {
                        "station_id": 3002
                    },
                    "snapshot": {
                        "station_id": 3002,
                        "station_code": "STN-1002",
                        "location": "South Depot",
                        "connector_count": 2,
                        "max_kw": 50
                    },
                    "via": [
                        "charging_sessions.station_id → stations"
                    ]
                }
            ]
        },
        "references": {
            "customers": [
                {
                    "key": {
                        "customer_id": 1002
                    },
                    "via": [
                        "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "meter_payload": "illustrative meter_payload",
                "tariff_snapshot": "illustrative tariff_snapshot",
                "grid_context": "illustrative grid_context"
            }
        }
    }
]));
  await db.getCollection("charging_session_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("charging_session_events").find({"eventType":"session_started"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("charging_session_events").find({"source.key.session_id":4001}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("charging_session_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("charging_session_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("charging_session_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "session_started",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "charging_sessions",
        "key": {
            "session_id": 4001
        },
        "snapshot": {
            "session_id": 4001,
            "vehicle_id": 2001,
            "station_id": 3001,
            "started_at": "2026-11-14T09:00:00+00:00",
            "ended_at": null,
            "energy_kwh": 12.4,
            "amount": 4.96,
            "status": "active"
        }
    },
    "embedded": {
        "vehicles": [
            {
                "key": {
                    "vehicle_id": 2001
                },
                "snapshot": {
                    "vehicle_id": 2001,
                    "customer_id": 1001,
                    "vin": "SYNTHVIN000000001",
                    "model": "Eon Compact",
                    "battery_kwh": 58.5
                },
                "via": [
                    "charging_sessions.vehicle_id → vehicles"
                ]
            }
        ],
        "stations": [
            {
                "key": {
                    "station_id": 3001
                },
                "snapshot": {
                    "station_id": 3001,
                    "station_code": "STN-1001",
                    "location": "North Depot",
                    "connector_count": 4,
                    "max_kw": 150
                },
                "via": [
                    "charging_sessions.station_id → stations"
                ]
            }
        ]
    },
    "references": {
        "customers": [
            {
                "key": {
                    "customer_id": 1001
                },
                "via": [
                    "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("charging_session_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "session_started",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "charging_sessions",
        "key": {
            "session_id": 4001
        },
        "snapshot": {
            "session_id": 4001,
            "vehicle_id": 2001,
            "station_id": 3001,
            "started_at": "2026-11-14T09:00:00+00:00",
            "ended_at": null,
            "energy_kwh": 12.4,
            "amount": 4.96,
            "status": "active"
        }
    },
    "embedded": {
        "vehicles": [
            {
                "key": {
                    "vehicle_id": 2001
                },
                "snapshot": {
                    "vehicle_id": 2001,
                    "customer_id": 1001,
                    "vin": "SYNTHVIN000000001",
                    "model": "Eon Compact",
                    "battery_kwh": 58.5
                },
                "via": [
                    "charging_sessions.vehicle_id → vehicles"
                ]
            }
        ],
        "stations": [
            {
                "key": {
                    "station_id": 3001
                },
                "snapshot": {
                    "station_id": 3001,
                    "station_code": "STN-1001",
                    "location": "North Depot",
                    "connector_count": 4,
                    "max_kw": 150
                },
                "via": [
                    "charging_sessions.station_id → stations"
                ]
            }
        ]
    },
    "references": {
        "customers": [
            {
                "key": {
                    "customer_id": 1001
                },
                "via": [
                    "charging_sessions.vehicle_id → vehicles.customer_id → customers"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("charging_session_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });