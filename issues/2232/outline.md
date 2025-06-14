**Task: Extend 3D Viewer Capabilities to VR (#2232)**

**Goal:** Integrate WebXR support into the existing `three.js`-based 3D model viewer to allow users with compatible devices to view models (STL, OBJ, PLY, LAS) in an immersive VR environment.

**Implementation Steps:**

1.  **Dependency & Setup:**
    *   Ensure the project's `three.js` version is recent enough to have stable WebXR support or update if necessary.
    *   Confirm necessary `three.js` modules for WebXR (like `WebXRManager`, `VRButton`, potentially controller handling modules) are available or add them.
2.  **UI Integration:**
    *   Identify the appropriate location within the 3D viewer's UI component(s) (likely near existing controls).
    *   Add a "View in VR" button.
    *   Implement logic to conditionally display this button only if `navigator.xr` exists and `navigator.xr.isSessionSupported('immersive-vr')` resolves to true.
    *   Utilize `three.js`'s `VRButton.createButton(renderer)` utility (or equivalent custom logic) to handle the VR session initiation when the button is clicked. Ensure the renderer (`renderer.xr.enabled = true`) is configured for XR *before* creating the button.
3.  **WebXR Rendering Loop:**
    *   Adapt the existing rendering/animation loop. Instead of `requestAnimationFrame`, use `renderer.setAnimationLoop(renderFunction)` which is required for WebXR compatibility.
    *   Ensure the `renderFunction` correctly renders the scene using the XR camera perspective when in an active VR session and the standard camera otherwise.
4.  **Model Presentation in VR:**
    *   Verify that the currently loaded model (regardless of format: STL, OBJ, PLY, LAS) is correctly positioned, scaled, and rendered when entering the VR session. Adjust default camera positioning/scaling for VR if necessary for a good initial viewing experience.
5.  **VR Interaction:**
    *   **Basic Rotation:** Headset rotation/movement should naturally control the camera perspective (usually handled by `three.js` WebXR integration).
    *   **Controller Interaction (Stretch Goal/Refinement):**
        *   Investigate adding `three.js`'s XR controller support (`renderer.xr.getController`).
        *   Implement basic interaction mapping (e.g., using thumbsticks or trigger buttons) for:
            *   Rotating the model around an axis.
            *   Scaling the model up/down.
            *   Panning/moving the model's position.
        *   Keep the interaction scheme simple and intuitive.
6.  **Testing:**
    *   Test on available WebXR-capable devices/browsers (e.g., Meta Quest Browser, Chrome/Edge on Desktop with SteamVR/Oculus Link, Safari on VisionOS if feasible).
    *   Verify seamless entry and exit from VR mode.
    *   Confirm standard desktop 3D viewer functionality remains unchanged.
    *   Test with different model types (STL, OBJ, PLY, LAS) to ensure compatibility.
7.  **Code Quality & Documentation:**
    *   Refactor code as needed for clarity and adherence to project standards (`style-guide.mdc`).
    *   Add comments explaining the WebXR-specific code sections.

---

**Relevant Files Analysis:**

Based on the task outline, the following files are relevant for implementing WebXR support:

1.  **`protected/views/shared/_model_viewer.php`**
    *   **Line 122:** (`importmap` script block) - Relevant for **Step 1 (Dependency & Setup)**. Check/update the `three.js` version and potentially add WebXR addons here.
    *   **Around Lines 28-49 or within the `.js-controls` div:** (HTML structure) - Relevant for **Step 2 (UI Integration)**. Add the "View in VR" button HTML here.

2.  **`gigadb/app/client/js/model-viewer/viewer/index.js`**
    *   **Function `createModelViewer` (Line 18):** Main viewer logic entry point.
    *   **Line 31:** (`renderer = createRenderer();`) - Relevant for **Step 1 & 2**. Need to enable `renderer.xr.enabled = true`.
    *   **Function `render` (Line 49):** Relevant for **Step 3 (WebXR Rendering Loop)**. Adapt to use `renderer.setAnimationLoop()` and handle VR/non-VR rendering.
    *   **Function `loadModel` (Line 53):** Relevant for **Step 4 (Model Presentation)**. Ensure model positioning/scaling works correctly in VR.
    *   **Consider adding a new method:** (e.g., `enterVR()`) to handle VR session initiation.

3.  **`gigadb/app/client/js/model-viewer/ui/index.js`**
    *   **Function `createUi` (Line 47):** Manages UI interactions.
    *   **Relevant section within `createUi`:** - Relevant for **Step 2 (UI Integration)**. Add logic to check XR support, show/hide the button, and handle its click event (calling the viewer's VR initiation method).

4.  **`gigadb/app/client/js/model-viewer/ui/uiView.js`**
    *   **Likely within the event listener setup:** Relevant for **Step 2 (UI Integration)**. Attach the event listener for the new VR button.

5.  **`gigadb/app/client/js/model-viewer/viewer/systems/renderer.js`**
    *   **Function `createRenderer` (Line 3):** Relevant for **Step 1 & 2**. Modifications needed to set `renderer.xr.enabled = true`.

6.  **`gigadb/app/client/js/model-viewer/viewer/systems/controls.js`**
    *   **Function `createControls` (Line 3):** Relevant for **Step 5 (VR Interaction)**. Need to manage enabling/disabling `OrbitControls` for VR mode.
    *   **Stretch Goal:** Implement controller interactions (`renderer.xr.getController`) here if pursued.

7.  **`gigadb/app/client/js/model-viewer/viewer/components/models/setupModel.js`**
    *   **Functions `centerGeometry`, `setupGeometry`, `setupLas` etc. (Lines 49-134):** Relevant for **Step 4 (Model Presentation)**. Review/adjust model scaling and positioning for the initial VR view.
