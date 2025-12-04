SELECT v.qualidade_reproducao,
       COUNT(*) AS qtd_sessoes,
       ROUND(100.0 * COUNT(*) / NULLIF(total.total,0), 2) AS perc_percentual
FROM visualizacao v
JOIN cliente c ON c.cliente_id = v.cliente_id
JOIN (
    SELECT COUNT(*) AS total
    FROM visualizacao vx
    JOIN cliente cx ON cx.cliente_id = vx.cliente_id
    WHERE cx.email = "omaynard@example.net"
      AND vx.data_hora BETWEEN '2025-10-01' AND '2025-12-01'
) total
  ON 1=1
WHERE c.email = "robersonnancy@example.com"
  AND v.data_hora BETWEEN '2025-10-01' AND '2025-12-01'
GROUP BY v.qualidade_reproducao, total.total
ORDER BY qtd_sessoes DESC;