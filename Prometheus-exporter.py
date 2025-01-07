import os
import requests
import time
from prometheus_client import start_http_server, Gauge
from threading import Thread

# Environment variables for RabbitMQ connection
RABBITMQ_HOST = os.getenv("RABBITMQ_HOST", "localhost")
RABBITMQ_USER = os.getenv("RABBITMQ_USER", "guest")
RABBITMQ_PASSWORD = os.getenv("RABBITMQ_PASSWORD", "guest")

# Prometheus Metrics
queue_messages = Gauge(
    "rabbitmq_individual_queue_messages",
    "Total messages in queue",
    ["host", "vhost", "name"],
)
queue_messages_ready = Gauge(
    "rabbitmq_individual_queue_messages_ready",
    "Messages ready for delivery",
    ["host", "vhost", "name"],
)
queue_messages_unack = Gauge(
    "rabbitmq_individual_queue_messages_unacknowledged",
    "Messages unacknowledged by consumer",
    ["host", "vhost", "name"],
)


def fetch_queue_metrics():
    api_url = f"http://{RABBITMQ_HOST}:15672/api/queues"
    auth = (RABBITMQ_USER, RABBITMQ_PASSWORD)

    while True:
        try:
            response = requests.get(api_url, auth=auth)
            response.raise_for_status()
            queues = response.json()

            for queue in queues:
                vhost = queue["vhost"]
                name = queue["name"]
                messages = queue["messages"]
                ready = queue["messages_ready"]
                unack = queue["messages_unacknowledged"]

                # Set Prometheus metrics
                queue_messages.labels(host=RABBITMQ_HOST, vhost=vhost, name=name).set(messages)
                queue_messages_ready.labels(host=RABBITMQ_HOST, vhost=vhost, name=name).set(ready)
                queue_messages_unack.labels(host=RABBITMQ_HOST, vhost=vhost, name=name).set(unack)

        except Exception as e:
            print(f"Error fetching metric: {e}")

        # Scrape every 30 seconds
        time.sleep(30)


if __name__ == "__main__":
    # Start the Prometheus  server
    start_http_server(9105)

    # Run the metrics collection in a background thread
    Thread(target=fetch_queue_metrics).start()

    print("RabbitMQ Prometheus Exporter running at http://localhost:9105/metrics")
