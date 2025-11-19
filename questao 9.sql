SELECT
    ad.airport_name->>'en' AS airport_name,
    f.departure_airport,
    COUNT(*) AS total_voos
FROM flights f
JOIN airports_data ad ON f.departure_airport = ad.airport_code
GROUP BY f.departure_airport, ad.airport_name
ORDER BY total_voos DESC;