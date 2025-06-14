## 1. Overview

GigaDB is an open–source web application that powers the public website (https://gigadb.org) hosting research datasets linked to papers published in the GigaScience journal.  The application allows authors, editors, and end–users to deposit, curate, browse, and download large scientific datasets, alongside APIs and administrative tooling.  The repository contains the full stack needed to run the service locally or in production – PHP application code (Yii 1.1), a growing migration layer towards Yii 2, frontend assets, Docker‐based infrastructure, and an extensive automated test‑suite.

---

## 2. Description of the codebase

### 2.1 High‑level architecture

| Layer | Main technology | Location | Notes |
|-------|-----------------|----------|-------|
| **Presentation** | jQuery 3, Bootstrap 3, Font‑Awesome 4, custom LESS → CSS | `css/`, `less/`, `js/`, `images/`, `fonts/` | Some Vue.js widgets are being introduced (`vite/`, `js/vue`)
| **Application** | PHP 7.4, **Yii 1.1.28** MVC framework | `protected/` | Classic Yii 1 directory layout (models, views, controllers, components, helpers, commands, migrations…)
| **API / Services** | REST(ish) controllers + service classes | `protected/controllers`, `protected/services` | Some new code uses namespaces under `GigaDB\`
| **Background / CLI** | Yii console commands, bash helpers | `protected/commands`, root‐level shell scripts (`up.sh`, test runners)
| **Data layer** | PostgreSQL 14‑ish (via Docker), Flysystem for S3 uploads | `protected/migrations`, `sql/`
| **Infrastructure** | Docker & docker‑compose, Nginx, cron, Playwright & Codeception test containers | `ops/`, root docker‑compose files
| **Tests** | PHPUnit (unit + functional), Behat (acceptance), Playwright (accessibility) | `protected/tests`, `features/`, `playwright/`

### 2.2 Key modules / folders

1. `protected/controllers` – MVC controllers exposing dataset pages, search, admin interfaces, API endpoints.
2. `protected/models` – ActiveRecord models mapping to PostgreSQL tables (`Dataset`, `Author`, `File`, etc.).
3. `protected/components` – Reusable Yii components: access control, helpers, mailers, filters.
4. `protected/migrations` – Database schema and data migrations split by environment (`schema`, `data.<env>`).
5. `protected/commands` – Console commands (eg. data import, cron helpers).
6. `protected/extensions` – Third‑party or custom Yii extensions (eg. Opauth for OAuth login).
7. `assets/`, `css/`, `less/`, `js/` – Static assets compiled via LESS and Vite.
8. `ops/` – Infrastructure‑as‑code: dockerfiles, compose overrides, sample env/secrets, CI scripts.
9. `tests/`, `features/`, `playwright/` – Automated testing at multiple levels.

### 2.3 Tool‑chain & dependencies

* PHP 7.4 with Composer packages (SwiftMailer, Flysystem, Twig, Unleash, etc.).
* Dual Yii versions: legacy Yii 1.1 **and** yii2 packages pulled in preparation for migration.
* Frontend: jQuery + Bootstrap; new Vite + Vue.js setup starting to appear.
* Testing: PHPUnit 5.7, Codeception 3, Behat 3, Playwright.
* CI/CD: GitLab pipelines (`.gitlab-ci.yml`) build Docker images, run tests, deploy.

---

## 3. Identified issues

### 3.1 Critical issues

1. **End‑of‑life PHP version (7.4)** – Security updates ended in Nov 2022; running EOL PHP exposes the service to unpatched vulnerabilities.
2. **Legacy Yii 1.1 framework** – Yii 1 stopped receiving security fixes in 2020.  Many upstream packages have dropped PHP 7 support.  Continuing maintenance is risky.
3. **Mixed framework versions** – Composer installs both Yii 1 and Yii 2 which inflates attack surface and increases cognitive load; the migration path is unclear and could introduce subtle bugs.
4. **Outdated frontend stack** – Bootstrap 3 and jQuery 3 are no longer actively developed; known XSS vulnerabilities may apply.
5. **Hard‑coded secrets in sample files** – Some placeholders look like real credentials (`.env.bk`); risk of accidental leakage.
6. **Large monolithic repository (>300 kLOC)** – Difficult onboarding, long CI times, higher merge‑conflict probability.

### 3.2 Important issues

1. **Coding standards drift** – Many files exceed 300 lines; functions exceed 30 lines, violating project style guide.
2. **Inconsistent namespace adoption** – Some models live in global namespace, others under `GigaDB\`, complicating autoloading.
3. **Duplicated logic** – Legacy services and new service classes coexist (eg. mail dispatch, file storage), causing divergence.
4. **Sparse type‑hinting / lack of strict_types** – Makes static analysis and PHP 8 migration harder.
5. **Test coverage gaps** – Unit tests exist but numerous controllers & services lack coverage; Playwright only covers a few critical paths.
6. **Manual migration scripts** – SQL in `/sql/` and bash scripts outside migrations can fall out of sync with code.
7. **CI only runs on Linux/Chrome** – No cross‑browser testing, accessibility coverage partial.

### 3.3 Minor issues

1. Legacy shell scripts (`up.sh`, `watch-vue.sh`) duplicate docker‑compose logic; could be replaced by Makefile.
2. Docs inconsistencies (README mentions Docker 18+, but sample compose files use newer syntax).
3. Dead assets & sample files (`sample.json`, `uppy-example.html`) left in root.
4. Some `.idea/`, `.history/` artefacts tracked in git.
5. Composer autoload classmap points to absolute `/var/www/...` paths – brittle for local development.

---

## 4. Remediation plan

### Phase 1 – Stabilisation (0‑3 months)

1. **Upgrade runtime to PHP 8.2** inside Docker images; run compatibility scan (Rector, PHP‑compatinfo).
2. **Lock dependencies** – Replace Yii 1 with maintained fork (if upgrade impossible) or back‑port security patches while migration occurs.
3. **Isolate secrets** – Remove committed sample secrets, use `.env.example` without real tokens; enforce git‑secrets pre‑commit hook.
4. **Harden CI** – Add SCA (Dependabot/Snyk), static analysis (PHPStan level 6, Psalm), and OWASP ZAP scan.

### Phase 2 – Modernisation (3‑9 months)

1. **Yii 2 (or Laravel/Symfony) migration** – Gradually port modules following Strangler‑Fig pattern; start with stateless APIs.
2. **Adopt Composer autoload with PSR‑4 throughout; refactor legacy classes into namespaces.**
3. **Replace Bootstrap 3/jQuery with modern UI kit (Bootstrap 5, Vue 3, or Tailwind + Alpine).**
4. **Enforce coding standards** via PHP‑CS‑Fixer & project rules; fail CI on violations.
5. **Increase automated test coverage to >80 %** – emphasise unit tests on migrated modules and Playwright e2e paths.

### Phase 3 – Optimisation (9‑12 months)

1. **Container rebuild** – Use multi‑stage builds, slim images, and separate prod vs dev Dockerfiles.
2. **Observability** – Instrument application with OpenTelemetry; ship logs/metrics to Prometheus + Grafana.
3. **Performance review** – Add query caching, lazy‑load large associations, enable HTTP/2 + Brotli on Nginx.
4. **Documentation & onboarding** – Consolidate docs under `docs/` with MkDocs; add architecture ADRs.

This phased approach mitigates critical risks early while providing a clear path towards a modern, maintainable, and secure GigaDB platform.
