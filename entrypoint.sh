#!/bin/bash
set -e

# Initialize the database if it's not already initialized
# This is a basic check; for production, consider more robust methods
pip install -r requirements.txt
echo "Initializing Airflow database..."
airflow db init

echo "Creating admin user..."
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin || true # Fails silently if user already exists

echo "Starting Airflow scheduler in the background..."
airflow scheduler &

echo "Starting Airflow webserver in the foreground..."
exec airflow webserver