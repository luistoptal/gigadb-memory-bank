```sh
# Sync develop with upstream
git fetch upstream && git checkout develop && git merge upstream/develop && git push origin develop

# Expose local dev
ngrok http 80 --host-header="gigadb.gigasciencejournal.com" --url=live-mildly-cockatoo.ngrok-free.app

# watch and rebuild less files
env "PATH=$PATH" chokidar "less/**/*.less" -c "docker-compose run --rm less"

# Delete all PHP migration data files
find protected/migrations/data -type f -name '*.php' -delete

# provision terraform
cd ops/infrastructure/envs/staging/
../../../scripts/tf_init.sh --project gigascience/forks/luis-gigadb-website --env staging --region eu-central-1 --ssh-key ~/.ssh/aws-gigadb-eu-central-1-luis.pem --web-ec2-type t3.small --bastion-ec2-type t3.small
# GITLAB_USERNAME=luis.martinez8251635

# Run acceptance tests based on branch name. Branch name must contain issue number xxxx and tests must be tagged like @issue-xxxx
docker-compose run --rm codecept run --no-redirect -g issue-$(git rev-parse --abbrev-ref HEAD | grep -oE '[0-9]+' | head -n 1) acceptance -vv
