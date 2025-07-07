# Triggering DataCite XML submission & creating a Curation Log

This quick reference shows three ways to send a dataset's metadata to DataCite **and** record the "Sent DataCite XML" action in `curation_log`.

---

## 1  Admin UI – "Mint DOI" button

1. Navigate to **Admin → Dataset → Update**.
2. Press **Mint DOI**.
   * Front-end sends an AJAX POST to `/adminDataset/mint` (see `protected/views/adminDataset/_form.php`).
3. Inside `AdminDatasetController::actionMint()`:
   * The dataset is converted to XML via `Dataset::toXML()`.
   * The XML is POSTed to DataCite.
   * On a 201 response the helper below is invoked:
     ```php
     CurationLog::createGeneralCurationLogEntry($dataset->id,
         'Sent DataCite XML', $xml_data, $userName);
     ```
4. Refresh – the **Curation Log** grid now shows the new row with a short XML preview and "+" expand button.

## 2  CLI batch sync

Run the console command to (re)push published datasets:
```bash
php protected/yiic updateDatasetDatacite --batchSize=50   # optional: --offset / --doi
```
`UpdateDatasetDataciteCommand` bulk-inserts identical log entries for every dataset processed.

## 3  Programmatic call

From any service or migration you can write a log entry directly:
```php
CurationLog::createGeneralCurationLogEntry(
    $datasetId,               // int – dataset id
    'Sent DataCite XML',      // action text
    $xmlString,               // full XML
    Yii::app()->user->name    // author (defaults to "system")
);
```
The `curation_log` row will immediately appear in the UI.

---

### Useful code locations
| Purpose | File | Key line |
|---|---|---|
| UI button definition | `protected/views/adminDataset/_form.php` | Mint DOI ajaxButton |
| Controller workflow | `protected/controllers/AdminDatasetController.php` | `actionMint()` |
| CLI batch command | `protected/commands/UpdateDatasetDataciteCommand.php` | `processBatch()` |
| Log helper | `protected/models/CurationLog.php` | `createGeneralCurationLogEntry()` |
| XML formatter (truncate/expand) | `protected/components/LogCurationFormatter.php` | `getDisplayXmlAttr()` |

---

Happy curating! :rocket: