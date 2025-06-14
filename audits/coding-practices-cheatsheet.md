# GigaDB Website Coding Practices Cheatsheet

This cheatsheet summarizes the key coding conventions, best practices, and rules applied in the GigaDB website codebase. Use this as a reference for all new and ongoing development.

---

## 1. **General Project Structure**
- **MVC Architecture:** Follows Yii 1.1 MVC (Models, Views, Controllers) with clear separation of concerns.
- **Repository Pattern:** Used for data access in models.
- **Directory Layout:**
  - `protected/models/`, `protected/controllers/`, `protected/views/` for core app logic
  - `less/`, `css/`, `js/` for frontend assets
  - `tests/` for automated tests (unit, functional, acceptance)
  - `style-guide/` for UI/UX and CSS conventions
- **Sensitive Data:** Managed via `.env` and `.secrets` files (never commit credentials).
- **Environment Config:** Use environment variables for deployment-specific settings (see `.gitlab-ci.yml`, `docs/SETUP_CI_CD_PIPELINE.md`).

---

## 2. **PHP Coding Standards**
- **Version:** PHP 7.4+
- **Framework:** Yii 1.1
- **Coding Style:**
  - **PSR-2** enforced via PHP_CodeSniffer (`ops/configuration/phpcs-conf/phpcs.psr2.xml`)
  - **PHPDoc** required for all classes, methods, and properties (`ops/configuration/phpcs-conf/phpcs.phpdoc.xml`)
  - **File Length:** Avoid files >300 lines
  - **Function Length:** Avoid functions >30 lines
  - **Naming:**
    - Classes: `CamelCase`
    - Methods: `camelCase`
    - Properties: `camelCase`
    - Constants: `UPPER_SNAKE_CASE`
  - **Controllers:** Suffix with `Controller` (e.g., `UserController`)
  - **Models:** Suffix with model name (e.g., `User`, `Project`)
  - **Views:** Use `.php` files, named after the action (e.g., `update.php`)
- **Yii Best Practices:**
  - Use `CActiveRecord` for models
  - Use `rules()`, `relations()`, `attributeLabels()` in models
  - Use `filters()`, `accessRules()` in controllers
  - Use `render()`/`renderPartial()` for views
  - Use scenario-based validation
- **Security:**
  - Never expose PII or credentials in code, logs, or documentation
  - Use secure password hashing (e.g., `sodium_crypto_pwhash_str`)
  - Validate all user input (see model `rules()`)
  - Follow [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
- **Testing:**
  - Use Codeception and PHPUnit for unit, functional, and acceptance tests
  - Write automated tests for all code changes
  - Ensure all tests pass before merging

---

## 3. **JavaScript Coding Standards**
- **Tech:** Modern JS (ES6+), Vue.js for widgets, jQuery 3 for DOM
- **File Location:**
  - New JS: `giga/app/client/js/` (do not add to `protected/js/`)
  - Import JS modules in PHP via `Yii::app()->clientScript->registerScriptFile(..., ['type' => 'module'])`
- **Best Practices:**
  - Write JS as modules
  - Use `import`/`export` syntax
  - Use jQuery for DOM manipulation
  - Avoid direct DOM API unless necessary
  - Use clear, descriptive variable and function names
  - Keep functions short and focused
  - Document complex logic with comments
  - Prefer object type arguments for functions with >2 parameters
  - **File Length:** Avoid files >300 lines
  - **Function Length:** Avoid functions >30 lines
- **Widget Rules:**
  - Place new widgets in `giga/app/client/js/widgets/`
  - Structure as reusable Vue components where possible

---

## 4. **CSS/LESS Coding Standards**
- **Tech:** LESS, Bootstrap 3, Font Awesome 4
- **Architecture:**
  - **SMACSS** methodology (see `less-rules` and `smaccs` rules)
    - **Base:** Default element styles
    - **Layout:** `.l-*` classes for page skeleton
    - **Modules:** `.my-module-*` for reusable components
    - **State:** `.is-*` for UI states
    - **Theme:** `.theme-*` for theme overrides
  - **Directory Structure:**
    - `less/base/`, `less/layout/`, `less/modules/`, `less/pages/`
- **Best Practices:**
  - Never hardcode colors; use variables from `less/base/variables.less`
  - Desktop-first: use media queries for mobile
  - Keep UI minimal and world-class
  - Avoid deep selector nesting
  - Group CSS properties logically (box model, typography, visual)
  - Use ARIA attributes and semantic HTML for accessibility

---

## 5. **Git & Commit Conventions**
- **Branching:**
  - Use `develop` for ongoing work, `release-*` for releases, `feature/*` and `fix/*` for features/bugs
  - Use `--no-ff` merges to preserve branch history
- **Commits:**
  - Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
  - Reference related issue numbers in commit messages
  - Use `.commit-template` for commit formatting
  - Squash trial-and-error commits before PR
- **Pull Requests:**
  - Keep PRs small and focused
  - Link to related issues
  - Use [Conventional Comments](https://conventionalcomments.org/) for code review

---

## 6. **Testing & Acceptance Criteria**
- **Acceptance Tests:**
  - Use Gherkin syntax in `tests/acceptance/`
  - Each scenario: 1 Given, 1 When, 1 Then (add "And" as needed)
  - Support functions in `tests/_support/`; reuse existing functions
- **Unit/Functional Tests:**
  - Use Codeception and PHPUnit
  - Place tests in `tests/unit/` and `tests/functional/`
- **CI/CD:**
  - All tests must pass in GitLab CI before merge

---

## 7. **Security & Compliance**
- **Security Policy:**
  - Report vulnerabilities to [tech AT gigasciencejournal.com]
  - Never commit secrets, passwords, or PII
  - Review [OWASP Docker Security](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
  - Use safe shell scripting ([MIT SIPB Safe Shell](https://sipb.mit.edu/doc/safe-shell/))
- **Access Control:**
  - Use Yii's `accessRules()` for controller actions
  - Validate all user input and output
- **Environment Variables:**
  - Store all credentials and sensitive config in environment variables or `.env` files
  - Use GitLab CI/CD variables for deployment

---

## 8. **Accessibility (WCAG 2.2)**
- **UI:**
  - Follow WCAG 2.2 standards for all user-facing features
  - Use semantic HTML and ARIA attributes
  - Ensure forms are accessible (labels, error messages, keyboard navigation)
  - Test with screen readers and keyboard-only navigation

---

## 9. **Docker & Deployment**
- **Containerization:**
  - Use Docker and Docker Compose for local development and deployment
  - Nginx as web server, PostgreSQL as database
  - Use environment variables for all deployment-specific config
- **CI/CD:**
  - Use GitLab CI/CD for automated builds, tests, and deployments
  - Stages: conformance, build, test, deploy

---

## 10. **Additional Resources**
- [SMACSS Documentation](https://smacss.com/)
- [Yii 1.1 Guide](https://www.yiiframework.com/doc/guide/1.1/en)
- [WCAG 2.2 Guidelines](https://www.w3.org/WAI/WCAG22/quickref/)
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

---

## Appendix: Frequently Asked Questions

### What is PII?
**PII** stands for **Personally Identifiable Information**. It refers to any data that could potentially identify a specific individual. Examples include names, email addresses, phone numbers, government IDs, IP addresses, and any other information that can be used to distinguish or trace an individual's identity. Protecting PII is critical for privacy and legal compliance.

### What is PHPDoc?
**PHPDoc** is a documentation standard for PHP code. It uses special comment blocks (starting with `/** ... */`) to describe the purpose, parameters, return values, and other metadata for classes, methods, and properties. PHPDoc comments are used by IDEs and documentation generators to provide code hints, type checking, and generate API documentation. Example:

```php
/**
 * Calculates the sum of two numbers.
 *
 * @param int $a First number
 * @param int $b Second number
 * @return int The sum of $a and $b
 */
function add($a, $b) {
    return $a + $b;
}
```

### What is safe shell scripting?
**Safe shell scripting** refers to writing shell scripts (e.g., Bash, Zsh) in a way that avoids common security pitfalls and bugs. This includes practices such as:
- Quoting variables to prevent word splitting and globbing
- Checking exit codes of commands
- Avoiding use of insecure temporary files
- Not running scripts as root unless necessary
- Validating and sanitizing user input
- Using `set -euo pipefail` to catch errors early

A good reference is the [MIT SIPB Safe Shell Programming guide](https://sipb.mit.edu/doc/safe-shell/), which provides detailed tips and examples for writing robust and secure shell scripts.

---

**Always check for updates to this cheatsheet and consult the codebase's documentation and style guides before starting new work.**