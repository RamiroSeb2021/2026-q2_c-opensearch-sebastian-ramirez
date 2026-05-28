# Dashboard eCommerce

El dashboard debe mostrar cómo se exploran órdenes eCommerce con visualizaciones y facetas. Podés clonar el dashboard de ejemplo o crear uno nuevo, pero debe quedar evidencia en `docs/screenshots/`.

## Camino rápido

1. Cargar **Sample eCommerce orders** desde OpenSearch Dashboards.
2. Abrir el dashboard de ejemplo del dataset.
3. Clonarlo o crear uno propio.
4. Asegurar al menos 3 visualizaciones.
5. Agregar controles o filtros para facetas.
6. Guardar capturas en `docs/screenshots/`.

## Cargar datos eCommerce

1. Entrar a `http://localhost:5601`.
2. Iniciar sesión con `admin/admin`.
3. Ir a **Home** o **Add data**.
4. Elegir **Sample eCommerce orders**.
5. Seleccionar **Add data**.
6. Confirmar que el índice sea `opensearch_dashboards_sample_data_ecommerce`.

## Crear o clonar el dashboard

Opción recomendada para el ejercicio:

1. Abrir el dashboard de ejemplo de eCommerce.
2. Guardarlo como una copia con un nombre propio.
3. Ajustar visualizaciones y filtros para demostrar facetas.

También podés crear un dashboard desde cero si incluye las evidencias mínimas.

## Requisitos mínimos

- Al menos 3 visualizaciones.
- Uso del índice `opensearch_dashboards_sample_data_ecommerce`.
- Controles, filtros o interacciones que permitan facetar los datos.
- Evidencia guardada en `docs/screenshots/`.

## Visualizaciones sugeridas

| Visualización | Campo sugerido | Qué demuestra |
|---|---|---|
| Órdenes por categoría | `category` | Faceta categórica principal. |
| Órdenes por fabricante | `manufacturer` | Comparación entre marcas o proveedores. |
| Órdenes por país | `geoip.country_iso_code` | Distribución geográfica. |
| Ventas por fecha | `order_date` | Evolución temporal. |
| Distribución de cantidad | `total_quantity` | Faceta numérica o filtro por cantidad. |
| Rangos de precio | `taxful_total_price` | Segmentación por valor de compra. |

## Controles y facetas

Incluir controles o filtros para explorar:

- `category`: filtrar por tipo de producto.
- `manufacturer`: comparar fabricantes.
- `total_quantity`: limitar por cantidad comprada.
- `order_date`: analizar un período específico.

La idea importante es que el dashboard permita cambiar el subconjunto de órdenes y ver cómo se actualizan las visualizaciones.

## Capturas recomendadas

Guardar las imágenes en `docs/screenshots/`.

Nombres sugeridos:

- `01-ecommerce-sample-loaded.png`: dataset cargado.
- `02-ecommerce-index.png`: índice visible en OpenSearch.
- `03-dashboard-overview.png`: dashboard completo.
- `04-category-filter.png`: dashboard filtrado por categoría.
- `05-manufacturer-filter.png`: dashboard filtrado por fabricante.
- `06-date-range-filter.png`: dashboard filtrado por fecha.

## Checklist de evidencia

- [ ] Se ve que **Sample eCommerce orders** está cargado.
- [ ] Se ve el dashboard creado o clonado.
- [ ] Se ven al menos 3 visualizaciones.
- [ ] Se ve un filtro por categoría.
- [ ] Se ve un filtro por fabricante.
- [ ] Se ve un filtro por cantidad o fecha.
- [ ] Las capturas están dentro de `docs/screenshots/`.
