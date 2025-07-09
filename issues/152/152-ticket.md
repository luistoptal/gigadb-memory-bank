# Issue 152 - create a simplified dataset view

Original issue URL: https://github.com/gigascience/gigadb-website/issues/152

## Description

@only1chunts

## User story
As a website user
I want to see a simplified version of a dataset page
So that I can print it or focus on the content

## Acceptance criteria
Given I am on a dataset page
When I click the "Simplified view" button
Then only the following page elements are displayed

| element |
| --- |
| DOI|
| Release Date |
| Title |
| Citation information |
| Data types |
| Keywords |
| Dataset summary |
| Links (all types) |
| Related manuscripts |
| Resource accessions |
| Funding information |
| Samples information (basic data table: sample id, species id)|
| Files information (basic data table: file name, file location, file description, file type, file format, file size, release date, file attributes) |
| Licence |

## Additional info

TODO: add scenario for the detailed content of simplified sample table

The Read me has almost all the information above (doesn't links and tables).
When implementing share the source between representation.

This maybe a task within #31?

There has been interest in a simplified view of dataset information. I have prepared an example HTML version of how that could look, but github wont let me attach it, it says that file format is not supported?!
find it here instead. and I pasted the html code into a GigaDB page to get the preview in this jpeg:
simplified_view_screenshot

The simplified view of each dataset should be on the URL <http://gigadb.org/dataset/100397.rtf>
and there will need to be a link from each dataset page to it:
simplified_view_button_screenshot

---

Metadata:

Labels: asa:WebsiteUser, backlog:Story, enhancement-public view, freelance, frontend
Milestone: L. Increase FAIRness

## Comments

**June 12, 2018 – @ScottBGI**
> This might be useful for the GigaDB widget (iframes version) we want to implement.

---

**Feb 26, 2025 – @luistoptal**
> I think before working on this it would be a good idea to have the PR for responsive layout merged: https://github.com/gigascience/gigadb-website/pull/2217

---

**Jun 14, 2025 – @luistoptal**
> @only1chunts if a dataset contains many samples and files (100s of entries), should they all be displayed in the simplified view? Would it be better to entirely omit the table to avoid overly long pages? I guess there could be pagination, but if the main purpose of the page is to be printed, then I see no point.
>
> Options that come to mind:
> A) show full table (potentially very long)
> B) show only first N rows and a link to the full page "see full table"
> C) entirely omit table from simplified view
>
> A different question about this requirement:
>
> > simplified view of each dataset should be on the URL http://gigadb.org/dataset/100397.rtf
>
> Is this a hard requirement? It would be technically simpler to have a normal URL like `/dataset/simplified/xxxxxx` or `/dataset/print/xxxxxx`, etc.

---

**Jun 16, 2025 – @only1chunts**
> @luistoptal thanks for the queries, last one first
>
> > is this a hard requirement? it would be technically simpler to have a normal url like /dataset/simplified/xxxxxx or /dataset/print/xxxxxx, etc
>
> No, it's not a hard requirement; I was just assuming the print view would be created and saved to the server for display, but actually it can be implemented in whatever way you and the dev team think appropriate. Note: creating the view as a file saved on the server would remove the issue with lots of files as it will be generated in the background and saved prior to a user wanting to view, then the view button is just opening a file hosted on our server. But there are drawbacks to this method too, namely the need to update it every time any change is made to anything in the dataset.
>
> > if a dataset contains many samples and files (100s of entries)
>
> I prefer option B, show only first N rows and a link to the full page "see full table", where I think N should be 100. Is it possible to have a way to show a few extra if there are say only 109 files? If there are >110 files then only show 100 in simplified view. It would be useful if the text saying click here to retrieve full table includes the total number of items that would be retrieved.

---

**Jul 9, 2025 – @luistoptal**
> @rija @only1chunts
>
> We have discussed this ticket briefly in VOH and we concluded the easiest solution would involve adding a "print view" button that toggles the CSS styles of the dataset page; it does not involve creating a new page and it reuses the existing HTML, so it should be relatively easy to accomplish in comparison to all other options, and also easier to maintain long term.
>
> I see it working like this (in case you are curious about the details):
> - add a button to the top of the dataset page content "print view"
> - button click changes the URL to have a URL query param `?print=true`
> - if `print=true`, a `print` CSS class is added to the `body` tag
> - `print` class hides header and footer from layout
> - `print` class also applies a different set of styles to the entire dataset page that are optimized for printing
> - print view shows a button "web view" that reverts all the above