USE SonoraDB;
GO

-- Ejemplo 12. Alternativa con subconsultas anidadas: tres niveles bajo cada género principal
SELECT gr.nombre AS genero_principal,
       (SELECT COUNT(*)
        FROM dbo.reproducciones AS r
        JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
        WHERE r.tipo_contenido = N'Canción'
          AND r.segundos_escuchados >= 30
          AND c.genero_id IN (
                SELECT gr.genero_id                                   -- el propio género
                UNION
                SELECT g1.genero_id FROM dbo.generos AS g1            -- hijos
                WHERE g1.genero_padre_id = gr.genero_id
                UNION
                SELECT g2.genero_id FROM dbo.generos AS g2            -- nietos
                WHERE g2.genero_padre_id IN (SELECT g1.genero_id FROM dbo.generos AS g1
                                             WHERE g1.genero_padre_id = gr.genero_id)
          )) AS reproducciones_validas
FROM dbo.generos AS gr
WHERE gr.genero_padre_id = (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL)
ORDER BY reproducciones_validas DESC;
