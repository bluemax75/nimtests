import db_sqlite

let conn = db_sqlite.open("test.db", "root", "sipview", "hola")

# Query con elementos NULL
var res = conn.getAllRows(sql"select * from hola")
echo res
