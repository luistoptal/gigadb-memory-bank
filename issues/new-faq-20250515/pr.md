# Pull request for issue: #490 #486 #483 #477 #475

This is a pull request for the following functionalities:

* Update the FAQ page text content to improve clarity, accuracy, and reflect current processes and organizational structure.
* Remove outdated instructions and panels, and add new sections about data curation and data support services.
* Update references to organizations and clarify the relationship between GigaScience Press, GigaDB, and BGI Group.
* Improve explanations of the data submission and curation process.
* Refine sustainability and cost coverage explanations for GigaDB.

## How to test?

1. Navigate to the FAQ page (`/site/faq`) in the application.
2. Review the following FAQ entries for the changes described below.
3. Ensure all links and references are correct and functional.
4. Confirm that the FAQ page renders without errors and the accordion panels work as expected.

## Which FAQ entries have been changed?

**Modified:**
- **"How do I submit data to GigaDB?"**
  - The instructions have been rewritten to focus on contacting editorial, curation team involvement, and the use of the online wizard. The previous details about the spreadsheet submission option have been removed.
- **"What's the relationship between GigaScience and GigaDB?"**
  - Now updated to: **"What's the relationship between GigaScience Press and GigaDB?"**
  - The content has been revised to clarify the relationship between GigaScience Press, GigaDB, and BGI Group, and to mention both GigaScience and GigaByte journals.
- **"How will GigaDB be sustained in the future?"**
  - The explanation of sustainability and cost coverage has been updated for clarity.

**Removed:**
- **"How do I download a large dataset with my slow internet connection?"**
  - This panel has been removed from the FAQ.

**Added:**
- **"What is involved in data curation?"**
  - New panel describing the actions, checks, and enhancements performed by GigaDB biocurators during the curation process.
- **"Who can use GigaDB's data support services?"**
  - New panel explaining the scope of GigaDB and eligibility for data support services.

## How have functionalities been implemented?

- The FAQ page view (`protected/views/site/faq.php`) was updated to:
  - Revise and condense the data submission instructions.
  - Remove the panel about downloading large datasets with slow internet connections.
  - Update the panel describing the relationship between GigaScience and GigaDB.
  - Update the sustainability panel.
  - Add new panels for data curation and data support services.
- The `CHANGELOG.md` was updated to document these changes.

## Any issues with implementation? [optional]

No major issues encountered. All changes are content updates and do not affect application logic or structure.

## Any changes to automated tests? [optional]

No changes to automated tests were necessary, as this update only affects static content.

## Any changes to documentation? [optional]

No separate documentation changes required, as the FAQ page itself serves as user-facing documentation for these processes.

## Any technical debt repayment? [optional]

Removed outdated and potentially confusing instructions and panels, improving maintainability and clarity of the FAQ content.

## Any improvements to CI/CD pipeline? [optional]

No changes to the CI/CD pipeline were made in this PR.
