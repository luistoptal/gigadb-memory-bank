Switch on search engine indexing directive based on environments #2190
Closed
Closed
Switch on search engine indexing directive based on environments
#2190
@rija
Description
rija
opened on Feb 10 · edited by rija
User story
As a third party system
I want to find GigaDB content through search engines
So that I can conveniently find GigaDB content relevant to my needs

Acceptance criteria
Given I am navigating live website
When I go to "/robots.txt"
Then I can see that search engines are allowed to crawl our website

Given I am navigating non-live website
When I go to "/robots.txt"
Then I can see that search engines are not allowed to crawl our website

Given I am navigating live website
When I go to page source's header
Then I can see in the meta-tags that search engines are allowed to crawl our website

Given I am navigating non-live website
When I go to page source's header
Then I can see in the meta-tags that search engines are not allowed to crawl our website

Additional Info
For robots.txt, ensure that there environment specific directory in `ops/configuration/gigadb-public'
Ensure we copy the environment specific public files into the Dockerfile on production
for the meta-tag, wrap the metal into a PHP if/else that test the value of GIGADB_ENV variable
eg:

if (in_array($_SERVER['GIGADB_ENV'], ["dev","CI"])
from UserController.

or try using Yii to get environment

also add a smoke test to check the value for a specific environment and make a job to run just after deployment job
Product Backlog Item Ready Checklist

Business value is clearly articulated

Item is understood enough by the IT team so it can make an informed decision as to whether it can complete this item

Dependencies are identified and no external dependencies would block this item from being completed

At the time of the scheduled sprint, the IT team has the appropriate composition to complete this item

This item is estimated and small enough to comfortably be completed in one sprint

Acceptance criteria are clear and testable

Performance criteria, if any, are defined and testable

The Scrum team understands how to demonstrate this item at the sprint review
Product Backlog Item Done Checklist

Item(s) in increment pass all Acceptance Criteria

Code is refactored to best practices and coding standards

Documentation is updated as needed

Data security has not been compromised (with particular reference to the personal information we hold in GigaDB)

No deviation from the team technology stack and software architecture has been introduced

The product is in a releasable state (i.e. the increment has not broken anything)
Activity

rija
added
asa:ThirdPartySystem

backlog:Story
 on Feb 10

rija
added this to  Backlog: GigaDB Databaseon Feb 10

rija
changed the title [-]Switching indexing directive based on environments[/-] [+]Switching search engine indexing directive based on environments[/+] on Feb 10

rija
mentioned this on Feb 10
improve SEO to enable GigaDB datasets to be found by google/bing/beidu searches #514

rija
moved this to To Estimate in  Backlog: GigaDB Databaseon Feb 10

rija
changed the title [-]Switching search engine indexing directive based on environments[/-] [+]Switch on search engine indexing directive based on environments[/+] on Feb 10

rija
mentioned this on Feb 24
[S569] Verify and update SEO settings for AWS deployed web site #744

only1chunts
added this to  Portfolio Backlogon Feb 24

only1chunts
moved this to Search Engine Optimisation in  Portfolio Backlogon Feb 24

rija
added
backlog:Size=5
 on Feb 25

rija
moved this from To Estimate to Ready in  Backlog: GigaDB Databaseon Feb 25

rija
added this to the B.2.Search Engine Optimisation milestone on Feb 25
kencho51
kencho51 commented on Feb 26
kencho51
on Feb 26
Member
meta tag implementation in #513


kencho51
mentioned this on Mar 4
Create meta tags based on envs #2227
kencho51
kencho51 commented on Mar 6
kencho51
on Mar 6
Member
Hi @rija, @only1chunts

Regarding the robots.txt, which content should be allowed/disallowed for the live one?
Can take a look at the example: https://www.nature.com/robots.txt and https://www.google.com/robots.txt

only1chunts
only1chunts commented on Mar 6
only1chunts
on Mar 6
Member
i dont understand what those example files mean, but for us we want the robots to be allowed to index the home page and all the static pages like about us, guides, faqs etc..
We also want them to index the contents of the main dataset pages; e.g. https://gigadb.org/dataset/100987
Ideally they should be able to index all the sample metadata, and all the file metadata, but I dont know how to tell them to do that.
What we dont want them to do is get stuck in infinite loops of looking at the same dataset with different pages of files listed!

NB Currently we still have at least 2 differnt URLs that point to the same thing? So I guess one of those should be dis-allowed? e.g.
https://gigadb.org/dataset/100987 & https://gigadb.org/dataset/view/id/100987 show the same page.

We should create a new ticket to remove the view/id/ version of things as that seems to be redundant (unless its required for the submission wizard or something?)

rija
rija commented on Mar 6
rija
on Mar 6
Member
Author
Hi @kencho51

as discussed, the only things that should be off-limit to search engines are:

The admin area
The API
@only1chunts it doesn't matter that pages have multiple URLs, as long as the page has a meta-tag indicating which URL is canonical (which we are doing). The search engines will use that URL only and adjust their indexing accordingly.


kencho51
mentioned this on Mar 14
Create robots txt based on env #2238
only1chunts
only1chunts commented 4 days ago
only1chunts
4 days ago
Member
@kencho51 as this appears to be being worked on now, should this ticket be in the current sprint backlog board somewhere?


kencho51
added this to  Current sprint board3 days ago

kencho51
moved this to Tasks To Do in  Current sprint board3 days ago
kencho51
kencho51 commented 3 days ago
kencho51
3 days ago
Member
@only1chunts It should be considered as done, there are PR #2227 and #2238 for this ticket, so closing