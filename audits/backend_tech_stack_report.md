# Backend Technology Stack and Architecture Report

This report outlines the key technologies, architectural patterns, and practices you should focus on to effectively work on the backend of this project.

## Core Technologies

*   **PHP version 7.4+**: This is the primary server-side scripting language. You will need a solid understanding of PHP fundamentals, including object-oriented programming (OOP) concepts, common data structures, and its standard library.
*   **Yii 1.1 Framework**: This is the core PHP framework used in the project. It's crucial to learn:
    *   **Model-View-Controller (MVC) Architecture**: Understand how Yii implements MVC to structure applications.
    *   **Controllers**: How they handle incoming requests and interact with models and views.
    *   **Models**: How they represent data and business logic, including database interactions (Active Record pattern is common in Yii).
    *   **Views**: How they render the presentation layer, though your focus is backend, understanding how data is passed to views is important.
    *   **Yii's conventions and components**: Familiarize yourself with Yii's directory structure, configuration, components (like CActiveRecord, CWebUser), and helper classes.
*   **PostgreSQL**: This is the relational database system used. You should be comfortable with:
    *   SQL fundamentals (queries, joins, indexing).
    *   PostgreSQL-specific features and syntax if they are heavily used.
    *   Database design principles.
*   **Composer**: This is the dependency manager for PHP. Learn how to:
    *   Declare and manage project dependencies in `composer.json`.
    *   Install and update packages.
    *   Understand autoloading.

## Architecture and Best Practices

*   **Yii's MVC Architecture & Repository Pattern**: The project adheres to Yii's MVC structure and utilizes the repository pattern. Focus on how these patterns are implemented to separate concerns and manage data access.
*   **Separation of Concerns**: Maintain clear boundaries between different parts of the application (e.g., business logic in models, request handling in controllers, data access in repositories if used).
*   **PHP CodeSniffer (PSR-2 and PHPDoc rules)**: The project enforces standard PHP coding styles. Familiarize yourself with PSR-2 coding style guidelines and PHPDoc standards for documenting code. Setting up your IDE to use PHP CodeSniffer will be beneficial.
*   **Sensitive Credentials and Environment Variables**: These are managed via `.env` and `.secrets` files. Understand how the application loads and uses these configurations, and the importance of not committing sensitive data to version control.

## Development and Deployment Environment

*   **Docker and Docker Compose**: These tools are used for containerized development and deployment. You'll need to understand:
    *   Basic Docker concepts (images, containers, Dockerfile).
    *   How to use Docker Compose to define and run multi-container applications (`docker-compose.yml`).
    *   How to manage development environments using these tools.
*   **Nginx**: This is the web server. While deep Nginx configuration might not be immediately required, understanding its role and basic configuration related to PHP-FPM (which PHP often uses with Nginx) can be helpful.
*   **GitLab CI/CD**: This is used for continuous integration and deployment. Understanding the basics of CI/CD pipelines and how they are configured in GitLab (`.gitlab-ci.yml`) will be useful for understanding the deployment process.

## Testing

*   **Codeception and PHPUnit**: These are the testing tools used for unit, functional, and acceptance tests. A strong understanding of testing principles and how to write tests using these frameworks is essential for backend development.

## Key Areas to Focus On:

1.  **PHP 7.4+ deep dive**: Beyond syntax, understand its OOP features, error handling, and performance aspects.
2.  **Yii 1.1 Mastery**: This is critical. Go through the official Yii 1.1 guide and documentation. Pay special attention to the MVC implementation, database interaction (Active Record), form handling, and security features.
3.  **Database Interaction**: Practice writing efficient SQL queries for PostgreSQL and understand how Yii's ORM (Active Record) maps to database tables.
4.  **Docker Workflow**: Get comfortable building and running the application using Docker and Docker Compose for your local development.
5.  **Testing Practices**: Learn to write effective unit and functional tests using PHPUnit and Codeception.

By focusing on these areas, you will be well-equipped to contribute to the backend development of the GigaDB project.