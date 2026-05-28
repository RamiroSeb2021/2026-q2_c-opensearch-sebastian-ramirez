# Proposal: OpenSearch local con búsqueda facetada

## Summary

Crear un repositorio de ejercicio para aprender OpenSearch desde cero: entorno local con Docker Compose, carga de datos de ejemplo, dashboard con visualizaciones y consultas REST para búsqueda facetada.

## Problem

El ejercicio pide demostrar varias capacidades conectadas: instalación local, ingesta, visualización, filtros/facetas y consumo del API REST. Sin una estructura clara, es fácil levantar contenedores sin entender qué se está haciendo.

## Goals

- Documentar el flujo reproducible del ejercicio en Markdown.
- Guiar la creación manual de `docker-compose.yml`.
- Usar OpenSearch Dashboards para cargar datos y crear visualizaciones.
- Practicar consultas REST con `_search`, `_count`, `_mapping`, `_settings` y agregaciones.
- Cargar al menos un ejemplo adicional construido manualmente.

## Non-goals

- Crear una aplicación web propia.
- Automatizar todo el taller con scripts desde el inicio.
- Configurar un clúster productivo o multi-nodo.

## Rollback

El entorno local se puede detener con `docker compose down`. Si se quiere borrar datos locales, usar `docker compose down -v` solo después de confirmar que no se necesitan los índices.
