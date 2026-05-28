# Tasks: OpenSearch local con búsqueda facetada

## Review Workload Forecast

| Field | Value |
|-------|-------|
| Estimated changed lines | 250-350 |
| 400-line budget risk | Low |
| Chained PRs recommended | No |
| Suggested split | Single PR |
| Delivery strategy | ask-always |
| Chain strategy | pending |

Decision needed before apply: No
Chained PRs recommended: No
Chain strategy: pending
400-line budget risk: Low

### Suggested Work Units

| Unit | Goal | Likely PR | Notes |
|------|------|-----------|-------|
| 1 | Local environment and guide | PR 1 | Compose, README, docs structure, verification steps. |
| 2 | Data, REST examples, dashboard evidence | PR 1 | Sample JSON, reusable requests, dashboard notes/screenshots. |

## Phase 1: Project scaffold

- [x] 1.1 Create `README.md` with objective, structure, setup, REST examples, and checklist.
- [x] 1.2 Create folders `data/sample/`, `docs/dashboard/`, `docs/rest-api/`, `docs/screenshots/`, `requests/`, and `scripts/`.
- [x] 1.3 Add `.gitignore` for local/editor/temporary files.

## Phase 2: Docker Compose guided creation

- [ ] 2.1 Create `docker-compose.yml` manually starting with top-level `services:`.
- [ ] 2.2 Add `opensearch` service with image, container name, single-node discovery, memory settings, ports, volume, and network.
- [ ] 2.3 Add `opensearch-dashboards` service connected to OpenSearch with port `5601`.
- [ ] 2.4 Validate with `docker compose up -d`, `docker compose ps`, and `curl -k -u admin:admin https://localhost:9200`.

## Phase 3: Dataset and manual ingestion

- [ ] 3.1 Load `opensearch_dashboards_sample_data_logs` from OpenSearch Dashboards.
- [ ] 3.2 Create `data/sample/manual-events.json` with custom example documents.
- [ ] 3.3 Add a request or command to load the manual dataset into a custom index.
- [ ] 3.4 Verify both datasets with `_search?size=1` and `_count`.

## Phase 4: Dashboard and faceted search

- [ ] 4.1 Document at least three visualizations in `docs/dashboard/`.
- [ ] 4.2 Document dashboard filters/facets and tested combinations.
- [ ] 4.3 Add REST examples for `_mapping`, `_settings`, term filters, and aggregations in `requests/` or `docs/rest-api/`.
- [ ] 4.4 Capture final evidence in `docs/screenshots/` and update README checklist.
