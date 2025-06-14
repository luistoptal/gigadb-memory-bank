# Outline: Pipeline Job to Check Required GitLab Project Variables

1. **Script Creation**
   - Create a Bash script (e.g., `ops/scripts/check_project_variables.sh`).
   - Script responsibilities:
     - Parse `docs/variables.md` to extract the list of required project-level variables.
     - Use the GitLab API to fetch all project-level variables for the current project.
     - Compare the documented variables with those present in the project.
     - Output a clear error message listing any missing variables and exit non-zero if any are missing.

2. **Secret Handling**
   - Ensure the script never outputs masked variable values—only names
   - If the variable is not masked, then it is okay to output the value along with the name.
   - Handle both masked (secret) and visible variables.

3. **Pipeline Integration**
   - Add a new job to `.gitlab-ci.yml` under the "conformance and security" stage.
   - Configure the job to run the check script.
   - Ensure the job fails if any required variable is missing.

4. **Documentation**
   - Update `docs/SETUP_CI_CD_PIPELINE.md` to document the new check and its requirements.

5. **Testing**
   - Test the script and pipeline job on a feature branch in your fork.
   - Confirm the job passes when all variables are present and fails with a clear message when any are missing.

---

## Codebase Review: Relevant Files for Pipeline Job to Check Required GitLab Project Variables

### 1. Script Creation
- **docs/variables.md** (various lines): Documents all required GitLab variables at group and project level. The script should parse this file to extract the list of required variables.
- **ops/configuration/variables/.gitlab-env-vars.example** (lines 1-76): Example file showing the format for required variables, including environment and visibility (masked/visible).
- **ops/scripts/set_env_vars.sh** (lines 1-108): Bash script that reads variables from a file and sets them in GitLab via the API. Shows how to interact with the GitLab API for variables, including handling masked/visible status.
- **ops/scripts/generate_config.sh** (lines 39-89): Fetches variables from GitLab using the API and processes them for use in the application. Demonstrates how to retrieve project variables and parse their values.
- **ops/scripts/ansible_init.sh** (lines 42-72): Fetches and updates project variables using the GitLab API, including environment scoping.

### 2. Secret Handling
- **ops/scripts/set_env_vars.sh** (lines 73-81): Handles masked variables, ensuring values are not output for masked variables. Shows logic for distinguishing between masked and visible variables.
- **ops/scripts/generate_config.sh** (lines 39-89): Fetches variables and could be adapted to check for masked status and handle output accordingly.

### 3. Pipeline Integration
- **.gitlab-ci.yml** (lines 1-54, and includes): Main pipeline configuration. The new job should be added under the "conformance and security" stage.
- **ops/pipelines/gigadb-conformance-security-jobs.yml** (lines 1-104): Contains jobs for the "conformance and security" stage. The new job should be defined here, running the check script and failing if any required variable is missing.

### 4. Documentation
- **docs/SETUP_CI_CD_PIPELINE.md** (lines 170-184, 263-348): Documents required variables, their environments, and how to set them. Should be updated to mention the new check and its requirements.

### 5. Testing
- **ops/scripts/set_env_vars.sh** (usage section at the top): Can be used to set up test variables for pipeline testing.
- **.gitlab-ci.yml** and **ops/pipelines/gigadb-conformance-security-jobs.yml**: The job should be tested in a feature branch to ensure it passes when all variables are present and fails with a clear message when any are missing.

---

**Summary Table**

| File/Path                                         | Line(s)      | Why Relevant                                                                 |
|---------------------------------------------------|--------------|-------------------------------------------------------------------------------|
| docs/variables.md                                | various      | Source of required variable names and structure                               |
| ops/configuration/variables/.gitlab-env-vars.example | 1-76         | Example of required variables and format                                      |
| ops/scripts/set_env_vars.sh                      | 1-108        | Shows how to interact with GitLab API for variables, including masking        |
| ops/scripts/generate_config.sh                   | 39-89        | Fetches and processes project variables from GitLab API                       |
| ops/scripts/ansible_init.sh                      | 42-72        | Fetches/updates project variables, shows API usage                            |
| .gitlab-ci.yml                                   | 1-54         | Main pipeline config, add job under "conformance and security"                |
| ops/pipelines/gigadb-conformance-security-jobs.yml| 1-104        | Where to define the new check job                                             |
| docs/SETUP_CI_CD_PIPELINE.md                     | 170-184, 263-348 | Documents required variables and pipeline setup, should be updated            |