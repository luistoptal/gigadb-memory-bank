# Sample Filtering Implementation Plan

## Current Understanding

1. The `_sample_panel.php` view already has filter inputs and JavaScript that sends filters via GET parameters with `samples_filter=true`.
2. The `DatasetController::actionView()` method has code to collect these filters but doesn't apply them to the data provider.
3. The `DatasetPageAssembly::setDatasetSamples()` method presumably creates the sample data provider but doesn't consider filters.

## Implementation Steps

### 1. Update DatasetController::actionView()

Modify to pass the filters to the DatasetPageAssembly:

```php
// Current code collects filters
if (Yii::app()->request->getParam('samples_filter')) {
    $filters = [];
    $filterFields = ['sample_id', 'common_name', 'scientific_name', 'attribute', 'taxonomic_id', 'genbank_name'];

    foreach ($filterFields as $field) {
        $value = Yii::app()->request->getParam($field);
        if ($value !== null && $value !== '') {
            $filters[$field] = $value;
        }
    }

    // Store filters for use when setting up the samples data provider
    $sampleFilters = $filters;
} else {
    $sampleFilters = [];
}

// Later in the code, pass filters to setDatasetSamples
$assembly->setDatasetSamples($sampleSettings["pageSize"], $sampleFilters);
```

### 2. Update DatasetPageAssembly::setDatasetSamples()

This method needs to be modified to accept and apply filters:

```php
public function setDatasetSamples($pageSize, $filters = [])
{
    // Existing code to get samples

    // Apply filters to the data provider or query
    if (!empty($filters)) {
        // Depending on how the data provider is implemented:
        // Option 1: If using CActiveDataProvider with a model
        $criteria = new CDbCriteria();
        foreach ($filters as $field => $value) {
            $criteria->addSearchCondition($field, $value, true, 'AND', 'ILIKE');
        }
        $dataProvider->criteria->mergeWith($criteria);

        // Option 2: If using CArrayDataProvider
        $filteredData = $originalData;
        foreach ($filters as $field => $value) {
            $filteredData = array_filter($filteredData, function($item) use ($field, $value) {
                return stripos($item[$field], $value) !== false;
            });
        }
        $dataProvider->setData($filteredData);
    }

    return $this;
}
```

### 3. Update JavaScript in _sample_panel.php

Modify to reload the page instead of using AJAX, since the current controller logic expects a full page reload:

```javascript
function submitFilters() {
    const filterState = getFilterState();

    // Build the URL with filter parameters
    let url = new URL(window.location.href);
    url.searchParams.set('samples_filter', 'true');

    // Add each filter to the URL
    Object.entries(filterState).forEach(([key, value]) => {
        if (value) {
            url.searchParams.set(key, value);
        } else {
            url.searchParams.delete(key);
        }
    });

    // Navigate to the filtered URL
    window.location.href = url.toString();
}
```

### 4. Consider UX Improvements

1. Preserve filter values after page reload:
   ```php
   // In _sample_panel.php, set initial input values from request parameters
   <input data-filter="sample_id" type="text" class="form-control"
          value="<?php echo CHtml::encode(Yii::app()->request->getParam('sample_id', '')); ?>"
          aria-label="Filter by Sample ID" />
   ```

2. Add visual indication that filters are active
3. Consider adding a loading indicator during page refresh

## Testing Strategy

1. Test with various filter combinations
2. Test filter clearing functionality
3. Verify pagination works correctly with filters applied
4. Test edge cases: special characters, very long filter values
5. Ensure filters work when combined with table column visibility settings

## Potential Issues

1. Performance with large datasets - may need optimization
2. Need to ensure proper escaping of filter values in SQL queries
3. Consider how filters interact with sorting functionality