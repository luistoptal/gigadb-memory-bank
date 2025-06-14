# FAQ Updates Implementation Plan

## User story description
This plan outlines the steps to update the Frequently Asked Questions (FAQ) page of the GigaDB website. This includes adding new FAQs, modifying existing content related to data curation and GigaDB's relationship with GigaScience Press and BGI, removing an obsolete FAQ, and ensuring consistency in terminology across related site pages.

## User story completion requirements
- All new FAQs as specified in the outline must be added to `protected/views/site/faq.php`.
- All specified existing FAQs in `protected/views/site/faq.php` must be updated with the new content.
- The specified obsolete FAQ must be removed from `protected/views/site/faq.php`.
- Mentions of CNGB in `protected/views/site/faq.php`, `protected/views/site/guide.php`, and `protected/views/site/term.php` must be consistent with the new information.
- The FAQ page must render correctly and all interactive elements (expand/collapse) must function as expected.
- Acceptance tests should be written to cover the FAQ changes.

## Tasks
- [x] **Task 1: Add New FAQ - "What is involved in data curation?"**
    - How to implement it step by step:
        - [x] Identify the HTML structure for an FAQ item in `protected/views/site/faq.php` (typically a `div.panel.panel-default` containing a `panel-heading` and `panel-collapse`).
        - [ ] Determine the next available unique IDs for the heading (e.g., `headingXX`) and panel body (e.g., `panelXX`), ensuring `aria-controls` and `data-target` attributes match.
        - [ ] Create a new FAQ panel with the question: "What is involved in data curation?"
        - [ ] Add the detailed answer as provided in the outline to the panel body.
        - [ ] Insert this new FAQ panel into an appropriate position within the `div#accordion` in `protected/views/site/faq.php`. This might involve updating/replacing the content of the existing "What curation do you carry out?" FAQ (around lines 561-581 in the outline). The new content from the outline for "What is involved in data curation?" should be used here.
    - **What was done:**
        - Identified the HTML structure for an FAQ item in `protected/views/site/faq.php` as a `div.panel.panel-default` containing a `panel-heading` and a `panel-collapse` section.

- [ ] **Task 2: Add New FAQ - "Who can use GigaDB's data support services?"**
    - How to implement it step by step:
        - [ ] Determine the next available unique IDs for the heading and panel body.
        - [ ] Create a new FAQ panel with the question: "Who can use GigaDB's data support services?"
        - [ ] Add the answer as provided in the outline to the panel body.
        - [ ] Insert this new FAQ panel into an appropriate position within the `div#accordion` in `protected/views/site/faq.php`.
    - How to test:
        - [ ] Manually navigate to the FAQ page.
        - [ ] Verify the new FAQ "Who can use GigaDB's data support services?" is present.
        - [ ] Verify the question and answer match the outline.
        - [ ] Verify the expand/collapse functionality works.

- [ ] **Task 3: Update FAQs regarding CNGB relationship**
    - **a. Update FAQ: "What's the relationship between GigaScience Press and GigaDB?"**
        - How to implement it step by step:
            - [ ] Locate the existing FAQ "What's the relationship between GigaScience and GigaDB?" (around line 40x in the outline) in `protected/views/site/faq.php`.
            - [ ] Update the question to: "What's the relationship between GigaScience Press and GigaDB?"
            - [ ] Replace the existing answer with the new answer provided in the outline.
        - How to test:
            - [ ] Manually navigate to the FAQ page.
            - [ ] Verify the question and answer for this FAQ are updated as per the outline.
            - [ ] Verify expand/collapse functionality.
    - **b. Update FAQ: "What is the long term preservation plan for GigaDB?"**
        - How to implement it step by step:
            - [ ] Locate the existing FAQ "What is the long term preservation plan for GigaDB?" (around line 41x in the outline) in `protected/views/site/faq.php`.
            - [ ] Replace the existing answer with the new answer provided in the outline.
        - How to test:
            - [ ] Manually navigate to the FAQ page.
            - [ ] Verify the answer for this FAQ is updated as per the outline.
            - [ ] Verify expand/collapse functionality.
    - **c. Review other CNGB mentions**
        - How to implement it step by step:
            - [ ] Search for "CNGB" within `protected/views/site/faq.php` (specifically lines 605-640 mentioned in the outline and any other instances). Update or remove mentions to align with the new relationship details.
            - [ ] Check `protected/views/site/guide.php` (around line 26) for CNGB mentions and update for consistency if necessary.
            - [ ] Check `protected/views/site/term.php` (around lines 142-157) for CNGB mentions and update for consistency if necessary.
        - How to test:
            - [ ] Manually review the modified sections in `faq.php`, `guide.php`, and `term.php` to confirm CNGB mentions are consistent with the new information.

- [ ] **Task 4: Remove FAQ - "How do I download a large dataset with my slow internet connection?"**
    - How to implement it step by step:
        - [ ] Locate the FAQ panel for "How do I download a large dataset with my slow internet connection?" (around line 277 in the outline) in `protected/views/site/faq.php`.
        - [ ] Delete the entire `div.panel.panel-default` block for this FAQ.
    - How to test:
        - [ ] Manually navigate to the FAQ page.
        - [ ] Verify that the FAQ "How do I download a large dataset with my slow internet connection?" is no longer present.
        - [ ] Check that the removal did not break the layout or functionality of other FAQs.

- [ ] **Task 5: Update FAQ - "How do I submit data?"**
    - How to implement it step by step:
        - [ ] Locate the FAQ "How do I submit data?" (around line 164 in the outline) in `protected/views/site/faq.php`.
        - [ ] Replace the existing answer with the new answer provided in the outline.
    - How to test:
        - [ ] Manually navigate to the FAQ page.
        - [ ] Verify the answer for "How do I submit data?" is updated as per the outline.
        - [ ] Verify expand/collapse functionality.

- [ ] **Task 6: Final Review and Testing**
    - How to implement it step by step:
        - [ ] Review all changes made to `protected/views/site/faq.php` for accuracy and completeness.
        - [ ] Ensure all new and updated FAQs have unique and correctly linked `id`, `data-target`, `aria-controls`, and `aria-labelledby` attributes.
        - [ ] Verify the overall structure and layout of the FAQ page.
        - [ ] Test the FAQ page in different browsers (if applicable) for consistency.
    - How to test:
        - [ ] Perform a full manual walkthrough of the FAQ page, checking all added, updated, and surrounding FAQs.
        - [ ] Ensure all links within the FAQ answers are working correctly.

- [ ] **Task 7: Write Acceptance Tests**
    - How to implement it step by step:
        - [ ] Based on the changes, identify key scenarios for acceptance testing.
        - [ ] Write new acceptance tests or update existing ones to cover:
            - [ ] Presence and content of the new FAQ: "What is involved in data curation?"
            - [ ] Presence and content of the new FAQ: "Who can use GigaDB's data support services?"
            - [ ] Updated content of FAQ: "What's the relationship between GigaScience Press and GigaDB?"
            - [ ] Updated content of FAQ: "What is the long term preservation plan for GigaDB?"
            - [ ] Absence of the FAQ: "How do I download a large dataset with my slow internet connection?"
            - [ ] Updated content of FAQ: "How do I submit data?"
            - [ ] Correct rendering and functionality of the FAQ page.
    - How to test:
        - [ ] Run the acceptance test suite and ensure all tests related to the FAQ changes pass.