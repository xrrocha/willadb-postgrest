
const tableQueries = {
    "tables": {
       "columns": {},
       "unique_keys!unique_keys_table_name_fkey": {"unique_key_columns": {}},
       "foreign_keys": {"foreign_key_columns": {}},
    },
};

function queryStringFor(tableName) {
    function collectParts(tableQuery, parts) {
        const attributes = tableQuery["attributes"]
        if (attributes !== undefined) {
            parts.push(attributes.join(", "))
        }
        const embedded = tableQuery["embedded"]
        if (embedded !== undefined) {
            for (const name in embedded) {
                const value = embedded[name]
                const embeddedParts = collectParts(name, []);
                parts.push(embeddedParts)
            }
        }
        return parts
    }
}

/*
const fetchJson =
    (url) => fetch(url).then(response => response.json());

const PostgREST = {
    baseUrl: "http://localhost:3000",
    loadTable: (tableName) =>
        fetchJson(`${this.baseUrl}/tables?table_name=ilike.*${tableName}*`),
};

function postProcessMetadata(metadata) {
    // ["data_types", "tables"]
    return metadata;
}
*/