# GitHub Actions Self-Hosted Runner for Raspberry Pi

This repository contains the configuration for running a GitHub Actions self-hosted runner in a Docker container on a Raspberry Pi 3B+.

## Prerequisites

- Raspberry Pi 3B+ running Raspberry Pi OS or similar
- Docker and Docker Compose installed
- GitHub repository where you want to add the runner

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/barnolacesc/gha-selfhosted-runner.git
   cd gha-selfhosted-runner
   ```

2. Create a `.env` file with the following variables:
   ```
   REPO_URL=https://github.com/your-username/your-repo
   RUNNER_TOKEN=your-runner-token
   RUNNER_NAME=raspberry-pi-runner
   ```

   To get the runner token:
   - Go to your GitHub repository
   - Navigate to Settings > Actions > Runners
   - Click "New self-hosted runner"
   - Copy the token from the configuration instructions

3. Build and start the container:
   ```bash
   docker-compose up -d
   ```

4. Check the logs to ensure the runner is connected:
   ```bash
   docker-compose logs -f
   ```

## Usage

The runner will automatically start when your Raspberry Pi boots up (thanks to the `restart: unless-stopped` policy in docker-compose.yml).

To stop the runner:
```bash
docker-compose down
```

To view logs:
```bash
docker-compose logs -f
```

## Security Considerations

- The runner runs as a non-root user inside the container
- The container is isolated from the host system
- Sensitive data is stored in environment variables
- The runner automatically removes itself when the container stops

## Resource Usage

This setup is optimized for minimal resource usage on a Raspberry Pi 3B+:
- Uses ARM32v7 base image
- Minimal package installation
- Automatic cleanup of temporary files
- Efficient runner configuration

## Troubleshooting

If you encounter issues:
1. Check the container logs: `docker-compose logs -f`
2. Ensure your `.env` file has the correct values
3. Verify your GitHub repository settings
4. Check if the runner appears in your GitHub repository's Actions > Runners section 