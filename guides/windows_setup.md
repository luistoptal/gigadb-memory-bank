# GigaDB Local Development Setup on Windows

## Introduction

This guide provides instructions for setting up the GigaDB project for local development on a Windows machine. The project's development environment is primarily based on Linux. The recommended and most straightforward approach for Windows users is to use the Windows Subsystem for Linux (WSL 2). This will ensure compatibility with the project's scripts and tooling.

This guide assumes you are using WSL 2.

## Part 1: Prerequisites

Before you begin, ensure you have the following installed and configured:

1.  **WSL 2**: The Windows Subsystem for Linux allows you to run a Linux environment directly on Windows.
    *   [Official Microsoft Installation Guide for WSL 2](https://docs.microsoft.com/en-us/windows/wsl/install)

2.  **A Linux Distribution**: You'll need to install a Linux distribution from the Microsoft Store. Ubuntu is a popular choice and is recommended.
    *   [Ubuntu on Microsoft Store](https://www.microsoft.com/store/productId/9PDXGNCFSCZV)

3.  **Docker Desktop for Windows**: Docker is used to manage the application's services (web server, database, etc.).
    *   [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
    *   **Crucially**, you must enable WSL 2 integration in Docker Desktop's settings:
        *   Go to Settings > Resources > WSL Integration.
        *   Enable integration with your installed Linux distribution (e.g., Ubuntu).

4.  **Git in WSL 2**: You'll need Git to clone the repository inside your WSL environment.
    *   Open your WSL terminal (e.g., Ubuntu).
    *   Run the following commands to install Git:
        ```bash
        sudo apt-get update
        sudo apt-get install git -y
        ```

5.  **(Recommended) Windows Terminal & VS Code**:
    *   **Windows Terminal** provides a modern, tabbed terminal experience. You can get it from the [Microsoft Store](https://www.microsoft.com/store/productId/9N0DX20HK701).
    *   **Visual Studio Code** with the [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) extension is highly recommended for editing code that lives inside your WSL file system.

## Part 2: Project Setup

All commands below should be run from your WSL 2 terminal.

1.  **Clone the Repository**
    *   Choose a location for your projects within WSL (e.g., `~/projects`).
    *   Clone the GigaDB repository (replace with the correct URL if different):
        ```bash
        mkdir -p ~/projects
        cd ~/projects
        git clone https://github.com/GigaDB/gigadb-website.git
        cd gigadb-website
        ```
    *   It's good practice to configure Git to handle line endings correctly between Windows and Linux.
        ```bash
        git config --global core.autocrlf input
        ```

2.  **Environment Configuration**
    *   The application requires `.env` and `.secrets` files for configuration. These files are not stored in version control for security reasons.
    *   You may need to create these from example files if they exist (e.g., `env.example`) or get them from a team member. For example:
        ```bash
        cp .env.example .env
        ```
    *   Populate `.env` and `.secrets` with the necessary configuration values for local development. You may need to ask a project maintainer for the required secrets and credentials.

3.  **Build and Run the Application**
    *   The project includes a script to orchestrate the setup process using Docker Compose.
    *   From the root of the project directory, run:
        ```bash
        ./up.sh
        ```
    *   This script will build the Docker images, start all the services, and may perform initial setup tasks like installing dependencies. This can take a significant amount of time on the first run.

4.  **Database Migrations**
    *   After the application is running, you may need to apply database migrations to set up the database schema.
    *   You will likely need to run the migration command inside the running PHP container. The exact command can vary, but it will look something like this:
        ```bash
        docker-compose exec <php-service-name> ./protected/yiic migrate
        ```
    *   You will need to find the correct service name for the PHP container in the `docker-compose.yml` file (it might be `php-fpm`, `app`, or `web`).

5.  **Frontend Assets**
    *   The project uses `npm` to manage frontend dependencies.
    *   Navigate to the frontend source directory, install dependencies, and build the assets:
        ```bash
        cd gigadb/app/client/web
        npm install
        npm run build
        ```
    *   For development, you can use the watch script to automatically rebuild assets when files change:
        ```bash
        ./watch-vue.sh
        ```
        (You may need to run this from the project root)

## Part 3: Accessing the Application

*   Once all services are running, you should be able to access the GigaDB website in your browser.
*   The default URL is likely `http://localhost`. If that doesn't work, check your `.env` file or the `docker-compose.yml` for the port number (e.g., `http://localhost:8080`).

## Part 4: Running Tests

The project contains several test suites. You can run them using the provided scripts from the project root in your WSL terminal:

*   **Run all unit and functional tests:**
    ```bash
    ./tests/unit_functional_runner
    ```
*   **Run only unit tests:**
    ```bash
    ./tests/unit_runner
    ```
*   **Run only functional tests:**
    ```bash
    ./tests/functional_runner
    ```
*   **Run acceptance tests:**
    ```bash
    ./tests/acceptance_runner
    ```
*   **Run Playwright end-to-end tests:**
    ```bash
    cd playwright
    npm install
    npx playwright test
    ```

## Troubleshooting

*   **Permission Errors on Scripts**: If you get a "permission denied" error when running a `.sh` file, make it executable: `chmod +x ./script-name.sh`.
*   **Docker not running**: Ensure Docker Desktop is running and the WSL 2 integration is enabled.
*   **Performance**: Ensure you are working with the code on the WSL 2 filesystem (e.g. inside `~/projects`) and not the Windows filesystem (`/mnt/c/...`) for better performance.