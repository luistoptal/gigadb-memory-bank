# Pull request for issue: #2232

This is a pull request for the following functionalities:

*   Extend the 3D model viewer with WebXR (VR) capabilities using Three.js.
*   Add a VR button to enter immersive VR mode for supported devices/browsers.
*   Update Three.js library from v0.170.0 to v0.175.0.
*   Integrate `VRButton` from Three.js examples.
*   Adjust `OrbitControls` to disable interaction during active VR sessions.
*   Refactor the rendering loop using `renderer.setAnimationLoop` for WebXR compatibility.
*   Update `.gitignore` to exclude Cursor IDE files and `memory-bank`.

## How to test?

1.  Navigate to a dataset page containing 3D models (e.g., `/dataset/view/id/100007`).
2.  Verify that the 3D model viewer loads and functions correctly (model selection, rotation, zoom).
3.  If using a WebXR-compatible browser (like Chrome or Firefox on a VR-ready system or headset), check for the appearance of a "VR" button within the viewer canvas area.
4.  **(Current Implementation Note):** Clicking the VR button should log messages to the browser's developer console indicating a VR session was requested. Full VR interaction is likely pending further development.
5.  Verify that standard mouse/touch controls (`OrbitControls`) work as expected when *not* in VR mode. (Future testing should confirm they are disabled *during* VR).

## How have functionalities been implemented?

*   Enabled the `renderer.xr` module in the Three.js `WebGLRenderer`.
*   Utilized `VRButton.createButton(renderer)` from `three/addons/webxr/VRButton.js` to automatically add a VR entry button to the DOM when WebXR is supported.
*   Passed the `renderer` instance through the `model-viewer` modules (`index.js`, `ui/index.js`, `viewer/index.js`, `viewer/systems/controls.js`) to allow access to XR capabilities and state.
*   Modified `viewer/systems/controls.js` to listen for `sessionstart` and `sessionend` events on `renderer.xr` and disable/enable `OrbitControls` accordingly.
*   Replaced the previous `requestAnimationFrame`-based render loop trigger (`controls.addEventListener("change", render)`) with `renderer.setAnimationLoop()`, which is the standard approach for handling rendering in WebXR applications.
*   Updated the Three.js importmap URLs in `_model_viewer.php` to point to version 0.175.0.
*   Added `.cursor*` and `memory-bank/` entries to `.gitignore`.

## Any issues with implementation? [optional]

*   The current implementation of the VR button click handler (`handleVR` in `ui/index.js`) only logs to the console. Actual VR scene presentation and interaction logic will need further development.

## Any changes to automated tests? [optional]

None indicated in the provided diff.

## Any changes to documentation? [optional]

None indicated in the provided diff.

## Any technical debt repayment? [optional]

*   Refactoring the render loop to use `renderer.setAnimationLoop` improves compatibility with WebXR standards.
*   Updating the Three.js dependency keeps the library up-to-date.

## Any improvements to CI/CD pipeline? [optional]

None indicated in the provided diff.