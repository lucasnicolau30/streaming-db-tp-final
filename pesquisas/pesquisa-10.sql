WITH assinaturas_ord AS (
  SELECT
      s.cliente_id,
      s.plano_id AS plano_atual,
      s.data_inicio AS inicio_atual,
      s.data_fim AS fim_atual,

      LAG(s.plano_id)      OVER (PARTITION BY s.cliente_id ORDER BY s.data_inicio) AS plano_anterior,
      LAG(s.data_inicio)   OVER (PARTITION BY s.cliente_id ORDER BY s.data_inicio) AS inicio_anterior,
      LAG(s.data_fim)      OVER (PARTITION BY s.cliente_id ORDER BY s.data_inicio) AS fim_anterior
  FROM assinatura s
)
SELECT
    c.cliente_id,
    c.nome,
    
    plano_anterior,
    plano_atual AS novo_plano,
    
    inicio_anterior,
    fim_anterior,
    
    inicio_atual AS inicio_novo_plano,
    fim_atual AS fim_novo_plano
FROM assinaturas_ord a
JOIN cliente c ON c.cliente_id = a.cliente_id
WHERE plano_anterior IS NOT NULL
  AND plano_anterior <> plano_atual
  AND inicio_atual BETWEEN '2025-10-01' AND '2025-12-01'
ORDER BY c.cliente_id, inicio_atual;
