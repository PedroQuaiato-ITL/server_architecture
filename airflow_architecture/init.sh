#!/bin/bash

# --- SERVIÇO DO AIRFLOW ---

# 1) Init
docker-compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml up -d airflow-init
sleep 15

# 2) Sobe tudo em modo detach
docker-compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml up -d
sleep 30

# 3) Limpa o PID do worker antes de reiniciar
echo "Limpando PID do Worker..."
docker exec airflow-worker-1 rm -f /opt/airflow/airflow-worker.pid || true

# 4) Reinicia o worker direito
docker-compose -f /var/server_architecture/airflow_architecture/docker/docker-compose.yaml restart airflow-worker-1
sleep 10

# --- SERVIÇO DO NGINX ---

docker-compose -f /var/server_architecture/airflow_architecture/docker-compose-nginx.yaml up -d
sleep 10

# --- SERVIÇO DO PROMETHEUS ---

docker-compose -f /var/server_architecture/airflow_architecture/infrastructure/docker-compose-prometheus.yaml up -d

# --- SERVIÇO DO ELASTIC ---

docker-compose -f /var/server_architecture/airflow_architecture/docker/docker-compose-elastic.yaml up -d
sleep 20

# --- MAPA DE VENDAS ---

docker-compose -f /var/server_architecture/airflow_architecture/hub/map_vendas/docker-compose.yml up -d
