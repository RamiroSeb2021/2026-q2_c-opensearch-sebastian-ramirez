# Consultas REST para eCommerce

Esta guía muestra cómo explorar `opensearch_dashboards_sample_data_ecommerce` desde terminal y desde Dev Tools. Primero ejecutá las consultas básicas; después avanzá a facetas y filtros.

## Cómo ejecutar

Desde terminal, usá `curl` con `-k` porque OpenSearch local usa HTTPS con certificado autofirmado:

```bash
curl -k -u admin:admin "https://localhost:9200/opensearch_dashboards_sample_data_ecommerce/_count"
```

Desde OpenSearch Dashboards:

1. Entrar a `http://localhost:5601`.
2. Abrir **Dev Tools**.
3. Pegar solo el método, path y body. No pegues el dominio completo.

Ejemplo para Dev Tools:

```http
GET opensearch_dashboards_sample_data_ecommerce/_count
```

## Índice usado

```text
opensearch_dashboards_sample_data_ecommerce
```

Este índice viene de **Sample eCommerce orders** y permite practicar facetas con categorías, fabricantes, países, fechas, cantidades y precios.

## Consultas básicas

Traer un documento:

```http
GET opensearch_dashboards_sample_data_ecommerce/_search?size=1
```

Contar documentos:

```http
GET opensearch_dashboards_sample_data_ecommerce/_count
```

Ver mapping:

```http
GET opensearch_dashboards_sample_data_ecommerce/_mapping
```

Ver settings:

```http
GET opensearch_dashboards_sample_data_ecommerce/_settings
```

## Agregaciones de términos

Las facetas categóricas usan `terms`. Para textos, normalmente conviene usar la variante `.keyword`.

Agrupar por categoría:

```http
GET opensearch_dashboards_sample_data_ecommerce/_search
{
  "size": 0,
  "aggs": {
    "por_categoria": {
      "terms": {
        "field": "category.keyword",
        "size": 10
      }
    }
  }
}
```

Agrupar por fabricante:

```http
GET opensearch_dashboards_sample_data_ecommerce/_search
{
  "size": 0,
  "aggs": {
    "por_fabricante": {
      "terms": {
        "field": "manufacturer.keyword",
        "size": 10
      }
    }
  }
}
```

Agrupar por país:

```http
GET opensearch_dashboards_sample_data_ecommerce/_search
{
  "size": 0,
  "aggs": {
    "por_pais": {
      "terms": {
        "field": "geoip.country_iso_code",
        "size": 10
      }
    }
  }
}
```

## Búsqueda facetada con filtro

Este ejemplo filtra una categoría y calcula facetas sobre el subconjunto filtrado.

```http
GET opensearch_dashboards_sample_data_ecommerce/_search
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
    "por_fabricante": {
      "terms": {
        "field": "manufacturer.keyword",
        "size": 10
      }
    },
    "por_pais": {
      "terms": {
        "field": "geoip.country_iso_code",
        "size": 10
      }
    }
  }
}
```

## Rango por precio total

`range` permite construir facetas numéricas. Acá se agrupa por `taxful_total_price`.

```http
GET opensearch_dashboards_sample_data_ecommerce/_search
{
  "size": 0,
  "aggs": {
    "rangos_de_precio": {
      "range": {
        "field": "taxful_total_price",
        "ranges": [
          { "key": "menos_de_50", "to": 50 },
          { "key": "50_a_100", "from": 50, "to": 100 },
          { "key": "100_o_mas", "from": 100 }
        ]
      }
    }
  }
}
```

## Archivo listo para ejecutar

Los mismos ejemplos están en `requests/ecommerce-rest-examples.http` para usarlos con un cliente HTTP compatible con archivos `.http`.
