### Simplified dataset view implementation

Provide commit-level steps to add the printer-friendly simplified dataset view for issue 152.

- [ ] **Add specific URL rule for simplified view**
      Routes `/dataset/<id>/simplified` before the generic dataset rule so the request hits the new action.
      - [ ] Insert `'/dataset/<id:\\d+>/simplified' => 'dataset/simplified/id/<id>',` at ~line 157 of `protected/config/main.php`, above the existing `/dataset/<id>` mapping.
      - [ ] Add inline comment `// simplified dataset view` immediately after the rule.
- [ ] **Extend DatasetController with access and action**
      Enables public access and renders the simplified page.
      - [ ] In `protected/controllers/DatasetController.php`, append `'simplified'` to the `accessRules()` allow array.
      - [ ] After `actionView()` (~line 165), add:
        ```php
        public function actionSimplified($id)
        {
            $model = $this->loadModel($id);
            $this->render('simplified', ['model' => $model]);
        }
        ```
- [ ] **Create simplified dataset view file**
      Renders only the key dataset elements listed in the outline.
      - [ ] New file `protected/views/dataset/simplified.php` starting with `$this->layout = '//layouts/print';`.
      - [ ] Echo DOI, release date, title, citation, data types, keywords, abstract, links, manuscripts, accessions, funding, licence via `$assembly` helpers.
      - [ ] Leave HTML comment `<!-- tables omitted per issue 152 -->` where samples/files tables would go.
- [ ] **Add dedicated print layout**
      Strips navigation chrome for a clean printable view.
      - [ ] Copy `protected/views/layouts/main.php` to `protected/views/layouts/print.php` and remove header, footer and sidebar blocks.
      - [ ] Insert `<link rel="stylesheet" media="print" href="/css/print-simplified.css">` in the `<head>` of the new layout.
- [ ] **Insert "Simplified view" link on dataset page**
      Gives users an entry point to the new view.
      - [ ] In `protected/views/dataset/view.php`, inside the `.dataset-view-container` header, add:
        ```php
        <a class="simplified-view-link" href="/dataset/<?php echo $model->identifier; ?>/simplified" title="Open printable version">Simplified view</a>
        ```
- [ ] **Add Less styles for simplified view**
      Provides screen tweaks and print-specific rules.
      - [ ] Create `less/pages/dataset-simplified.less` containing `@media print` rules that hide navigation and display URLs inline.
      - [ ] Import the file at the end of `less/index.less` with `@import "pages/dataset-simplified.less";`.
- [ ] Write or update tests
      Ensure routing and visibility behave as expected.
      - [ ] New functional test `tests/functional/DatasetSimplifiedViewCest.php`:
        - Assert that GET `/dataset/101001/simplified` returns status 200.
        - Check that navigation elements are not present and required sections are.
        - Verify `.simplified-view-link` exists on the main dataset page.
      - [ ] Run `./tests/functional_runner` to confirm all tests pass.