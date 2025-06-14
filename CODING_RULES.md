# Coding Rules

## Build & Scripts
- Deploy the full stack locally with `./up.sh` (wraps Docker Compose and environment setup).
- Tests: `./tests/unit_functional_runner`, `./tests/unit_runner`, `./tests/functional_runner`, `./tests/acceptance_runner`.
- Run `composer install` to fetch PHP deps; add `--no-dev -o` in production.
- Use `npm run build` in `gigadb/app/client/web` to bundle the Vue/Webpack assets.
- Auto-rebuild frontend during dev with `./watch-vue.sh` (wraps chokidar + build + deploy).
- Lint PHP with `./bin/phpcs`; JS lint via project-specific eslint when present.
- E2E tests: `npx playwright test`; single PHPUnit test: append file path arg.

## Tech Stack
- PHP 7.4, Yii 1.1 core app; Yii 2 used for background tools/services.
- Frontend: legacy widgets use Vue 2 + Webpack; new widgets must use Vue 3 + Vite; plus jQuery 3, Bootstrap 3, FontAwesome 4, Less.
- Build: Webpack 4, lessphp, Docker & Docker-Compose orchestrate services.
- Package managers: Composer (backend) & npm (frontend).
- DB: PostgreSQL; web server: Nginx; AWS SDK PHP for S3.
- Testing libs: PHPUnit 5, Codeception 3, Playwright 1, Karma + Jasmine.

## Style
- Follow PSR-2 & PHPDoc; lint violations fail CI.
- Keep PHP functions ≤ 30 lines; files ≤ 300 lines.
- Adhere to WCAG 2.2 AA for all UI components.
- Structure CSS with SMACSS; organize Less by module.
- Avoid inline styles; manipulate DOM only through Vue or jQuery, never raw DOM APIs.
- Prefer explicit types & null-checks in PHP for readability.

## Naming
- PHP classes & filenames in PascalCase; controllers end with `Controller`.
- Models use singular nouns; DB tables snake_case plural; columns snake_case.
- JS variables camelCase; constants UPPER_SNAKE_CASE; CSS classes dash-case.
- Git branches: `new-feature/*`, `fix/*`, `release-*`, `hotfix-*`.
- Env vars SCREAMING_SNAKE_CASE; Docker service names kebab-case.
- Migration files timestamp_prefix + concise action (e.g., `20250412_add_user_idx`).

## Architecture
- Respect Yii MVC: controllers, models, views under `protected/*`.
- Shared services/behaviors live in `gigadb/app/{services,behaviors}` and DI-inject.
- Frontend source in `gigadb/app/client/web/src`; `npm run deploy` copies to `/var/www`.
- Store config in `.env`, `.secrets`, plus Docker secrets; never commit credentials.
- Tests: unit/functional in `tests/`, e2e in `playwright/`.
- Controllers call services; direct DB access only in models & DAOs.
- The project is migrating from Yii 1.1 to Yii 2, so expect mixed folder conventions.

## Misc
- All new UI must pass axe-core accessibility scans.
- Use Unleash feature flags for risky or phased roll-outs.
- Production branch is `develop`; tag every release there (one tag per deploy).
- Ignore compiled assets, vendor & secrets via `.gitignore`.