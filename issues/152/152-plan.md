### Simplified dataset print view

Create a toggleable, printer-friendly variant of the dataset page that hides site chrome when `?print=true` is present.

- [x] **Add reusable `_printToggle.php` partial**
      Provides the Print/Web button and inline JS helper.
      - [ ] Create new file `protected/views/shared/_printToggle.php` with markup:
            ```php
            <button class="btn btn-default simplified-view-link" aria-label="Switch to print view">
              <span class="label-text">Print view</span>
            </button>
            <script>
              (function () {
                var url = new URL(window.location);
                var btn = document.querySelector('.simplified-view-link');
                var label = btn.querySelector('.label-text');
                function update(toPrint) {
                  document.body.classList.toggle('print', toPrint);
                  label.textContent = toPrint ? 'Web view' : 'Print view';
                }
                var isPrint = url.searchParams.get('print') === 'true';
                update(isPrint);
                btn.addEventListener('click', function () {
                  isPrint = !isPrint;
                  url.searchParams.set('print', isPrint);
                  history.replaceState(null, '', url);
                  update(isPrint);
                });
              })();
            </script>
            ```
      - [x] Ensure button uses existing `.btn` styling; keep script ≤ 15 LOC per outline.

- [ ] **Embed partial into dataset view template**
      Makes the toggle visible near the dataset title.
      - [x] In `protected/views/dataset/view.php` insert `<?php $this->renderPartial('application.views.shared._printToggle'); ?>` ~at line 16, inside the `.dataset-view-container` header DIV.
      - [x] Give surrounding div `class="pull-right"` so button aligns top-right.

- [ ] **Create `less/pages/dataset-print.less` stylesheet**
      Houses all print overrides.
      - [ ] Add file with content:
            ```less
            body.print {
              header,
              footer,
              .tabs,
              .table-settings-dialog,
              .sketchfab-3d,
              .model-3d {
                display: none !important;
              }
              .dataset-view-container { max-width: 100%; }
              .tab-content { display: block; }
            }
            @media print {
              a:after { content: " (" attr(href) ")"; font-size: 90%; }
            }
            ```

- [ ] **Import the new stylesheet**
      Ensures print rules are bundled after web rules.
      - [ ] In `less/index.less` add `@import "pages/dataset-print.less";` immediately after the existing `@import "pages/dataset.less";` (currently around line 41).

- [ ] Write or update tests
      Describe how to test the change.
      - [ ] Add Codeception functional test `tests/functional/PrintDatasetViewCest.php` that requests `/dataset/101001?print=true` and asserts header/footer absence and button label reads “Web view”.
