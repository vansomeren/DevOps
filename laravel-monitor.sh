#!/bin/bash

#Standard script Configuration
SERVICE_NAME="laravel-monitor"
CPU_THRESHOLD=80
CHECK_INTERVAL=30

# Function to check CPU usage
check_cpu_usage() {
    # Get the average CPU usage over the last minute
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    # Round CPU usage to an integer
    cpu_usage=$(printf "%.0f" "$cpu_usage")

    echo "Current CPU Usage: ${cpu_usage}%"

    # If CPU usage exceeds the threshold, restart the service
    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        echo "CPU usage exceeded ${CPU_THRESHOLD}%. Restarting ${SERVICE_NAME}..."
        restart_service
    else
        echo "CPU usage is normal."
    fi
}

# Function to restart the Laravel service
restart_service() {
    # Restart the service using systemd
    sudo systemctl restart ${SERVICE_NAME}
    echo "${SERVICE_NAME} restarted successfully."

}

# Loop to check CPU usage periodically
while true; do
    check_cpu_usage
    sleep $CHECK_INTERVAL
done
