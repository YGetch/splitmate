# Checkpoint - Research and requirements (week 10)

**Project:** SplitMate - Shared Expenses \& Group Budget Tracker
**Team:** Vladyslav Olefir, Daryna Nevska
**Date of checkpoint:** *fill in*
**Repository:** *link to GitHub repo*

> Draft status: the sections marked \_TO CONFIRM\_ or \_TO VERIFY\_ must be checked by the team before the oral update.

\---

## 1\. Problem and target users

**Problem.** Friends on a trip or students sharing a dorm pay for common things at different times (accommodation, food, transport). The costs are usually tracked in chats, notes or spreadsheets, so it is hard to see who paid what, who owes whom, and receipts get lost.

**Target users.**

* Groups of students living together in a dorm or flat.
* Friends planning a trip with shared costs.

**Roles inside the system.**

* **Group creator (admin):** creates the group (trip or budget), invites members, manages categories.
* **Member:** adds expenses with a receipt photo, filters expenses, sees the balance and the printable report.

## 2\. Comparable solutions

*TO VERIFY: try each solution (or read its official page), take a screenshot and fill in the real strengths and limits.*

|Solution|What it does well|Limitation for our users|What SplitMate does|
|-|-|-|-|
|Splitwise|*verify*|*verify*|*verify*|
|Tricount|*verify*|*verify*|*verify*|
|Chat + spreadsheet|Free, no setup|No automatic balance, receipts scattered, errors|Single place with automatic balance and report|

## 3\. Key user workflows

**Workflow 1 - Create a group (creator).**

1. Register and log in.
2. Create a new group (trip or shared budget).
3. Add members and expense categories (housing, food, transport).

**Workflow 2 - Add and review expenses (member).**

1. Log in and open the group.
2. Add an expense: amount, date, category, who paid, receipt photo.
3. Filter expenses by category and payer, or by date range.
4. Open the summary: who owes whom, and the average spending per category.
5. Open the printable report for the trip or month.

## 4\. Initial backlog

**Must have**

* Registration, login, logout, two roles (creator, member)
* Groups and group members
* Categories
* Expenses: create, view list and details, edit, delete (with confirmation), receipt photo upload
* Search/filter by at least two criteria (category + payer, or date range)
* Calculated values: balance (who owes whom) and average per category
* Printable summary report
* Server-side validation and clear error messages
* Security: password hashing, sessions, CSRF protection, XSS escaping, prepared SQL statements
* Responsive, accessible interface; shared header and footer (authors, e-mail, year)
* README with installation steps and a demo account

**Should have**

* Cookie for a user setting (for example theme)
* Custom error pages (404, 403, 500)
* Asynchronous filtering without page reload
* Recording a payment between members ("settle up")

**Could have**

* Unequal splitting of an expense
* Several currencies
* CSV export
* Simple charts

## 5\. Team responsibilities - *TO CONFIRM with Daryna*

|Area|Vladyslav|Daryna|
|-|-|-|
|Main features|Authentication, roles, groups and members, balance calculation|Expenses (CRUD + receipt), categories, search/filter, printable report|
|Security|Passwords, sessions, CSRF|XSS and SQL injection in own parts, file upload checks|
|Testing|Tests Daryna's parts|Tests Vladyslav's parts|
|Together|Database schema and ER diagram, shared layout, responsive CSS, README, report, slides||

## 6\. Evidence for the oral update

* Repository link with commits from both team members
* This document
* *optional:* screenshots of the compared solutions, a sketch of the data model

## 7\. Open questions

* Confirm with the lecturer which checkpoints are expected and how to report the ones already passed.
* Agree on the final list of tables with the partner before writing `schema.sql`.

