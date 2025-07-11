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

# Run tests
./tests/unit_functional_runner
./tests/unit_runner
./tests/functional_runner
./tests/acceptance_runner

# Run specific files / tests
docker-compose run --rm codecept run --no-redirect acceptance tests/acceptance/AdminDataset.feature:basic\ search -vv
docker-compose run --rm codecept run --no-redirect acceptance tests/acceptance/AdminDataset.feature -vv
# Run acceptance tests based on branch name. Branch name must contain issue number xxxx and tests must be tagged like @issue-xxxx
docker-compose run --rm codecept run --no-redirect -g issue-$(git rev-parse --abbrev-ref HEAD | grep -oE '[0-9]+' | head -n 1) acceptance -vv
# Run Behat tests
docker-compose run --rm test ./vendor/behat/behat/bin/behat --profile local --stop-on-failure features/dataset-admin.feature
docker-compose run --rm test ./vendor/behat/behat/bin/behat --profile no-secrets -v --stop-on-failure --tags this
# Run specific unit test
docker-compose run --rm test ./vendor/phpunit/phpunit/phpunit --testsuite unit --bootstrap protected/tests/unit_bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/unit/DatasetDAOTest.php

# Lint file with PHP
./vendor/squizlabs/php_codesniffer/bin/phpcbf --standard=PSR12 path/to/file.php

# Destroy staging
cd ops/infrastructure/envs/staging
AWS_PROFILE=gigadb terraform destroy
