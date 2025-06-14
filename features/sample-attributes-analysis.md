## Feature Analysis: Sample Attributes

**Feature Summary:**

From a user's perspective (specifically an admin or data curator), "Attributes" are predefined metadata fields (like "geographic location", "collection date", "sequencing method") that can be associated with individual Samples within a Dataset. Admins can define the available attributes system-wide. When creating or editing a sample, users can assign specific values (and sometimes units) to these predefined attributes for that particular sample. These attributes and their values are then displayed on the dataset view page, associated with their respective samples. Technically, the goal is to allow flexible, structured metadata annotation for samples using a centrally managed vocabulary of attribute types.

**Key Components:**

*   **`protected/models/Attributes.php` (`Attributes` model):** Defines the schema for the `attribute` table. Represents the *definition* of an attribute type (name, definition, allowed units, syntax, etc.). These are the templates for attributes that can be assigned.
*   **`protected/models/Sample.php` (`Sample` model):** Represents a biological sample.
*   **`protected/models/SampleAttribute.php` (`SampleAttribute` model):** Defines the schema for the `sample_attribute` table. This is the *linking table* storing the specific `value` and `unit_id` for a given `Attributes` record associated with a specific `Sample` record.
*   **`protected/controllers/AttributeController.php` (`AttributeController`):** Handles the administrative CRUD (Create, Read, Update, Delete) operations for defining and managing the available `Attributes` types system-wide. Accessed via the `/attribute/admin` page.
*   **`protected/views/attribute/`:** Contains the views used by `AttributeController` for admin management of attribute definitions (e.g., `admin.php`, `_form.php`).
*   **`protected/controllers/AdminSampleController.php` (`AdminSampleController`):** Handles the creation and updating of `Sample` records. It includes logic (specifically the `updateSampleAttributes` method) to parse and save the `SampleAttribute` values submitted via the sample form.
*   **`protected/views/adminSample/_form.php`:** The form view used for creating and editing `Sample` records. It uses a specific text area (`attributesList`) where users input/edit the key-value pairs for the sample's attributes.
*   **`application.components.controls.TextArea`:** A custom widget used in the sample form to render the text area for attribute input.
*   **`protected/views/dataset/view.php` (Likely):** Although not explicitly checked, this view (or related partials) would be responsible for querying and displaying the `SampleAttribute` values associated with the samples listed in a dataset.

**Implementation Workflow:**

1.  **Attribute Definition (Admin):**
    *   An admin navigates to `/attribute/admin`.
    *   `AttributeController::actionAdmin()` renders the `admin.php` view, listing existing attributes defined in the `attribute` table (via the `Attributes` model).
    *   The admin clicks "Create Attribute".
    *   `AttributeController::actionCreate()` renders the `_form.php` view.
    *   The admin fills in the details (name, definition, allowed units, etc.) and submits.
    *   `AttributeController::actionCreate()` receives the POST data, populates an `Attributes` model, validates, and saves it to the `attribute` table.

2.  **Assigning Attributes to a Sample (Admin/Curator):**
    *   A user navigates to `/adminSample/create` or `/adminSample/update/{id}`.
    *   `AdminSampleController::actionCreate()` or `actionUpdate()` initializes a `Sample` model and renders the `protected/views/adminSample/_form.php` view.
    *   For an existing sample, the `Sample` model's `getAttributesList(true)` method is called, which likely queries the `sample_attribute` table (via the `SampleAttribute` model) for attributes linked to this sample and formats them into a string (e.g., `"attr_name1="value1"","attr_name2="value2""`).
    *   This string populates the `attributesList` text area rendered by the `TextArea` widget.
    *   The user edits the sample details (name, species) and modifies the text in the `attributesList` text area to add, change, or remove key-value attribute pairs. The keys used must correspond to the `structured_comment_name` field of an existing `Attributes` record.
    *   The user submits the form.
    *   `AdminSampleController::actionCreate()` or `actionUpdate()` receives the POST data.
    *   The main `Sample` data (name, species_id) is saved first.
    *   If the `Sample` saves successfully, the `updateSampleAttributes($model)` method is called.
    *   `updateSampleAttributes` deletes existing `SampleAttribute` records for this sample.
    *   It parses the submitted `$model->attributesList` string (splitting by `","` and then `=`).
    *   For each pair, it finds the corresponding `Attributes` record using the key (`structured_comment_name`).
    *   If found, it creates a new `SampleAttribute` model instance, sets `sample_id`, `attribute_id` (from the found `Attributes` record), and `value`, then saves it to the `sample_attribute` table. Validation occurs on the `SampleAttribute` model.
    *   If any attribute name is invalid or saving fails, errors are added to the main `$model`.

3.  **Displaying Attributes (Public/User):**
    *   A user views a dataset page (e.g., `/dataset/{identifier}`).
    *   The relevant controller action (likely in `DatasetController`) fetches the `Dataset` model, its associated `Sample` models, and for each `Sample`, its associated `SampleAttribute` records (joining `sample_attribute` with `attribute` and potentially `unit`).
    *   The view (`protected/views/dataset/view.php` or similar) iterates through the samples and their attributes, displaying the attribute names (`attribute.attribute_name`), values (`sample_attribute.value`), and units (`sample_attribute.unit_id`).

**Data Flow:**

*   **Attribute Definitions:** Admin UI -> `AttributeController` -> `Attributes` model -> `attribute` database table.
*   **Sample Attribute Assignment:** User edits `attributesList` text area in Sample Form UI -> `AdminSampleController` -> Parses string -> Looks up `Attributes` model (using `structured_comment_name`) -> Creates/Updates `SampleAttribute` models -> `sample_attribute` database table.
*   **Attribute Display:** Dataset View request -> Controller fetches `Sample`, `SampleAttribute`, `Attributes`, `Unit` models -> Data passed to View -> Rendered HTML.

**Key Dependencies:**

*   **Yii 1.1 Framework:** Core MVC structure, `CActiveRecord` for database interaction, `CActiveForm` and widgets (`CJuiAutoComplete`, custom `TextArea`) for form handling.
*   **Database:** PostgreSQL tables (`attribute`, `sample`, `sample_attribute`, `unit`, `species`).

**(Optional) Code Snippets:**

*Parsing and Saving Sample Attributes in `AdminSampleController::updateSampleAttributes`:*
```php
// Simplified snippet from AdminSampleController::updateSampleAttributes
SampleAttribute::model()->deleteAllByAttributes(array('sample_id' => $model->id));

if (!empty($model->attributesList) && trim($model->attributesList)) {
    foreach (explode('",', $model->attributesList) as $attributes) {
        $sampleAttribute = new SampleAttribute();
        $sampleAttribute->sample_id = $model->id;
        $attributes = str_replace('"', '', $attributes);
        $attributeData = explode('=', $attributes);
        if (count($attributeData) == 2) {
            // Get attribute definition based on structured_comment_name
            $attribute = Attributes::model()->findByAttributes(array('structured_comment_name' => trim($attributeData[0])));
            if ($attribute) {
                $sampleAttribute->value = trim($attributeData[1]);
                $sampleAttribute->attribute_id = $attribute->id;
                if (!$sampleAttribute->save(true)) {
                    // handle errors
                }
            } else {
                // handle invalid attribute name error
            }
        }
    }
}
```

*Attribute Text Area in `protected/views/adminSample/_form.php`:*
```php
<?php
$model->attributesList = $model->attributesList ? $model->attributesList :  $model->getAttributesList(true); // Sets default content
$this->widget('application.components.controls.TextArea', [
    'form' => $form,
    'model' => $model,
    'attributeName' => 'attributesList',
]);
?>
```