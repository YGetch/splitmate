# Week 11 Checkpoint: Planning and Design

## 1\. Technology Choices

* Runtime and backend: Node.js with Express.js (modular routing, middleware, Post/Redirect/Get pattern).
* Templates and frontend: EJS server-side templates (shared partials for header, navigation, and footer; automatic output escaping against XSS) and external responsive CSS3 tested at 360px, 768px, and 1280px, plus a print stylesheet (`@media print`).
* Database: SQLite via the `better-sqlite3` driver using parameterized queries against SQL injection and enforced foreign keys.
* Security and utilities: `bcrypt` for password hashing, `express-session` for session management and session ID regeneration on login, custom CSRF token middleware, `multer` for receipt image uploads, and `cookie-parser` for a non-sensitive theme preference cookie.
* Version control: Git and GitHub (`https://github.com/YGetch/splitmate`).

## 2\. Relational Data Model (ER Diagram)

The database schema (`database/schema.sql`) includes 6 relational tables with primary keys, foreign keys, `UNIQUE` and `CHECK` constraints, and referential actions:

* `ON DELETE CASCADE` when a group is removed (its members, categories, expenses and shares are removed with it).
* `ON DELETE RESTRICT` to prevent deleting categories, users or members that are linked to existing expenses.
* Composite foreign keys guarantee that the category and the payer of an expense belong to the same group as the expense.
* The role (`creator` or `member`) is stored per group in `group\_members`, because one user can be the creator of one group and an ordinary member of another.
* Money is stored as integer cents (`amount\_cents`, `share\_cents`) to avoid floating-point rounding errors in balance calculation.
* `expense\_shares` stores who owes what for each expense; it is the basis of the "who owes whom" balance.

```mermaid
erDiagram
    USERS ||--o{ GROUPS : "creates"
    USERS ||--o{ GROUP\_MEMBERS : "joins"
    GROUPS ||--o{ GROUP\_MEMBERS : "has"
    GROUPS ||--o{ CATEGORIES : "defines"
    GROUPS ||--o{ EXPENSES : "tracks"
    CATEGORIES ||--o{ EXPENSES : "classifies"
    USERS ||--o{ EXPENSES : "pays"
    EXPENSES ||--o{ EXPENSE\_SHARES : "is split into"
    USERS ||--o{ EXPENSE\_SHARES : "owes"

    USERS {
        int id PK
        string name
        string email UK
        string password\_hash
        datetime created\_at
    }
    GROUPS {
        int id PK
        string title
        string description
        string currency
        int created\_by FK
        datetime created\_at
    }
    GROUP\_MEMBERS {
        int id PK
        int group\_id FK
        int user\_id FK
        string role
        datetime joined\_at
    }
    CATEGORIES {
        int id PK
        int group\_id FK
        string name
    }
    EXPENSES {
        int id PK
        int group\_id FK
        int category\_id FK
        int paid\_by FK
        string title
        int amount\_cents
        date expense\_date
        string receipt\_path
        string notes
        datetime created\_at
    }
    EXPENSE\_SHARES {
        int id PK
        int expense\_id FK
        int user\_id FK
        int share\_cents
    }
```

## 3\. Work Plan (Weeks 11-14)

* Week 11 (Planning \& Design): Finalize tech stack, SQLite schema, ER diagram, site map, and wireframes (Vladyslav \& Daryna).
* Week 12 (Database \& Core Backend): Initialize SQLite DB with seed data, build user registration/login (bcrypt, sessions), role middleware, and first working CRUD flow (Vladyslav \& Daryna).
* Week 13 (Integrated Application): Complete expense CRUD (PRG + delete confirmation), receipt uploads (multer), multi-criteria JOIN search, debt balance calculation, preference cookie, print report, CSRF/XSS/SQLi protections, and responsive CSS (Vladyslav \& Daryna).
* Week 14 (Testing \& Release): Execute full test matrix, W3C HTML/CSS validation, clean-install ZIP check, technical report (6-10 pages), slides, and 3-minute demo video.

## 4\. Site Map and Access Levels

*To be added (Daryna): public area, authenticated member area, creator-only area.*

## 5\. Wireframes

*To be added (Daryna): key pages saved in `docs/wireframes/` and listed here.*

