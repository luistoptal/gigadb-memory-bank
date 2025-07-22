# Cheatsheet

## Access dockerized local DB

- Make sure containerized app is running locally
- Open DBeaver
- Enter credentials:
  - **Host**: `localhost`
  - **Port**: `54321`
  - **Database**: `gigadb`
  - **Username**: `gigadb`
  - **Password**: `vagrant`

## Log things in PHP

- add this to the code `<?php error_log($thing_to_log); ?>`
- Open https://localhost:9443/#!/2/docker/containers
- Click on container (probably https://localhost:9443/#!/2/docker/containers/f1cfa39466ccb407764efb3920f924c85bfd944580284ae62ed4dea03cd3301e -- portainer)
- Click on logs

# Debug on android phone

- Expose local dev:

```sh
ngrok http 80 --host-header="gigadb.gigasciencejournal.com" --url=live-mildly-cockatoo.ngrok-free.app
```

- Enable developer options on the phone: Settings > About Device > Version > Tap "build number" 8 times
- Enable USB debugging from Additional Settings > Developer Options
- Connect the android phone to the desktop via USB
- In Chrome, open this: chrome://inspect/#devices
- Accept USB debugging permissions on android
- Open the URL exposed by ngrok in android

# Manage PR backlog

https://github.com/orgs/gigascience/projects/90

- when PR is ready for review, move it to "Ready for Review" column
- after handling changes required, move PR to "reviewing required" column and add comment to PR

# Review PR

- Make sure their branch is added as remote, i.e. `git remote -v`
  - if it isn't, add it: `git remote add [name] [url]`, e.g. `git remote add kencho51 https://github.com/kencho51/gigadb-website.git`
- fetch their fork: `git fetch kencho51`
- checkout to their branch via command, or use the IDE UI to checkout to their branch
```sh
git checkout -b <local_branch_name> <remote_name>/<remote_branch_name>
```
- if need to deploy to my staging, create and push a tag, e.g.:
```sh
git tag -a <local_branch_name>-v1.0.0 -m "[TAG_LABEL]"
git push [YOUR_GITLAB_REPO_LABEL] <local_branch_name>-v1.0.0
```