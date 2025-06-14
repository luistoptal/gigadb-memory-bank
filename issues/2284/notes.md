- question: If we run the script locally, obviously we need to use the gitlab API and an access token to get the variables. But if the script is run from the CI/CD pipeline, don't we have intrinsic access to the environment variables already, and thus we do not need to fetch them using the API and instead we simply check for their presence and whether they have a value?

I am thinking we should have two separate scripts: one to run locally and one for the CI/CD pipeline.

The local script should:
- fetch the variables from the GitLab API
- check if the variables are present and have a value
- print the missing variables

The CI/CD pipeline script should:
- check if the variables are present and have a value
- print the missing variables