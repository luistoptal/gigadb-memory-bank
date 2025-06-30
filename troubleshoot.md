Q: Changes on local database are not being reflected in the UI of the local dev site

A: In `index.php`, set `DISABLE_CACHE` to `true`.

Q: Acceptance tests failing with: `(...) invalid integer value "%GIGADB_PORT%" (...)`

A: Add `GIGADB_PORT=5432` to your `.secrets` file.