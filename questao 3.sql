SELECT
    aircraft_code,
    fare_conditions,
    COUNT(*) AS assentos_disponiveis
FROM seats
GROUP BY aircraft_code, fare_conditions
ORDER BY aircraft_code, fare_conditions;
