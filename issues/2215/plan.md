### Display File Attribute Units in File Tab

- [ ] **Modify `StoredDatasetFiles.php` to include unit in attribute data**
      Update the `$toNameValueHash` closure in `getDatasetFiles` to return name, value, and unit for each attribute. This makes unit information available for formatting.
- [ ] **Modify `FormattedDatasetFiles.php` to display units**
      Update `getDatasetFiles` to use the new attribute structure from `StoredDatasetFiles.php`. Concatenate the unit to the value if present when building `attrDesc`. This ensures units are shown in the UI.
- [ ] Write or update tests

### Detailed Plan: Display File Attribute Units in File Tab

This plan outlines the specific code changes required to display file attribute units in the "Files" tab of the dataset view page.

- [ ] **1. Modify `protected/components/StoredDatasetFiles.php` to include unit information in file attribute data.**
    - **Goal:** Ensure that when file attributes are fetched, their associated unit symbol (e.g., "Mb", "GB") is also retrieved and stored.
    - **File:** `protected/components/StoredDatasetFiles.php`
    - **Method:** `getDatasetFiles()`
    - **Specific Change:** Update the closure assigned to `$toNameValueHash`.
        - **Locate this part of the code (around lines 52-54):**
          ```php
          // ...
          $toNameValueHash = function ($carry, $file_attribute) {
              $carry[$file_attribute->attribute->attribute_name] = $file_attribute->value;
              return $carry;
          };
          // ...
          ```
        - **Modify it to:**
          ```php
          // ...
          $toNameValueHash = function ($carry, $file_attribute) {
              $unit_symbol = ''; // Default to empty string if no unit
              if (isset($file_attribute->unit) && $file_attribute->unit !== null) {
                  // Assumes Unit model's 'id' field holds the symbol (e.g., "Mb")
                  // And that the 'unit' relation is available on $file_attribute
                  $unit_symbol = $file_attribute->unit->id;
              } elseif (!empty($file_attribute->unit_id)) {
                  // Fallback: if unit_id is set but relation not loaded, try to load Unit model
                  // This part might need adjustment based on how Unit model is typically fetched
                  // or if eager loading is expected to handle this.
                  // For now, we'll assume $file_attribute->unit->id is the primary way.
                  // If $file_attribute->unit is null but $file_attribute->unit_id is present,
                  // it implies the relation wasn't eager loaded or doesn't exist.
                  // A direct lookup could be: $unitModel = Unit::model()->findByPk($file_attribute->unit_id);
                  // if ($unitModel) { $unit_symbol = $unitModel->id; }
                  // However, the outline suggests $file_attribute->unit->id should work if relation is loaded.
                  // We'll stick to the outline's primary suggestion.
                  // If $file_attribute->unit is null, this means no unit is associated or not loaded.
              }

              // Instead of attribute_name => value, create a structured array
              $carry[] = array(
                  'name' => $file_attribute->attribute->attribute_name,
                  'value' => $file_attribute->value,
                  'unit' => $unit_symbol
              );
              return $carry;
          };
          // ...
          ```
        - **Explanation for the change:**
            - The original code stored attributes as `attribute_name => value`.
            - The new code stores attributes as an array of structured items: `['name' => ..., 'value' => ..., 'unit' => ...]`.
            - It attempts to get the unit symbol from `$file_attribute->unit->id`. This relies on the `FileAttributes` model having a working `unit` relation to the `Unit` model, and the `Unit` model's `id` field containing the symbol.
            - An empty string `''` is used for `unit` if no unit is found.
            - The `$carry` array now accumulates these structured attribute arrays. Initialize `$attributes_map = []` before the loop and use `$attributes_map = array_reduce($file_model->fileAttributes, $toNameValueHash, []);`

- [ ] **2. Modify `protected/components/FormattedDatasetFiles.php` to format and display the unit with the attribute value.**
    - **Goal:** Take the structured attribute data (now including the unit) and format it for display, appending the unit to the value if a unit exists.
    - **File:** `protected/components/FormattedDatasetFiles.php`
    - **Method:** `getDatasetFiles()`
    - **Specific Change:** Update the loop that processes `$file['file_attributes']` (which will now contain the structured array from the previous step) to build the `$file['attrDesc']` string.
        - **Locate this part of the code (around lines 53-55):**
          ```php
          // ...
          $attribute_strings = array();
          foreach ($file['file_attributes'] as $file_attribute) { // This loop will change
              $attribute_strings[] = implode(array_keys($file_attribute)) . ": " . implode(array_values($file_attribute)) . "<br>";
          }
          $file['attrDesc'] = implode($attribute_strings);
          // ...
          ```
        - **Modify it to (assuming `$file['file_attributes']` is now the array of structured attribute data):**
          ```php
          // ...
          $attribute_strings = array();
          if (isset($file['file_attributes']) && is_array($file['file_attributes'])) {
              foreach ($file['file_attributes'] as $attribute_item) { // $attribute_item is one of ['name'=>..., 'value'=>..., 'unit'=>...]
                  $display_value = $attribute_item['value'];
                  if (isset($attribute_item['unit']) && !empty($attribute_item['unit'])) {
                      $display_value .= " " . $attribute_item['unit'];
                  }
                  // Ensure 'name' exists before using it
                  $attribute_name = isset($attribute_item['name']) ? $attribute_item['name'] : 'N/A';
                  $attribute_strings[] = htmlspecialchars($attribute_name, ENT_QUOTES, 'UTF-8') . ": " . htmlspecialchars($display_value, ENT_QUOTES, 'UTF-8') . "<br>";
              }
          }
          $file['attrDesc'] = implode("", $attribute_strings); // Join with empty string as <br> is already appended
          // ...
          ```
        - **Explanation for the change:**
            - The original code was designed for a simple key-value structure and would not work with the new structured attribute data.
            - The new code iterates through the array of attribute structures.
            - For each attribute, it takes `name`, `value`, and `unit`.
            - If `unit` is present and not empty, it appends it to `value` with a space.
            - `htmlspecialchars` is used to prevent XSS vulnerabilities when rendering these values.
            - The resulting strings are collected and then `implode`d to create the final `attrDesc`.

- [ ] **3. Verify changes manually (as per Verification Steps in `outline.md`)**
    - Go to an admin page for a file (e.g., `/adminFile/update/id/YOUR_FILE_ID`).
    - Add/edit an attribute with a value and a unit (e.g., "Size", "100", "Mb").
    - Save.
    - Go to the public dataset page for that file.
    - Check the "Files" tab.
    - **Expected:** Attribute displays as "Size: 100 Mb".
    - Test attributes without units.
    - Test files with no attributes.

- [ ] **4. Write or update tests**
    - **Goal:** Create automated tests to ensure the unit display functionality works correctly and to prevent regressions.
    - **Considerations:**
        - **Unit Tests:** Test the `StoredDatasetFiles::getDatasetFiles()` method to ensure it returns the correct structured data, including units. Test the `FormattedDatasetFiles::getDatasetFiles()` method to ensure `attrDesc` is formatted correctly with units.
        - **Functional/Acceptance Tests:** Create a test that simulates the user actions (adding an attribute with a unit, viewing the dataset) and asserts that the unit is displayed correctly on the page. This might involve using Codeception.
    - This step is highly dependent on the existing testing infrastructure and practices. Focus on testing the logic added in `StoredDatasetFiles.php` and `FormattedDatasetFiles.php`.

**Important Notes for the Junior Developer:**
*   **Backup Files:** Before making any changes, it's a good idea to make a backup of `StoredDatasetFiles.php` and `FormattedDatasetFiles.php`.
*   **Error Checking:** Pay attention to PHP error logs during development. If something goes wrong, the logs can provide clues.
*   **Yii Framework:** Remember that this is a Yii 1.1 application. Model relations (like `$file_attribute->unit`) are defined in the model classes (e.g., `FileAttributes.php`).
*   **Database Structure:** The `unit.id` is assumed to hold the unit symbol (e.g., "Mb"). This should be confirmed by looking at the `unit` table structure or the `Unit.php` model. The outline confirms this.
*   **Eager Loading:** The outline mentions potential N+1 query issues. While the provided changes focus on fixing the display bug, if performance issues are noticed later, eager loading of the `unit` relation in `FileAttributes` might be necessary. This would typically be done where `FileAttributes` are fetched (e.g., in the `File` model's relations or when querying for files). For now, the changes assume the relation is either already eager-loaded or the performance impact on typical dataset pages is acceptable. The current fix tries to use the loaded relation if available.