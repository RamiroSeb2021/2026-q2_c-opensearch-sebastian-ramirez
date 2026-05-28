# Spec: OpenSearch local con búsqueda facetada

## Requirement: Entorno local

El proyecto MUST permitir levantar OpenSearch y OpenSearch Dashboards con Docker Compose.

### Scenario: levantar servicios locales

Given que Docker está disponible
When el usuario ejecute `docker compose up -d`
Then OpenSearch SHOULD responder en `https://localhost:9200`
And Dashboards SHOULD responder en `http://localhost:5601`.

## Requirement: Dataset de ejemplo

El usuario MUST cargar el índice `opensearch_dashboards_sample_data_logs` desde OpenSearch Dashboards.

### Scenario: validar índice de logs

Given que Dashboards está disponible
When el usuario cargue el dataset de logs
Then el índice SHOULD poder consultarse desde Dashboards y desde el API REST.

## Requirement: Dashboard

El ejercicio MUST incluir al menos tres visualizaciones y un dashboard integrado.

### Scenario: crear visualizaciones

Given que el índice de logs existe
When el usuario cree visualizaciones sobre campos como host, response o timestamp
Then el dashboard SHOULD permitir explorar los datos visualmente.

## Requirement: Faceted search vía REST

El ejercicio MUST demostrar búsquedas facetadas combinando filtros y agregaciones.

### Scenario: consultar facetas

Given que el índice de logs existe
When el usuario ejecute una consulta `_search` con `size: 0` y `aggs`
Then OpenSearch SHOULD devolver buckets agrupados por campos categóricos.

## Requirement: Ingesta manual adicional

El ejercicio MUST incluir un documento o dataset adicional construido manualmente.

### Scenario: cargar ejemplo propio

Given que OpenSearch está corriendo
When el usuario cargue un documento JSON propio
Then el nuevo índice SHOULD poder consultarse con `_search` y `_count`.
