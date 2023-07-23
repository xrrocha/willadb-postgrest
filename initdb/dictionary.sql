DROP TABLE IF EXISTS foreign_key_columns;

DROP TABLE IF EXISTS foreign_keys;

DROP TABLE IF EXISTS primary_key_columns;

DROP TABLE IF EXISTS columns;

DROP TABLE IF EXISTS tables;

CREATE TABLE tables (
    table_name VARCHAR NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (table_name)
);

CREATE TABLE columns (
    table_name VARCHAR NOT NULL,
    column_name VARCHAR NOT NULL,
    position INT,
    data_type VARCHAR NOT NULL,
    nullable BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (table_name, column_name),
    FOREIGN KEY (table_name) REFERENCES tables,
    CHECK (data_type IN ('varchar', 'numeric', 'boolean'))
);

CREATE TABLE primary_key_columns (
    table_name VARCHAR NOT NULL,
    column_name VARCHAR NOT NULL,
    PRIMARY KEY (table_name, column_name),
    FOREIGN KEY (table_name, column_name) REFERENCES columns
);

CREATE TABLE foreign_keys (
    referencing_table_name VARCHAR NOT NULL,
    referenced_table_name VARCHAR NOT NULL,
    foreign_key_name VARCHAR NOT NULL,
    PRIMARY KEY (
        referencing_table_name,
        referenced_table_name,
        foreign_key_name
    ),
    FOREIGN KEY (referencing_table_name) REFERENCES tables,
    FOREIGN KEY (referenced_table_name) REFERENCES tables,
    UNIQUE(referencing_table_name, foreign_key_name),
    UNIQUE(referenced_table_name, foreign_key_name)
);

CREATE TABLE foreign_key_columns (
    referencing_table_name VARCHAR NOT NULL,
    referenced_table_name VARCHAR NOT NULL,
    foreign_key_name VARCHAR NOT NULL,
    referencing_column_name VARCHAR NOT NULL,
    referenced_column_name VARCHAR NOT NULL,
    PRIMARY KEY (
        referencing_table_name,
        referenced_table_name,
        foreign_key_name,
        referencing_column_name
    ),
    FOREIGN KEY (
        referencing_table_name,
        referenced_table_name,
        foreign_key_name
    ) REFERENCES foreign_keys,
    FOREIGN KEY (referencing_table_name, referencing_column_name) REFERENCES columns,
    FOREIGN KEY (referenced_table_name, referenced_column_name) REFERENCES primary_key_columns
);

-- Tables
INSERT INTO tables (table_name, position) VALUES
    ('tables', 1),
    ('columns', 2),
    ('primary_key_columns', 3),
    ('foreign_keys', 4),
    ('foreign_key_columns', 5);

-- Columns
INSERT INTO
    columns (table_name, column_name, position, data_type, nullable)
VALUES
    ('tables', 'table_name', 1, 'varchar', FALSE),
    ('tables', 'position', 2, 'numeric', FALSE),
    ('columns', 'table_name', 1, 'varchar', FALSE),
    ('columns', 'column_name', 2, 'varchar', FALSE),
    ('columns', 'position', 3, 'numeric', FALSE),
    ('columns', 'data_type', 4, 'varchar', FALSE),
    ('columns', 'nullable', 5, 'boolean', FALSE),
    ('primary_key_columns', 'table_name', 1, 'varchar', FALSE),
    ('primary_key_columns', 'column_name', 2, 'varchar', FALSE),
    ('foreign_keys', 'referenced_table_name', 1, 'varchar', FALSE),
    ('foreign_keys', 'referencing_table_name', 2, 'varchar', FALSE),
    ('foreign_keys', 'foreign_key_name', 3, 'varchar', FALSE),
    ('foreign_key_columns', 'referencing_table_name', 1, 'varchar', FALSE),
    ('foreign_key_columns', 'referenced_table_name', 2, 'varchar', FALSE),
    ('foreign_key_columns', 'foreign_key_name', 3, 'varchar', FALSE),
    ('foreign_key_columns', 'referencing_column_name', 4, 'varchar', FALSE),
    ('foreign_key_columns', 'referenced_column_name', 5, 'varchar', FALSE);

-- Primary Key Columns
INSERT INTO
    primary_key_columns (table_name, column_name)
VALUES
    ('tables', 'table_name'),
    ('columns', 'table_name'),
    ('columns', 'column_name'),
    ('primary_key_columns', 'table_name'),
    ('primary_key_columns', 'column_name'),
    ('foreign_keys', 'referencing_table_name'),
    ('foreign_keys', 'referenced_table_name'),
    ('foreign_keys', 'foreign_key_name'),
    ('foreign_key_columns', 'referencing_table_name'),
    ('foreign_key_columns', 'referenced_table_name'),
    ('foreign_key_columns', 'foreign_key_name'),
    ('foreign_key_columns', 'referencing_column_name'),
    ('foreign_key_columns', 'referenced_column_name');

INSERT INTO
    foreign_keys(referencing_table_name, referenced_table_name, foreign_key_name)
VALUES
    ('columns', 'tables', 'column_table'),
    ('primary_key_columns', 'columns', 'pk_column'),
    ('foreign_keys', 'tables', 'fk_referencing_table'),
    ('foreign_keys', 'tables', 'fk_referenced_table'),
    ('foreign_key_columns', 'foreign_keys', 'fkc_foreign_key'),
    ('foreign_key_columns', 'columns', 'fkc_referencing_column'),
    ('foreign_key_columns', 'primary_key_columns', 'fkc_referenced_column');

INSERT INTO
    foreign_key_columns(referencing_table_name, referenced_table_name, foreign_key_name, referencing_column_name, referenced_column_name)
VALUES
    ('columns', 'tables', 'column_table', 'table_name', 'table_name'),
    ('primary_key_columns', 'columns', 'pk_column', 'table_name', 'table_name'),
    ('primary_key_columns', 'columns', 'pk_column', 'column_name', 'column_name'),
    ('foreign_keys', 'tables', 'fk_referencing_table', 'referencing_table_name', 'table_name'),
    ('foreign_keys', 'tables', 'fk_referenced_table', 'referenced_table_name', 'table_name'),
    ('foreign_key_columns', 'foreign_keys', 'fkc_foreign_key', 'referencing_table_name', 'referencing_table_name'),
    ('foreign_key_columns', 'foreign_keys', 'fkc_foreign_key', 'referenced_table_name', 'referenced_table_name'),
    ('foreign_key_columns', 'foreign_keys', 'fkc_foreign_key', 'foreign_key_name', 'foreign_key_name'),
    ('foreign_key_columns', 'columns', 'fkc_referencing_column', 'referencing_table_name', 'table_name'),
    ('foreign_key_columns', 'columns', 'fkc_referencing_column', 'referencing_column_name', 'column_name'),
    ('foreign_key_columns', 'primary_key_columns', 'fkc_referenced_column', 'referenced_table_name', 'table_name'),
    ('foreign_key_columns', 'primary_key_columns', 'fkc_referenced_column', 'referenced_column_name', 'column_name');