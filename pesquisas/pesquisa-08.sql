SELECT f.titulo,
       COALESCE(SUM(v.duracao_minutos),0) AS total_minutos,
       COUNT(v.visualizacao_id) AS total_sessoes
FROM filme f
JOIN disponibilidade d ON f.filme_id = d.filme_id
JOIN regiao r ON r.regiao_id = d.regiao_id
LEFT JOIN visualizacao v
  ON v.filme_id = f.filme_id
  AND YEAR(v.data_hora) = 2025
  AND MONTH(v.data_hora) = 7
WHERE r.nome = "África"
GROUP BY f.filme_id
ORDER BY total_minutos DESC, total_sessoes DESC
LIMIT 5;
