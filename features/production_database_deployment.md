# Production Database Deployment Summary

This document summarizes the findings regarding the deployment and configuration of the production database for the GigaDB application.

## Key Findings

1.  **Environment:** The production application, including the database, is deployed on **AWS EC2 instances**. This is inferred from the use of the `ec2-user` home directory (`/home/ec2-user/app_data`) in deployment scripts (`ops/pipelines/gigadb-deploy-jobs.yml`).
2.  **Database Type:** The database is **PostgreSQL**. The specific version is defined by the `POSTGRES_VERSION` variable in `.env` and `ops/deployment/docker-compose.yml` (e.g., `14.8` or `14.15` depending on context).
3.  **Deployment Method:** The database runs inside a **Docker container**, managed by **Docker Compose**. The service definition is found in `ops/deployment/docker-compose.yml`.
4.  **Configuration & Credentials:**
    *   Sensitive database credentials (database name, username, password) are **not stored** directly in the repository.
    *   They are injected during the CI/CD pipeline (defined in `.gitlab-ci.yml`) from **GitLab CI/CD secret variables**.
    *   The `before_script` in `.gitlab-ci.yml` and deployment steps in `ops/pipelines/gigadb-deploy-jobs.yml` dynamically populate `.env` and `.secrets` files with these variables within the CI runner environment before executing `docker-compose` commands.
    *   The `docker-compose.yml` file references environment variables like `POSTGRES_DB`, `POSTGRES_USER`, and `POSTGRES_PASSWORD`, which are sourced from these dynamically generated files or GitLab variables during deployment.
5.  **Network Configuration:**
    *   The PostgreSQL container (`database` service in `ops/deployment/docker-compose.yml`) listens on port `5432` internally.
    *   This internal port is mapped to port **`54321`** on the host EC2 instance (`published: 54321`).
6.  **Connection Method (External Tools):**
    *   Direct connection from external tools (like DBeaver) requires an **SSH tunnel** to the production EC2 instance.
    *   The tunnel should forward a local port to `localhost:5432` *on the EC2 instance* (connecting to the container's internal port).
    *   Alternatively, the tunnel can forward to the EC2 host's port `54321`. The DBeaver configuration should target `localhost:5432` when using the SSH tunnel setup.
7.  **Relevant Files:**
    *   `.env`: Contains general environment settings and points to GitLab for secrets.
    *   `.gitlab-ci.yml`: Defines the CI/CD pipeline, stages, jobs, and variable handling.
    *   `ops/pipelines/gigadb-deploy-jobs.yml`: Contains scripts executed during deployment stages, showing interaction with remote Docker hosts and variable handling.
    *   `ops/deployment/docker-compose.yml`: Defines the database service, default credentials (overridden), and port mapping (`54321`).
    *   `ops/deployment/docker-compose.production-envs.yml`: Used in deployment steps, but notably *lacks* the database service definition itself.

## Security Considerations

*   Database credentials are appropriately managed via GitLab CI/CD secrets, not committed to the repository.
*   Direct access to the database requires SSH access to the EC2 instance, limiting exposure.
*   Manual database changes should be performed with extreme caution and preferably avoided in favor of application-level changes or migrations.