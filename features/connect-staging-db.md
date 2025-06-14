# Connecting to the Staging PostgreSQL Database

Connecting to the staging database requires establishing an SSH tunnel through the bastion host because the database is not directly accessible from the public internet.

## Prerequisites

1.  **Database Credentials:** Obtain the following details for the staging database, typically stored as GitLab CI/CD variables scoped to the `staging` environment:
    *   `gigadb_db_host`: The **private** hostname or IP address of the RDS instance.
    *   `gigadb_db_database`: The name of the database (e.g., `gigadb`).
    *   `gigadb_db_user`: The database username.
    *   `gigadb_db_password`: The database password (likely masked in GitLab).
    *   *(Optional)* `gigadb_db_port`: The database port (defaults to 5432 if not specified).

2.  **SSH Tunnel Credentials:** Obtain the following details for the SSH bastion host:
    *   **Bastion Host IP/Hostname:** The public IP address or hostname of the staging bastion server. Find this in the `remote_bastion_public_ip` GitLab CI/CD variable (scoped to `staging`).
    *   **SSH User:** The username to connect to the bastion host (typically `ec2-user`).
    *   **SSH Private Key:** The path on your **local machine** to the SSH private key file (`.pem`) that was used during the provisioning of the staging environment (e.g., `~/.ssh/id-rsa-aws-hk-gigadb.pem`).

3.  **Database Client:** A database client tool that supports SSH tunneling (e.g., DBeaver, pgAdmin, command-line `psql` with SSH tunneling).

## Connection Steps (using DBeaver as an example)

1.  **Create New Connection:** Start creating a new PostgreSQL connection in DBeaver.
2.  **Main Tab:**
    *   **Host:** Enter the **private** database hostname/IP (`gigadb_db_host`).
    *   **Port:** Enter the database port (usually 5432).
    *   **Database:** Enter the database name (`gigadb_db_database`).
    *   **Username:** Enter the database user (`gigadb_db_user`).
    *   **Password:** Enter the database password (`gigadb_db_password`).
3.  **SSH Tab:**
    *   Check "Use SSH Tunnel".
    *   **Host/IP:** Enter the **public** IP or hostname of the bastion server (`remote_bastion_public_ip`).
    *   **Port:** 22 (or the bastion's SSH port if different).
    *   **User Name:** Enter the SSH user (`ec2-user`).
    *   **Authentication Method:** Select "Public Key".
    *   **Private Key:** Browse to and select your local SSH private key file (`.pem`). Enter the passphrase if required.
4.  **Test Connection:** Click "Test Connection..." to verify the settings.
5.  **Finish:** Save the connection configuration.

You should now be able to connect to the staging database through the secure SSH tunnel.
