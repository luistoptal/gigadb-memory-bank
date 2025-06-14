### Pipeline Job to Check Required GitLab Project Variables

- [x] **Create `check_variables.sh` script skeleton**
      Initialize `ops/scripts/check_variables.sh` with shebang, basic comments, and ensure it's executable.
- [x] **Implement parsing of required variable names from `docs/variables.md`**
      Add logic to `check_variables.sh` to read `docs/variables.md` and extract the list of required project-level variable names.
Done: Added a function to check_variables.sh that parses required variable names from docs/variables.md using awk.
- [x] **Implement fetching of existing project variables via GitLab API**
      Add function in `check_variables.sh` to call the GitLab API endpoint `/projects/${CI_PROJECT_ID}/variables` using `curl` and `GITLAB_API_TOKEN` to retrieve current project variables.
Done: Added a function to check_variables.sh that fetches project variables from the GitLab API using curl and GITLAB_API_TOKEN.
- [x] **Implement comparison logic for variables**
      Add logic to `check_variables.sh` to compare the list of required variable names (from `docs/variables.md`) with the variable names fetched from the GitLab API.
Done: Added comparison logic to check_variables.sh to detect missing required variables by comparing docs/variables.md and GitLab API results.
- [x] **Implement error reporting and non-zero exit status for missing variables**
      Modify `check_variables.sh` to print a clear error message listing any missing required variables and exit with a non-zero status if mismatches are found.
Done: Script now prints missing variables and exits with non-zero status if any are missing.
- [x] **Refine script for secret handling (masked variables)**
      Update `check_variables.sh` to correctly identify masked variables based on the API response and ensure their values are never printed, only their names.
- [x] add a check to ensure that `jq` is installed. If it isn't fail the script with a meaningful message
Done: Added a check at the start of check_variables.sh to ensure jq is installed, failing with a clear error if not.
- [x] **Add new CI job to `ops/pipelines/gigadb-conformance-security-jobs.yml`**
      Define a new job within the "conformance and security" stage in `ops/pipelines/gigadb-conformance-security-jobs.yml` that executes `ops/scripts/check_variables.sh`.
- [ ] Write or update tests
      Manually test the script locally with various scenarios (all variables present, some missing) and verify the CI job passes/fails correctly on a feature branch.
- [ ] **Update documentation in `docs/SETUP_CI_CD_PIPELINE.md`**
      Add a section to `docs/SETUP_CI_CD_PIPELINE.md` describing the new CI job, its purpose, and how it helps ensure all required GitLab project variables are set.

### Adapt `check_variables_ci.sh` for CI/CD Environment

- [x] **Remove sourcing of `.env` and `.secrets` from `check_variables_ci.sh`**
      CI/CD provides all variables as environment variables; sourcing is unnecessary.
- [x] **Remove GitLab API and `jq` logic from `check_variables_ci.sh`**
      The script should not fetch variables from the API or require `jq` in CI.
- [x] **Update logic to check required variables against environment**
      For each required variable parsed from `docs/variables.md`, check if it is set in the environment.
- [ ] **Make path to `variables.md` robust**
      Ensure the script can find `docs/variables.md` regardless of the working directory in CI.
- [x] **Remove argument parsing; use only `$GIGADB_ENV` to determine environment**
      The script should not accept arguments; it should use the environment variable or default to 'dev'.
- [ ] **Print missing variables and exit with error if any are missing**
      If any required variables are missing, print them and exit with code 1 to fail the CI job.
- [ ] Write or update tests
      Test the script in CI with scenarios where variables are present and missing, and verify correct job behavior.