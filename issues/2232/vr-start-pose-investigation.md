# Investigation Report – Incorrect Camera Start Pose in WebXR

*Issue ID:* #2232 – Extend 3D Viewer Capabilities to VR
*Date:* 2025-06-24
*Author:* dev-assistant (with @luistoptal)

---

## 1. Problem Statement
When entering VR (WebXR) mode the loaded model appears **below eye-level and too close**, forcing users to look down. Desktop/2-D view is unaffected.

## 2. Debugging Steps Taken

1. **Initial hypothesis** – wrong camera position only for XR sessions.
2. Added an event hook (`attachVrListeners`) in `viewer/components/camera.js` to:
   * Listen for `sessionstart` / `sessionend` emitted by `renderer.xr`.
   * Apply a pose `position = (0 m, 1.6 m, 2 m)` at session start.
   * Restore desktop pose on session end.
3. Added verbose console logging via existing `logger` helper.  Key lines:

   ```js
   logger('info', 'XR session started – applying VR pose');
   // One frame later…
   const xrCam = renderer.xr.getCamera();
   logger('debug', 'Our camera position', {...});
   logger('debug', 'XR internal camera position', {...});
   ```

4. **Live test** on Meta Quest browser & Vision Pro Safari.
5. Collected console output (excerpt):

   ```text
   DEBUG attachVrListeners: adding sessionstart & sessionend handlers
   INFO  WebXRManager.onSessionStart: XR session started – applying VR pose
   DEBUG Our camera position           { pos: [0, 1.6, 2], rot: [...] }
   DEBUG XR internal camera position   { pos: [ 0.0, 0.0, 0.0 ], rot: [...] }
   ```

## 3. Findings

1. **Event listeners fire correctly** – log shows handler executes on `sessionstart`.
2. **Our PerspectiveCamera is updated** – `pos: (0, 1.6, 2)` confirms pose applied.
3. **`renderer.xr.getCamera()` (internal XR camera) stays unchanged** – still at (0, 0, 0).
4. Rendering in XR uses **the internal XR camera**, not the original one.  Therefore visual pose does not update despite code running.
5. Three-JS documentation indicates that on `setSession()` the renderer **creates a cloned camera** and subsequently updates it every frame from headset tracking.  Later changes to the original camera are ignored.

## 4. Root Cause
Attempting to reposition the *original* camera after a WebXR session starts has no effect, because Three-JS renders with a *cloned XR camera* whose transform is overridden every frame by the XR device.

## 5. Recommended Fix Options

1. **Apply offset before session starts**
   * Move the camera *immediately before* calling `renderer.xr.setSession()` (i.e. inside the VRButton click flow) so the cloned camera inherits the correct pose.
2. **Use a camera-rig `Group`**
   * Create a `Group` (aka "cameraRig") that contains the camera.
   * Add the rig to the scene and move the *rig* on `sessionstart`; the headset then modifies the camera's local transform while the rig provides a global offset.
3. **Translate the entire model**
   * Leave camera at (0,0,0); instead translate the root model `Object3D` downwards/away so it appears centred at eye-level and ~2 m distant.
4. **Scale-aware offset** (optional)
   * Combine option 2 or 3 with model bounding-box size to derive a dynamic offset for extremely large/small models.

## 6. Next Steps

* Decide on the preferred solution (rig vs model translation vs pre-session offset).
* Implement & retest on Quest / Vision Pro.
* Update documentation and acceptance tests accordingly.

---

_End of report_