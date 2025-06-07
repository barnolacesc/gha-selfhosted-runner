#!/bin/bash

# Function to remove the runner
remove_runner() {
    echo "Removing runner..."
    ./config.sh remove --token "${RUNNER_TOKEN}"
}

# Register the runner
./config.sh --url "${REPO_URL}" --token "${RUNNER_TOKEN}" --name "${RUNNER_NAME}" --unattended

# Set up cleanup on container exit
trap remove_runner EXIT

# Start the runner
./run.sh 