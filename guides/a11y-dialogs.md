Let's synthesize the key takeaways from those sources and build an optimized, accessible tooltip pattern.

### The Single Most Important Rule

First, let's clarify the core principle that resolves 90% of the confusion in that GitHub thread:

**A true tooltip contains only non-interactive, supplemental information.**

If your "tooltip" needs to contain links, buttons, form elements, or rich content that the user must interact with, **it is not a tooltip**. It is a **Toggletip**, a **Menu**, or a **non-modal Dialog**. Using the correct pattern is crucial.

---

### Key Principles for an Accessible Tooltip

Based on the APG draft and the expert discussion, here are the non-negotiable principles for an optimized, accessible tooltip.

1.  **Use `aria-describedby`:** The trigger element (e.g., a button) should have `aria-describedby` pointing to the `id` of the tooltip element. This correctly associates the tooltip's content as a *description* for the trigger, which is what screen readers announce.
    *   **Why not `aria-label`?** `aria-label` *replaces* the trigger's accessible name. `aria-describedby` *appends* to it. For a "Settings" icon button, you want it announced as "Settings, button. *Provides additional information about settings.*", not just "*Provides additional information about settings.*"

2.  **The Trigger MUST Be Focusable:** This is a major point of failure. A keyboard user can only trigger a tooltip if they can `Tab` to the trigger element.
    *   **Best:** Use a naturally focusable element like `<button>` or `<a>`. A `<button>` is often the most semantically correct choice for an icon that reveals information.
    *   **Acceptable:** If you must use a non-interactive element like a `<span>`, you **must** add `tabindex="0"` to make it focusable.

3.  **Handle All Triggering and Dismissal Cases:** A robust tooltip works for everyone.
    *   **Mouse Enter / Leave:** Show on `mouseenter`, hide on `mouseleave`.
    *   **Focus In / Out:** Show on `focusin`, hide on `focusout`.
    *   **Escape Key:** The user must be able to press `Esc` at any time to dismiss the tooltip without moving focus. This is a WCAG requirement.

4.  **Hide the Tooltip Correctly:** The tooltip element should be hidden from both sighted users and assistive technology by default.
    *   Use `visibility: hidden` and `opacity: 0` instead of `display: none`. This allows for CSS transitions and can be better for performance, as it doesn't trigger a full page reflow.
    *   **Do not** use `aria-hidden="true"` on the tooltip when it's visible. `role="tooltip"` is sufficient for screen readers to understand its purpose.

5.  **Comply with WCAG 2.1 "Content on Hover or Focus" (1.4.13):**
    *   **Dismissible:** The tooltip can be dismissed without moving the pointer or focus (the `Esc` key handles this).
    *   **Hoverable:** The user can move their mouse pointer over the tooltip content without it disappearing. This is critical for users with screen magnifiers. (This is achieved with a small delay or by listening for `mouseleave` on both the trigger and the tooltip itself).
    *   **Persistent:** The tooltip remains visible until hover/focus is removed, it is dismissed, or the information is no longer valid.

---

### Optimized Pattern & Code Example

This example implements all the principles above. We'll use a `<button>` as the trigger for maximum accessibility out-of-the-box.

#### HTML

```html
<p>
  Need help? Click or hover the
  <span class="tooltip-container">
    <!--
      The trigger element.
      - A <button> is focusable by default.
      - aria-describedby links it to the tooltip content.
    -->
    <button class="tooltip-trigger" aria-describedby="tooltip-1">
      Help Icon
    </button>

    <!--
      The tooltip content.
      - It has a unique ID to be referenced by the trigger.
      - role="tooltip" tells screen readers what it is.
      - It's hidden by default via the 'hidden' class.
    -->
    <span role="tooltip" id="tooltip-1" class="tooltip-content hidden">
      This is some helpful, non-interactive information.
    </span>
  </span>
  for more information.
</p>
```
*Note: I've wrapped them in a `<span>` with relative positioning to make CSS positioning easier.*

#### CSS

```css
.tooltip-container {
  position: relative;
  display: inline-block;
}

/* Style the trigger button as needed */
.tooltip-trigger {
  border: 1px dashed blue;
  border-radius: 4px;
  cursor: help;
}

.tooltip-content {
  /* Positioning */
  position: absolute;
  bottom: 125%; /* Position above the trigger */
  left: 50%;
  transform: translateX(-50%);

  /* Styling */
  background-color: #333;
  color: #fff;
  padding: 8px 12px;
  border-radius: 4px;
  width: max-content; /* Adjust width to content */
  max-width: 250px; /* Prevent it from being too wide */
  z-index: 10;

  /* Animation / Hiding */
  visibility: hidden;
  opacity: 0;
  transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;
}

.tooltip-content.visible {
  visibility: visible;
  opacity: 1;
}

/* Hide the tooltip by default from screen readers until it is shown */
.tooltip-content.hidden {
   visibility: hidden;
}
```

#### JavaScript

This is the most critical part for getting the behavior right.

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const triggers = document.querySelectorAll('.tooltip-trigger');

  const showTooltip = (trigger) => {
    const tooltipId = trigger.getAttribute('aria-describedby');
    const tooltip = document.getElementById(tooltipId);
    if (tooltip) {
      tooltip.classList.remove('hidden');
      tooltip.classList.add('visible');
    }
  };

  const hideTooltip = (trigger) => {
    const tooltipId = trigger.getAttribute('aria-describedby');
    const tooltip = document.getElementById(tooltipId);
    if (tooltip) {
      tooltip.classList.remove('visible');
      tooltip.classList.add('hidden');
    }
  };

  triggers.forEach(trigger => {
    // Show on hover
    trigger.addEventListener('mouseenter', () => showTooltip(trigger));
    // Show on focus
    trigger.addEventListener('focus', () => showTooltip(trigger));

    // Hide on mouse out
    trigger.addEventListener('mouseleave', () => hideTooltip(trigger));
    // Hide on focus out
    trigger.addEventListener('blur', () => hideTooltip(trigger));

    // Hide with Escape key
    trigger.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        hideTooltip(trigger);
      }
    });
  });
});
```

---

### What to Do For "Interactive Tooltips"?

If you need interactive content, you are building a **Toggletip** or **Non-Modal Dialog**.

**High-level implementation:**
1.  **Trigger:** A `<button>` is still the best choice.
2.  **ARIA for Trigger:** Use `aria-haspopup="dialog"` and `aria-expanded="false"`. On click, toggle `aria-expanded` between `true` and `false`.
3.  **Popup Container:** The popup should have `role="dialog"`, `aria-labelledby` pointing to its title, and be hidden by default.
4.  **Interaction:**
    *   It is shown/hidden **on click**, not hover.
    *   When the popup opens, focus should be programmatically moved to the first interactive element inside it.
    *   The `Esc` key should close the popup and return focus to the trigger button.
    *   Focus must be "trapped" inside the popup so a user can't `Tab` out of it accidentally.

This is a more complex pattern, and you can find official guidance under the [APG Dialog (Modal) Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/).