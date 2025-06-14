# Outline – Issue 152: Create a Simplified Dataset View

## 1. Objective
Provide a printable, content-focused version of each dataset page that shows only key information and omits bulky layout elements.

## 2. Format Decision (see decision record `152-decision-html-page-format.md`)
* Implement as an **HTML page** served at `/dataset/<id>/simplified` (exact Yii route name TBD).

## 3. Scope & Displayed Elements
Render the following (in order):
1. DOI
2. Release date
3. Title
4. Citation information (including RIS / BibTeX / Text links)
5. Data types
6. Keywords
7. Dataset summary (abstract)
8. Links (all categories)
9. Related manuscripts
10. Resource accessions
11. Funding information
12. Samples information – basic table (columns: `sample_id`, `species_id`, … ?) **→ Table inclusion volume still unresolved – see §7**
13. Files information – basic table (columns: `file_name`, `file_location`, `description`, `type`, `format`, `size`, `release_date`, `attributes`) **→ Table inclusion volume still unresolved – see §7**
14. Licence

## 4. Routing & Access Control
* New action `DatasetController::actionSimplified($id)` (Yii 1.1).
* Enforce same access rules as normal dataset pages (respect embargo/private flags).

## 5. Rendering Strategy
* Reuse existing partials / view fragments where possible.
* Add a dedicated simplified `layout` stripping header, footer, sidebars.
* Provide `@media print` CSS to deliver clean, white-background printable output.

## 6. "Simplified view" Link Placement
* Add a small textual link near the **top-right of the dataset content area**, matching `simplified-link-location.jpg`.

## 7. Outstanding Question – Samples & Files Tables
* How many rows to display if there are hundreds of entries?
  * ❓ **Decision pending**: full table vs first N rows vs omit entirely.
  * Decision: Omit tables entirely for now, they can be added back later if desired

## 8. Accessibility
* Follow WCAG 2.2 AA: semantic headings, alt-text for images, sufficient colour contrast.

## 9. Print Optimisation
* Use print-specific CSS to:
  * Hide navigation/UI chrome.
  * Ensure tables and long URLs wrap gracefully.
  * Display hyperlink URLs inline (so printed page contains visible addresses).

## 10. Acceptance Criteria
* Given a dataset page, when the user clicks "Simplified", they are routed to `/dataset/<id>/simplified`.
* Only the elements listed in §3 are visible.
* The link is placed per §6.
* Page passes axe-core with zero critical violations.
* Print preview shows clean layout without nav bars.
* Access control matches the main dataset page.
* Unit/functional tests cover:
  * Controller route returns 200 for public dataset.
  * Asserts DOM contains expected sections but not hidden elements.

## 11. Non-Goals / Out of Scope
* Generating RTF, PDF, or other download formats.
* Refactoring existing dataset view code outside what is necessary for reuse.
* Performance optimisation beyond reasonable view caching.

## 12. Codebase Review – Relevant Files & Code Sections

Below is a first-pass map of where the current codebase already covers, or will need to be extended for, the simplified dataset view.  Line numbers are from the current `develop` branch and are provided so the team can jump straight to the right spots.

* **protected/controllers/DatasetController.php**
  * ```24:33``` &nbsp;`accessRules()` – currently allows `view`, `mockup`; we must add `simplified` so anyone can request the print view.
  * ```38:46``` &nbsp;`actions()` – registers custom child actions; if we opt for an **inline** `actionSimplified()` method we can skip this, otherwise we'd add a new entry here.
  * **New method** to insert after the existing `actionView()` (~`165:`) to render the stripped-down page.

* **protected/config/main.php**
  * ```157:164``` – URL-manager rules block. Add the higher-priority rule:
    ```php
    '/dataset/<id:\\d+>/simplified' => 'dataset/simplified/id/<id>',
    ```
    Place it before the generic `/dataset/<id>` rule so it is matched first.

* **protected/views/dataset/view.php**
  * Around ```20:40``` inside `.dataset-view-container` header. Insert a small `<a>` pointing to `/dataset/<?php echo $model->identifier; ?>/simplified` and style class `simplified-view-link` (per §6 of the outline).

* **protected/views/dataset/simplified.php** *(new file)*
  * Will reuse the `$assembly` helpers to echo only the sections listed in §3.
  * Sets `$this->layout = '//layouts/print';` so the pared-down layout is applied.
  * No interactive widgets → static markup only; keep under ~200 lines.

* **protected/views/layouts/print.php** *(new file)*
  * Copy of `layouts/main.php` but with header/footer/sidebar blocks removed.
  * Add `<link rel="stylesheet" media="print" href="/css/print-simplified.css">`.

* **less/pages/dataset-simplified.less** *(new)*
  * Houses screen-only tweaks and the `@media print { … }` rules described in §9; import it from `less/index.less`.

* **tests/functional/DatasetSimplifiedViewCest.php** *(new)*
  * Playwright or Codeception test ensuring:
    * Route `/dataset/101001/simplified` returns `200`.
    * DOM hides navigation and shows only required sections.

* **protected/components/DatasetPageAssembly.php** – no changes, but worth noting that its fluent builders (e.g. ```60:140``` setters) already expose the data we need for the simplified template.

### Clarifications (added 2025-06-14)

* **Why the URL rule must be first** – Yii 1 uses *first-match wins* routing. If `/dataset/<id>` is listed before `/dataset/<id>/simplified`, the request `…/simplified` would wrongly fall through to the generic rule and hit `actionView()`. Placing the specific rule first routes it to `actionSimplified()`.
* **Why rename the layout to `print.php`** – The new layout's sole purpose is to produce a printer-friendly page. Naming it `print.php` signals that intent more clearly than `simplified.php`, while the *view* remains `simplified.php` to mirror the route.
* **Why add a *functional* test (`DatasetSimplifiedViewCest.php`)** – Functional tests hit the Yii app without a real browser, letting us quickly assert that the `/simplified` route returns `200` and that the stripped DOM shows only the expected elements. They run faster than full acceptance (browser) tests yet still cover the behaviour needed here.

*Initial code review added* – 2025-06-14