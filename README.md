# Coimbatore Flood Risk Mapping System | WebGIS

*Note: This repository serves as the architectural case study and performance report for the WebGIS Flood Risk System. The full system deployment was localized for academic review.*

## 📌 System Overview
[cite_start]An enterprise-grade Spatial Decision Support System (SDSS) engineered to identify high-risk flood zones across the Noyyal River basin and surrounding low-lying urban settlements[cite: 11]. [cite_start]The architecture shifts heavy spatial processing away from standard GIS desktop software into a highly optimized Relational Database Management System (RDBMS)[cite: 45].

**Lead Developer:** DHANVANTHRI S

## ⚙️ Technology Stack
* [cite_start]**Database Backend:** PostgreSQL 17 [cite: 68]
* [cite_start]**Spatial Engine:** PostGIS [cite: 68]
* [cite_start]**Middleware Map Server:** GeoServer (Java SE 17) [cite: 69, 70]
* [cite_start]**Frontend Interface:** HTML5, Tailwind CSS, Leaflet.js [cite: 71]

## 🚀 Key Engineering Achievements

* [cite_start]**Massive Data Processing:** Processed and structured over 146,000 complex building footprint MultiPolygons and high-resolution Digital Elevation Models (DEM)[cite: 14, 105].
* [cite_start]**Extreme Query Optimization:** Implemented Generalized Search Tree (GiST) indexing on geometry and raster columns, reducing complex spatial intersection query execution time from over 45 minutes to under 20 seconds[cite: 122, 199, 200, 201].
* [cite_start]**Dynamic Cartography:** Configured Open Geospatial Consortium (OGC) standard Web Map Service (WMS) to render transparent map tiles on the server side, bypassing heavy client-side browser rendering[cite: 49, 93].
* [cite_start]**Automated Styling:** Engineered XML-based Styled Layer Descriptors (SLD) to dynamically read risk attributes, automatically rendering structures below the 405-meter safe elevation threshold as red (High Risk) and others as green (Safe)[cite: 95, 96, 97, 98, 164].

## 📊 Core Spatial SQL Implementation
[cite_start]To handle the massive spatial joins without memory exhaustion, the following indexing and intersection logic was executed on the backend[cite: 159]:

```sql
CREATE INDEX idx_coimbatore_buildings_geom ON coimbatore_buildings USING GIST(geom);
CREATE INDEX idx_coimbatore_dem_rast ON coimbatore_dem USING GIST(rast);

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
