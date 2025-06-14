# Pull request for issue: #379

This is a pull request for the following functionalities:

* Auto hyperlink URLs in dataset file and sample attributes
* Improved long text toggler component with CSS-based line clamping
* Enhanced HTML string processing with sanitization and URL detection

## How to test?

To test the new auto-hyperlinking functionality:

1. Navigate to a dataset page that contains file attributes or sample attributes with URLs (e.g., containing `http://` or `https://` links)
2. Verify that URLs in the file attributes table are automatically converted to clickable links that open in new tabs
3. Check that URLs in sample attributes are also properly hyperlinked and display correctly within the line-clamped text toggler
4. Test the improved long text toggler by finding sample attributes with long text content - verify that text is properly clamped to 3 lines initially with a toggle button to expand/collapse
5. Ensure that HTML content is properly sanitized and malicious scripts are stripped while preserving safe HTML and URLs

## How have functionalities been implemented?

The auto-hyperlinking functionality has been implemented through several components:

**1. HtmlStringHelper Class (`protected/helpers/HtmlStringHelper.php`)**
- New helper class with `autoLinkUrls()` method that safely processes text containing URLs
- Uses CHtmlPurifier to sanitize input HTML and prevent XSS attacks
- Applies regex pattern to detect unwrapped HTTP/HTTPS URLs and converts them to clickable links
- Generated links include `target="_blank"` and `rel="noopener noreferrer"` for security

**2. Enhanced Long Text Toggler (`protected/views/shared/_longTextToggler.php`)**
- Completely redesigned component using modern CSS line-clamp instead of JavaScript string truncation
- Now supports line-based clamping (configurable via `$maxLines` parameter) rather than character-based
- Uses CSS custom properties for dynamic line configuration
- Improved accessibility with proper ARIA attributes
- Better performance by deferring operations until fonts are loaded

**3. CSS Styling (`less/modules/long-text-toggler.less`)**
- New CSS module implementing webkit-line-clamp for cross-browser text truncation
- Responsive design with proper transitions and hover states
- Support for dynamic line count via CSS custom properties

**4. Integration in Views**
- Updated dataset view (`protected/views/dataset/view.php`) to apply auto-linking to file attributes and sample attributes
- Updated admin file form (`protected/views/adminFile/_form.php`) to use improved toggler for file attribute values
- Modified `FormattedDatasetSamples.php` to use new `fullAttrDesc()` method for sample attributes

## Any issues with implementation?

- The regex pattern for URL detection is conservative and only matches complete HTTP/HTTPS URLs to avoid false positives
- Some edge cases with malformed URLs may not be detected, but this is intentional to prevent security issues
- The line-clamp CSS feature has good browser support but may fall back to basic overflow behavior in very old browsers

## Any changes to automated tests?

Yes, comprehensive unit tests have been added:

**HtmlStringHelperTest (`tests/unit/HtmlStringHelperTest.php`)**
- Tests URL auto-linking functionality with various input scenarios
- Validates HTML sanitization and XSS prevention
- Covers edge cases like URLs within existing HTML links
- Tests handling of malicious content and script tag removal
- Includes test cases for URLs with query parameters, fragments, and complex paths

## Any changes to documentation?

No documentation changes were required for this internal functionality enhancement.

## Any technical debt repayment?

- Replaced the old JavaScript-based text truncation system with modern CSS-based line clamping
- Improved code organization by creating dedicated helper class for HTML/URL processing
- Enhanced security by implementing proper HTML sanitization
- Modernized CSS with CSS custom properties instead of hardcoded values

## Any improvements to CI/CD pipeline?

No changes to the CI/CD pipeline were made in this PR.
