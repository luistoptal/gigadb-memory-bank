# Implementation Plan: Adding Filtering to Dataset Samples

## Overview
This plan outlines the steps needed to implement filtering for samples in the DatasetPageAssembly component. The goal is to allow filtering of samples based on various attributes while maintaining pagination functionality.

## Current Architecture
- `DatasetPageAssembly` uses a decorator pattern with multiple layers for sample handling
- Sample data flow: StoredDatasetSamples -> CachedDatasetSamples -> FormattedDatasetSamples
- Pagination is already implemented but filtering is only partially implemented (filter params are logged but not applied)

## Required Changes

### 1. Update Interface Definition
- Modify `DatasetSamplesInterface` to include filter parameter in methods:
  - Update `getDatasetSamples()` method to accept a filters parameter
  - Update `countDatasetSamples()` method to accept a filters parameter

```php
public function getDatasetSamples(?string $limit, ?int $offset, array $filters = []): array;
public function countDatasetSamples(array $filters = []): int;
```

### 2. Implement Filtering in StoredDatasetSamples
- Modify the SQL in `getDatasetSamples()` to include WHERE clauses for filters
- Modify `countDatasetSamples()` to also respect filters
- Sample filter implementation:
  - Support filtering by sample name, species name, tax_id
  - Add WHERE conditions to SQL query based on the provided filters
  - Use parameterized queries to prevent SQL injection

### 3. Update Decorator Classes
- Update `CachedDatasetSamples` to pass filters to the decorated class
- Update `FormattedDatasetSamples` to pass filters to its delegate and modify `getDataProvider()`

### 4. Modify DatasetPageAssembly
- Currently `setDatasetSamples()` already accepts a filters parameter but doesn't use it
- Pass filters from `setDatasetSamples()` to `FormattedDatasetSamples`
- Ensure the pagination works with filtered results

### 5. UI Integration (not part of this plan, but noted for completeness)
- Create a form for filter inputs in the samples view
- Submit filters via AJAX or regular form submission
- Display filtered results while maintaining pagination

## Detailed Implementation Steps

### Step 1: Update StoredDatasetSamples
1. Modify `getDatasetSamples()` to apply filters:
   ```php
   public function getDatasetSamples(?string $limit = "ALL", ?int $offset = 0, array $filters = []): array
   {
       // Existing object mapper code...

       $sql = "select ds.sample_id as id, s.name, s.species_id, s.consent_document,
              s.submitted_id, s.submission_date, s.contact_author_name,
              s.contact_author_email, s.sampling_protocol
              from sample s, dataset_sample ds
              where ds.sample_id = s.id and ds.dataset_id=:id";

       $params = ['id' => $this->_id];

       // Apply filters
       if (!empty($filters)) {
           if (isset($filters['name']) && !empty($filters['name'])) {
               $sql .= " AND s.name ILIKE :name";
               $params[':name'] = '%' . $filters['name'] . '%';
           }

           if (isset($filters['tax_id']) && !empty($filters['tax_id'])) {
               $sql .= " LEFT JOIN species sp ON s.species_id = sp.id WHERE sp.tax_id = :tax_id";
               $params[':tax_id'] = $filters['tax_id'];
           }

           if (isset($filters['scientific_name']) && !empty($filters['scientific_name'])) {
               if (!strpos($sql, "LEFT JOIN species sp")) {
                   $sql .= " LEFT JOIN species sp ON s.species_id = sp.id";
               }
               $sql .= " AND sp.scientific_name ILIKE :scientific_name";
               $params[':scientific_name'] = '%' . $filters['scientific_name'] . '%';
           }

           // Add more filters as needed
       }

       $sql .= " ORDER BY id LIMIT $limit OFFSET $offset";

       $samples = Sample::model()->findAllBySql($sql, $params);
       $result = array_map($objectToHash, $samples);
       return $result;
   }
   ```

2. Update `countDatasetSamples()` to respect filters:
   ```php
   public function countDatasetSamples(array $filters = []): int
   {
       $criteria = new CDbCriteria;
       $criteria->join = "LEFT JOIN dataset ON dataset.id = dataset_id";
       $criteria->condition = 'dataset.identifier=:identifier';
       $criteria->params = [':identifier' => $this->getDatasetDOI()];

       // Apply filters
       if (!empty($filters)) {
           if (isset($filters['name']) && !empty($filters['name'])) {
               $criteria->join .= " LEFT JOIN sample s ON dataset_sample.sample_id = s.id";
               $criteria->condition .= " AND s.name ILIKE :name";
               $criteria->params[':name'] = '%' . $filters['name'] . '%';
           }

           // Add other filters similarly
       }

       return DatasetSample::model()->count($criteria);
   }
   ```

### Step 2: Update Decorator Classes
1. Update the cached and formatted sample classes to pass filters through the chain

### Step 3: Modify DatasetPageAssembly
1. Pass filters from `setDatasetSamples()` to the sample component instances:
   ```php
   public function setDatasetSamples(int $pageSize, array $filters = []): DatasetPageAssembly
   {
       // Existing code...

       $pager = new FilesPagination();
       $pager->setPageSize($pageSize);

       // Pass filters to the FormattedDatasetSamples
       $this->_samples = new FormattedDatasetSamples(
           $pager,
           $dataSource,
           $filters  // Pass filters here
       );
       return $this;
   }
   ```

## Testing Strategy
1. Unit tests for filter application in StoredDatasetSamples
2. Functional tests for end-to-end filter application
3. Manual testing with various filter combinations

## Risks and Mitigations
- Performance impact of complex queries: Use indexes on filtered columns
- SQL injection: Use parameterized queries
- Cache invalidation: Ensure cache keys include filter parameters