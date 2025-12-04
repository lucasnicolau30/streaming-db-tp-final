SELECT f.titulo, ROUND(AVG(a.nota),2) AS media_avaliacao
FROM filme f
JOIN avaliacao a ON a.filme_id = f.filme_id
WHERE f.genero = "Terror"
GROUP BY f.filme_id
HAVING AVG(a.nota) >= 4
ORDER BY media_avaliacao DESC, f.titulo;