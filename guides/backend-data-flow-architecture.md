# Guide: Backend Data Flow & Layered Architecture in GigaDB

## 1. Introduction

This guide describes the layered backend architecture, often resembling an "onion structure," used within the GigaDB Yii 1.1 application. This pattern is prevalent for fetching data from the database, processing it through various layers (caching, formatting), and ultimately preparing it for presentation in the views.

The core idea is that data passes through distinct layers, each with a specific responsibility. This approach enhances separation of concerns, maintainability, and testability.

## 2. Core Components & Layers

The architecture typically involves the following components, acting as layers:

*   **Controller** (e.g., `DatasetController`)
    *   **Role:** Handles incoming HTTP requests, interprets user input, and orchestrates the response. It decides which data is needed and which view should render it.
    *   **Interaction:** Instantiates and configures a "Page Assembly" or orchestrator component to gather and prepare data. It then passes this prepared data to a Yii view file.

*   **Page Assembly / Orchestrator** (e.g., `DatasetPageAssembly`)
    *   **Role:** Acts as a central coordinator for gathering all data required for a complex page or a significant section of a page. It manages the instantiation and configuration of various data-specific components (Formatters, Caching, Storage layers).
    *   **Interaction:** Often uses a fluent interface (e.g., `->setDatasetFiles()->setDatasetSamples()`) for a readable setup process in the Controller. It calls upon Formatting layers to get the final data structures.

*   **Formatting Layer** (e.g., `FormattedDatasetFiles`, `FormattedDatasetAccessions`)
    *   **Role:** This layer is responsible for transforming raw data (fetched from storage or cache) into a presentation-ready format suitable for the views. This includes:
        *   Combining multiple data fields.
        *   Generating HTML snippets (though this should be used judiciously, with most HTML in views).
        *   Formatting dates, numbers, sizes (e.g., `UnitHelper::specifySizeUnits()`).
        *   Creating descriptive text based on data (e.g., the `attrDesc` field).
    *   **Interaction:** Typically wraps a data source, which could be a Caching layer or directly a Storage layer. It's consumed by the Page Assembly/Orchestrator, which then passes the formatted data to the Controller or View.

*   **Caching Layer** (e.g., `CachedDatasetFiles`, `CachedDatasetSubmitter`)
    *   **Role:** Implements caching logic to store frequently accessed or computationally expensive data, reducing database load and improving response times.
    *   **Interaction:** Wraps a Storage layer. When requested for data, it first checks its cache.
        *   If data is found in the cache and is still valid, it returns the cached data.
        *   Otherwise, it delegates the call to the underlying Storage layer, caches the result, and then returns it.
        *   This layer is generally transparent to the Formatting layer that consumes it.

*   **Storage / Data Access Layer (DAO)** (e.g., `StoredDatasetFiles`, `StoredDatasetSubmitter`)
    *   **Role:** Directly interacts with the primary data source, which is usually the PostgreSQL database in this application. It's responsible for fetching raw data.
    *   **Interaction:**
        *   Uses Yii's CActiveRecord models (e.g., `File`, `FileAttributes`, `Dataset`) to query the database and retrieve data objects.
        *   May also use `CDbCommand` for more complex queries or when models are not suitable.
        *   It's consumed by the Caching layer or, if caching is bypassed for a specific case, directly by the Formatting layer.

*   **Models** (e.g., `Dataset`, `File`, `FileAttributes`, `Unit`)
    *   **Role:** Represent database tables and their relationships, as per Yii's CActiveRecord pattern. They encapsulate data and business logic related to specific entities.
    *   **Interaction:** Used extensively by the Storage layer to perform CRUD (Create, Read, Update, Delete) operations and to define relationships between data entities (e.g., a `File` has many `FileAttributes`, a `FileAttribute` belongs to a `Unit`).

*   **View** (e.g., `protected/views/dataset/view.php`)
    *   **Role:** Renders the final HTML output that is sent to the user's browser. It should contain minimal logic, focusing primarily on presentation.
    *   **Interaction:** Receives prepared data (often as arrays or `CArrayDataProvider` instances) from the Controller. It then iterates through this data and displays it using PHP and HTML.

## 3. Data Flow Example: Displaying File Attributes

Let's trace the flow for displaying file attributes on a dataset page, as investigated for issue #2215:

1.  **Request:** A user navigates to a dataset page. The request is routed to `DatasetController::actionView()`.
2.  **Controller Action:** `DatasetController` instantiates `DatasetPageAssembly`.
3.  **Assembly Configuration:** `DatasetPageAssembly->setDatasetFiles()` is called.
    *   Inside `setDatasetFiles`, a `FormattedDatasetFiles` instance is created.
    *   This `FormattedDatasetFiles` instance is typically given a `CachedDatasetFiles` instance as its data source.
    *   The `CachedDatasetFiles` instance, in turn, is given a `StoredDatasetFiles` instance.
4.  **View Rendering & Data Retrieval:** When the view (`view.php`) needs to display the files table (usually through a `CArrayDataProvider` initialized by `FormattedDatasetFiles`):
    *   A method like `FormattedDatasetFiles::getDatasetFiles()` (often called internally by its `getDataProvider()`) is invoked.
    *   `FormattedDatasetFiles` delegates the call to `CachedDatasetFiles::getDatasetFiles()`.
    *   `CachedDatasetFiles` checks its cache (e.g., Yii's `CCache` component) for the requested data.
        *   **Cache Hit:** If valid data is found, it's returned directly.
        *   **Cache Miss:** `CachedDatasetFiles` calls `StoredDatasetFiles::getDatasetFiles()`.
    *   `StoredDatasetFiles::getDatasetFiles()`:
        *   Constructs and executes a database query (e.g., using `File::model()->findAllBySql()` or criteria).
        *   This query fetches raw data for files and their related attributes, including `attribute_name`, `value`, and `unit_id` (or `unit->id` if relations are eager-loaded) from tables like `file`, `file_attributes`, `attribute`, `unit`.
        *   It processes the raw database results into a structured array (e.g., where each file attribute contains its name, value, and unit symbol).
    *   The raw, structured data is returned from `StoredDatasetFiles` to `CachedDatasetFiles`.
    *   `CachedDatasetFiles` stores this data in the cache for future requests.
    *   The data is then returned to `FormattedDatasetFiles`.
    *   `FormattedDatasetFiles::getDatasetFiles()` iterates over this raw data. For each file and its attributes:
        *   It performs formatting tasks, such as combining the attribute value and its unit symbol (e.g., "618.1" and "Mb" become "618.1 Mb").
        *   It populates the `attrDesc` field with the fully formatted string for all attributes of a file.
        *   It might also format other fields like file size (`sizeUnit`).
5.  **Data to Controller:** The fully formatted array of file data is made available by `DatasetPageAssembly` (e.g., via `$assembly->getDatasetFiles()`).
6.  **Data to View:** The `DatasetController` passes this prepared data (often within a `CArrayDataProvider`) to the `view.php` template.
7.  **Display:** `view.php` iterates through the file data and renders the `attrDesc` (e.g., `<?= $file['attrDesc'] ?>`), displaying the attributes with their units.

## 4. Benefits of this Architecture

*   **Separation of Concerns (SoC):** Each class has a clear, single responsibility. Controllers handle requests, Storage layers fetch data, Caching layers cache it, Formatting layers prepare it for display, and Views render it.
*   **Maintainability:** Changes within one layer are less likely to ripple through the entire system. For instance, optimizing a database query in a Storage layer won't necessarily require changes in the Formatting layer or Controller, as long as the data contract is maintained.
*   **Testability:** Individual components (layers) can be unit-tested in isolation by mocking their dependencies. For example, `FormattedDatasetFiles` can be tested by providing it with a mock data source, without needing a live database or cache.
*   **Reusability:** Some components, especially in the Storage or Caching layers, might be designed for reuse across different parts of the application if they handle common data entities.
*   **Readability & Clarity:** The use of orchestrators like `DatasetPageAssembly` with fluent interfaces can make the data preparation logic in controllers more understandable. The distinct layers also make the overall data flow easier to follow.
*   **Flexibility:** This architecture allows for flexibility, such as easily adding or bypassing layers. For example, caching can be conditionally skipped by having the Formatting layer interact directly with the Storage layer if needed.

## 5. Key Design Patterns Observed

*   **Decorator Pattern (Implicitly):**
    *   The Caching layer "decorates" the Storage layer by adding caching functionality without altering the Storage layer's core responsibility.
    *   The Formatting layer "decorates" its data source (Caching or Storage layer) by adding presentation-specific logic.
*   **Adapter Pattern (Implicitly):**
    *   Formatting layers often adapt the data structure provided by lower layers into a structure more convenient for the view or a `CArrayDataProvider`.
*   **Fluent Interface:**
    *   Used by components like `DatasetPageAssembly` to allow for a chained, readable configuration of its various parts (e.g., `assemble(...)->setDatasetSubmitter()->setDatasetFiles()`).
*   **Dependency Injection:**
    *   Dependencies (like `CDbConnection`, `CApplication` instance, other service components) are often passed into constructors or setters, promoting loose coupling.
*   **Data Access Object (DAO):**
    *   The Storage layers (e.g., `StoredDatasetFiles`) act as DAOs, abstracting the specifics of data retrieval from the rest of the application.

This layered approach provides a robust and maintainable way to handle data complexities in the GigaDB application.