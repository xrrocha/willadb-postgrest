'use strict';

var TABLE_QUERY_URL_PREFIX = 'http://localhost:3000/tables?table_name=ilike.'

var app = {};

app.addResultRows = function (rows) {
    var rowsString = '';
    var rowsLength = rows.length;

    if (rowsLength > 0) {
        for (var i = 0; i < rowsLength; i++) {
            rowsString += app.buildResultRowString(rows[i]);
        }
    } else {
        rowsString = '<tr><td colspan="2">Results not found</td></tr>';
    }

    document.getElementById('results-table-body').innerHTML = rowsString;
    app.showElement('results-table');
}

app.buildResultRowString = function (row) {
    return  '<tr>' +
                '<td>' + row.table_name + '</td>' +
                '<td>' + row.position + '</td>' +
            '</tr>';
}

app.showElement = function (id) {
    document.getElementById(id).classList.remove('hidden');
}

app.querytable = function (tableName) {
    var queryURL = TABLE_QUERY_URL_PREFIX + '*' + tableName + '*';
    
    fetch(queryURL)
        .then(function(response) {
            return response.json();
        })
        .then(function (j) {
            console.log(j);
            app.addResultRows(j);
        })
}

app.searchClick = function () {
    var table = document.getElementById('table-input').value;

    app.querytable(table);
}