# Task Outline: Issue #428 - Link Previews

1.  **Goal:** Implement dynamic link previews for URLs listed in the "Additional information" section of dataset pages (e.g., `/dataset/100002`).
2.  **Core Functionality:**
    *   For each "Additional information" link, fetch the target URL's HTML content on the server-side.
    *   Parse the HTML to extract metadata:
        *   Primary: Open Graph (og:title, og:description, og:image) and Twitter Card (twitter:title, twitter:description, twitter:image) tags.
        *   Fallback: Standard HTML `<title>` and `<meta name="description" ...>` tags.
    *   Prioritize Open Graph/Twitter tags if available.
3.  **Implementation (Backend - PHP/Yii):**
    *   Follow the Onion Architecture pattern demonstrated in `DatasetPageAssembly.php`.
    *   **Data Fetching (`StoredDatasetLinksPreview.php`):**
        *   Implement a component responsible for fetching URL content using an HTTP client (e.g., Guzzle).
        *   Implement HTML parsing to extract the required meta tags. Handle potential errors (network issues, timeouts, non-HTML content, missing tags).
        *   Consider using a dedicated PHP library for meta tag extraction if available via Composer (search Packagist for "meta tags", "Open Graph", "html parser").
    *   **Caching (`CachedDatasetLinksPreview.php`):**
        *   Implement a caching layer using Yii's cache component (`Yii::app()->cache`).
        *   Cache the extracted metadata (title, description, image URL) per URL.
        *   Define appropriate cache keys and expiration/dependency strategy to balance freshness and performance.
    *   **Formatting (`FormattedDatasetLinksPreview.php`):**
        *   Implement a component that takes the (cached) metadata and prepares it for the view.
        *   Structure the data (e.g., an array of preview objects/arrays, one per link).
        *   Handle missing data gracefully (e.g., provide default placeholders or omit elements if title/description/image are not found).
    *   **Integration:**
        *   Modify `DatasetPageAssembly.php` to assemble the new preview components.
        *   Modify `DatasetController.php` to pass the formatted preview data to the view.
4.  **Implementation (Frontend - View/CSS):**
    *   **View (`protected/views/dataset/view.php`):**
        *   Update the template to iterate through the formatted preview data.
        *   Render the preview for each link, displaying the title, description, and image (if available).
        *   Style the previews to resemble the mockup provided in the issue (square panels).
    *   **Styling (LESS/CSS):**
        *   Add necessary CSS rules to style the preview panels, images, text, etc., according to the mockup.
5.  **Acceptance Testing (Codeception):**
    *   Implement acceptance tests based on the scenarios defined by Rija (Oct 18, 2020 comment), covering links with full metadata, partial metadata (title/description only, title only), and ensuring the previews are visible on the dataset page. Use the provided example dataset (100002) and URLs.
6.  **Error Handling:** Ensure the page loads correctly even if fetching metadata for some or all links fails. The preview section should degrade gracefully (e.g., show nothing or just the plain link).
7.  **Dependencies:** Ensure any new libraries (HTTP client, HTML parser) are added to `composer.json` and installed.
