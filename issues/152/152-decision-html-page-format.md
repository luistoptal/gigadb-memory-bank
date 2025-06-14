# Decision: Simplified Dataset View will be an HTML Page

**Context**: Issue #152 explores creating a "simplified" representation of a dataset page. Two technical approaches were considered:

1. Serve a dedicated HTML page (e.g. `/dataset/<id>/simplified`).
2. Generate and return an RTF document (e.g. `/dataset/<id>.rtf`).

**Decision**: We will implement the simplified view as a *standard HTML page*.

## Rationale

* **Reuse & Maintainability** – The HTML option allows us to share Yii partials and existing CSS, keeping layout changes DRY and eliminating a parallel RTF template that would easily drift out-of-date.
* **Accessibility** – HTML lets us meet WCAG 2.2 AA via semantic markup. RTF has no native support for alt-text or landmarks, so accessibility would suffer.
* **No Extra Dependencies** – HTML relies on existing rendering pipelines; RTF would add a library such as `PHPRtfLite` and new build/test overhead.
* **Printability** – With a dedicated `@media print` stylesheet we can guarantee high-fidelity printing while still providing a live, link-enabled web page.
* **User Experience** – Users can copy/paste, link, and print directly from the browser. If a document file is needed, browsers already offer "Save as PDF/RTF".

## Consequences

* URL pattern will be `/dataset/<id>/simplified` (exact route to be confirmed during implementation).
* A new view template (and likely a new `actionSimplified` in `DatasetController`) will be introduced.
* We will create/adjust print-specific CSS rules.
* The implementation work will *not* include any RTF generation. Any future need for downloadable documents will be handled as a separate enhancement.

---
*Date*: 2025-06-14
*Author*: AI assistant on behalf of product owner