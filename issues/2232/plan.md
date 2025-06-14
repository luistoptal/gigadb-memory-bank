# Extend 3D Viewer Capabilities to VR (#2232)

## User story description
Integrate WebXR support into the existing `three.js`-based 3D model viewer to allow users with compatible devices to view models (STL, OBJ, PLY, LAS) in an immersive VR environment.

## User story completion requirements
- A "View in VR" button appears in the 3D viewer UI only if the user's browser and device support WebXR immersive VR sessions.
- Clicking the VR button successfully initiates and enters a WebXR session.
- The currently loaded 3D model (STL, OBJ, PLY, or LAS) is displayed correctly within the VR environment upon session entry.
- Users can naturally look around the model using headset rotation and movement.
- Exiting the VR session returns the user seamlessly to the standard desktop 3D viewer.
- The standard desktop 3D viewer functionality remains unaffected by the addition of VR features.
- Controller-based interactions (rotation, scaling, panning) are implemented as a stretch goal.
- The implementation adheres to project coding standards and includes relevant comments for WebXR-specific code.
- Comprehensive testing confirms functionality across supported devices/browsers and model types.

## Tasks
- [ ] **Dependency & Setup**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [x] Review the current `three.js` version listed in `protected/views/shared/_model_viewer.php`'s importmap.
      - [x] If the version is too old for stable WebXR, update it in the importmap and check for any breaking changes in the existing viewer code.
      - [x] Verify if necessary WebXR modules (`WebXRManager`, `VRButton`) are included or implicitly available in the used `three.js` version. If not, add them explicitly to the importmap.
      - [x] Modify `gigadb/app/client/js/model-viewer/viewer/systems/renderer.js` within the `createRenderer` function to set `renderer.xr.enabled = true`.
    - suggest how to test the implementation:
      - Check the browser console for errors related to `three.js` loading after changes.
      - Manually inspect the `renderer.xr` object in the browser's developer console after initialization to confirm it's enabled.

- [ ] **UI Integration**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [x] Add an HTML button element (e.g., `<button id="vr-button">View in VR</button>`) within the viewer controls section (likely inside the `.js-controls` div) in `protected/views/shared/_model_viewer.php`.
      - [x] In `gigadb/app/client/js/model-viewer/ui/index.js` (within `createUi` or a new dedicated function), add JavaScript logic to check for WebXR support using `navigator.xr && navigator.xr.isSessionSupported('immersive-vr')`.
      - [x] Conditionally show or hide the `#vr-button` based on the support check result.
      - [x] In `gigadb/app/client/js/model-viewer/ui/uiView.js` (or `ui/index.js`), attach an event listener to the `#vr-button`.
      - [x] Implement the VR session initiation logic within the `#vr-button`'s click event listener. Choose one of the following approaches:
        - [x] **Approach A (Easier): Use `three.js`'s `VRButton.createButton`:**
          - Modify the UI setup code (in `ui/index.js` or `ui/uiView.js`) to receive the `renderer` instance created in `viewer/index.js`.
          - Call `const vrButton = VRButton.createButton(renderer);`.
          - Append the returned `vrButton` element to the document's body or a suitable container in your UI (it might replace your original `#vr-button` or you might hide your button and just use this one). This button handles its own click events internally to start/stop the VR session.
        - [-] **Approach B (More Control): Use `navigator.xr.requestSession`:**
          - Ensure the click listener function has access to the `renderer` instance from `viewer/index.js`.
          - Inside the listener, call `navigator.xr.requestSession('immersive-vr')`.
          - If the request is successful (returns a promise that resolves with an `XRSession`), call `await renderer.xr.setSession(session)` to link the session to the `three.js` renderer.
          - Add logic to handle potential errors during session requests.
          - Add an event listener to the `session` object for the `'end'` event to know when the user exits VR, so you can clean up or revert any necessary states (e.g., re-enable OrbitControls).
    - suggest how to test the implementation:
      - Load the viewer page on a browser/device *without* WebXR support and verify the button is hidden.
      - Load the viewer page on a browser/device *with* WebXR support (e.g., Quest Browser, Desktop Chrome with SteamVR) and verify the button is visible.
      - Click the button and confirm the browser prompts for VR session permission or enters VR mode.

- [ ] **WebXR Rendering Loop**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [x] Locate the existing animation loop logic in `gigadb/app/client/js/model-viewer/viewer/index.js` (likely using `requestAnimationFrame` within or called by the `render` function).
      - [x] Replace the `requestAnimationFrame` call with `renderer.setAnimationLoop(renderFunction)`, passing the existing `render` function (or a wrapper). `three.js`'s `setAnimationLoop` handles the differences between standard and XR rendering loops.
      - [x] Ensure the `render` function continues to use the standard camera and scene for rendering, as `three.js`'s WebXRManager typically handles switching to the XR camera automatically when a session is active.
    - suggest how to test the implementation:
      - Verify the standard desktop view still animates correctly.
      - Enter VR mode and confirm the scene renders and updates based on headset movement.
      - Check performance in both desktop and VR modes.

- [ ] **Model Presentation in VR**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [ ] Review the model loading and positioning logic in `gigadb/app/client/js/model-viewer/viewer/components/models/setupModel.js` (functions like `centerGeometry`, `setupGeometry`).
      - [ ] Enter VR mode with various models (STL, OBJ, PLY, LAS).
      - [ ] Assess the initial viewing scale and position. If models appear too large, too small, or off-center, adjust the scaling or centering logic specifically for the VR context, or adjust the initial VR camera rig position relative to the scene origin. This might involve setting a different default zoom/position if `renderer.xr.isPresenting` is true.
    - suggest how to test the implementation:
      - Load each supported model type (STL, OBJ, PLY, LAS).
      - Enter VR mode for each model.
      - Verify the model is visible, reasonably sized, and centered in the initial view.

- [ ] **VR Interaction (Basic)**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [x] Most basic head-based rotation/perspective change is handled automatically by `three.js`'s `WebXRManager` and the `setAnimationLoop`.
      - [x] In `gigadb/app/client/js/model-viewer/viewer/systems/controls.js`, modify `createControls` or the update logic to disable `OrbitControls` when a VR session is active (`renderer.xr.isPresenting === true`) to prevent conflicting inputs. Re-enable them upon exiting VR.
    - suggest how to test the implementation:
      - Enter VR mode.
      - Move your head around (rotate, look up/down, lean side-to-side) and confirm the view updates accordingly.
      - Verify mouse/touch interactions (orbit, pan, zoom) are disabled in VR.
      - Exit VR mode and verify `OrbitControls` work again.

- [ ] **VR Interaction (Stretch Goal: Controller)**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [ ] In `gigadb/app/client/js/model-viewer/viewer/index.js` or `systems/controls.js`, use `renderer.xr.getController(0)` and `renderer.xr.getController(1)` to get controller objects. Add them to the scene.
      - [ ] Add event listeners to the controllers for events like `selectstart`, `selectend`, `squeezestart`, `squeezeend`, or axis changes.
      - [ ] In `systems/controls.js`, implement logic within the controller event listeners or the main update loop (`renderFunction`) to:
        - [ ] Rotate the loaded model (the `Object3D` containing the mesh) based on thumbstick input or button presses.
        - [ ] Scale the model based on trigger squeeze or button combinations.
        - [ ] Pan/move the model's position based on thumbstick input or grip buttons.
      - [ ] Add visual feedback if possible (e.g., showing controller models, laser pointers).
    - suggest how to test the implementation:
      - Enter VR with controllers active.
      - Test each implemented interaction (rotate, scale, pan) using the designated controller inputs.
      - Ensure interactions feel intuitive and responsive.

- [ ] **Testing**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [ ] Test VR entry/exit flow on Meta Quest Browser.
      - [ ] Test VR entry/exit flow on Desktop Chrome/Edge with SteamVR or Oculus Link enabled.
      - [ ] If feasible, test on Safari with VisionOS.
      - [ ] Verify standard desktop viewer controls (orbit, zoom, pan) are unchanged and fully functional.
      - [ ] Load and view models of each type (STL, OBJ, PLY, LAS) in both desktop and VR modes.
      - [ ] Perform regression testing on existing viewer features.
    - suggest how to test the implementation:
      - Follow a structured test plan covering all requirements and supported platforms/models. Document results.

- [ ] **Code Quality & Documentation**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [ ] Review all new/modified code for adherence to project JavaScript standards (`javascript-rules`, `style-guide.mdc`).
      - [ ] Refactor complex sections for clarity (e.g., VR setup, controller logic).
      - [ ] Add JSDoc comments explaining WebXR-specific functions, checks, and configurations.
    - suggest how to test the implementation:
      - Run any configured linters/formatters.
      - Perform a code review with another developer.

- [ ] **Write Acceptance Tests**
  - briefly outline the following:
    - how to implement it step by step with subtasks:
      - [ ] Identify key user flows: viewing model normally, seeing VR button (if supported), entering VR, looking around in VR, exiting VR.
      - [ ] Write acceptance tests (e.g., using Codeception) to simulate these flows.
      - [ ] For VR-specific steps that cannot be easily automated (like checking display within a headset), the acceptance test might need to focus on automatable parts:
        - [ ] Check for the VR button's conditional visibility based on mocking `navigator.xr`.
        - [ ] Verify clicking the button triggers the expected JavaScript function calls (mocking session request/start if needed).
        - [ ] Check that `OrbitControls` are disabled/enabled appropriately based on mocked VR state.
    - suggest how to test the implementation:
      - Run the acceptance tests locally and in CI.
      - Manually supplement with tests on actual VR hardware as automated VR testing is limited.
