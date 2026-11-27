PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    currency TEXT NOT NULL DEFAULT 'EUR',
    created_by INTEGER NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT
);

-- The role lives here, not in users: the same person can be the creator of one
-- group and an ordinary member of another.
CREATE TABLE IF NOT EXISTS group_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('creator', 'member')),
    joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (group_id, user_id),
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    UNIQUE (group_id, name),
    UNIQUE (id, group_id),  -- needed for the composite foreign key in expenses
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE
);

-- Money is stored in integer cents to avoid floating-point rounding errors
-- when balances are calculated (for example 0.1 + 0.2).
CREATE TABLE IF NOT EXISTS expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    paid_by INTEGER NOT NULL,
    title TEXT NOT NULL,
    amount_cents INTEGER NOT NULL CHECK (amount_cents > 0),
    expense_date DATE NOT NULL,
    receipt_path TEXT,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE,
    -- the category must belong to the same group as the expense
    FOREIGN KEY (category_id, group_id) REFERENCES categories(id, group_id) ON DELETE RESTRICT,
    -- the payer must be a member of the same group
    FOREIGN KEY (group_id, paid_by) REFERENCES group_members(group_id, user_id) ON DELETE RESTRICT
);

-- Who owes what for each expense. The sum of share_cents of one expense must
-- equal expenses.amount_cents (checked in the application code).
CREATE TABLE IF NOT EXISTS expense_shares (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expense_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    share_cents INTEGER NOT NULL CHECK (share_cents >= 0),
    UNIQUE (expense_id, user_id),
    FOREIGN KEY (expense_id) REFERENCES expenses(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_expenses_group_date ON expenses (group_id, expense_date);
CREATE INDEX IF NOT EXISTS idx_expenses_group_category ON expenses (group_id, category_id);
CREATE INDEX IF NOT EXISTS idx_expenses_group_payer ON expenses (group_id, paid_by);
