# Overview of the `cnhk-infra` GitLab Project

## What is `cnhk-infra`?

`cnhk-infra` is a GitLab project located at [https://gitlab.com/gigascience/cnhk-infra](https://gitlab.com/gigascience/cnhk-infra).

## Purpose

Based on investigations and codebase references, `cnhk-infra` appears to serve (or have served) the following purposes:

1.  **Centralized Secrets Management**: It acts as a repository for storing sensitive information and configuration variables for the GigaScience project.
2.  **CI/CD Variables**: It hosts variables crucial for Continuous Integration/Continuous Deployment (CI/CD) pipelines. Examples found in documentation include credentials for services like Uptime Robot, Cloudflare, and SSH keys (e.g., `id-rsa-aws-hk-gigadb.pem`).
3.  **Programmatic Access to Variables**: The project provides a GitLab API endpoint for scripts and tools to fetch these variables. This URL is frequently assigned to an environment variable named `MISC_VARIABLES_URL` in various scripts and configuration files (e.g., `gigadb/app/configurator/src/dotfiles.sh`, various `env.example` files, and CI job definitions). The typical API URL pattern is: `https://gitlab.com/api/v4/projects/gigascience%2Fcnhk-infra/variables`.
4.  **Specific Variable Prefixes**: The `dotfiles.sh` script, in particular, attempts to retrieve variables from `cnhk-infra` that are scoped for the current environment (e.g., `staging`, `live`, or `*` for all environments) and have keys (names) starting with:
    *   `sftp_`
    *   `MATRIX_`
    *   `gigadb_datasetfiles_`

## Team Lead Input

According to the team lead:

> "Normally, there should not be any automated `curl` going to the `cnhk-infra` project as that's mostly as password manager for developers and for legacy infrastructure."

This suggests that:
*   Automated access by CI/CD pipelines might be deprecated or unintended for newer setups/forks.
*   Its primary current role might be for manual access by developers or for supporting older parts of the infrastructure.

## Current Status & Observed Issues (as of October 7, 2024)

*   **Accessibility**: Attempts to access the `cnhk-infra` repository URL directly ([https://gitlab.com/gigascience/cnhk-infra](https://gitlab.com/gigascience/cnhk-infra)) have resulted in a 404 (Not Found) error, even for users with presumed admin rights to the parent GitLab group. This indicates the project might be archived, private with very restricted access, or its URL/path has changed.
*   **Pipeline Failures**: CI/CD pipelines, particularly in forked repositories, have been observed to fail. For example, the `FilesUrlsUpdaterBuildStaging` job fails when the `gigadb/app/configurator/src/dotfiles.sh` script attempts to `curl` variables from `MISC_VARIABLES_URL` (pointing to `cnhk-infra`). The failure occurs because the `curl` command receives a 404 page (an HTML string) instead of the expected JSON, causing the subsequent `jq` command to error out with `Cannot index string with string "environment_scope"`.

## Implications

*   The inaccessibility of `cnhk-infra` can break CI/CD pipelines that rely on it for configuration variables.
*   If `cnhk-infra` is indeed legacy or access is intentionally restricted, scripts and CI configurations that reference `MISC_VARIABLES_URL` (pointing to `cnhk-infra`) need to be updated.
*   Necessary variables for CI/CD processes should ideally be transitioned to more accessible and maintainable locations, such as GitLab group-level or project-level CI/CD variables, especially for forked repository workflows.

This document should serve as a starting point for anyone encountering `cnhk-infra` references in the codebase or CI/CD pipelines.