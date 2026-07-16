# Coimbatore Flood Risk Mapping System | WebGIS

*Note: This repository serves as the architectural case study and performance report for the WebGIS Flood Risk System. The full system deployment was localized for academic review.*

## 📌 System Overview
An enterprise-grade Spatial Decision Support System (SDSS) engineered to identify high-risk flood zones across the Noyyal River basin and surrounding low-lying urban settlements. The architecture shifts heavy spatial processing away from standard GIS desktop software into a highly optimized Relational Database Management System (RDBMS).

**Lead Developer:** DHANVANTHRI S

## ⚙️ Technology Stack
* **Database Backend:** PostgreSQL 17
* **Spatial Engine:** PostGIS
* **Middleware Map Server:** GeoServer (Java SE 17)
* **Frontend Interface:** HTML5, Tailwind CSS, Leaflet.js

## 🚀 Key Engineering Achievements

* **Massive Data Processing:** Processed and structured over 146,000 complex building footprint MultiPolygons and high-resolution Digital Elevation Models (DEM).
* **Extreme Query Optimization:** Implemented Generalized Search Tree (GiST) indexing on geometry and raster columns, reducing complex spatial intersection query execution time from over 45 minutes to under 20 seconds.
* **Dynamic Cartography:** Configured Open Geospatial Consortium (OGC) standard Web Map Service (WMS) to render transparent map tiles on the server side, bypassing heavy client-side browser rendering.
* **Automated Styling:** Engineered XML-based Styled Layer Descriptors (SLD) to dynamically read risk attributes, automatically rendering structures below the 405-meter safe elevation threshold as red (High Risk) and others as green (Safe).

## 📊 Core Spatial SQL Implementation
To handle the massive spatial joins without memory exhaustion, the following indexing and intersection logic was executed on the backend:

```sql
-- GiST Indexing for rapid spatial querying
CREATE INDEX idx_coimbatore_buildings_geom ON coimbatore_buildings USING GIST(geom);
CREATE INDEX idx_coimbatore_dem_rast ON coimbatore_dem USING GIST(rast);

-- Spatial Intersection to calculate precise ground elevation from raster pixels
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
