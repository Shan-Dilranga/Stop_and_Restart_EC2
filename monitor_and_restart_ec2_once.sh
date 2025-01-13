#!/bin/bash

# Variables
INSTANCE_ID="your-instance-id" # Replace with your EC2 instance ID
REGION="your-region"          # Replace with your AWS region

# Function to get the health status
get_health_status() {
    aws ec2 describe-instance-status \
        --instance-id "$INSTANCE_ID" \
        --region "$REGION" \
        --query 'InstanceStatuses[0].InstanceStatus.Status' \
        --output text
}

# Function to stop and restart the instance
stop_and_restart_instance() {
    echo "Stopping instance $INSTANCE_ID..."
    aws ec2 stop-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
    echo "Waiting for the instance to stop..."
    aws ec2 wait instance-stopped --instance-ids "$INSTANCE_ID" --region "$REGION"
    echo "Instance stopped successfully."

    echo "Starting instance $INSTANCE_ID..."
    aws ec2 start-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
    echo "Waiting for the instance to start..."
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"
    echo "Instance started successfully."
}

# Main logic
HEALTH_STATUS=$(get_health_status)

echo "Health status of instance $INSTANCE_ID: $HEALTH_STATUS"

if [[ "$HEALTH_STATUS" != "ok" && "$HEALTH_STATUS" != "initializing" ]]; then
    echo "Health check failed. Taking corrective action..."
    stop_and_restart_instance
else
    echo "Instance is healthy. No action required."
fi
