SELECT
    ac.model AS modelo,
    ad.airport_name->>'en' AS nome_do_aeroporto,
    ad.city->>'en' AS cidade,
    'Rússia' AS regiao
FROM flights f
JOIN aircrafts_data ac ON f.aircraft_code = ac.aircraft_code
JOIN airports_data ad ON f.arrival_airport = ad.airport_code;