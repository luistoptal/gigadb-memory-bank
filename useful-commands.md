
```sh
# Sync develop with upstream
git fetch upstream && git checkout develop && git merge upstream/develop && git push origin develop

# Expose local dev
ngrok http 80 --host-header="gigadb.gigasciencejournal.com" --url=live-mildly-cockatoo.ngrok-free.app

# watch and rebuild less files
env "PATH=$PATH" chokidar "less/**/*.less" -c "docker-compose run --rm less"
```
