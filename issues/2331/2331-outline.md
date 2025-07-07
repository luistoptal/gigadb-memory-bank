# Outline – Issue #2331: Adjust the curation log view for a better user experience

## 1. Goal
* Make the "Curation History" table on each dataset-admin page more compact to reduce scrolling for curators.

## 2. In-scope Changes
1. **Visible columns (left-to-right)**
   * Comment (prefixed with the action, plain text)
   * Created Date
   * Action Buttons (existing edit/delete controls)
2. **Hidden fields moved to tooltip**
   * Created by
   * Modified by
   * Modified date
   * Any other current non-visible metadata
3. **Tooltip behaviour**
   * Bootstrap 3 tooltip (`data-toggle="tooltip"`) appears when hovering anywhere on the row.
   * Content lists each hidden value preceded by its label (e.g. "Created by: Jane Doe").
4. **Row layout**
   * Minimise vertical padding for tighter rows.
   * Preserve existing row striping, sorting, and pagination.

## 3. Out-of-scope
* No mobile/touch fallback (desktop curator workflow only).
* No new visual design assets; rely solely on existing Bootstrap 3 classes.
* Public dataset pages remain untouched.

## 4. Acceptance Criteria
1. Table shows only the three specified columns.
2. Hovering a row displays a tooltip with Action, Created by, Modified by, Modified date, each labelled.
3. Table retains current striping, sorting, and pagination.
4. Compact layout reduces vertical height by ≥30 % compared to previous design on a dataset with ≥10 log entries.
5. No JavaScript console errors; existing automated tests pass.
6. Change limited to curator-only pages.

## 5. Technical Notes / Constraints
* Yii 1.1 view uses Bootstrap 3—leverage its tooltip JS, initialise after AJAX pagination.
* Keep PSR-2 compliance; functions ≤30 lines.
* Maintain HTML headers & ARIA attributes to avoid breaking screen-reader navigation.

## 6. Definition of Done
* All acceptance criteria met.
* Code follows project standards; tests updated/added.
* Documentation updated as needed.

## 7. Relevant Code Locations

| File | Lines | Purpose |
| ---- | ----- | ------- |
| `protected/views/adminDataset/curationLog.php` | 15-31 | Current GridView column definitions; will be simplified and row-level tooltip added. |
| `protected/controllers/AdminDatasetController.php` | 60-70 | `registerTooltipScript()` registers the Bootstrap tooltip JS; ensure it's called when rendering dataset admin page. |
| `protected/js/bootstrap-tooltip-init.js` | 1-3 | Initialises Bootstrap 3 tooltips for elements annotated with `data-toggle="tooltip"`. |
| `protected/js/custom-grid-view.js` | 100-110 | `afterAjaxUpdate()` callback executed after AJAX pagination; needs augmentation to re-initialise tooltips. |
| `less/modules/tooltip.less` | 1-40 | Custom tooltip styling matching design guidelines; may require tweaks for compact rows. |
| `protected/models/CurationLog.php` | 25-45 | Attribute labels (`created_by`, `last_modified_*`) and validation; provide data for tooltip. |