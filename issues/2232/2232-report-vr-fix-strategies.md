# No fix

https://live-mildly-cockatoo.ngrok-free.app/dataset/100006

In VR, I have to "look down" to see the model

Console logs:

```
VRButton.js:93 Unsupported feature requested: layers
button.onclick @ VRButton.js:93Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
setSize @ resizer.js:7
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
WebGLRenderer.setPixelRatio @ three.module.js:15179
setSize @ resizer.js:8
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15533 WebGL: INVALID_FRAMEBUFFER_OPERATION: clear: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
WebGLRenderer.clear @ three.module.js:15533
render @ three.module.js:1363
WebGLRenderer.render @ three.module.js:16221
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
render @ three.module.js:2187
WebGLRenderer.renderBufferDirect @ three.module.js:15843
renderObject @ three.module.js:16607
renderObjects @ three.module.js:16576
renderScene @ three.module.js:16419
WebGLRenderer.render @ three.module.js:16227
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
```

# pre-session-offset

I still need to look down, but the model appears in a different position-- as if it's closer to the camera than "no fix"

Console logs:

```
[Violation] 'requestAnimationFrame' handler took 87ms
VRButton.js:93 Unsupported feature requested: layers
```

# camera-rig

I need to look down similar to "no fix"

Console logs:

```
[Violation] 'requestAnimationFrame' handler took 124ms
VRButton.js:93 Unsupported feature requested: layers
button.onclick @ VRButton.js:93Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
setSize @ resizer.js:7
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
WebGLRenderer.setPixelRatio @ three.module.js:15179
setSize @ resizer.js:8
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15533 WebGL: INVALID_FRAMEBUFFER_OPERATION: clear: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
WebGLRenderer.clear @ three.module.js:15533
render @ three.module.js:1363
WebGLRenderer.render @ three.module.js:16221
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
render @ three.module.js:2187
WebGLRenderer.renderBufferDirect @ three.module.js:15843
renderObject @ three.module.js:16607
renderObjects @ three.module.js:16576
renderScene @ three.module.js:16419
WebGLRenderer.render @ three.module.js:16227
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback
```

# model-translate

I need to look down similar to "no fix"

Console logs:

```
[Violation] 'requestAnimationFrame' handler took 82ms
VRButton.js:93 Unsupported feature requested: layers
button.onclick @ VRButton.js:93Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
setSize @ resizer.js:7
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
```

# scale-aware

I need to look down similar to "no fix"

Console logs:

```
[Violation] 'requestAnimationFrame' handler took 88ms
VRButton.js:93 Unsupported feature requested: layers
button.onclick @ VRButton.js:93Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
setSize @ resizer.js:7
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15208 THREE.WebGLRenderer: Can't change size while VR device is presenting.
WebGLRenderer.setSize @ three.module.js:15208
WebGLRenderer.setPixelRatio @ three.module.js:15179
setSize @ resizer.js:8
(anonymous) @ resizer.js:32
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:15533 WebGL: INVALID_FRAMEBUFFER_OPERATION: clear: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
WebGLRenderer.clear @ three.module.js:15533
render @ three.module.js:1363
WebGLRenderer.render @ three.module.js:16221
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
render @ three.module.js:2187
WebGLRenderer.renderBufferDirect @ three.module.js:15843
renderObject @ three.module.js:16607
renderObjects @ three.module.js:16576
renderScene @ three.module.js:16419
WebGLRenderer.render @ three.module.js:16227
render @ index.js:108
(anonymous) @ resizer.js:33
(anonymous) @ debounce.js:29
setTimeout
debouncedFn @ debounce.js:27
(anonymous) @ resizer.js:15Understand this warning
three.module.js:2187 WebGL: INVALID_FRAMEBUFFER_OPERATION: drawArrays: Cannot render to a XRWebGLLayer framebuffer outside of an XRSession animation frame callback.
```