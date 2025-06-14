# Refine Fullscreen Toggle Logic for 3D Model Viewer

## User story description
Prevent the 3D model viewer from toggling fullscreen mode when key combinations involving 'F' (like Ctrl+F) are pressed. Fullscreen should only activate when the 'F' key is pressed *alone*, the 3D model tab is active, and a model has successfully loaded.

## User story completion requirements
- The 'F' key alone toggles fullscreen *only* when the 3D model tab (`#3dmodels`) is visible and active, and the model viewer state indicates a successful load (e.g., 'success').
- Key combinations involving 'F' (e.g., Ctrl+F, Shift+F) do *not* toggle fullscreen and must allow the browser's default behavior (like opening the find bar).
- Pressing 'F' when the 3D model tab is not active or the model hasn't successfully loaded does not toggle fullscreen.
- The changes do not introduce side effects on pages without the 3D model viewer.

## Tasks
- [x] Update Keyboard Event Handler Logic in `gigadb/app/client/js/model-viewer/ui/index.js`

- Implement the refined logic within the `handleKeyDown` function:
    - [x] Locate the existing condition that checks for the 'F' key (around line 124 in `ui/index.js`).
    - [x] Enhance the condition to check `event.key === 'F'` (or equivalent key code check).
    - [x] Add checks to ensure modifier keys (`event.ctrlKey`, `event.shiftKey`, `event.altKey`, `event.metaKey`) are all `false`.
    - [x] Add a check to verify the 3D model tab is active using jQuery: `$('#3dmodels').is('.visible.active')`.
    - [x] Integrate a check for the model's loaded state. Query the state managed by the module associated with `uiView.js` (e.g., access a state property like `this.uiView.state === 'success'`).
    - [x] Ensure the `toggleFullscreenMode()` function is called *only* if all the above conditions (F key alone, no modifiers, tab active, model loaded) are true.
    - [x] Verify that `event.preventDefault()` is called *only* when toggling fullscreen, allowing default browser actions otherwise.
- Suggest how to test the task implementation:
    - Manually test on a dataset page with a 3D model (e.g., dataset/100006):
        - Press Ctrl+F: Verify browser find bar opens, no fullscreen toggle.
        - Press Shift+F, Alt+F, Cmd+F: Verify no fullscreen toggle.
        - Activate the 3D model tab, wait for load.
        - Press 'F' alone: Verify fullscreen toggles on/off.
        - Switch to another tab (e.g., Files) on the same page.
        - Press 'F' alone: Verify fullscreen does *not* toggle.
    - Manually test on a page without a 3D model viewer (e.g., dataset/100020): Press 'F', verify no errors or unexpected behavior.
    - Test in different browsers (e.g., Chrome, Firefox).

- [ ] Write Acceptance Tests

- Create or update Codeception acceptance tests to cover the new logic:
    - [ ] Identify or create a suitable acceptance test file (likely related to dataset view).
    - [ ] Test Case 1 (Successful Toggle): Navigate to dataset 100006, wait for the 3D model viewer to load (`waitForElementVisible`), switch to the '#3dmodels' tab (`click`), press 'F' (`pressKey`), assert fullscreen mode is active (`waitForElementVisible` for a fullscreen-specific element/class).
    - [ ] Test Case 2 (Modifier Key): Navigate to dataset 100006, wait for load, switch to '#3dmodels' tab, press Ctrl+'F' (`pressKey('F', 'ctrl')`), assert fullscreen mode is *not* active (`dontSeeElement`). Maybe assert find bar is active if possible, or just lack of fullscreen.
    - [ ] Test Case 3 (Inactive Tab): Navigate to dataset 100006, wait for load, ensure '#3dmodels' tab is *not* active, press 'F', assert fullscreen mode is *not* active.
    - [ ] Test Case 4 (No Viewer): Navigate to dataset 100020, press 'F', assert no viewer-related errors or fullscreen.
- Suggest how to test the task implementation:
    - Run the acceptance test suite (`vendor/bin/codecept run acceptance`) and ensure the new/updated tests pass.
