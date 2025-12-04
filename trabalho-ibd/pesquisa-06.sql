SELECT f.genero,
       COALESCE(SUM(v.duracao_minutos)/60.0,0) AS horas_assistidas
FROM visualizacao v
JOIN cliente c ON c.cliente_id = v.cliente_id
JOIN filme f ON f.filme_id = v.filme_id
WHERE c.email = "robersonnancy@example.com"    
  AND v.data_hora BETWEEN '2025-10-01' AND '2025-12-01'
GROUP BY f.genero
ORDER BY horas_assistidas DESC;
