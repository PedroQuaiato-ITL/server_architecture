#!/bin/bash

docker-compose -f C:\Users\pedro.quaiato\Desktop\architecture_airflow\docker\docker-compose.yaml up airflow-init
sleep 30
docker-compose -f C:\Users\pedro.quaiato\Desktop\architecture_airflow\docker\docker-compose.yaml up 
sleep 120
docker-compose -f C:\Users\pedro.quaiato\Desktop\architecture_airflow\docker\docker-compose-elastic.yaml up
sleep 60
docker-compose -f C:\Users\pedro.quaiato\Desktop\architecture_airflow\docker-compose-nginx.yaml up
sleep 60
docker-compose -f C:\Users\pedro.quaiato\Desktop\architecture_airflow\infrastructure\docker-compose-prometheus.yaml up