-- Usando o valor total da reserva (pode ser mais preciso para "vendas")
SELECT
    date_trunc('month', b.book_date) AS mes_ano,
    SUM(b.total_amount) AS total_vendas
FROM bookings b
GROUP BY date_trunc('month', b.book_date)
ORDER BY mes_ano;