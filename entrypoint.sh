#!/bin/bash

# Function to remove the runner
remove_runner() {
    echo "Removing runner..."
    ./config.sh remove --token "${RUNNER_TOKEN}"
}

# Function to start the runner
start_runner() {
    echo "Starting runner..."
    ./run.sh
}

# Register the runner
./config.sh --url "${REPO_URL}" --token "${RUNNER_TOKEN}" --name "${RUNNER_NAME}" --unattended

# Set up cleanup on container exit
trap remove_runner EXIT

# Start the runner and keep it running
while true; do
    start_runner
    echo "Runner stopped. Restarting in 5 seconds..."
    sleep 5
done 