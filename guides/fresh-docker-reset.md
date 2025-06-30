# Fresh Docker Reset for Local Development

Use this guide whenever you need a **100 % clean** local Docker environment before starting GigaDB + FUW with `./up.sh`.

```bash
# 1 – Move to project root so compose paths resolve correctly
cd /home/luis/APP/001-WORK/GIGADB/gigadb-website

# 2 – Stop and delete everything the compose stack created
#     (containers, networks, named volumes, local images)
docker-compose \
  -f ops/deployment/docker-compose.yml \
  --env-file .env \
  down --rmi local --volumes --remove-orphans

# 3 – Optional spring-clean of the Docker daemon
docker volume  prune -f      # remove dangling volumes
docker network prune -f      # remove orphaned networks
docker image   prune -f      # delete dangling images
# or go nuclear:
# docker system prune -af --volumes

# 4 – Spin everything up from scratch
./up.sh            # add a DB set arg like "production_like" if required
```

What each step does
1. **Change directory** – ensures the relative paths inside the compose file resolve.
2. **`docker-compose down …`** – shuts the stack down **and** deletes:
   • containers  • networks  • named volumes  • images built **locally** by the project.
3. **Prune** – clears any dangling resources left in the Docker daemon.
4. **`./up.sh`** – your normal bootstrap script: builds images, installs Composer/NPM deps, seeds the databases, and starts workers.

This sequence is effectively a "nuke-and-pave" for local development.