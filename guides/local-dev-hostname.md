# Local Development URL Configuration for GigaDB

This document explains why the site you run with `./up.sh` is accessible at
`http://gigadb.gigasciencejournal.com/` and what pieces in the repository are
responsible for making that work.

---

## 1. Environment variables

* **File**: `ops/configuration/variables/env-sample` (copied to `.env` on first
  run)
* Relevant keys:
  * `HOME_URL` – canonical base URL used by the application
  * `SERVER_HOSTNAME` – hostname injected into Nginx & Yii configs
  * `PUBLIC_HTTP_PORT` / `PUBLIC_HTTPS_PORT` – ports exposed on the host

These variables steer every other step in the setup.

---

## 2. Docker-Compose wiring

* **File**: `ops/deployment/docker-compose.yml`
* The **web** service exposes container ports through the variables above:
  ```yaml
  ports:
    - "${PUBLIC_HTTP_PORT}:80"
    - "${PUBLIC_HTTPS_PORT}:443"
  ```
* The service sits at a fixed internal IP (`172.16.238.10`) on the custom
  `web-tier` network so that sibling containers can reach it reliably.

---

## 3. Nginx virtual-host

* **File**: `ops/configuration/nginx-conf/sites/dev/gigadb.dev.http.conf`
* Activated by the helper script `enable_sites` when the container starts.
* Accepts the host headers below, the first being the canonical one:
  ```nginx
  server_name gigadb.gigasciencejournal.com web gigadb.dev gigadb.test;
  ```

---

## 4. Automatic templating

`./up.sh` launches two helper containers (`config` and `fuw-config`) that run
`ops/scripts/generate_config.sh`.  That script substitute-exports the
environment variables into a large set of `*.dist` template files, including
all Nginx site files and both Yii 1.1 and Yii 2 config files.  This keeps the
hostname consistent across every layer.

---

## 5. Container-to-container resolution

Services that need to contact the web tier use static `/etc/hosts` lines added
through `extra_hosts` in the compose file, e.g.
```yaml
extra_hosts:
  - "gigadb.dev:172.16.238.10"
  - "gigadb.test:172.16.238.10"
```

---

## 6. How your host machine resolves the name

`docker-compose` maps container port **80** directly to the same port on your
host, so *any* request landing on `localhost:80` is forwarded inside — provided
that the request's **Host** header is `gigadb.gigasciencejournal.com`.

You usually get that header via one of two methods:

1. A manual line in `/etc/hosts`:
   ```
   127.0.0.1   gigadb.gigasciencejournal.com
   ```
2. A local DNS stub (Docker Desktop, dnsmasq, systemd-resolved, etc.) previously
   configured to answer `gigadb.gigasciencejournal.com → 127.0.0.1`.

The project itself never edits `/etc/hosts`; it merely assumes the name resolves
to the machine where Docker is running.

---

## Recap

1. `.env` defines the hostname and exposed ports.
2. `generate_config.sh` injects that hostname into Nginx and Yii templates.
3. The **web** container publishes port 80 to your host.
4. Your OS resolves `gigadb.gigasciencejournal.com` to `127.0.0.1`, so the
   browser reaches the container.

With these pieces in place, the site is reachable at
`http://gigadb.gigasciencejournal.com/` every time you run `./up.sh`.  If the
name ever stops resolving, just add it to `/etc/hosts` manually and the rest of
the stack will continue to work.