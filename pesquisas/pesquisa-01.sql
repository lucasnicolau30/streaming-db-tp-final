SELECT DISTINCT f.titulo
FROM filme f
JOIN disponibilidade d ON f.filme_id = d.filme_id
JOIN regiao r ON r.regiao_id = d.regiao_id
WHERE r.nome = "América do Norte"
ORDER BY f.titulo;
