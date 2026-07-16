CREATE INDEX idx_coimbatore_buildings_geom ON coimbatore_buildings USING GIST(geom);
CREATE INDEX idx_coimbatore_dem_rast ON coimbatore_dem USING GIST(rast);

ANALYZE coimbatore_buildings;
ANALYZE coimbatore_dem;
