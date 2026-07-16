UPDATE coimbatore_buildings
SET ground_elevation = ST_Value(
    coimbatore_dem.rast,
    ST_Transform(ST_Centroid(coimbatore_buildings.geom), 4326)
)
FROM coimbatore_dem
WHERE ST_Intersects(
    coimbatore_dem.rast,
    ST_Transform(ST_Centroid(coimbatore_buildings.geom), 4326)
);

UPDATE coimbatore_buildings
SET risk_level = CASE
    WHEN ground_elevation < 405.0 THEN 'High Risk'
    WHEN ground_elevation >= 405.0 AND ground_elevation <= 410.0 THEN 'Moderate Risk'
    ELSE 'Low Risk'
END;
