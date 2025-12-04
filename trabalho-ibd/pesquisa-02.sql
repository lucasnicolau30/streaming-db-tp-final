SELECT f.titulo, fav.data_favorito
FROM favorito fav
JOIN cliente c ON c.cliente_id = fav.cliente_id
JOIN filme f ON f.filme_id = fav.filme_id
WHERE c.email = "robersonnancy@example.com"
ORDER BY fav.data_favorito DESC;
