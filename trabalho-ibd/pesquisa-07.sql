SELECT p.plano_id,
       p.qualidade_reproducao AS nome_plano,
       COUNT(DISTINCT s.cliente_id) AS clientes_ativos,
       AVG(p.quantidade_max_dispositivos) AS media_max_dispositivos
FROM plano p
LEFT JOIN assinatura s
    ON s.plano_id = p.plano_id
   AND s.status = 'ativo'
GROUP BY p.plano_id, p.qualidade_reproducao
ORDER BY clientes_ativos DESC;
