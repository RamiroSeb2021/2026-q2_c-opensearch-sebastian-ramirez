# Design: OpenSearch local con búsqueda facetada

## Approach

El repositorio se organiza como un ejercicio guiado. La infraestructura local vive en `docker-compose.yml`, la explicación principal en `README.md`, las evidencias en `docs/`, los ejemplos JSON en `data/sample/` y las consultas REST reutilizables en `requests/`.

## Components

| Component | Purpose |
|---|---|
| `docker-compose.yml` | Define servicios `opensearch` y `opensearch-dashboards`. |
| `README.md` | Guía de ejecución y validación del ejercicio. |
| `data/sample/` | Guarda documentos manuales para ingesta adicional. |
| `requests/` | Guarda consultas REST para repetir pruebas. |
| `docs/dashboard/` | Documenta visualizaciones, filtros y dashboard. |
| `docs/rest-api/` | Explica resultados de consultas REST y facetas. |
| `docs/screenshots/` | Evidencias visuales del entorno funcionando. |

## Key decisions

- Usar un clúster single-node para reducir complejidad local.
- Mantener seguridad demo con `admin/admin` porque el enunciado lo pide.
- Guiar la creación de Compose manualmente para reforzar aprendizaje.
- Separar documentación de dashboard y REST para que la revisión sea clara.

## Verification

- `docker compose ps` muestra ambos servicios activos.
- `curl -k -u admin:admin https://localhost:9200` devuelve información del clúster.
- Dashboards carga en `http://localhost:5601`.
- `_count`, `_mapping`, `_settings` y agregaciones devuelven JSON válido.
