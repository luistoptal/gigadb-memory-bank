## Task Outline: Add "Commenting on Datasets" Help Tab

1.  **Content Preparation:**
    *   Access the provided `mhtml` file ([GigaDB User Guide - Commenting on our Datasets](https://drive.google.com/file/d/1n0qGBKFiSmxTdRmStwf4T89Guqc9KF4T/view?usp=sharing)).
    *   Extract the main textual content regarding commenting on datasets.
    *   Identify and extract all images embedded within the `mhtml` file.
    *   Clean up any unnecessary HTML formatting from the extracted text that might conflict with the site's existing styles. Ensure content aligns with GigaDB's voice and style.

2.  **Asset Integration:**
    *   Determine an appropriate directory for help page images within the project structure (e.g., `htdocs/images/help/commenting/`).
    *   Save the extracted images into this directory.
    *   Optimize images for web use (e.g., appropriate format, compression) if necessary.

3.  **Identify Target Files:**
    *   Controller: `/home/luis/APP/001-WORK/GIGADB/gigadb-website/protected/controllers/SiteController.php`
    *   View: `/home/luis/APP/001-WORK/GIGADB/gigadb-website/protected/views/site/help.php`

4.  **View Modification (`protected/views/site/help.php`):**
    *   Open the `help.php` file.
    *   Add a new tab link to the `ul.nav-tabs` (currently `id="alltabs"`). The new list item (`<li>`) should be:
        *   Title: "Commenting on Datasets"
        *   `id`: `licommenting`
        *   `href`: `#commenting`
        *   `aria-controls`: `commenting`
        *   Positioned as the last tab.
    *   Add a new tab content pane (`<div role="tabpanel" class="tab-pane" id="commenting" aria-labelledby="licommenting">`) within `div.tab-content`. This new pane should be:
        *   Positioned as the last content pane.
        *   Populated with the extracted HTML content from step 1.
        *   Image `src` attributes updated to point to the local image assets (from step 2).
        *   Ensure the new tab and its content inherit existing styling.

5.  **Controller Modification (`SiteController.php` - if needed):**
    *   Review the `actionHelp` method in `SiteController.php`.
    *   If tabs or their content are dynamically generated or require data passed from the controller, update the action to include data for the "Commenting on Datasets" tab. (This is unlikely based on current file structure).

6.  **Styling (CSS/LESS):**
    *   Verify that the new tab and its content display correctly, following existing site styles.
    *   If minor style adjustments are needed, add them to the appropriate LESS/CSS file, adhering to SMACCS and existing conventions.

7.  **Testing:**
    *   **Local Verification:**
        *   Navigate to `/site/help`.
        *   Confirm "Commenting on Datasets" tab appears last.
        *   Verify content (text and images) renders correctly.
        *   Check for broken links/images and layout/responsiveness issues.
    *   **Acceptance Criteria Check:**
        *   Confirm both acceptance criteria from `memory-bank/issues/2324/ticket.md` are met.
    *   **Accessibility (WCAG 2.2):**
        *   Ensure new content is accessible (e.g., images have alt text, text contrast is adequate).

8.  **Code Review & Standards:**
    *   Ensure all code changes adhere to PSR2, PHPDoc, Yii MVC guidelines, and project-specific file/function length limits.
    *   Confirm data security is maintained and no deviations from the tech stack/architecture are introduced.
    *   Verify the product remains in a releasable state.

## Codebase Review Findings (as per review-codebase.md instructions)

*   **Controller:**
    *   File: `protected/controllers/SiteController.php`
    *   Relevant Line: Around line 348 (method `actionHelp`).
    *   Description: This controller action renders the help page. It's unlikely to require changes for adding a new static tab, as it simply renders the `help` view.

*   **View:**
    *   File: `protected/views/site/help.php`
    *   Relevant Lines:
        *   Around line 24: The `ul.nav-tabs` (with `id="alltabs"`) is where the new tab link (`<li>`) needs to be added.
        *   Around line 30: The `div.tab-content` is where the new tab content pane (`<div role="tabpanel" class="tab-pane">`) needs to be added.
    *   Description: This is the main file for the help page's structure and content. The new tab and its content will be added here.

*   **Image Assets Directory:**
    *   Path: `images/help/commenting/`
    *   Description: The root `images/` directory exists. The `help/` subdirectory and the `commenting/` subdirectory within it will need to be created to store images for the new help tab.

*   **Styling (LESS files):**
    *   File 1: `less/pages/help.less`
        *   Description: This file likely contains specific styles for the help page. If the content of the new "Commenting on Datasets" tab requires unique styling, it should be added here.
    *   File 2: `less/modules/tabs.less`
        *   Description: This file likely handles the general appearance and behavior of tab elements across the site. If the new tab requires adjustments to fit the existing tab design, or if any global tab styling is impacted, changes might be needed here.
    *   Note: The project uses a SMACCS-based structure for LESS files, with `less/index.less` typically being the main file that imports other LESS components.