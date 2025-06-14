# Fix General Horizontal Overflow

## User story description
Content on pages sometimes overflows horizontally, especially on mobile devices, when long words or strings without spaces are present. This breaks the layout. The content should wrap correctly or be hidden to prevent layout distortion.

## User story completion requirements
- Long words or strings without spaces within common text elements (`p`, `td`, `th`, `li`, `div`, `span`, `a`, etc.) should wrap correctly and not cause horizontal scrolling or layout breaking.
- The fix should be applied globally across the site, likely by modifying base layout or typography styles.
- The main content area should handle overflow gracefully, potentially by hiding horizontal overflow if word wrapping alone is insufficient.

## Tasks
- [ ] Apply `overflow-wrap: break-word;` to common text elements

  - **How to implement:** Add `overflow-wrap: break-word;` to the rules for elements like `p`, `td`, `th`, `li`, `div`, `span`, `a` in a relevant base LESS file, likely `less/base/type.less` or `less/base/scaffolding.less`. Compile the LESS files.
  - **How to test:** Create or modify a dataset description or other text content to include a very long string without spaces. Verify on different screen sizes (desktop and mobile) that the text wraps correctly within its container and does not cause the page to overflow horizontally. Check various element types.

- [ ] Investigate and potentially apply `overflow-x: hidden;` to the main content container

  - **How to implement:** If the `break-word` solution is insufficient for certain edge cases, identify the main content container element (e.g., `<main id="maincontent">` in `protected/views/layouts/main.php`). Add `overflow-x: hidden;` to the CSS rules for this container, likely in a layout-specific LESS file such as `less/layout/app.less`. Compile the LESS files.
  - **How to test:** Re-test with the long string example. If `break-word` didn't fully solve it, verify that the horizontal overflow is now hidden for the main content area. Ensure this doesn't negatively impact other layout aspects (e.g., intentionally horizontally scrolling elements, if any exist).

- [ ] Write acceptance tests

  - **How to implement:** Create a Codeception acceptance test that navigates to a page with intentionally long text content (perhaps a dedicated test page or a modified existing one). Assert that the page layout is not broken and that specific elements containing long text wrap correctly or that the main container prevents horizontal scrolling.
  - **How to test:** Run the acceptance test suite to ensure the new test passes and verifies the fix.