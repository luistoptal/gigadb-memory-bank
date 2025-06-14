# Pipeline job that check that documented variables exists and have value in the current Gitlab project

**Issue #2284** ([view on GitHub](https://github.com/gigascience/gigadb-website/issues/2284))

**Author:** [rija](https://github.com/rija)
**Assignee:** [luistoptal](https://github.com/luistoptal)
**Labels:** backlog:Story, asa:Developer, infrastructure
**Milestone:** [A.2. backup related](https://github.com/gigascience/gigadb-website/milestone/28)

---

## User story

>As a developer
>I want to be notified if I don't have all the necessary variables setup in my fork projects
>So that I can add missing ones to avoid hard to debug pipeline issues

## Acceptance criteria

>Given  variable X is describe in `docs/variables.md`
>And variable X exists and has a value in my fork project on Gitlab
>When I run a pipeline
>Then the job "CheckVariables" of the "conformance and security" stage passes

>Given  variable X is describe in `docs/variables.md`
>And variable X does not exists nor has value in my fork project on Gitlab
>When I run a pipeline
>Then the job "CheckVariables" of the "conformance and security" stage fails

## Additional Info


## Product Backlog Item Ready Checklist

* [ ] Business value is clearly articulated
* [ ] Item is understood enough by the IT team so it can make an informed decision as to whether it can complete this item
* [ ] Dependencies are identified and no external dependencies would block this item from being completed
* [ ] At the time of the scheduled sprint, the IT team has the appropriate composition to complete this item
* [ ] This item is estimated and small enough to comfortably be completed in one sprint
* [ ] Acceptance criteria are clear and testable
* [ ] Performance criteria, if any, are defined and testable
* [ ] The Scrum team understands how to demonstrate this item at the sprint review

## Product Backlog Item Done Checklist

* [ ] Item(s) in increment pass all Acceptance Criteria
* [ ] Code is refactored to best practices and coding standards
* [ ] Documentation is updated as needed
* [ ] Data security has not been compromised (with particular reference to the personal information we hold in GigaDB)
* [ ] No deviation from the team technology stack and software architecture has been introduced
* [ ] The product is in a releasable state (i.e. the increment has not broken anything)