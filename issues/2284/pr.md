# Pull request for issue: #2284

This is a pull request for the following functionalities:

* Creates a new CI/CD job to check for missing GitLab project variables.
* The job parses `docs/variables.md` to get a list of required variables.
* It then compares this list with the environment variables available in the CI job.
* If any variables are missing, the job fails and outputs the names of the missing variables.
* A local script version is also provided to compare `docs/variables.md` against a local `.env` file or GitLab API (if `GITLAB_API_TOKEN` is set).

## How to test?

1.  **CI Job:**
    *   Push a commit to a feature branch.
    *   Go to the GitLab pipeline for that commit.
    *   Observe the `check-project-variables` job in the `conformance-and-security` stage.
    *   To test failure: temporarily remove a required variable from `docs/variables.md` (or from the project/group CI/CD settings if you have access) and push again. The job should fail and list the missing variable.
    *   To test success: ensure all variables listed in `docs/variables.md` for the relevant environment (e.g., `dev`, `staging`, `prod`) are defined in the GitLab project/group CI/CD settings. The job should pass.

2.  **Local Script (`ops/scripts/check_variables_local.sh`):**
    *   Ensure you have a `.env` file in the project root with your local variables.
    *   Run `./ops/scripts/check_variables_local.sh`. It will compare `docs/variables.md` (for the `dev` environment by default) against your `.env` file.
    *   To test with GitLab API: `export GITLAB_API_TOKEN="your_token"` and then run `./ops/scripts/check_variables_local.sh gitlab`. This will compare against variables in your GitLab project.
    *   The script will output any missing variables and exit with an error code if any are found.

## How have functionalities been implemented?

*   **`ops/scripts/check_variables_ci.sh`**:
    *   This Bash script is designed to run in the GitLab CI environment.
    *   It determines the current environment (e.g., `dev`, `staging`, `prod`) using the `CI_ENVIRONMENT_NAME` variable or defaults to `dev`.
    *   It defines a function `parse_required_variables` that uses `awk` to extract all variable names from `docs/variables.md` (e.g., `awk '/^\| [A-Za-z0-9_]+[ ]*\|/ { gsub(/^\| /, \"\"); gsub(/ .*/, \"\"); print $1 }' "$VARIABLES_MD_PATH" | grep -v '^Variable$'`).
    *   It iterates through the required variable names and checks if each is set (and non-empty) as an environment variable.
    *   If any variables are missing, it prints their names and exits with code 1.
*   **`ops/scripts/check_variables_local.sh`**:
    *   This Bash script is for local use and requires `jq` to be installed.
    *   It checks for `GITLAB_PRIVATE_TOKEN` and `GITLAB_PROJECT_ID` environment variables.
    *   It determines the environment based on `-e` or `--env` arguments, `GIGADB_ENV`, or defaults to `dev`.
    *   It defines a function `parse_required_variables` that uses a more specific `awk` script to extract variable names from `docs/variables.md` under a "## PROJECT: *-gigadb-website" heading.
    *   It fetches project variables from the GitLab API using `curl` and `jq`, filtering by `environment_scope`.
    *   It compares the required variables with those from the API and outputs missing variables, exiting with an error code if any are found.
*   **`.gitlab-ci.yml` & `ops/pipelines/gigadb-conformance-security-jobs.yml`**:
    *   A new job `check-project-variables` is added to the `conformance-and-security` stage in `ops/pipelines/gigadb-conformance-security-jobs.yml`.
    *   This job executes `ops/scripts/check_variables_ci.sh`.

## Any issues with implementation?

*   The `parse_required_variables` function in `ops/scripts/check_variables_ci.sh` and `ops/scripts/check_variables_local.sh` relies on specific formats in `docs/variables.md`. Significant changes to this format might require updates to the parsing logic in both scripts.
*   The local script (`ops/scripts/check_variables_local.sh`) requires `jq` to be installed and `GITLAB_PRIVATE_TOKEN` / `GITLAB_PROJECT_ID` to be set for API access.
*   The CI script (`ops/scripts/check_variables_ci.sh`) determines the path to `docs/variables.md` assuming it is run from the project root.

## Any changes to automated tests?

*   No new automated tests (e.g., PHPUnit, Codeception) were added as this is a CI/CD operational script.
*   Manual testing procedures are outlined above.

## Any changes to documentation?

*   `docs/SETUP_CI_CD_PIPELINE.md` will need to be updated to describe the new `check-project-variables` CI job, its purpose, and how it helps ensure all required GitLab project variables are correctly set.

## Any technical debt repayment?

*   N/A

## Any improvements to CI/CD pipeline?

*   Yes, this entire PR is an improvement to the CI/CD pipeline.
*   It adds a new conformance check to ensure that all documented required project-level variables are present in the CI/CD environment, preventing potential runtime errors or misconfigurations due to missing variables.
