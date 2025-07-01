# Title length warning in admin pages

Issue URL: https://github.com/gigascience/gigadb-website/issues/1028

Labels: backlog:Story, asa:Curator, freelance, frontend
State: open
Created by @rija on 2022-04-22

---

## User story

>As a curator
>I want to be warned when the dataset I am curating has a title that is too long
>so that we can encourage authors to be more succinct

## Acceptance criteria

>Given I am creating a new dataset in the admin pages
>When I enter the dataset title into the relevant field
>and that title reaches 100 char in length
>Then a warning notice appears suggesting that the title is too long
>"Warning: Your title is over 100 characters long, you should reduce it if possible."

>Given I am updating a pre-publication dataset in the admin pages
>When I enter the dataset title into the relevant field
>and that title reaches 100 char in length
>Then a warning notice appears suggesting that the title is too long
>"Warning: Your title is over 100 characters long, you should reduce it if possible."

## Additional Info

This is the curator side of story #112

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