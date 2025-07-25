#!/bin/bash

# --- SERVIÇO DO AIRFLOW ---

echo "Rodando airflow-init..."
docker compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml run --rm airflow-init

echo "Subindo serviços principais..."
docker compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml up -d
sleep 30

echo "Limpando PID do Worker..."
docker exec docker-airflow-worker-1 rm -f /opt/airflow/airflow-worker.pid || true

echo "Reiniciando Worker..."
docker compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml restart airflow-worker
sleep 10

# --- SERVIÇO DO NGINX ---
docker compose -f /var/server_architecture/airflow_architecture/docker-compose-nginx.yaml up -d
sleep 10

# --- SERVIÇO DO PROMETHEUS ---
docker compose -f /var/server_architecture/airflow_architecture/infrastructure/docker-compose-prometheus.yaml up -d

# --- SERVIÇO DO ELASTIC ---
docker compose -f /var/server_architecture/airflow_architecture/docker/docker-compose-elastic.yaml up -d
sleep 20

# --- MAPA DE VENDAS ---
docker compose -f /var/server_architecture/airflow_architecture/hub/map_vendas/docker-compose.yml up -d

echo "🚀 Tudo certo! Sem loop no init, sem zumbi."
