DROP TABLE zones;
CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS ca_temp (
    CountryCode VARCHAR(2),
    PostalCode VARCHAR(20),
    PlaceName VARCHAR(180),
    Admin1Name VARCHAR(100),
    Admin1Code VARCHAR(20),
    Admin2Name VARCHAR(100),
    Admin2Code VARCHAR(20),
    Admin3Name VARCHAR(100),
    Admin3Code VARCHAR(20),
    Latitude DOUBLE PRECISION,
    Longitude DOUBLE PRECISION,
    Accuracy INTEGER
);

CREATE TABLE IF NOT EXISTS zones (
    Id SERIAL PRIMARY KEY,
    CountryCode VARCHAR(2),
    PlaceName VARCHAR(200),
    Latitude DOUBLE PRECISION,
    Longitude DOUBLE PRECISION,
    Coords GEOMETRY(Point, 4326)
);

CREATE INDEX idx_points_geom ON zones USING GIST (Coords);


-- Copy Canada data
COPY ca_temp (CountryCode, PostalCode, PlaceName, Admin1Name, Admin1Code, Admin2Name, Admin2Code, Admin3Name, Admin3Code, Latitude, Longitude, Accuracy)
FROM '/setup/CA/CA.txt'
WITH (
    FORMAT csv,
    DELIMITER E'\t',
    NULL ''
);

INSERT INTO ZONES (CountryCode, PlaceName, Latitude, Longitude)
SELECT CountryCode, PlaceName, Latitude, Longitude
FROM ca_temp;

-- Copy US data
CREATE TABLE IF NOT EXISTS us_temp (
    geonameid INTEGER,
    name VARCHAR(200),
    asciiname VARCHAR(200),
    alternatenames VARCHAR(10000),
    Latitude DOUBLE PRECISION,
    Longitude DOUBLE PRECISION
);

COPY us_temp (geonameid, name, asciiname, alternatenames, Latitude, Longitude)
FROM '/setup/US/us_columns_filtered.txt'
WITH (
    FORMAT csv,
    DELIMITER E'\t',
    NULL ''
);

INSERT INTO ZONES (CountryCode, PlaceName, Latitude, Longitude)
SELECT 'US', name as PlaceName, Latitude, Longitude
FROM us_temp;

-- Create PostGIS points from the lat/long values
UPDATE zones SET Coords = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

-- cleanup temp tables
DROP TABLE ca_temp;
DROP TABLE us_temp;
