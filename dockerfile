# Use a Python base image
FROM python:3.10-slim

ENV AIRFLOW_HOME=/opt/airflow

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow && \
    apt-get autoremove -yqq --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${AIRFLOW_HOME}

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Copy the rest of the application
COPY ./dags .
COPY ./entrypoint.sh .


RUN chown -R airflow:airflow ${AIRFLOW_HOME} && chmod +x entrypoint.sh

EXPOSE 8080
USER airflow

CMD ["./entrypoint.sh"]
