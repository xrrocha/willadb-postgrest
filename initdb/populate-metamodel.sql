TRUNCATE TABLE seed_row_columns CASCADE;
TRUNCATE TABLE seed_rows CASCADE;
TRUNCATE TABLE foreign_key_columns CASCADE;
TRUNCATE TABLE foreign_keys CASCADE;
TRUNCATE TABLE unique_key_columns CASCADE;
TRUNCATE TABLE unique_keys CASCADE;
TRUNCATE TABLE columns CASCADE;
TRUNCATE TABLE tables CASCADE;
TRUNCATE TABLE data_types CASCADE;

INSERT INTO data_types(data_type, position, spec_regex, default_regex)
VALUES ('varchar', 1, null, null),
       ('numeric', 2, '[0-9]+(,\s*[0-9]+)?', '[0-9]+(\.[0-9]+)?'),
       ('boolean', 3, null, 'true|false'),
       ('date', 4, null, '[0-9]{4}-[0-9]{2}-[0-9]{2}');

INSERT INTO tables (table_name, position)
VALUES ('data_types', 1),
       ('tables', 2),
       ('columns', 3),
       ('unique_keys', 4),
       ('unique_key_columns', 5),
       ('foreign_keys', 6),
       ('foreign_key_columns', 7),
       ('seed_rows', 8),
       ('seed_row_columns', 9);

INSERT INTO columns (table_name,
                     column_name,
                     position,
                     data_type,
                     nullable,
                     default_value)
VALUES ('data_types', 'data_type', 1, 'varchar', FALSE, NULL),
       ('data_types', 'position', 2, 'numeric', FALSE, NULL),
       ('data_types', 'spec_regex', 3, 'varchar', TRUE, NULL),
       ('data_types', 'default_regex', 4, 'varchar', TRUE, NULL),
       ('tables', 'table_name', 1, 'varchar', FALSE, NULL),
       ('tables', 'position', 2, 'numeric', FALSE, NULL),
       ('columns', 'table_name', 1, 'varchar', FALSE, NULL),
       ('columns', 'column_name', 2, 'varchar', FALSE, NULL),
       ('columns', 'position', 3, 'numeric', FALSE, NULL),
       ('columns', 'data_type', 4, 'varchar', FALSE, NULL),
       ('columns', 'nullable', 5, 'boolean', FALSE, 'false'),
       ('unique_keys', 'table_name', 1, 'varchar', FALSE, NULL),
       ('unique_keys', 'unique_key_name', 2, 'varchar', FALSE, NULL),
       ('unique_key_columns', 'table_name', 1, 'varchar', FALSE, NULL),
       ('unique_key_columns', 'unique_key_name', 2, 'varchar', FALSE, NULL),
       ('unique_key_columns', 'column_name', 3, 'varchar', FALSE, NULL),
       ('foreign_keys', 'referencing_table_name', 1, 'varchar', FALSE, NULL),
       ('foreign_keys', 'referenced_table_name', 2, 'varchar', FALSE, NULL),
       ('foreign_keys', 'referenced_unique_key_name', 3, 'varchar', FALSE, NULL),
       ('foreign_keys', 'foreign_key_name', 4, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'referencing_table_name', 1, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'referenced_table_name', 2, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'referenced_unique_key_name', 3, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'foreign_key_name', 4, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'referencing_column_name', 5, 'varchar', FALSE, NULL),
       ('foreign_key_columns', 'referenced_column_name', 6, 'varchar', FALSE, NULL),
       ('seed_rows', 'table_name', 1, 'varchar', FALSE, NULL),
       ('seed_rows', 'position', 2, 'numeric', FALSE, NULL),
       ('seed_row_columns', 'table_name', 1, 'varchar', FALSE, NULL),
       ('seed_row_columns', 'position', 2, 'numeric', FALSE, NULL),
       ('seed_row_columns', 'column_name', 3, 'varchar', FALSE, NULL),
       ('seed_row_columns', 'column_value', 4, 'varchar', FALSE, NULL);

INSERT INTO unique_keys (table_name, unique_key_name)
VALUES ('data_types', 'pk'),
       ('tables', 'pk'),
       ('columns', 'pk'),
       ('unique_keys', 'pk'),
       ('unique_key_columns', 'pk'),
       ('foreign_keys', 'pk'),
       ('foreign_key_columns', 'pk'),
       ('seed_rows', 'pk'),
       ('seed_row_columns', 'pk');

INSERT INTO unique_key_columns (table_name, unique_key_name, column_name)
VALUES ('data_types', 'pk', 'data_type'),
       ('tables', 'pk', 'table_name'),
       ('columns', 'pk', 'table_name'),
       ('columns', 'pk', 'column_name'),
       ('unique_keys', 'pk', 'table_name'),
       ('unique_keys', 'pk', 'unique_key_name'),
       ('unique_key_columns', 'pk', 'table_name'),
       ('unique_key_columns', 'pk', 'unique_key_name'),
       ('unique_key_columns', 'pk', 'column_name'),
       ('foreign_keys', 'pk', 'referencing_table_name'),
       ('foreign_keys', 'pk', 'referenced_table_name'),
       ('foreign_keys', 'pk', 'referenced_unique_key_name'),
       ('foreign_keys', 'pk', 'foreign_key_name'),
       ('foreign_key_columns', 'pk', 'referencing_table_name'),
       ('foreign_key_columns', 'pk', 'referenced_table_name'),
       ('foreign_key_columns', 'pk', 'referenced_unique_key_name'),
       ('foreign_key_columns', 'pk', 'foreign_key_name'),
       ('foreign_key_columns', 'pk', 'referencing_column_name'),
       ('foreign_key_columns', 'pk', 'referenced_column_name'),
       ('seed_rows', 'pk', 'table_name'),
       ('seed_rows', 'pk', 'position'),
       ('seed_row_columns', 'pk', 'table_name'),
       ('seed_row_columns', 'pk', 'position'),
       ('seed_row_columns', 'pk', 'column_name');

INSERT INTO foreign_keys(referencing_table_name,
                         referenced_table_name,
                         referenced_unique_key_name,
                         foreign_key_name)
VALUES ('columns', 'tables', 'pk', 'column_table'),
       ('columns', 'data_types', 'pk', 'column_data_type'),
       ('unique_key_columns', 'columns', 'pk', 'pk_column'),
       ('foreign_keys', 'tables', 'pk', 'fk_referencing_table'),
       ('foreign_keys', 'tables', 'pk', 'fk_referenced_table'),
       ('foreign_key_columns', 'foreign_keys', 'pk', 'fk_foreign_key'),
       ('foreign_key_columns', 'columns', 'pk', 'fk_referencing_column'),
       ('foreign_key_columns', 'unique_key_columns', 'pk', 'fk_referenced_column'),
       ('seed_rows', 'tables', 'pk', 'fk_table'),
       ('seed_row_columns',
        'seed_rows', 'pk', 'fk_row');

INSERT INTO foreign_key_columns(referencing_table_name,
                                referenced_table_name,
                                referenced_unique_key_name,
                                foreign_key_name,
                                referencing_column_name,
                                referenced_column_name)
VALUES ('columns', 'tables', 'pk', 'column_table', 'table_name', 'table_name'),
       ('columns', 'data_types', 'pk', 'column_data_type', 'data_type', 'data_type'),
       ('unique_key_columns', 'columns', 'pk', 'pk_column', 'table_name', 'table_name'),
       ('unique_key_columns', 'columns', 'pk', 'pk_column', 'column_name', 'column_name'),
       ('foreign_keys', 'tables', 'pk', 'fk_referencing_table', 'referencing_table_name',
        'table_name'),
       ('foreign_keys', 'tables', 'pk', 'fk_referenced_table', 'referenced_table_name', 'table_name'),
       ('foreign_key_columns', 'foreign_keys', 'pk', 'fk_foreign_key', 'referencing_table_name',
        'referencing_table_name'),
       ('foreign_key_columns', 'foreign_keys', 'pk', 'fk_foreign_key', 'referenced_table_name',
        'referenced_table_name'),
       ('foreign_key_columns', 'foreign_keys', 'pk', 'fk_foreign_key', 'foreign_key_name', 'foreign_key_name'),
       ('foreign_key_columns', 'columns', 'pk', 'fk_referencing_column', 'referencing_table_name', 'table_name'),
       ('foreign_key_columns', 'columns', 'pk', 'fk_referencing_column', 'referencing_column_name', 'column_name'),
       ('foreign_key_columns', 'unique_key_columns', 'pk', 'fk_referenced_column', 'referenced_table_name',
        'table_name'),
       ('foreign_key_columns', 'unique_key_columns', 'pk', 'fk_referenced_column', 'referenced_column_name',
        'column_name'),
       ('seed_rows', 'tables', 'pk', 'fk_table', 'table_name', 'table_name'),
       ('seed_row_columns', 'seed_rows', 'pk', 'fk_row', 'table_name', 'table_name'),
       ('seed_row_columns', 'seed_rows', 'pk', 'fk_row', 'position', 'position');

INSERT INTO seed_rows(table_name, position)
VALUES ('data_types', 1),
       ('data_types', 2),
       ('data_types', 3),
       ('data_types', 4);

INSERT INTO seed_row_columns(table_name, position, column_name, column_value)
VALUES ('data_types', 1, 'data_type', 'varchar'),
       ('data_types', 1, 'position', '1'),
       ('data_types', 1, 'spec_regex', null),
       ('data_types', 1, 'default_regex', null),
       ('data_types', 2, 'data_type', 'numeric'),
       ('data_types', 2, 'position', '2'),
       ('data_types', 2, 'spec_regex', '[0-9]+(,\s*[0-9]+)?'),
       ('data_types', 2, 'default_regex', '[0-9]+(\.[0-9]+)?'),
       ('data_types', 3, 'data_type', 'boolean'),
       ('data_types', 3, 'position', '3'),
       ('data_types', 3, 'spec_regex', null),
       ('data_types', 3, 'default_regex', 'true|false'),
       ('data_types', 4, 'data_type', 'date'),
       ('data_types', 4, 'position', '4'),
       ('data_types', 4, 'spec_regex', null),
       ('data_types', 4, 'default_regex', '[0-9]{4}-[0-9]{2}-[0-9]{2}');
