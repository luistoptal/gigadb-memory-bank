# Issue 1: General Horizontal Overflow

## Description

Sometimes the content of a page overflows horizontally, e.g. with long words without breaks or spaces. On mobile, sometimes it causes the page to become wider than it should. The content should not be overflown, probably `overflow-x: hidden;` needs to be added somewhere. Or maybe update default styels for `p`, `a`, etc so that some kind of wordbreak happens for extremely long words

## Conclusions & Proposed Solution

*   **Clarification:** Issue observed on dataset page, but fix should be applied at the layout level for site-wide effect.
*   **Primary Solution:** Apply `overflow-wrap: break-word;` via CSS to common text-containing elements (`p`, `td`, `th`, `li`, `div`, `span`, `a`, etc.) within the main content area. Identify the global/layout CSS file for this.
*   **Secondary Solution:** If word wrapping is insufficient, investigate applying `overflow-x: hidden;` to the main content container element (potentially `<main>` or a wrapper `div` identified in the layout file).

## Relevant Files

*   `less/base/type.less` or `less/base/scaffolding.less` (Line: N/A - Add new rules): Target LESS file for applying global `overflow-wrap: break-word;` base styles.
*   `protected/views/layouts/main.php` (Line: 44): Contains the `<main id="maincontent">` wrapper, potentially needing `overflow-x: hidden;` as a secondary measure (style likely defined in a `layout` LESS file like `less/layout/app.less`).

---

# Issue 2: Help Page Tab Navigation

## Description

site/help page contains a tab navigation section with links. Apparently on mobile devices, the tab navigation is not horizontally scrollable even if it overflows the x direction. It should be x-scrollable if it overflows

## Conclusion & Proposed Solution

*   **Solution:** Apply `overflow-x: auto;` and `white-space: nowrap;` via CSS to the container element holding the tab navigation `ul` on the `site/help` page.

## Relevant Files

*   `protected/views/site/help.php` (Line: TBD - Inspect for tab structure): Contains the HTML for the tab navigation.
*   `less/modules/tabs.less` (Line: N/A - Add new rules or find existing): Target LESS file for applying `overflow-x: auto;` and `white-space: nowrap;` to the tab container module.

---

# Issue 3: Dataset Page Samples Table

## Description

in the dataset page (protected/views/dataset/view.php) we should make sure that any tables on display are scrollable. What we see is that the samples table is not x-scrollable and the files table is correctly x-scrollable as expected. So we should fix the x-scroll for the samples table (and for any other table, if there are any)

## Conclusion & Proposed Solution

*   **Solution:** Modify `protected/views/dataset/view.php` to wrap the "Samples" table in a `div` (or apply an existing suitable class) that has the style `overflow-x: auto;`, mimicking the structure used for the "Files" table.

## Relevant Files

*   `protected/views/dataset/view.php` (Line: TBD - Inspect for Samples table): Contains the HTML for the Samples table; needs modification to add a scrollable wrapper.
*   `less/modules/tables.less` (Line: TBD - Find or add rule): Target LESS file containing the existing/new CSS class/rule for the scrollable table wrapper module.