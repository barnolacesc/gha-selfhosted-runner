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

# Check if environment variables are set
if [ -z "${REPO_URL}" ]; then
    echo "Error: REPO_URL is not set"
    exit 1
fi

if [ -z "${RUNNER_TOKEN}" ]; then
    echo "Error: RUNNER_TOKEN is not set"
    exit 1
fi

if [ -z "${RUNNER_NAME}" ]; then
    echo "Error: RUNNER_NAME is not set"
    exit 1
fi

echo "Configuring runner for: ${REPO_URL}"
echo "Runner name: ${RUNNER_NAME}"

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