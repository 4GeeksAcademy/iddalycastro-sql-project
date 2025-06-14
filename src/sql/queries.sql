-- queries.sql
-- Complete each mission by writing your SQL query below the instructions.
-- Don't forget to end each query with a semicolon ;

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM observations;


-- MISSION 1 
Misión 1: Queremos conocer la biodiversidad de cada región. ¿Qué regiones tienen más especies registradas?
-- Your query here;
SELECT regions.name, regions.country, COUNT(DISTINCT observations.species_id) as diversidad_especies
FROM observations
JOIN regions ON observations.region_id = regions.id 
JOIN species ON observations.species_id = species_id
GROUP BY regions.name, regions.country 
ORDER BY diversidad_especies DESC; 



-- MISSION 2
¿Qué meses tienen mayor actividad de observación? Agrupa por mes a partir de las fechas de observación reales. Es útil para detectar estacionalidad.
-- Your query here:
SELECT
  DATE_TRUNC('month', observation_date) AS mes_real,
  COUNT(*) AS total_observaciones
FROM observations
WHERE observation_date IS NOT NULL
GROUP BY mes_real
ORDER BY mes_real;


-- MISSION 3
 Detecta las especies con pocos individuos registrados (posibles casos raros).
-- Your query here:
SELECT 
    scientific_name, 
    SUM(individualCount) AS total_individuos
FROM species
GROUP BY scientific_name
HAVING SUM(individualCount) <= 5
ORDER BY total_individuos ASC;

-- MISSION 4
 ¿Qué región tiene el mayor número de especies distintas observadas?
-- Your query here:
SELECT region_id, COUNT(DISTINCT scientific_name) AS especies_distintas
FROM observations
GROUP BY region_id
ORDER BY especies_distintas DESC
LIMIT 1;

-- MISSION 5
¿Qué especies han sido observadas con mayor frecuencia?
-- Your query here:
SELECT species.scientific_name, COUNT(*) AS frecuencia_observacion
FROM observations
JOIN species ON observations.species_id = species.id
GROUP BY species.scientific_name
ORDER BY frecuencia_observacion DESC;

-- MISSION 6  Queremos identificar a los observadores más activos. ¿Quiénes son las personas que más registros de observación han realizado?
-- Your query here:
SELECT observer, COUNT(*) AS total_observaciones
FROM observations
GROUP BY observer
ORDER BY total_observaciones DESC;


-- MISSION 7
 ¿Qué especies no han sido observadas nunca? Comprueba si existen especies en la tabla species que no aparecen en observations.
-- Your query here:
SELECT s.species_id, s.scientific_name
FROM [species] s
LEFT JOIN [observations] o ON s.species_id = o.species_id
WHERE o.species_id IS NULL;

-- MISSION 8 ¿En qué fechas se observaron más especies distintas? Esta informacion es ideal para explorar la biodiversidad máxima en días específicos.
-- Your query here:
SELECT 
  observation_date, 
  COUNT(DISTINCT species_id) AS especies_distintas
FROM observations
GROUP BY observation_date
ORDER BY especies_distintas DESC
LIMIT 10;