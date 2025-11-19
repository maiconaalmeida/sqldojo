-- Primeiro, alterar o tipo da coluna para acomodar o novo formato
ALTER TABLE boarding_passes ALTER COLUMN seat_no TYPE VARCHAR(100);

-- Atualizar os assentos com uma sequência única
WITH seq AS (
    SELECT
        bp.ticket_no,
        bp.flight_id,
        bp.seat_no,
        ROW_NUMBER() OVER (
            PARTITION BY bp.flight_id
            ORDER BY bp.ticket_no, bp.flight_id
        ) AS seq_num
    FROM boarding_passes bp
)
UPDATE boarding_passes bp
SET seat_no = seq.flight_id || '_' || seq.seq_num || '_' || seq.seat_no
FROM seq
WHERE bp.flight_id = seq.flight_id
  AND bp.ticket_no = seq.ticket_no;

-- Verificar amostra dos dados atualizados
SELECT 
    flight_id,
    ticket_no,
    seat_no
FROM boarding_passes 
ORDER BY flight_id, ticket_no
LIMIT 20;