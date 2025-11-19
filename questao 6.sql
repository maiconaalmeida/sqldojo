SELECT
    t.ticket_no,
    t.passenger_name,
    LENGTH(t.contact_data ->> 'email') AS tamanho_email
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
WHERE (t.contact_data ->> 'email') LIKE 'a%'
AND LENGTH(t.contact_data ->> 'email') > 40;