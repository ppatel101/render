# User Management Application (Ruby on Rails + PostgreSQL)

A clean, production-grade **User Management CRUD application** built with standard Rails MVC architecture, modern pure CSS, and PostgreSQL.

---

## Technology Stack & Versions

* **Ruby**: `4.0.6` (Latest stable)
* **Ruby on Rails**: `8.1.3.1` (Latest stable)
* **Database**: `PostgreSQL 18.6`
* **Test Suite**: `Minitest` (Rails standard)
* **Frontend**: Pure semantic HTML5 + Responsive CSS (Zero frontend framework dependencies)

---

## Application Features & CRUD Operations

The application provides complete RESTful CRUD functionality for managing users:

1. **User Index (`GET /users` & `GET /`)**:
   * Lists all users sorted by most recently created.
   * Displays ID, Name, Email, Age, and action buttons.
   * Includes empty state handling when no users exist.
   * Direct CTA to create new users.

2. **User Show (`GET /users/:id`)**:
   * Displays full profile details including timestamps (created at, updated at).
   * Direct actions to edit, delete, or return to user listing.

3. **User Creation (`GET /users/new` & `POST /users`)**:
   * Form with real-time field attributes and validation error summaries.
   * Redirects with flash success banner upon creation.

4. **User Update (`GET /users/:id/edit` & `PATCH/PUT /users/:id`)**:
   * Pre-populated form partial for editing existing records.
   * Proper 422 Unprocessable Entity error handling.

5. **User Deletion (`DELETE /users/:id`)**:
   * Secure deletion with Turbo confirmation modal and redirect flash message.

---

## User Data Model & Database Schema

### Table: `users`

| Column | Type | Constraints / Modifiers |
|---|---|---|
| `id` | `bigint` | Primary Key, Auto-incrementing |
| `name` | `string` | `null: false` |
| `email` | `string` | `null: false`, Unique Index (`index_users_on_email`) |
| `age` | `integer` | Optional (allows `NULL`) |
| `created_at` | `datetime` | `null: false` |
| `updated_at` | `datetime` | `null: false` |

### Validations & Business Rules

* **Name**: Required (`presence: true`), trimmed of leading/trailing whitespace.
* **Email**: Required (`presence: true`), case-insensitive uniqueness (`uniqueness: { case_sensitive: false }`), standard format validation (`URI::MailTo::EMAIL_REGEXP`), downcased and trimmed automatically.
* **Age**: Optional, but if provided, must be a positive integer strictly greater than 0 (`numericality: { only_integer: true, greater_than: 0 }`).

---

## RESTful Routing

```text
Prefix    Verb   URI Pattern               Controller#Action
users     GET    /users(.:format)          users#index
          POST   /users(.:format)          users#create
new_user  GET    /users/new(.:format)      users#new
edit_user GET    /users/:id/edit(.:format) users#edit
user      GET    /users/:id(.:format)      users#show
          PATCH  /users/:id(.:format)      users#update
          PUT    /users/:id(.:format)      users#update
          DELETE /users/:id(.:format)      users#destroy
root      GET    /                         users#index
```

---

## Getting Started & Installation

### Prerequisites

Ensure you have the following installed on your machine:
* Ruby `>= 4.0.0`
* PostgreSQL `>= 14.0` (PostgreSQL 18.6 recommended)
* Bundler

### 1. Clone & Navigate to Project

```bash
git clone <repository-url>
cd parth
```

### 2. Install Gem Dependencies

```bash
bundle install
```

### 3. Setup the Database

Create development and test databases in PostgreSQL:

```bash
bin/rails db:create
```

Run migrations to apply the `users` schema:

```bash
bin/rails db:migrate
```

*(Optional)* Seed sample users:

```bash
bin/rails db:seed
```

### 4. Start the Rails Server

```bash
bin/rails server
```

Open your browser and navigate to:
```text
http://localhost:3000
```

---

## Running Automated Tests

Run the complete test suite:

```bash
bin/rails test
```

Run model unit tests:

```bash
bin/rails test test/models/user_test.rb
```

Run controller integration tests:

```bash
bin/rails test test/controllers/users_controller_test.rb
```

---

## Project Structure

```text
parth/
├── app/
│   ├── assets/
│   │   └── stylesheets/
│   │       └── application.css       # Clean, modern responsive pure CSS
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── users_controller.rb       # RESTful thin controller with strong parameters
│   ├── models/
│   │   ├── application_record.rb
│   │   └── user.rb                   # Validations, normalizations, database constraints
│   └── views/
│       ├── layouts/
│       │   └── application.html.erb  # Responsive layout with navbar and flash messages
│       └── users/
│           ├── _form.html.erb        # Shared form partial with error summary
│           ├── edit.html.erb         # User edit view
│           ├── index.html.erb        # User list table & empty state
│           ├── new.html.erb          # User creation view
│           └── show.html.erb         # User details view
├── config/
│   ├── database.yml                  # PostgreSQL database configuration
│   └── routes.rb                     # RESTful user resources and root route
├── db/
│   ├── migrate/
│   │   └── 20260824085034_create_users.rb
│   ├── schema.rb                     # PostgreSQL schema definition
│   └── seeds.rb                      # Sample user data
├── test/
│   ├── controllers/
│   │   └── users_controller_test.rb  # Integration tests for all CRUD actions
│   ├── fixtures/
│   │   └── users.yml                 # Test fixtures
│   └── models/
│       └── user_test.rb              # Comprehensive unit tests for model validations
├── Gemfile
└── README.md
```
