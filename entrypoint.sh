#!/bin/bash

# Initialize the database if it's not already initialized
# This is a basic check; for production, consider more robust methods
echo "start";
    echo "Initializing Airflow database..."
airflow db init
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

nohup bash airflow webserver > output.txt