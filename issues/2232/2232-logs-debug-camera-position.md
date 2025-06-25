jquery.min.js:2 [Violation] 'setTimeout' handler took 73ms
logger.js:34 [2025-06-25 05:18:18] INFO (applyVrFix): VR Diagnostic {
    "strategy": "camera-rig",
    "isXRPresenting": false,
    "xrCamWorldPos": [
        0,
        0,
        0
    ],
    "xrCamParentIsRig": false,
    "cameraWorldPos": [
        5,
        5,
        5.000000000000001
    ],
    "rigWorldPos": null,
    "controlsTarget": [
        0,
        0,
        0
    ],
    "modelWorldPos": [
        0,
        0,
        0
    ],
    "bboxHeight": 2.965164872834671
}
three.module.js:16 [Violation] 'requestAnimationFrame' handler took 83ms
VRButton.js:93 Unsupported feature requested: layers
button.onclick @ VRButton.js:93Understand this warning
logger.js:34 [2025-06-25 05:18:20] INFO (WebXRManager.onXRSessionStart): XR Session Started {}
logger.js:34 [2025-06-25 05:18:20] INFO (applyVrFix): VR Diagnostic {
    "strategy": "camera-rig",
    "isXRPresenting": true,
    "xrCamWorldPos": [
        0,
        1.6,
        0
    ],
    "xrCamParentIsRig": true,
    "cameraWorldPos": [
        5,
        5,
        5.000000000000001
    ],
    "rigWorldPos": [
        0,
        1.6,
        0
    ],
    "controlsTarget": [
        0,
        0,
        0
    ],
    "modelWorldPos": [
        0,
        0,
        0
    ],
    "bboxHeight": 2.965164872834671
}
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
setSize @ resizer.js:8
(anonymous) @ resizer.js:37
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
WebGLRenderer.setPixelRatio @ three.module.js:15179
setSize @ resizer.js:9
(anonymous) @ resizer.js:37
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
logger.js:40 [2025-06-25 05:18:20] WARN (setSize): setSize invoked while XR is presenting
logger @ logger.js:40
setSize @ resizer.js:12
(anonymous) @ resizer.js:37
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
three.module.js:15533 WebGL: INVALID_FRAMEBUFFER_OPERATION: clear: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
WebGLRenderer.clear @ three.module.js:15533
render @ three.module.js:1363
WebGLRenderer.render @ three.module.js:16221
render @ index.js:144
(anonymous) @ resizer.js:38
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
render @ three.module.js:2187
WebGLRenderer.renderBufferDirect @ three.module.js:15843
renderObject @ three.module.js:16607
renderObjects @ three.module.js:16576
renderScene @ three.module.js:16419
WebGLRenderer.render @ three.module.js:16227
render @ index.js:144
(anonymous) @ resizer.js:38
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
render @ three.module.js:2187
WebGLRenderer.renderBufferDirect @ three.module.js:15843
renderObject @ three.module.js:16607
renderObjects @ three.module.js:16576
renderScene @ three.module.js:16419
WebGLRenderer.render @ three.module.js:16227
render @ index.js:144
(anonymous) @ resizer.js:38
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:20Understand this warning
100006:1 [.WebGL-0x6a01235c00]GL ERROR :GL_INVALID_OPERATION : DoCreateAndTexStorage2DSharedImageINTERNAL: invalid mailbox nameUnderstand this warning
100006:1 [.WebGL-0x6a01235c00]GL ERROR :GL_INVALID_OPERATION : DoBeginSharedImageAccessCHROMIUM: bound texture is not a shared imageUnderstand this warning
100006:1 [.WebGL-0x6a01235c00]GL ERROR :GL_INVALID_OPERATION : glFramebufferTexture2DMultisample: Attachment textarget doesn't match texture targetUnderstand this warning
100006:1 [.WebGL-0x6a01235c00]GL ERROR :GL_INVALID_OPERATION : DoEndSharedImageAccessCHROMIUM: bound texture is not a shared imageUnderstand this warning