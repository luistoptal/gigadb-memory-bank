# Outline for Issue 2342 – Display & Manage Funder Uri Column

## 1 – Purpose / Goal
Add a new **"Uri"** column to the existing Funder admin table at `/funder/admin` so curators can quickly identify funders without valid ROR/FundRef identifiers and correct them.

## 2 – Scope & Requirements
1. Column placement: immediately **left of the Action buttons** column (keeps edit/delete actions on far right).
2. Cell content: show the Uri as a **clickable link** opening in a new tab.
3. Sorting: standard alphanumeric ascending/descending (case-insensitive).
4. Filtering: partial-match / "contains" filter (case-insensitive).
5. Empty values: display nothing (blank cell) – no placeholder text.
6. Visibility: available to **all authenticated admin users** (includes Curator & Admin roles).
7. Accessibility: follow existing table conventions; no extra WCAG requirements beyond current pattern.
8. Data source: **TBD – research** whether a Uri field already exists in the dataset_funders table/model. If missing, create migration & model update.

## 3 – Out-of-Scope
- No changes to public-facing funder listings.
- No bulk-edit functionality for Uri values (handled separately).

## 4 – Acceptance Criteria (Testable)
| # | Scenario | Given | When | Then |
|---|----------|-------|------|------|
| 1 | Column visible | I am on `/funder/admin` | page loads | I see a **"Uri"** column between "<previous column>" and Action buttons |
| 2 | Link behaviour | table shows a Uri value | I click the link | Target opens in new tab |
| 3 | Sorting | column header clicked | first click | rows sort ascending alphabetically on Uri |
| 4 | Sorting (desc) | same | second click | rows sort descending |
| 5 | Filtering | I enter text in Uri filter field | filter applied | only rows whose Uri **contains** the text (case-insensitive) remain |
| 6 | Empty display | a record has no Uri | page loads | blank cell shown (no placeholder) |

## 5 – Implementation Tasks
1. Frontend (Yii 1 GridView):
   a. Add `uri` attribute/column definition at specified position.
   b. Render value via `CHtml::link($data->uri, $data->uri, ['target'=>'_blank'])` (if not empty).
   c. Enable `filter` with `CHtml::textField` for contains search; update criteria accordingly.
   d. Ensure `sortable=>true`.
2. Backend / Data layer:
   a. **Research** existing DB/model field for funder Uri.
   b. If absent:
      ‑ Create migration `20250626_add_uri_to_dataset_funders` (varchar 255, nullable).
      ‑ Update `DatasetFunder` AR model rules/labels.
3. Access control: verify `/funder/admin` already ACL-restricted to admin users.
4. Acceptance tests (Codeception):
   a. `tests/acceptance/AdminFunderUriColumnCest.php` covering criteria 1-5.
5. Documentation: update internal SOP/README for curators.

## 6 – Risks / Mitigations
- Missing Uri field → migration needed → coordinate with DBA.
- Large data set may impact filter performance → ensure index if field added.

## 7 – Dependencies
- DB migration (if required) must be deployed before frontend release.

## 8 – Definition of Done
- All acceptance criteria pass (automated tests green).
- Code merged to `develop`, reviewed & lint-clean.
- Documentation updated.
- Deployed to staging for UAT.