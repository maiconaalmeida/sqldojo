SELECT
    t.ticket_no,
    t.passenger_name,
    split_part(t.contact_data ->> 'email', '@', 2) AS dominio_email,
    RIGHT(t.contact_data ->> 'phone', 1) AS ultimo_digito
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
WHERE t.contact_data ->> 'phone' LIKE '+703%';