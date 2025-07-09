# Outline – Issue 152: Create a Simplified (Print) Dataset View

## 1. Objective
Deliver a printer-friendly, content-focused view of every dataset page that users can easily toggle on/off via the URL query string. The view hides chrome (header, footer, sidebar) and shows only essential dataset information.

## 2. Approach & Format
* **Reuse the existing dataset page** – no new Yii action or route is added.
* Toggling is driven by the query parameter `?print=true`.
  * If present, a `print` CSS class is added to `<body>` (done client-side via a tiny JS snippet executed at page load).
  * All styling/visibility changes are handled via CSS (screen & `@media print`).
* Future review item: if this proves too limiting, revisit generating a dedicated page – **flagged _to-be-reviewed_**.

## 3. Scope & Displayed Elements
* In print mode, all the content in the dataset page is displayed, except for the common layout elements (header, footer, etc).
* In print mode, dynamic controls are NOT displayed: Table settings dialog
* In print mode, tabs widget is not displayed, and instead the tab panel content is displayed all at once as regular page sections
* In print mode, 3D Models and 3D Sketchfab tab content is not displayed

## 4. Toggle Mechanism & Routing
* Button/link labelled **“Print view”** is added to the top-right of the dataset content area (near the dataset title, right aligned).
* Clicking the button appends `?print=true` to the current URL (`url.searchParams.set`) and uses jquery to toggle the `print` class on the `<body>` tag.
  * Note: button click does not reload the page, because page load is slow
  * Note: if the user manually refreshes the page with `?print=true` in the URL, the page will load with the print view
* While `print=true` is present:
  * The button label switches to **“Web view”** which removes the param and reloads.
  * `<body>` receives class `print`.
  * Header, footer and any non-essential UI elements are hidden.
* Access control is unchanged – users must have permission to view the dataset.

## 5. Stylesheet Strategy
* **File structure & load order**
  * `less/pages/dataset.less` – existing web-view rules, unchanged.
  * `less/pages/dataset-print.less` – new file imported **after** the web file inside `less/index.less` so its rules cascade last.
* **Scoping**
  * All overrides live under `body.print` (and `@media print`) selectors, so they affect nothing until the class is present.
* **Key rules inside `dataset-print.less`**
  ```less
  body.print {
    header,
    footer,
    .tabs,
    .table-settings-dialog,
    .sketchfab-3d,
    .model-3d {
      display: none !important;
    }

    .dataset-view-container {
      max-width: 100%;
    }

    .tab-content {
      display: block;
    }
  }

  @media print {
    a:after { content: " (" attr(href) ")"; font-size:90%; }
  }
  ```
  These concise rules hide page chrome, reveal all tab-panel content, and enhance print readability without touching the normal view.
* **Why not disable the web CSS?**
  Overriding a handful of selectors is far simpler and safer than loading a separate bundle. New web-only styles automatically ignore print mode unless a developer intentionally adds a `.print` override.
* **JavaScript helper**
  A ≤10-line inline script (bundled with the print-toggle partial) checks `url.searchParams.has('print')` on load, toggles `body.print`, and handles button clicks that add/remove the param without reloading the page.

## 6. Link Placement
* Inside `.dataset-view-container` header region, right-aligned.
* Uses existing button styling; adds class `simplified-view-link` for overrides if needed.

## 7. Samples & Files Table Pagination – _TBD_
* Current decision: **show all rows** while requirement is under review.
* If future perf/usability issues arise, revisit options (first-N rows + link, or omit entirely).

## 8. Accessibility & Print Enhancements
* WCAG 2.2 AA compliance.
* Ensure sufficient colour contrast after chrome removal.
* `aria-label` on toggle button clarifies purpose (e.g. “Switch to print view”).
* Tables retain `<thead>` / `<th>` semantics for screen readers.

## 9. Acceptance Criteria
* GIVEN a dataset page WHEN user clicks “Print view” THEN URL gains `?print=true`, page reloads, header/footer are hidden, and only sections listed in §3 are visible.
* GIVEN print view WHEN user clicks “Web view” THEN page returns to normal view.
* GIVEN `?print=true` WHEN user invokes browser print preview THEN layout is clean and free of navigation UI.
* Page passes axe-core with **zero critical violations**.

## 10. Implementation Checklist
- [ ] Create reusable partial `_printToggle.php` that renders the Print/Web button and embeds the inline jquery / JS helper
- [ ] Embed the partial near the dataset title in `protected/views/dataset/view.php`.
- [ ] Create `less/pages/dataset-print.less` **and import it after** `dataset-web.less` in `less/index.less`; rebuild assets.
- [ ] Hide chrome and adjust typography in `.print` rules.
- [ ] Verify header/footer/tabs/3D panels are hidden in print mode.
- [ ] Append URLs to links in `@media print`.
- [ ] Verify long tables render within printable page width.
- [ ] Update translation strings if needed.

## 11. Test Plan
### Automated (Codeception functional test)
1. Request `/dataset/101001?print=true` – expect HTTP 200.
2. Assert that `header` and `footer` elements are not present in DOM.
3. Assert that DOI and Title are present.
4. Assert toggle button reads “Web view”.

### Manual
1. Run axe-core on both views; confirm zero critical violations.
2. Trigger browser print preview; visually confirm clean output.

## 12. Non-Goals
* Generating RTF/PDF downloads.
* Server-side cached simplified pages.
* Refactoring dataset controller beyond minimal JS & view tweaks.

## 13. Open Items
* Row-limit strategy for large tables remains **to be reviewed**.
* Any required performance optimisations will be evaluated after initial rollout.

## 14. References & Assets
* `@print-view-example.jpg` – rough mock-up of expected appearance (June 2025).
* Original ticket discussion – [Issue #152](https://github.com/gigascience/gigadb-website/issues/152).

## 15. Codebase Review – Relevant Files

| File | Key Lines | Why it matters |
| ---- | --------- | -------------- |
| protected/views/dataset/view.php | 12-18, 270-310 | Main dataset page markup. Lines 12-18 contain the opening `<div class="container dataset-view-container">` where the Print/Web toggle partial will be inserted (§6). Lines 270-310 start the `<ul class="nav nav-tabs ...">` block and subsequent `.tab-content` panels that the print stylesheet will reveal/hide (§3). |
| protected/views/layouts/main.php | 30-45 | Declares the `<body>` element and renders the shared header & footer partials. The JS helper toggles the `print` class here, and `body.print` rules hide chrome elements (§5). |
| protected/views/shared/_header.php | 1-EOF | Structural markup for the site header which will be hidden by the `body.print header { display:none }` rule. |
| protected/views/shared/_footer.php | 1-EOF | Structural markup for the site footer hidden by `body.print footer { display:none }`. |
| less/pages/dataset.less | 1-168 | Existing web-view styles for the dataset page (e.g., `.dataset-view-container`). Print overrides in `dataset-print.less` will cascade on top when `body.print` is active. |
| less/index.less | 38-44 | Central Less import list; current `@import "pages/dataset.less";` lives at line 41. A new `@import "pages/dataset-print.less";` line should be added immediately after so print rules load last (§5). |

_Notes_: No controller logic changes are required. Dynamic controls (table-settings dialogs, 3D tabs, etc.) already exist in `view.php`; they will simply be hidden via new CSS rules.