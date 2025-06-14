**Task: Refine Fullscreen Toggle Logic for 3D Model Viewer**

1.  **Goal:** Prevent the 3D model viewer from toggling fullscreen mode when key combinations involving 'F' (like Ctrl+F) are pressed. Fullscreen should only activate when the 'F' key is pressed *alone*, the 3D model tab is active, and a model has successfully loaded.

2.  **Locate Keyboard Event Handler:**
    *   Identify the JavaScript file responsible for handling keyboard inputs specifically for the 3D model viewer component. This is likely within the `gigadb/app/client/js/model-viewer/` directory structure.
    *   Find the event listener that currently triggers the fullscreen toggle, paying attention to `keydown` or `keyup` events.

3.  **Update Event Listener Logic:**
    *   **Key Check:** Modify the listener to specifically check if `event.key === 'F'` (or the equivalent key code, ensuring case-insensitivity if necessary).
    *   **Modifier Key Check:** Add conditions to ensure that `event.ctrlKey`, `event.shiftKey`, `event.altKey`, and `event.metaKey` are all `false`.
    *   **Tab Active Check:** Implement a check using jQuery to verify if the element `$('#3dmodels')` exists and has both the `visible` and `active` classes (e.g., `$('#3dmodels').is('.visible.active')`).
    *   **Model Loaded Check:** Access the state managed by the module associated with `uiView.js`. Determine how the keyboard event handler can query this state. The logic should only proceed if the state is `'success'`.
    *   **Conditional Toggle:** Wrap the existing fullscreen toggle function call within an `if` statement that combines all the above checks (F key alone, no modifiers, tab active, model loaded state is 'success').

4.  **Ensure Default Behavior:** Verify that when the conditions for fullscreen are *not* met (e.g., Ctrl+F is pressed), the event listener does not interfere with the browser's default action (e.g., `event.preventDefault()` is not called inappropriately).

5.  **Testing:**
    *   Load a dataset page with a 3D model (e.g., dataset/100006).
    *   Confirm Ctrl+F opens the browser's find bar.
    *   Confirm Shift+F, Alt+F, Cmd+F do not toggle fullscreen.
    *   Activate the 3D model tab and wait for the model to load ('success' state).
    *   Press 'F' alone – verify it toggles fullscreen.
    *   Switch to another tab on the page.
    *   Press 'F' alone – verify it does *not* toggle fullscreen.
    *   Test on a page without a 3D model viewer (e.g., dataset/100020) to ensure no unintended side effects.
    *   Consider testing in different browsers (Chrome, Firefox).

6.  **Codebase Findings:**
    *   **Keyboard Handler:** The primary keyboard event listener is the `handleKeyDown` function located in `gigadb/app/client/js/model-viewer/ui/index.js` (around line 111).
    *   **Fullscreen Function:** The function responsible for toggling fullscreen is `toggleFullscreenMode` in `gigadb/app/client/js/model-viewer/ui/index.js` (around line 84). The logic modifications should occur *before* this function is called within `handleKeyDown` (around line 124).
    *   **Tab Active Check:** The target element for checking if the 3D model tab is active is the `div` with `id="3dmodels"` defined in `protected/views/dataset/view.php` (around line 568). The check should verify if this element has both the `visible` and `active` classes.
    *   **Model State:** The state indicating whether the model has loaded successfully ('success') is likely managed within `gigadb/app/client/js/model-viewer/ui/uiView.js`. The `handleKeyDown` function will need to query the state from this module.
    *   **Viewer HTML:** The HTML structure for the model viewer, including the fullscreen button (`.js-fullscreen-btn`), is defined in the partial view `protected/views/shared/_model_viewer.php`.
    *   **Initialization:** The model viewer JavaScript is initialized in `protected/views/shared/_model_viewer.php` (around line 135), which calls the entry point in `gigadb/app/client/js/model-viewer/index.js`.