# Dataset Page Table Horizontal Scrollability
## User story description
On the dataset view page (`protected/views/dataset/view.php`), the "Samples" table does not scroll horizontally when its content overflows the container width. Other tables, like the "Files" table, already have this behavior. All tables on this page should be horizontally scrollable when their content overflows.

## User story completion requirements
- The "Samples" table on the dataset view page must become horizontally scrollable when its content exceeds the available width.
- Any other tables on the same page should also be horizontally scrollable if they overflow.
- The scroll behavior should mimic the existing behavior of the "Files" table.
- The solution should ideally reuse existing CSS classes or structures if available and appropriate.

## Tasks
- [ ] Investigate the existing implementation for the scrollable "Files" table in `protected/views/dataset/view.php`.
  - Locate the "Files" table section in the view file.
  - Identify the HTML structure (e.g., wrapping `div`) and any specific CSS classes used to enable its horizontal scrolling.
  - Check `less/modules/tables.less` or use browser developer tools to find the corresponding CSS rules (`overflow-x: auto;` or similar).
  - Test by viewing a dataset page with a wide "Files" table and confirming its scroll behavior.

- [ ] Locate the "Samples" table (and any other tables) in `protected/views/dataset/view.php`.
  - Find the HTML markup for the "Samples" table.
  - Identify any other tables present on the page that might require similar treatment.
  - No specific testing needed for identification.

- [ ] Apply the scrollable container structure/class to the "Samples" table (and others if necessary).
  - Modify `protected/views/dataset/view.php` to wrap the "Samples" table (and any other identified non-scrollable tables) with the same HTML structure (e.g., `<div class="table-responsive">...</div>` if that's the pattern) used for the "Files" table.
  - Ensure the applied class correctly triggers the `overflow-x: auto;` style.
  - Test by viewing a dataset page with a wide "Samples" table (potentially mock data or resize window) and confirm it scrolls horizontally. Verify other tables are also scrollable if they were modified.

- [ ] Write acceptance tests.
  - Create or update a Codeception acceptance test for the dataset view page.
  - The test should ensure a dataset is loaded where the "Samples" table is likely to overflow (or manipulate the DOM/CSS to force overflow).
  - Assert that the container wrapping the "Samples" table has the `overflow-x: auto` (or similar) style applied.
  - Assert that the table is actually scrollable (e.g., via JavaScript check or attempting a scroll action).
  - Repeat assertions for any other tables that were modified.
