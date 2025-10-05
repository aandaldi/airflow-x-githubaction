# Use a Python base image
FROM python:3.10-slim

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR ${AIRFLOW_HOME}

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Copy the rest of the application
COPY . .

RUN chown -R airflow:airflow ${AIRFLOW_HOME} && chmod +x entrypoint.sh

EXPOSE 8080
USER airflow

CMD ["./entrypoint.sh"]
