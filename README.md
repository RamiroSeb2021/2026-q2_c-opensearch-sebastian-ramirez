# OpenSearch local con eCommerce y búsqueda facetada

Esta guía reúne lo necesario para completar el ejercicio: levantar OpenSearch en local, cargar datos eCommerce de ejemplo, crear un dashboard, explorar el API REST y practicar búsquedas facetadas con agregaciones.

## Camino rápido

1. Levantar los servicios con `docker compose up -d`.
2. Validar OpenSearch con `curl -k -u admin:admin https://localhost:9200`.
3. Cargar **Sample eCommerce orders** desde OpenSearch Dashboards.
4. Crear o clonar un dashboard con al menos 3 visualizaciones.
5. Ejecutar consultas REST sobre `opensearch_dashboards_sample_data_ecommerce`.
6. Cargar los pedidos manuales con `./scripts/load-manual-orders.sh`.

## Objetivo

Demostrar una instalación local de OpenSearch y OpenSearch Dashboards, usando datos de órdenes eCommerce para entender facetas: categorías, fabricantes, países, cantidades, fechas y rangos de precio.

## Prerrequisitos

| Herramienta | Uso |
|---|---|
| Docker | Ejecutar OpenSearch y Dashboards. |
| Docker Compose | Levantar ambos servicios desde `docker-compose.yml`. |
| `curl` | Probar el API REST desde terminal. |
| Navegador | Usar OpenSearch Dashboards en `http://localhost:5601`. |

Las credenciales locales del ejercicio son `admin/admin`. OpenSearch usa HTTPS con un certificado local autofirmado; por eso los comandos `curl` usan `-k`.

## Estructura del proyecto

```text
.
├── docker-compose.yml                  # OpenSearch y OpenSearch Dashboards
├── README.md                           # Guía principal
├── data/sample/manual-orders.ndjson    # Pedidos manuales para _bulk
├── docs/dashboard/README.md            # Pasos y evidencias del dashboard
├── docs/rest-api/README.md             # Explicación de consultas REST
├── docs/screenshots/                   # Capturas del ejercicio
├── requests/ecommerce-rest-examples.http
├── requests/manual-ingest.http
└── scripts/load-manual-orders.sh       # Carga automática del índice manual
```

## Levantar OpenSearch

Desde la raíz del proyecto:

```bash
docker compose up -d
```

Servicios esperados:

| Servicio | URL | Credenciales |
|---|---|---|
| OpenSearch API | `https://localhost:9200` | `admin/admin` |
| OpenSearch Dashboards | `http://localhost:5601` | `admin/admin` |

## Validar el entorno

Probar que OpenSearch responde:

```bash
curl -k -u admin:admin https://localhost:9200
```

La respuesta debe incluir datos como `cluster_name`, `cluster_uuid`, `version` y `tagline`.

Ver los índices disponibles:

```bash
curl -k -u admin:admin "https://localhost:9200/_cat/indices?v"
```

Después de cargar el dataset eCommerce debe aparecer el índice:

```text
opensearch_dashboards_sample_data_ecommerce
```

En este entorno se validó que el índice eCommerce quedó cargado con `4675` documentos.

## Cargar Sample eCommerce orders

En OpenSearch Dashboards:

1. Entrar a `http://localhost:5601`.
2. Iniciar sesión con `admin/admin`.
3. Ir a **Home** o **Add data**.
4. Buscar **Sample eCommerce orders**.
5. Seleccionar **Add data**.
6. Confirmar que existe `opensearch_dashboards_sample_data_ecommerce`.

Este dataset se usa en lugar del dataset de logs porque permite entender mejor las facetas: categoría, fabricante, país, cantidad, fecha y precio.

## Requisitos del dashboard

Crear o clonar un dashboard basado en Sample eCommerce orders. Debe incluir:

- Al menos 3 visualizaciones.
- Filtros o controles para explorar facetas.
- Campos recomendados: `category`, `manufacturer`, `total_quantity` y `order_date`.
- Evidencia visual guardada en `docs/screenshots/`.

La guía detallada está en `docs/dashboard/README.md`.

## Exploración REST

El índice principal del ejercicio es:

```text
opensearch_dashboards_sample_data_ecommerce
```

Ejemplos básicos:

```bash
curl -k -u admin:admin "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_search?size=1"
curl -k -u admin:admin "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_count"
curl -k -u admin:admin "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_mapping"
curl -k -u admin:admin "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_settings"
```

También hay ejemplos listos para REST Client en `requests/ecommerce-rest-examples.http` y una explicación paso a paso en `docs/rest-api/README.md`.

## Búsqueda facetada

Una búsqueda facetada combina dos ideas:

- Filtros: reducen los documentos que se están mirando.
- Agregaciones: muestran grupos navegables dentro de esos documentos.

Ejemplo: filtrar órdenes de una categoría y calcular facetas por fabricante y país.

```bash
curl -k -u admin:admin -X GET "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_search" \
  -H "Content-Type: application/json" \
  --data @- <<'JSON'
{
    "size": 0,
    "query": {
      "bool": {
        "filter": [
          { "term": { "category.keyword": "Men's Clothing" } }
        ]
      }
    },
    "aggs": {
      "por_fabricante": { "terms": { "field": "manufacturer.keyword", "size": 10 } },
      "por_pais": { "terms": { "field": "geoip.country_iso_code", "size": 10 } },
      "precios": {
        "range": {
          "field": "taxful_total_price",
          "ranges": [
            { "to": 50 },
            { "from": 50, "to": 100 },
            { "from": 100 }
          ]
        }
      }
    }
}
JSON
```

## Ingesta manual

El archivo `data/sample/manual-orders.ndjson` contiene pedidos eCommerce propios en formato `_bulk`.

Para crear el índice `manual_ecommerce_orders` y cargar los documentos:

```bash
./scripts/load-manual-orders.sh
```

Validar la carga:

```bash
curl -k -u admin:admin "https://localhost:9200/manual_ecommerce_orders/_count"
curl -k -u admin:admin "https://localhost:9200/manual_ecommerce_orders/_search?size=3"
```

Los mismos pasos están documentados como requests en `requests/manual-ingest.http`.

## Troubleshooting

| Problema | Qué revisar |
|---|---|
| `curl` muestra error de certificado | Usar `-k`; el certificado local es autofirmado. |
| OpenSearch no responde en `9200` | Revisar `docker compose ps` y `docker compose logs opensearch`. |
| Dashboards no abre | Esperar unos segundos y revisar `docker compose logs opensearch-dashboards`. |
| Login falla | Confirmar `admin/admin` y que los contenedores sean los del `docker-compose.yml`. |
| No aparece el índice eCommerce | Cargar **Sample eCommerce orders** desde Dashboards. |
| Un campo no agrega bien | Usar campos `keyword` para facetas, por ejemplo `category.keyword` y `manufacturer.keyword`. |
| `_bulk` falla | Confirmar que `manual-orders.ndjson` tenga una línea de acción y una línea de documento por cada registro. |

## Checklist final

- [ ] `docker compose up -d` levanta OpenSearch y Dashboards.
- [ ] `curl -k -u admin:admin https://localhost:9200` devuelve JSON del clúster.
- [ ] `_cat/indices` muestra `opensearch_dashboards_sample_data_ecommerce`.
- [ ] El índice eCommerce tiene documentos cargados.
- [ ] El dashboard usa Sample eCommerce orders.
- [ ] Hay al menos 3 visualizaciones.
- [ ] Hay controles o filtros para facetas.
- [ ] Las capturas están guardadas en `docs/screenshots/`.
- [ ] Se probaron `_search`, `_count`, `_mapping` y `_settings`.
- [ ] Se probaron agregaciones por categoría, fabricante, país y rango de precio.
- [ ] Se cargó `manual_ecommerce_orders` con `scripts/load-manual-orders.sh`.
