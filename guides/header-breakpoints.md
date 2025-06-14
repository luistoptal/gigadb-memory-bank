# Header Breakpoints and Responsive Behaviour

This guide documents where and how the desktop and mobile headers are toggled in the GigaDB front-end stylesheets.

---

## 1. Global breakpoint variables

The Less variables that control responsive ranges are declared in `less/base/breakpoints.less`:

```less
@screen-md-min: 992px;     // Desktop ≥ 992 px
@screen-sm-max: (@screen-md-min - 1);  // Mobile / tablet ≤ 991 px
@screen-md-max: (@screen-lg-min - 1);  // 1199 px upper-bound helper
```

## 2. Main navigation

* **Desktop menu (`.main-nav-bar`)** is visible by default and hidden at **≤ 991 px**.
* **Hamburger button (`.navbar-toggle`)** is shown at the same ≤ 991 px breakpoint.

```less
// less/modules/navs.less
@media (max-width: @screen-sm-max) {
  .main-nav-bar { display: none; }
  .navbar-toggle { display: block; }
}
```

## 3. Mobile off-canvas menu

The overlay menu (`.mobile-navigation`) is enabled only below the desktop threshold. From **≥ 992 px** it is forcibly hidden to prevent overlap with the desktop bar.

```less
// less/modules/mobile-nav.less
@media (min-width: @screen-md-min) {
  .mobile-navigation { display: none !important; }
}
```

## 4. Top-bar search field swap

Within the slim green top bar, the full search bar hides slightly earlier to keep space on small laptops/tablets, switching at **≤ 1199 px**.

```less
// less/layout/basetopbar.less
@media (max-width: @screen-md-max) {
  .base-top-bar .top-bar-left .search-bar { display: none; }
  .base-top-bar .search-bar-mobile        { display: block; }
}
```

## 5. Breakpoint summary

| Viewport width | Header state |
|----------------|--------------|
| ≥ 992 px       | Desktop header: `.main-nav-bar` visible, hamburger hidden, mobile nav disabled |
| 992 px > w > 768 px | Mobile header active (same breakpoints as phones) |
| ≤ 991 px       | Mobile header: desktop menu removed, hamburger & off-canvas nav active |
| ≤ 1199 px      | (Aux) desktop top-bar search switches to compact mobile version |

> Note: Tablet widths (768 – 991 px) already fall under the *mobile* header rules, so the same hamburger/off-canvas flow is applied.

---

Last updated: <!-- placeholder, will be replaced by CI or manually -->