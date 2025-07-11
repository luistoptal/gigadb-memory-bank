Q: Changes on local database are not being reflected in the UI of the local dev site

A: In `index.php`, set `DISABLE_CACHE` to `true`.

Q: Acceptance tests failing with: `(...) invalid integer value "%GIGADB_PORT%" (...)`

A: Add `GIGADB_PORT=5432` to your `.secrets` file.

Q: bastion playbook failing (`env OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook -i ../../inventories bastion_playbook.yml -e "gigadb_env=staging" -e "backupDate=latest"`)

A:

- direct ssh to bastion: `ssh -i ~/.ssh/aws-gigadb-eu-central-1-luis.pem ec2-user@3.75.156.38`
- run `databaseReset`

Q: `up.sh` command fails

A: Try:

- delete composer.lock and try up.sh again
- `docker-compose down -v --remove-orphans`