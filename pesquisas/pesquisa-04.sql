SELECT f.titulo
FROM filme f
LEFT JOIN (
    SELECT filme_id
    FROM visualizacao
    WHERE data_hora BETWEEN '2025-10-01' AND '2025-12-01'
    GROUP BY filme_id
) v ON v.filme_id = f.filme_id
WHERE v.filme_id IS NULL
ORDER BY f.titulo;
