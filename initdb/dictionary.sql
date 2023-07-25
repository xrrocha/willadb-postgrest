DROP TABLE IF EXISTS seed_rows;

DROP TABLE IF EXISTS seed_row_columns;

DROP TABLE IF EXISTS foreign_key_columns;

DROP TABLE IF EXISTS foreign_keys;

ALTER TABLE
    tables DROP CONSTRAINT IF EXISTS fk_tables_unique_keys;

DROP TABLE IF EXISTS unique_key_columns;

DROP TABLE IF EXISTS unique_keys;

DROP TABLE IF EXISTS columns;

DROP TABLE IF EXISTS tables;

DROP TABLE IF EXISTS data_types;

CREATE TABLE data_types (
    data_type VARCHAR NOT NULL,
    position INT NOT NULL,
    -- spec regex,
    -- default value regex
    PRIMARY KEY(data_type)
);

INSERT INTO
    data_types(data_type, position)
VALUES
    ('varchar', 1),
    ('numeric', 2),
    ('boolean', 3),
    ('date', 4);

CREATE TABLE tables (
    table_name VARCHAR NOT NULL,
    position INT NOT NULL,
    -- TODO Is a partially null FK allowed in all RDBMS?
    primary_key_name VARCHAR,
    PRIMARY KEY (table_name)
);

CREATE TABLE columns (
    table_name VARCHAR NOT NULL,
    column_name VARCHAR NOT NULL,
    position INT,
    data_type VARCHAR NOT NULL,
    nullable BOOLEAN NOT NULL DEFAULT FALSE,
    default_value VARCHAR,
    PRIMARY KEY (table_name, column_name),
    FOREIGN KEY (table_name) REFERENCES tables,
    FOREIGN KEY (data_type) REFERENCES data_types
);

CREATE TABLE unique_keys (
    table_name VARCHAR NOT NULL,
    uk_name VARCHAR NOT NULL,
    PRIMARY KEY(table_name, uk_name),
    FOREIGN KEY(table_name) REFERENCES tables
);

ALTER TABLE
    tables
ADD
    CONSTRAINT fk_tables_unique_keys FOREIGN KEY (table_name, primary_key_name) REFERENCES unique_keys (table_name, uk_name);

CREATE TABLE unique_key_columns (
    table_name VARCHAR NOT NULL,
    uk_name VARCHAR NOT NULL,
    column_name VARCHAR NOT NULL,
    PRIMARY KEY (table_name, uk_name, column_name),
    FOREIGN KEY (table_name, uk_name) REFERENCES unique_keys,
    FOREIGN KEY (table_name, column_name) REFERENCES columns
);

CREATE TABLE foreign_keys (
    referencing_table_name VARCHAR NOT NULL,
    referenced_table_name VARCHAR NOT NULL,
    referenced_uk_name VARCHAR NOT NULL,
    foreign_key_name VARCHAR NOT NULL,
    PRIMARY KEY (
        referencing_table_name,
        referenced_table_name,
        referenced_uk_name,
        foreign_key_name
    ),
    FOREIGN KEY (referencing_table_name) REFERENCES tables,
    FOREIGN KEY (referenced_table_name, referenced_uk_name) REFERENCES unique_keys,
    UNIQUE(referencing_table_name, foreign_key_name),
    UNIQUE(referenced_table_name, foreign_key_name)
);

CREATE TABLE foreign_key_columns (
    referencing_table_name VARCHAR NOT NULL,
    referenced_table_name VARCHAR NOT NULL,
    referenced_uk_name VARCHAR NOT NULL,
    foreign_key_name VARCHAR NOT NULL,
    referencing_column_name VARCHAR NOT NULL,
    referenced_column_name VARCHAR NOT NULL,
    PRIMARY KEY (
        referencing_table_name,
        referenced_table_name,
        referenced_uk_name,
        foreign_key_name,
        referencing_column_name
    ),
    FOREIGN KEY (
        referencing_table_name,
        referenced_table_name,
        referenced_uk_name,
        foreign_key_name
    ) REFERENCES foreign_keys,
    FOREIGN KEY (
        referencing_table_name,
        referencing_column_name
    ) REFERENCES columns,
    FOREIGN KEY (
        referenced_table_name,
        referenced_uk_name,
        referenced_column_name
    ) REFERENCES unique_key_columns
);

CREATE TABLE seed_rows (
    table_name VARCHAR NOT NULL,
    position NUMERIC NOT NULL,
    PRIMARY KEY(table_name, position),
    FOREIGN KEY(table_name) REFERENCES tables
);

CREATE TABLE seed_row_columns (
    table_name VARCHAR NOT NULL,
    position NUMERIC NOT NULL,
    column_name VARCHAR NOT NULL,
    column_value VARCHAR,
    PRIMARY KEY(table_name, position, column_value),
    FOREIGN KEY(table_name, column_name) REFERENCES columns
);

-- tables
INSERT INTO
    tables (table_name, position)
VALUES
    ('data_types', 1),
    ('tables', 2),
    ('columns', 3),
    ('unique_keys', 4),
    ('unique_key_columns', 5),
    ('foreign_keys', 6),
    ('foreign_key_columns', 7),
    ('seed_rows', 8),
    ('seed_row_columns', 9);

-- columns
INSERT INTO
    columns (
        table_name,
        column_name,
        position,
        data_type,
        nullable,
        default_value
    )
VALUES
    (
        'data_types',
        'data_type',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'data_types',
        'position',
        2,
        'numeric',
        FALSE,
        NULL
    ),
    (
        'tables',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    ('tables', 'position', 2, 'numeric', FALSE, NULL),
    (
        'columns',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'columns',
        'column_name',
        2,
        'varchar',
        FALSE,
        NULL
    ),
    ('columns', 'position', 3, 'numeric', FALSE, NULL),
    (
        'columns',
        'data_type',
        4,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'columns',
        'nullable',
        5,
        'boolean',
        FALSE,
        'false'
    ),
    (
        'unique_keys',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'unique_keys',
        'uk_name',
        2,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'unique_key_columns',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'unique_key_columns',
        'uk_name',
        2,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'unique_key_columns',
        'column_name',
        3,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_keys',
        'referencing_table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_keys',
        'referenced_table_name',
        2,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_keys',
        'referenced_uk_name',
        3,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_keys',
        'foreign_key_name',
        4,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'referencing_table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'referenced_table_name',
        2,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'referenced_uk_name',
        3,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'foreign_key_name',
        4,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'referencing_column_name',
        5,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'foreign_key_columns',
        'referenced_column_name',
        6,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'seed_rows',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'seed_rows',
        'position',
        2,
        'numeric',
        FALSE,
        NULL
    ),
    (
        'seed_row_columns',
        'table_name',
        1,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'seed_row_columns',
        'position',
        2,
        'numeric',
        FALSE,
        NULL
    ),
    (
        'seed_row_columns',
        'column_name',
        3,
        'varchar',
        FALSE,
        NULL
    ),
    (
        'seed_row_columns',
        'column_value',
        4,
        'varchar',
        FALSE,
        NULL
    );

-- Unique Keys
INSERT INTO
    unique_keys (table_name, uk_name)
VALUES
    ('data_types', 'pk'),
    ('tables', 'pk'),
    ('columns', 'pk'),
    ('unique_keys', 'pk'),
    ('unique_key_columns', 'pk'),
    ('foreign_keys', 'pk'),
    ('foreign_key_columns', 'pk'),
    ('seed_rows', 'pk'),
    ('seed_row_columns', 'pk');

UPDATE
    tables
SET
    primary_key_name = 'pk'
WHERE
    table_name in(
        'data_types',
        'tables',
        'columns',
        'unique_keys',
        'unique_key_columns',
        'foreign_keys',
        'foreign_key_columns',
        'seed_rows',
        'seed_row_columns'
    );

-- Unique Key columns
INSERT INTO
    unique_key_columns (table_name, uk_name, column_name)
VALUES
    ('data_types', 'pk', 'data_type'),
    ('tables', 'pk', 'table_name'),
    ('columns', 'pk', 'table_name'),
    ('columns', 'pk', 'column_name'),
    ('unique_keys', 'pk', 'table_name'),
    ('unique_keys', 'pk', 'uk_name'),
    ('unique_key_columns', 'pk', 'table_name'),
    ('unique_key_columns', 'pk', 'uk_name'),
    ('unique_key_columns', 'pk', 'column_name'),
    ('foreign_keys', 'pk', 'referencing_table_name'),
    ('foreign_keys', 'pk', 'referenced_table_name'),
    ('foreign_keys', 'pk', 'referenced_uk_name'),
    ('foreign_keys', 'pk', 'foreign_key_name'),
    (
        'foreign_key_columns',
        'pk',
        'referencing_table_name'
    ),
    (
        'foreign_key_columns',
        'pk',
        'referenced_table_name'
    ),
    (
        'foreign_key_columns',
        'pk',
        'referenced_uk_name'
    ),
    ('foreign_key_columns', 'pk', 'foreign_key_name'),
    (
        'foreign_key_columns',
        'pk',
        'referencing_column_name'
    ),
    (
        'foreign_key_columns',
        'pk',
        'referenced_column_name'
    ),
    ('seed_rows', 'pk', 'table_name'),
    ('seed_rows', 'pk', 'position'),
    ('seed_row_columns', 'pk', 'table_name'),
    ('seed_row_columns', 'pk', 'position'),
    ('seed_row_columns', 'pk', 'column_name');

INSERT INTO
    foreign_keys(
        referencing_table_name,
        referenced_table_name,
        referenced_uk_name,
        foreign_key_name
    )
VALUES
    ('columns', 'tables', 'pk', 'column_table'),
    (
        'unique_key_columns',
        'columns',
        'pk',
        'pk_column'
    ),
    (
        'foreign_keys',
        'tables',
        'pk',
        'fk_referencing_table'
    ),
    (
        'foreign_keys',
        'tables',
        'pk',
        'fk_referenced_table'
    ),
    (
        'foreign_key_columns',
        'foreign_keys',
        'pk',
        'fkc_foreign_key'
    ),
    (
        'foreign_key_columns',
        'columns',
        'pk',
        'fkc_referencing_column'
    ),
    (
        'foreign_key_columns',
        'unique_key_columns',
        'pk',
        'fkc_referenced_column'
    ),
    (
        'seed_rows',
        'tables',
        'pk',
        'fk_table'
    ),
    (
        'seed_row_columns',
        'seed_rows',
        'pk',
        'fk_row'
    );

INSERT INTO
    foreign_key_columns(
        referencing_table_name,
        referenced_table_name,
        referenced_uk_name,
        foreign_key_name,
        referencing_column_name,
        referenced_column_name
    )
VALUES
    (
        'columns',
        'tables',
        'pk',
        'column_table',
        'table_name',
        'table_name'
    ),
    (
        'unique_key_columns',
        'columns',
        'pk',
        'pk_column',
        'table_name',
        'table_name'
    ),
    (
        'unique_key_columns',
        'columns',
        'pk',
        'pk_column',
        'column_name',
        'column_name'
    ),
    (
        'foreign_keys',
        'tables',
        'pk',
        'fk_referencing_table',
        'referencing_table_name',
        'table_name'
    ),
    (
        'foreign_keys',
        'tables',
        'pk',
        'fk_referenced_table',
        'referenced_table_name',
        'table_name'
    ),
    (
        'foreign_key_columns',
        'foreign_keys',
        'pk',
        'fkc_foreign_key',
        'referencing_table_name',
        'referencing_table_name'
    ),
    (
        'foreign_key_columns',
        'foreign_keys',
        'pk',
        'fkc_foreign_key',
        'referenced_table_name',
        'referenced_table_name'
    ),
    (
        'foreign_key_columns',
        'foreign_keys',
        'pk',
        'fkc_foreign_key',
        'foreign_key_name',
        'foreign_key_name'
    ),
    (
        'foreign_key_columns',
        'columns',
        'pk',
        'fkc_referencing_column',
        'referencing_table_name',
        'table_name'
    ),
    (
        'foreign_key_columns',
        'columns',
        'pk',
        'fkc_referencing_column',
        'referencing_column_name',
        'column_name'
    ),
    (
        'foreign_key_columns',
        'unique_key_columns',
        'pk',
        'fkc_referenced_column',
        'referenced_table_name',
        'table_name'
    ),
    (
        'foreign_key_columns',
        'unique_key_columns',
        'pk',
        'fkc_referenced_column',
        'referenced_column_name',
        'column_name'
    ),
    (
        'seed_rows',
        'tables',
        'pk',
        'fk_table',
        'table_name',
        'table_name'
    ),
    (
        'seed_row_columns',
        'seed_rows',
        'pk',
        'fk_row',
        'table_name',
        'table_name'
    ),
    (
        'seed_row_columns',
        'seed_rows',
        'pk',
        'fk_row',
        'position',
        'position'
    );

INSERT INTO
    seed_rows(table_name, position)
VALUES
    ('data_types', 1),
    ('data_types', 2),
    ('data_types', 3),
    ('data_types', 4);

INSERT INTO
    seed_row_columns(table_name, position, column_name, column_value)
VALUES
    ('data_types', 1, 'data_type', 'varchar'),
    ('data_types', 1, 'position', '1'),
    ('data_types', 2, 'data_type', 'varchar'),
    ('data_types', 2, 'position', '2'),
    ('data_types', 3, 'data_type', 'varchar'),
    ('data_types', 3, 'position', '3'),
    ('data_types', 4, 'data_type', 'varchar'),
    ('data_types', 4, 'position', '4');