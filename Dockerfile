FROM arm32v7/ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash github-runner

# Set up the working directory
WORKDIR /home/github-runner

# Switch to the non-root user
USER github-runner

# Download and install the runner
RUN curl -o actions-runner-linux-arm-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-arm-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-arm-2.311.0.tar.gz \
    && rm actions-runner-linux-arm-2.311.0.tar.gz

# Copy the entrypoint script
COPY --chown=github-runner:github-runner entrypoint.sh /home/github-runner/entrypoint.sh
RUN chmod +x /home/github-runner/entrypoint.sh

ENTRYPOINT ["/home/github-runner/entrypoint.sh"] 