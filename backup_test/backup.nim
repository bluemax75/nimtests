import db_mysql

var conn = db_mysql.open("127.0.0.1:3306", "root", "sipview", "centrex")

var res = conn.getAllRows(sql"select id,name,group_id,login_id,version from user")
echo res[0]

# Establish Mysql connection

# Incremental backup: dump selected records from some tables 