import db_mysql

var conn = db_mysql.open("127.0.0.1:3306", "root", "sipview", "centrex")

# Query sin elementos NULL
var res = conn.getAllRows(sql"select id,name,group_id,version from user")
echo repr res

# Query con elementos NULL
var res2 = conn.getAllRows(sql"select id,name,group_id,login_id,version from user")
echo repr res2

var res3 = conn.getAllRows(sql"select * from hola")
echo repr res3

var res4 = conn.getRow(sql"select * from hola")
echo repr res4

# No se puede guardar en una variaable el resultado de conn.rows
# Hay que usarlo directo en un for
for i in conn.rows(sql"select * from hola"):
    echo repr i


conn.exec(sql"insert into hola (name) values ('pedro')")
echo conn.execAffectedRows(sql"update hola set name='pipi' where id=2")
#conn.insertId(sql"insert into hola (name) values ('pedro')")