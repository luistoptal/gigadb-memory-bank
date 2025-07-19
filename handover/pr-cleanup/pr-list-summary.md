# PR Summary for Handover

This document contains summaries of all open PRs (excluding drafts) for handover to the new developer team.

## PR Analysis Format

Each PR entry follows this format:
- **PR Title**: Brief descriptive title
- **Link**: GitHub PR URL
- **Description**: 1-3 sentence summary of what the PR does
- **Tags**: Infrastructure, Web A11y, or other relevant tags
- **Complexity**: Fibonacci poker value (1, 2, 3, 5, 8, 13, 21)
- **Should merge**: [To be filled by user]

---

## PRs to be analyzed

### Create a simplified dataset view
- **Link**: https://github.com/gigascience/gigadb-website/pull/2413
- **Description**: Adds a printer-friendly version of dataset view pages with a toggle button to switch between web and print modes. Includes simplified layout optimized for printing by removing navigation elements and restructuring content for better readability.
- **Tags**: Web A11y
- **Complexity**: 8
- **Should merge**: N

### Fix checkbox focus styling in login form
- **Link**: https://github.com/gigascience/gigadb-website/pull/2403
- **Description**: Fixes checkbox focus styling in the login form to improve accessibility and visual feedback for keyboard navigation.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**: Y

### Simplify and compact curation log table
- **Link**: https://github.com/gigascience/gigadb-website/pull/2400
- **Description**: Streamlines the curation log table by removing unnecessary columns and adding tooltips for detailed information. Improves readability with compact layout and better text visibility.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**: N

### Add Supplemental File Guidelines page
- **Link**: https://github.com/gigascience/gigadb-website/pull/2398
- **Description**: Creates a new "Supplemental File Guidelines" page with detailed recommendations for file submissions. Adds navigation tab and accessible link from the guide section with enhanced definition list styling.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**: N

### Add dataset title length warning to dataset create and update form
- **Link**: https://github.com/gigascience/gigadb-website/pull/2397
- **Description**: Adds dynamic warning and character counter for dataset title field, notifying users when title exceeds 100 characters. Provides real-time feedback and accessibility features.
- **Tags**: Web A11y
- **Complexity**: 5
- **Should merge**: N

### Add db port to secrets template
- **Link**: https://github.com/gigascience/gigadb-website/pull/2396
- **Description**: Adds `GIGADB_PORT=5432` to the secrets template file to ensure tests work locally without additional configuration.
- **Tags**: Infrastructure
- **Complexity**: 1
- **Should merge**: Y

### Disable coderabbit auto review status
- **Link**: https://github.com/gigascience/gigadb-website/pull/2383
- **Description**: Disables automatic CodeRabbit status messages to prevent email inbox overflow. CodeRabbit will now only add messages on demand.
- **Tags**: Infrastructure
- **Complexity**: 2
- **Should merge**: N

### Update the layout of the Advisory board page
- **Link**: https://github.com/gigascience/gigadb-website/pull/2380
- **Description**: Adjusts layout so items per row stay consistent across screen sizes and adds max width to image containers to prevent oversized appearance.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**: N

### Content change in Genomic Guideline page
- **Link**: https://github.com/gigascience/gigadb-website/pull/2379
- **Description**: Updates two links in the genomic guideline page with more meaningful labels and improved SEO practices using semantic HTML elements.
- **Tags**: Web A11y
- **Complexity**: 1
- **Should merge**: N

### Add new FAQ entries
- **Link**: https://github.com/gigascience/gigadb-website/pull/2378
- **Description**: Adds three new FAQ entries: "What is included in a dataset?", "What is the file name convention for GigaDB?", and "What are the expectations on file compression?".
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**: N

### Add "GigaScience RRID list" help tab panel
- **Link**: https://github.com/gigascience/gigadb-website/pull/2366
- **Description**: Adds new tab panel to help page with GigaScience RRID list content. Ports content from provided mhtml file and uses semantic slugs for entry IDs.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**: N

### docs: update GigaDB search help page content for filtering results
- **Link**: https://github.com/gigascience/gigadb-website/pull/2360
- **Description**: Simple text change on the help page to update content about filtering search results.
- **Tags**: Web A11y
- **Complexity**: 1
- **Should merge**: N

### Add BlueSky social icon to header and footer
- **Link**: https://github.com/gigascience/gigadb-website/pull/2358
- **Description**: Adds BlueSky social media link with new logo icon to website header, footer, and mobile navigation. Updates responsive breakpoints and component widths to accommodate the additional icon.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**: N

### Add "Commenting on our datasets" help tab panel
- **Link**: https://github.com/gigascience/gigadb-website/pull/2352
- **Description**: Adds detailed help section explaining how to comment on datasets using Hypothes.is annotation tool. Introduces new styles for blogpost-type content to improve readability.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**:

### Auto hyperlink URLs in dataset file and sample attributes
- **Link**: https://github.com/gigascience/gigadb-website/pull/2332
- **Description**: Automatically converts URLs in dataset file and sample attributes into clickable links. Replaces JavaScript-based text truncation with modern CSS-based line clamping for better accessibility.
- **Tags**: Web A11y
- **Complexity**: 8
- **Should merge**:

### compare missing environment variables to the variables.md file in a ci/cd job
- **Link**: https://github.com/gigascience/gigadb-website/pull/2323
- **Description**: Creates CI/CD jobs to check for missing GitLab project variables by comparing against documented requirements. Includes scripts for local validation and GitLab API integration.
- **Tags**: Infrastructure
- **Complexity**: 8
- **Should merge**:

### Comment out non-functional API endpoints in help page
- **Link**: https://github.com/gigascience/gigadb-website/pull/2316
- **Description**: Temporarily removes two API endpoint examples from the help page to reflect current service availability.
- **Tags**: Web A11y
- **Complexity**: 1
- **Should merge**:

### Update FAQ text content
- **Link**: https://github.com/gigascience/gigadb-website/pull/2302
- **Description**: Updates FAQ content according to multiple tickets, including modifications to existing entries, removal of outdated content, and addition of new entries about data curation and support services.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**:

### Improve keyboard shortcuts (h, f) in 3D model viewer
- **Link**: https://github.com/gigascience/gigadb-website/pull/2277
- **Description**: Improves keyboard shortcuts in 3D model viewer to only trigger when the 3D model tab is active and no modifier keys are pressed. Adds proper state checking for model loading.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**:

### extend 3d viewer capabilities to VR
- **Link**: https://github.com/gigascience/gigadb-website/pull/2272
- **Description**: Extends 3D model viewer with WebXR (VR) capabilities using Three.js. Adds VR button for immersive mode and updates Three.js library to v0.175.0 with improved rendering loop.
- **Tags**: Web A11y
- **Complexity**: 8
- **Should merge**:

### Prevent overflowing unbroken words in curation log table
- **Link**: https://github.com/gigascience/gigadb-website/pull/2271
- **Description**: Forces long words without breaks to wrap in curation log tables to prevent table overflow. Adds utility class for table styling and sets explicit column widths.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**:

### Remove config popup from user admin page
- **Link**: https://github.com/gigascience/gigadb-website/pull/2269
- **Description**: Removes redundant modal popup from user admin page and moves "Link to Author" action directly into the action column as a dedicated button, simplifying the user interface.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**:

### FAQ search and question submission form
- **Link**: https://github.com/gigascience/gigadb-website/pull/2261
- **Description**: Adds search functionality to FAQ page with dynamic filtering and a question submission form. Includes client-side validation, server-side validation, and integration with user creation flow.
- **Tags**: Web A11y
- **Complexity**: 8
- **Should merge**:

### Improves admin dataset table UX
- **Link**: https://github.com/gigascience/gigadb-website/pull/2259
- **Description**: Improves curator experience in admin dataset table by changing visible columns, adding search filters for curator and upload status columns, and setting default sorting to descending ID.
- **Tags**: Web A11y
- **Complexity**: 5
- **Should merge**:

### Update FAQ
- **Link**: https://github.com/gigascience/gigadb-website/pull/2255
- **Description**: Updates FAQ text content according to multiple tickets and adds new entry "What are the benefits of using GigaDB?" as the second entry.
- **Tags**: Web A11y
- **Complexity**: 1
- **Should merge**:

### Update FAQ. What data storage procedures do you follow?
- **Link**: https://github.com/gigascience/gigadb-website/pull/2254
- **Description**: Updates FAQ entry about data storage procedures as requested in the ticket.
- **Tags**: Web A11y
- **Complexity**: 1
- **Should merge**:

### Balance size of dataset table columns
- **Link**: https://github.com/gigascience/gigadb-website/pull/2224
- **Description**: Explicitly sets relative size of dataset table columns to give more weight to the description column for better layout and readability.
- **Tags**: Web A11y
- **Complexity**: 2
- **Should merge**:

### Update default dataset view file settings
- **Link**: https://github.com/gigascience/gigadb-website/pull/2218
- **Description**: Updates default active columns for file table in dataset page and changes default number of items per page to 50 according to ticket requirements.
- **Tags**: Web A11y
- **Complexity**: 3
- **Should merge**:

### Add dataset description length warning and error messages
- **Link**: https://github.com/gigascience/gigadb-website/pull/2197
- **Description**: Adds frontend validation logic for dataset description with dynamic word count, warnings for over 250 words, and errors for over 500 words. Distinguishes between published and non-published datasets.
- **Tags**: Web A11y
- **Complexity**: 5
- **Should merge**:

### New feature/66 browser native dataset file preview
- **Link**: https://github.com/gigascience/gigadb-website/pull/2172
- **Description**: Adds preview modal for dataset files allowing users to preview supported files (images, text, HTML, PDF) without opening new tabs. Includes preview button with disabled state for unsupported files.
- **Tags**: Web A11y
- **Complexity**: 8
- **Should merge**:
