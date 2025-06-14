# 152 - create a simplified dataset view

Original issue: https://github.com/gigascience/gigadb-website/issues/152

## User story

>As a website user
>I want to see a simplified version of a dataset page
>So that I can print it or focus on the content

## Acceptance criteria

>Given I am on a dataset page
>When I click the "Simplified view" button
>Then only the following page element are displayed

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
| Samples information (basic data table:sample id, species id)|
| Files information (basic data table: file name, file location, file description, file type, file format, file size, release date, file attributes) |
| Licence |

## Additional info

TODO: add scenario for the detailed content of simplified sample table

The Read me has almost all the information above (doesn't links and tables).
When implementing share the source between representation.

This maybe a task within #31?

There has been interest in a simplified view of dataset information. I have prepared an example HTML version of how that could look, but github wont let me attach it, it says that file format is not supported?!
find it [here](https://drive.google.com/file/d/174Y8A-Ydr_6Plv730dJCmudZxKueWCmi/view?usp=sharing) instead. and I pasted the html code into a GigaDB page to get the preview in this jpeg:
![simplified_view_screenshot](https://user-images.githubusercontent.com/6037145/34887948-3e9136c6-f7c0-11e7-9489-4bb6d9154991.jpg)

The simplified view of each dataset should be on the URL http://gigadb.org/dataset/100397.rtf
and there will need to be a link from each dataset page to it:
![simplified_view_button_screenshot](https://user-images.githubusercontent.com/6037145/34888286-97209290-f7c1-11e7-83be-dc687ed90f05.jpg)