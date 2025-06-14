# Importing JavaScript ES6 Modules in Yii 1.1 Views

This guide explains how to properly import JavaScript ES6 modules in Yii 1.1 views using Yii's asset publishing and script registration system. This approach ensures correct asset versioning, cache busting, and compatibility with Yii's asset management.

## Why Use This Method?
- Ensures assets are published to a web-accessible location
- Handles cache busting and versioning automatically
- Keeps asset paths dynamic and environment-agnostic
- Follows best practices for Yii 1.1 and modern JS (ES6 modules)

## Step-by-Step Instructions

### 1. Place Your JS Module in the Correct Directory
Place your ES6 module (e.g., `throttle.js`) in the appropriate directory, such as:

```
gigadb/app/client/js/throttle.js
```

### 2. Publish the JS Directory with Yii Asset Manager
In your PHP view or partial, use Yii's asset manager to publish the JS directory. This will generate a web-accessible URL for your assets.

```php
Yii::app()->assetManager->forceCopy = YII_DEBUG; // Only in development
$jsDir = Yii::getAlias('/gigadb/app/client/js');
$jsUrl = Yii::app()->assetManager->publish($jsDir);
```

- `forceCopy` ensures updated files are always published in development.
- `getAlias` resolves the path to your JS directory.
- `publish` returns the public URL for the directory.

### 3. Register the Script File as a Module
Register your JS file as a module using `registerScriptFile`:

```php
Yii::app()->clientScript->registerScriptFile(
    $jsUrl . '/throttle.js',
    CClientScript::POS_END,
    ['type' => 'module']
);
```

- The third argument sets the script type to `module` for ES6 imports/exports.

### 4. Import the Module in a <script type="module"> Block
Now you can import your module using the published URL:

```php
<script type="module">
  import { throttle } from "<?php echo $jsUrl; ?>/throttle.js";

  // Your JS code here
  $(document).ready(function () {
    // Use throttle(...)
  });
</script>
```

### 5. Example: Complete Usage in a Yii View
```php
<?php
Yii::app()->assetManager->forceCopy = YII_DEBUG;
$jsDir = Yii::getAlias('/gigadb/app/client/js');
$jsUrl = Yii::app()->assetManager->publish($jsDir);
Yii::app()->clientScript->registerScriptFile($jsUrl . '/throttle.js', CClientScript::POS_END, ['type' => 'module']);
?>

<script type="module">
  import { throttle } from "<?php echo $jsUrl; ?>/throttle.js";
  $(document).ready(function () {
    // Use throttle here
  });
</script>
```

## Notes
- Always use the published URL (`$jsUrl`) for imports to ensure the correct path.
- This method works for any ES6 module, not just `throttle.js`.
- For multiple modules, repeat the registration and import steps as needed.
- For third-party modules, consider using import maps or CDN URLs as appropriate.

## References
- See `protected/views/shared/_carousel_slider.php` and `protected/views/shared/_model_viewer.php` for real examples in this codebase.
- [Yii 1.1 Asset Manager Documentation](https://www.yiiframework.com/doc/api/1.1/CAssetManager)