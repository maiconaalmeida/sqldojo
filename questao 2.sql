SELECT 
    book_ref,
    book_date,
    EXTRACT(DAY FROM (CURRENT_DATE - book_date)) AS diferenca_dias
FROM bookings;