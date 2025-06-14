# Help Page Tab Navigation Scrollability
## User story description
The tab navigation section on the site/help page does not scroll horizontally on mobile devices when the content overflows the screen width. Users should be able to scroll horizontally to see all tabs.

## User story completion requirements
- The tab navigation on the site/help page must be horizontally scrollable on viewports where the tabs exceed the available width.
- The scrolling behavior should only be active when necessary (i.e., when content overflows).
- The visual appearance should remain consistent with the existing design, only adding the scroll capability.

## Tasks
- [ ] Identify the specific HTML container element for the tab navigation `ul` in `protected/views/site/help.php`.
  - Inspect the HTML structure of the `site/help` page to find the direct parent or a suitable ancestor container of the `ul` element that holds the tabs. Look for existing classes or IDs, or consider adding one if necessary (e.g., `.tab-nav-container`).
  - No specific testing needed for identification, but verification in browser developer tools is recommended.

- [ ] Apply CSS rules to enable horizontal scrolling in `less/modules/tabs.less`.
  - Add or modify a LESS rule targeting the identified container (e.g., `.tab-nav-container` or a more specific selector based on the existing structure).
  - Apply the CSS properties `overflow-x: auto;` and `white-space: nowrap;` to this selector. Ensure this applies only when needed, possibly using media queries if the issue is specific to certain screen sizes, although `overflow-x: auto` inherently handles this.
  - Test by resizing the browser window or using device emulation in developer tools to simulate overflow and confirm horizontal scrolling appears and functions correctly. Check that scrolling does *not* appear when content does not overflow.

- [ ] Write acceptance tests.
  - Create a Codeception acceptance test (`*.suite.yml`, `*.php`) that navigates to the `site/help` page.
  - The test should simulate a narrow viewport width.
  - It should assert that the tab navigation container is horizontally scrollable (this might involve checking CSS properties via JavaScript execution or attempting a scroll action).
  - It should also assert that tabs which are initially off-screen become visible after scrolling.

---

**Note on Scrollbar Visibility:**

Keep in mind that default scrollbar behavior differs between browsers/OS:
- **iOS (Safari):** Often hides scrollbars by default until the user actively swipes within the scrollable area. The container *is* scrollable, but the visual indicator might not be present initially.
- **Android (Chrome) / Desktop Browsers:** Tend to show a subtle scrollbar indicator if the content overflows, making scrollability more immediately obvious.

Testing should confirm *scroll functionality* (ability to swipe/scroll to reveal hidden tabs) rather than just the *presence* of a visible scrollbar, especially on iOS devices.
