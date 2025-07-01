Clarity rating: 97/100 ✅

# Outline — Title Length Warning in Admin Pages (Issue #1028)

## 1. Objective
Warn curators, in real-time, when the dataset title they enter in any admin-side dataset form exceeds 100 characters, encouraging concise titles.

## 2. In-Scope Pages
- "Create Dataset" admin form.
- "Update Dataset" (pre-publication) admin form.

## 3. Functional Requirements
1. When the curator types in the **Dataset Title** input field and the length becomes **> 100 characters** (i.e., 101+), display a warning.
2. The warning appears **inline directly beneath** the title input, styled like other form-validation helper text (e.g., small, orange text with warning icon if available).
3. If the page loads with an existing title already > 100 characters, **do not** show the warning until the user edits the field and the length is still > 100.
4. The warning is informational only; curators may still save the form with a long title (no hard limit enforced).
5. Warning text (exact copy):
   "Warning: Your title is over 100 characters long, you should reduce it if possible."
6. The same message, styling, and behavior apply to both **create** and **update** forms.

## 4. Acceptance Criteria
Given I am creating or updating a dataset in the admin pages
When I type a title that reaches **101 characters**
Then I see the inline warning beneath the field: *"Warning: Your title is over 100 characters long, you should reduce it if possible."*

Given I load the edit form for a dataset whose title is already > 100 characters
When I have not yet edited the title field
Then **no warning** is visible
And when I focus and modify the field such that the title remains > 100 characters
Then the warning appears inline beneath the field.

Given I shorten the title to **≤ 100 characters**
Then the warning disappears automatically.

## 5. Non-Functional / UI Notes
- Follow existing form-validation styling guidelines (Bootstrap 3 + Less); match color palette for warnings.
- Must function without page reload (client-side jQuery).
- Must pass WCAG 2.2 AA contrast and screen-reader accessibility.

## 6. Out of Scope
- Backend enforcement of maximum title length.
- Changes to public-facing dataset display.

## 7. Deliverables
- UI update implementing warning on relevant forms.
- Unit/functional/acceptance tests covering: appearance, disappearance, and non-appearance on load.

## 8. Codebase Review

The following locations contain the code that will need to be touched to add the real-time 100-character title warning:

1. **Title input field markup**

```462:470:protected/views/adminDataset/_form.php
                        'model'               => $model,
                        'attributeName'       => 'title',
                        'labelOptions'        => ['class' => 'col-xs-4'],
                        'inputWrapperOptions' => 'input-wrapper col-xs-6',
                        'inputOptions'        => [
                            'required'  => true,
                            'size'      => 60,
                            'maxlength' => 300
                        ],
```
This `TextField` widget produces the `<input id="Dataset_title">` element used on both create and update pages. It is the DOM anchor where the live-length script will attach and where the inline helper message can be placed (e.g. an adjacent `.help-block.text-warning`).

2. **Existing admin-dataset jQuery block**

```640:646:protected/views/adminDataset/_form.php
<script>
    $(document).ready(function () {
        let previousValue = ''
```
A large `$(document).ready(...);` block already lives at the bottom of `_form.php`. Adding another `$('#Dataset_title').on('input', …)` handler here (or in a new `<script>` tag) will centralise the new logic without creating another asset file.

3. **Page wrappers**

- `protected/views/adminDataset/create.php`
- `protected/views/adminDataset/update.php`

These pages just render the shared `_form.php`, so no changes are required beyond manual testing; they are the URLs QA will hit.

4. **Form control helpers**

```1:20:protected/components/controls/TextField.php
class TextField extends BaseInput
{
  public function run()
  {
    $this->renderControlGroup(function () {
      echo $this->form->textField($this->model, $this->attributeName, $this->inputOptions);
    });
  }
}
```
Knowing the helper's output structure (label → input → description/error) helps decide whether to inject the warning server-side or purely via JS.

5. **Functional test scaffold**

```25:33:tests/admin-dataset-form-loading.js
        test.assertExists(x('//input[@type="text" and @id="Dataset_title"]'), 'Dataset Title');
        test.assertExists(x('//textarea[@id="Dataset_description"]'), 'Dataset Description');
```
This CasperJS test demonstrates existing admin interactions; use it as the starting point for a new test that types a long title and asserts the warning appears/disappears.

No other admin forms contain a dataset title field, and the public-side submission forms are out of scope for this issue. With these touch-points identified, the implementation can be confined to `_form.php` and accompanying tests/styles.
