# VR Camera Pose Troubleshooting – Chat Summary  (2025-06-25)

*Issue ID:* #2232 – Extend 3D Viewer Capabilities to VR
*Participants:* @luistoptal, dev-assistant AI
*Context:* Loaded 3-D models appear **below eye-level** in WebXR sessions; desktop view is fine.

---

## 1  Initial Hypotheses & Fix Candidates
1. Pre-session camera offset
2. Camera-rig (`Group`) offset
3. Model translation
4. Scale-aware dynamic offset

A run-time switch (`vrFix`) was implemented to flip among these strategies via query param or Unleash flag.

## 2  Implementation & Tests
1. Added `vrFixStrategy.js` and wiring inside `viewer/index.js` (later removed).
2. Inserted camera-rig logic and verbose diagnostics (`logger`).
3. Added guard logs to `resizer.js` to catch forbidden `setSize()` calls during XR.

## 3  Diagnostic Log Highlights
```jsonc
// before session
isXRPresenting: false,
xrCamWorldPos: [0,0,0], cameraWorldPos: [5,5,5]

// after sessionstart
isXRPresenting: true,
xrCamWorldPos: [0,1.6,0], xrCamParentIsRig: true,
controlsTarget: [0,0,0], modelWorldPos: [0,0,0]
```
* Observed camera clone correctly inside rig and lifted by +1.6 m.
* Target remained at world origin – camera looked *straight down*.
* Browser supplied default **viewer** reference space (`local-floor` not requested), so origin already equals eye-level → the +1.6 m lift is wrong.
* `resizer.js` kept firing during XR, causing framebuffer errors (noise, not pose-related).

## 4  Conclusions Drawn
1. **Root cause now identified:** camera aimed downward due to fixed target; reference-space mismatch exacerbates height perception.
2. Proposed solution hierarchy:
   * (a) Switch renderer to `local-floor` reference space – rated 95 / 100.
   * (b) Keep rig but change target/forward offset – 75 / 100.
   * (c) Translate model instead of camera – 50 / 100.
3. Extra work on multi-strategy switch & offsets added complexity without fixing the issue.

## 5  Decision
Effort deemed *fruitless*; current code path complicates viewer logic and still requires the user to look down.  The team will pause this branch and re-evaluate a simpler approach (likely: adopt `local-floor` plus Z-offset, drop Y-offset logic).

### Clean-up Actions Suggested (not yet executed)
* Remove experimental `vrFix` switch and dead strategies.
* Revert logger/resizer patches once proper fix is tested.

---

_End of report_