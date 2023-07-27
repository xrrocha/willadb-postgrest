DROP TABLE IF EXISTS seed_row_columns;
DROP TABLE IF EXISTS seed_rows;
DROP TABLE IF EXISTS foreign_key_columns;
DROP TABLE IF EXISTS foreign_keys;
DROP TABLE IF EXISTS unique_key_columns;
DROP TABLE IF EXISTS unique_keys;
DROP TABLE IF EXISTS columns;
DROP TABLE IF EXISTS tables;
DROP TABLE IF EXISTS data_types;

CREATE TABLE data_types
(
    data_type     VARCHAR NOT NULL,
    position      NUMERIC NOT NULL,
    spec_regex    VARCHAR,
    default_regex VARCHAR,
    UNIQUE (data_type)
);

CREATE TABLE tables
(
    table_name VARCHAR NOT NULL,
    position   NUMERIC NOT NULL,
    UNIQUE (table_name)
);

CREATE TABLE columns
(
    table_name    VARCHAR NOT NULL,
    column_name   VARCHAR NOT NULL,
    position      NUMERIC,
    data_type     VARCHAR NOT NULL,
    nullable      BOOLEAN NOT NULL DEFAULT FALSE,
    default_value VARCHAR,
    UNIQUE (table_name, column_name),
    FOREIGN KEY (table_name) REFERENCES tables (table_name),
    FOREIGN KEY (data_type) REFERENCES data_types (data_type)
);

CREATE TABLE unique_keys
(
    table_name      VARCHAR NOT NULL,
    unique_key_name VARCHAR NOT NULL,
    UNIQUE (table_name, unique_key_name),
    FOREIGN KEY (table_name) REFERENCES tables (table_name)
);

CREATE TABLE unique_key_columns
(
    table_name      VARCHAR NOT NULL,
    unique_key_name VARCHAR NOT NULL,
    column_name     VARCHAR NOT NULL,
    UNIQUE (table_name, unique_key_name, column_name),
    FOREIGN KEY (table_name, unique_key_name) REFERENCES unique_keys (table_name, unique_key_name),
    FOREIGN KEY (table_name, column_name) REFERENCES columns (table_name, column_name)
);

CREATE TABLE foreign_keys
(
    referencing_table_name     VARCHAR NOT NULL,
    referenced_table_name      VARCHAR NOT NULL,
    referenced_unique_key_name VARCHAR NOT NULL,
    foreign_key_name           VARCHAR NOT NULL,
    UNIQUE (
            referencing_table_name,
            referenced_table_name,
            referenced_unique_key_name,
            foreign_key_name
        ),
    FOREIGN KEY (referencing_table_name) REFERENCES tables (table_name),
    FOREIGN KEY (referenced_table_name, referenced_unique_key_name) REFERENCES unique_keys (table_name, unique_key_name),
    UNIQUE (referencing_table_name, foreign_key_name),
    UNIQUE (referenced_table_name, foreign_key_name)
);

CREATE TABLE foreign_key_columns
(
    referencing_table_name     VARCHAR NOT NULL,
    referenced_table_name      VARCHAR NOT NULL,
    referenced_unique_key_name VARCHAR NOT NULL,
    foreign_key_name           VARCHAR NOT NULL,
    referencing_column_name    VARCHAR NOT NULL,
    referenced_column_name     VARCHAR NOT NULL,
    UNIQUE (
            referencing_table_name,
            referenced_table_name,
            referenced_unique_key_name,
            foreign_key_name,
            referencing_column_name
        ),
    FOREIGN KEY (
                 referencing_table_name,
                 referenced_table_name,
                 referenced_unique_key_name,
                 foreign_key_name
        ) REFERENCES foreign_keys (referencing_table_name, referenced_table_name, referenced_unique_key_name,
                                   foreign_key_name),
    FOREIGN KEY (
                 referencing_table_name,
                 referencing_column_name
        ) REFERENCES columns (table_name, column_name),
    FOREIGN KEY (
                 referenced_table_name,
                 referenced_unique_key_name,
                 referenced_column_name
        ) REFERENCES unique_key_columns (table_name, unique_key_name, column_name)
);

CREATE TABLE seed_rows
(
    table_name VARCHAR NOT NULL,
    position   NUMERIC NOT NULL,
    UNIQUE (table_name, position),
    FOREIGN KEY (table_name) REFERENCES tables (table_name)
);

CREATE TABLE seed_row_columns
(
    table_name   VARCHAR NOT NULL,
    position     NUMERIC NOT NULL,
    column_name  VARCHAR NOT NULL,
    column_value VARCHAR,
    UNIQUE (table_name, position, column_value),
    FOREIGN KEY (table_name, column_name) REFERENCES columns (table_name, column_name)
);
