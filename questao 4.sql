UPDATE seats
SET fare_conditions = 'Premium Economy'
WHERE aircraft_code IN (
    SELECT aircraft_code
    FROM aircrafts
    WHERE model = 'Cessna 208 Caravan'
)
AND fare_conditions = 'Economy';

-- caso seja necessário ajustar o tamanho
ALTER TABLE seats
ALTER COLUMN fare_conditions TYPE VARCHAR(20);

-- revalidar checks
ALTER TABLE seats DROP CONSTRAINT seats_fare_conditions_check;

ALTER TABLE seats
ADD CONSTRAINT seats_fare_conditions_check
CHECK (fare_conditions IN ('Economy', 'Comfort', 'Business', 'Premium Economy'));