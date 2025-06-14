# User Admin Page Improvements

## Overview
This task focuses on improving the user experience of the user admin page (https://staging.gigadb.org/user/admin) by simplifying the interface and removing redundant interactions.

## Current Issues
1. Text selection is hindered by an intrusive popup that appears when clicking table rows
2. The configure button (spanner icon) triggers a redundant popup with actions that are already available
3. The "link to author" action is only accessible through the popup

## Required Changes

### 1. Remove Popup Functionality
- Eliminate the popup that appears when clicking on table rows
- Remove the popup trigger from the configure button
- Preserve the ability to select and copy text from any cell
- Maintain existing row hover effects and styling

### 2. Action Buttons Modification
- Keep the standard action buttons in their current order:
  1. View
  2. Edit
  3. Replace "Configure" with "Link to Author"
  4. Delete

### 3. Link to Author Button Implementation
- Replace the existing spanner (configure) icon with the link icon
- Position the button after the view and edit buttons and before the delete button
- Clicking the button should directly navigate to the author page
- No confirmation dialog or intermediate steps needed

### Visual and Accessibility Requirements
1. Button Styling
   - Match the hover/focus states of existing action buttons
   - Use the existing link icon from the system
   - Maintain consistent button sizing and spacing

2. Accessibility Features
   - Preserve ARIA labels for screen readers
   - Maintain tooltips for user guidance
   - Ensure keyboard navigation works as expected

### Expected Behavior
1. Text Selection
   - Users can click and drag to select text anywhere in the table
   - No popups or interruptions during text selection
   - Copy/paste functionality works normally

2. Navigation
   - Clicking the link-to-author button navigates directly to the author page
   - Other action buttons (view, edit, delete) retain their current functionality
   - Table row clicks no longer trigger any popups

## Testing Points
1. Verify text selection works smoothly in all table cells
2. Confirm no popups appear when clicking table rows
3. Check that the link-to-author button:
   - Displays correctly with the link icon
   - Has proper hover/focus states
   - Navigates to the correct author page
4. Ensure all other action buttons work as before
5. Verify accessibility features are maintained
6. Test keyboard navigation through all action buttons

## Relevant Files

1. `/protected/views/user/admin.php` (Lines 1-212)
   - Main user admin page implementation
   - Contains the table view, popup dialog, and action buttons
   - Includes JavaScript functions for handling user actions
   - Key areas to modify:
     - Remove popup trigger from table rows (selectionChanged event)
     - Replace configure button with link-to-author button
     - Update action buttons configuration

2. `/less/modules/buttons.less` (Lines 1-96)
   - Contains button styling definitions
   - Relevant classes:
     - `.background-btn-o` for standard action buttons
     - `.danger-btn-o` for delete button
     - `.btns-row` for button layout

3. `/less/modules/tables.less` (Lines 91-196)
   - Contains table styling and action button icons
   - Relevant sections:
     - `.button-column` class for action buttons column
     - `.icon` classes for button icons
     - Table hover and interaction styles

4. `style-guide/doc/modules/ui-dialog.html` (Lines 1-71)
   - Contains reference implementation of the user operations dialog
   - Shows current dialog structure and styling
   - Will need to be updated to reflect new button configuration

5. `/protected/views/adminAuthor/admin.php` (Lines 161-234)
   - Contains the link-to-author functionality
   - Reference for implementing direct author linking
   - Includes modal dialog implementation that will be removed

