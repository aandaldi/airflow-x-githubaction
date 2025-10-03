FROM apache/airflow:2.9.1

COPY --chown=airflow:root test_dag.py /opt/airflow/dags
