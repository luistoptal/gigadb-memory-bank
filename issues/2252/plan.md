# User Admin Page Improvements

## User story description
Improve the user experience of the user admin page (https://staging.gigadb.org/user/admin) by simplifying the interface, removing redundant interactions like popups triggered by row clicks or the configure button, and making the "link to author" action directly accessible via a dedicated button.

## User story completion requirements
- Text selection within the table must be possible without triggering popups.
- Clicking table rows should no longer trigger any popups.
- The configure button's popup functionality must be removed.
- The action buttons column should display: View, Edit, Link to Author, Delete (in that order).
- The "Configure" button (spanner icon) must be replaced by a "Link to Author" button (link icon).
- Clicking the "Link to Author" button must navigate directly to the corresponding author page without intermediate steps.
- All buttons must maintain consistent styling, hover/focus states, tooltips, and accessibility features (ARIA labels, keyboard navigation).

## Tasks
- [x] **Task 1: Remove Row Click Popup and Text Selection Interference**
    - *Implementation:* Modify the JavaScript options for the `CGridView` widget in `protected/views/user/admin.php`. Remove or comment out the `selectionChanged` property or ensure its callback function no longer triggers the dialog popup. Verify no other row/cell click handlers impede text selection.
    - *Testing:* Manually click and drag to select text in various table cells. Confirm that no popup appears when clicking anywhere on a table row.

- [x] **Task 2: Remove Configure Button Popup**
    - *Implementation:* In `protected/views/user/admin.php`, locate the JavaScript code that initializes the dialog popup for the configure button (likely tied to a class like `.operations-btn`). Remove or comment out this event handler.
    - *Testing:* Manually click the original configure button (spanner icon) before it's replaced in the next step. Confirm no popup appears.

- [x] **Task 3: Replace Configure Button with Link to Author Button**
    - *Implementation:* In `protected/views/user/admin.php`, modify the `buttons` array within the `CButtonColumn` configuration:
        - Rename the `configure` button key to `linkAuthor` (or similar).
        - Update its `label` to `'Link to Author'`.
        - Change the icon class in `options['class']` from the spanner icon (e.g., `icon-wrench`) to the link icon (e.g., `icon-link`). Verify the correct icon class in `less/modules/tables.less` or Font Awesome documentation.
        - Update the `url` expression to generate the correct URL for the author page, likely using `$data->author_id` and `Yii::app()->createUrl('adminAuthor/view', array('id'=>$data->author_id))`. Reference `protected/views/adminAuthor/admin.php` if needed.
        - Remove any custom `click` handler associated with the old configure button.
        - Update the `template` property to place the new button correctly: e.g., `{view} {update} {linkAuthor} {delete}`.
    - *Testing:* Refresh the user admin page. Visually verify the link icon appears in the third position in the actions column. Check the button's tooltip. Click the link button for several users and confirm it navigates directly to the correct author page. Check hover/focus states.

- [x] **Task 4: Verify Button Styling**
    - *Implementation:* Ensure the new "Link to Author" button correctly inherits styles (likely `.background-btn-o` from `less/modules/buttons.less`). If styling is incorrect, adjust CSS selectors in the LESS files as needed.
    - *Testing:* Visually inspect the new button's appearance, size, spacing, and hover/focus states in the browser. Compare it to the View and Edit buttons for consistency.

- [x] **Task 5: Update Style Guide Documentation**
    - *Implementation:* Edit `style-guide/doc/modules/ui-dialog.html`. Remove the section documenting the user operations dialog triggered from the table, as it no longer exists.
    - *Testing:* Render and review the style guide page to confirm the outdated dialog documentation is removed.

- [ ] **Task 6: Verify Accessibility and Keyboard Navigation**
    - *Implementation:* Confirm the new "Link to Author" button in `protected/views/user/admin.php` has a `title` attribute for the tooltip. Ensure ARIA labels are consistent with other buttons if used.
    - *Testing:* Use browser developer tools to inspect the button's `title` and any ARIA attributes. Use the Tab key to navigate through the action buttons, ensuring the new button is included and can be activated with Enter/Space. Test with a screen reader if possible.

- [ ] **Task 7: Write Acceptance Tests**
    - *Implementation:* Using Codeception, create or update acceptance tests (`tests/acceptance/UserAdminCest.php` or similar) to cover the requirements:
        - Test text selection in the grid.
        - Test that clicking rows does not trigger popups.
        - Test the correct order and icons of action buttons.
        - Test that clicking the "Link to Author" button navigates to the correct URL.
        - Test the functionality of View, Edit, and Delete buttons remain unchanged.
        - Test keyboard navigation through the action buttons.
    - *Testing:* Run the acceptance test suite (`vendor/bin/codecept run acceptance`) and ensure the new/updated tests pass.