#!/usr/bin/env bash
set -euo pipefail

URL="${URL:-https://localhost:9200}"
INDEX="${INDEX:-manual_ecommerce_orders}"
AUTH="${AUTH:-admin:admin}"
DATA_FILE="${DATA_FILE:-data/sample/manual-orders.ndjson}"

if [[ ! -f "$DATA_FILE" ]]; then
  printf 'Data file not found: %s\n' "$DATA_FILE" >&2
  exit 1
fi

if ! curl -k -sS -u "$AUTH" -f "$URL/$INDEX" >/dev/null; then
  curl -k -sS -u "$AUTH" -X PUT "$URL/$INDEX" \
    -H 'Content-Type: application/json' \
    -d '{
      "mappings": {
        "properties": {
          "order_id": { "type": "keyword" },
          "customer_id": { "type": "keyword" },
          "order_date": { "type": "date" },
          "category": { "type": "keyword" },
          "manufacturer": { "type": "keyword" },
          "country": { "type": "keyword" },
          "currency": { "type": "keyword" },
          "quantity": { "type": "integer" },
          "taxful_total_price": { "type": "float" },
          "products": {
            "type": "nested",
            "properties": {
              "sku": { "type": "keyword" },
              "name": { "type": "text", "fields": { "keyword": { "type": "keyword" } } },
              "quantity": { "type": "integer" },
              "price": { "type": "float" }
            }
          }
        }
      }
    }'
fi

curl -k -sS -u "$AUTH" -X POST "$URL/$INDEX/_bulk" \
  -H 'Content-Type: application/x-ndjson' \
  --data-binary "@$DATA_FILE"

printf '\nLoaded manual orders into %s\n' "$INDEX"
