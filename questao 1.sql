SELECT
    f.flight_no,
    AVG(bp.assentos_ocupados) AS media_assentos_ocupados
FROM (
    SELECT flight_id, COUNT(*) AS assentos_ocupados
    FROM boarding_passes
    GROUP BY flight_id
) bp
JOIN flights f ON f.flight_id = bp.flight_id
GROUP BY f.flight_no;
