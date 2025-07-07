# Issue #2331: adjust the curation log view for a better user experience

Original GitHub issue URL: https://github.com/gigascience/gigadb-website/issues/2331

## User story

> As a curator
> I want the curator comments to be more compact
> So that I dont have to scroll so much to read them

## Acceptance criteria

> Given I am on a dataset admin page, e.g. <https://staging.gigadb.org/adminDataset/update/id/2964>
> When I look at the curation history log at the bottom of the page
> Then the table is more compact showing only the comments and date, with the other details shown on hover-over (see screenshot/wireframe)

## Additional Info

The dark grey patch is the hover-over details of the "Status changed to private" comment.

Image

Notice:
1 - The "Action" is concatenated to the start of the "comment" field
2 - The "Created by", "Modified by" and "Modified date" fields are all moved to be visible on hover-over instead of in columns.
3 - The minimal gaps between row lines and text, we want to maximise content with less concern for aestetics on this page (i.e. its not public its only curators that see it)

## Product Backlog Item Ready Checklist

* Business value is clearly articulated
* Item is understood enough by the IT team so it can make an informed decision as to whether it can complete this item
* Dependencies are identified and no external dependencies would block this item from being completed
* At the time of the scheduled sprint, the IT team has the appropriate composition to complete this item
* This item is estimated and small enough to comfortably be completed in one sprint
* Acceptance criteria are clear and testable
* Performance criteria, if any, are defined and testable
* The Scrum team understands how to demonstrate this item at the sprint review

## Product Backlog Item Done Checklist

* Item(s) in increment pass all Acceptance Criteria
* Code is refactored to best practices and coding standards
* Documentation is updated as needed
* Data security has not been compromised (with particular reference to the personal information we hold in GigaDB)
* No deviation from the team technology stack and software architecture has been introduced
* The product is in a releasable state (i.e. the increment has not broken anything)