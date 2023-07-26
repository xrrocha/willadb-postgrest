
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