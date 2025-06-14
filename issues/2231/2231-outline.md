# Task Outline: Add BlueSky Social Icon to Header & Footer

## 1. Goal
Add a BlueSky call-to-action (CTA) to every GigaDB web page so users can follow GigaScience on the BlueSky platform.

## 2. BlueSky Account & URL
* Username: `@gigascience.bsky.social`
* Link URL: `https://bsky.app/profile/gigascience.bsky.social`

## 3. Icon Asset & Styling
* Use font-awesome 4 BlueSky icon if available, and match the current single-colour social icons.
* Dimensions: 24 × 24 px (same as existing icons).
* Colour: inherit the current icon colour (CSS class already applied to social icons).
* If fa4 icon not available, user will provide SVG asset in `images/icons/bsky.svg`

## 4. Placement
* Header: insert the BlueSky icon immediately to the **right of the Twitter/X icon** inside the social-media icon group.
* Footer: insert the BlueSky icon **next to the Twitter/X icon**, mirroring header order.
* Maintain existing spacing and hover styles.

## 5. Behaviour
* Clicking the icon opens the BlueSky profile **in a new tab/window** using `target="_blank"` and `rel="noopener noreferrer"`, mirroring behaviour of other social links.

## 6. Accessibility
* Add `aria-label="Follow GigaScience on BlueSky"` (pattern consistent with other icons).
* Include `<span class="sr-only">BlueSky</span>` if screen-reader helper spans are used elsewhere.

## 7. Feature Flags
* **No** Unleash flag required; deploy directly.

## 8. Code Touchpoints
1. **Header:** `protected/views/layouts/_header.php` (or equivalent partial)
2. **Footer:** `protected/views/layouts/_footer.php` (or equivalent partial)
3. **Assets:** update icon bundle or sprite sheet and import `bsky.svg`.
4. **Styles:** if needed, add `.icon-bsky` rule in the SMACSS "module-social" Less file.

## 9. Testing
* **Unit/Functional:** review existing unit tests for social media icons. If they exist, add Bluesky check.
* **Acceptance:** review existing unit tests for social media icons. If they exist, add Bluesky check.
* **Accessibility:** Run axe-core scan to confirm no new violations.

## 10. Acceptance Criteria (Restated)
1. Given any GigaDB page, when I view the header, I see a BlueSky icon linked to `@gigascience.bsky.social`.
2. Given any GigaDB page, when I view the footer, I see the same BlueSky icon linked appropriately.

## 11. Codebase Review – Existing Social-Icon Touchpoints

| File | Key Lines | Why It Matters |
| --- | --- | --- |
| `protected/views/shared/_topBar.php` | 55-68 | Renders the header's social-media `<ul class="share-zone"> … </ul>`. Insert the BlueSky `<li>` immediately after the existing Twitter/X item (`x.com/GigaScience`). |
| `protected/views/shared/_footer.php` | 19-32 | Renders the footer's social-media `<ul class="footer-social"> … </ul>`. Add the BlueSky `<li>` right after the Twitter/X item to mirror header order. |
| `images/icons/` (directory) | — | SVG assets for non-FontAwesome icons live here (`x-logo.svg`, `mastodon-logo.svg`). Place new file `bsky-logo.svg` here if Font Awesome 4 lacks a BlueSky glyph. |
| `less/modules/sharezone.less` | 1-40 | Styles the header's `.share-zone` icons (size, hover, spacing). No changes expected—new `<li>` will inherit these rules. |
| `less/layout/basefooterbar.less` | 80-130 | Styles the footer's `.footer-social` components. The new icon inherits the same block/hover rules; update only if custom tweaks are required. |

These sections collectively define where markup, styling, and assets for the BlueSky CTA must be integrated so it appears consistently in both header and footer.