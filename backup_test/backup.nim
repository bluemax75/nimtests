import logging
import db_sqlite
import strutils

var logger = newFileLogger("backup.log", fmtStr = verboseFmtStr)
handlers.add(logger)
info("Initiating backup")

# Initiate db connection
proc initDBConnection(): TDbConn =
    result = db_sqlite.open("test.db", "charly", "d2sms953", "test")

proc getLastId(conn: TDbConn): int =
    let str_result = conn.getValue(sql"select max(id) from hola")
    if str_result=="":
        result = 0
    else:
        result = parseInt str_result

proc createBackupTable(conn) = 
    query = sql"create table `backup` (int id PRIMARY KEY, varchar table_name, int table_id, int timestamp)"
    conn.exec(query)
    conn.commit()

when isMainModule:
    let conn = initDBConnection()

    #conn.exec(sql"select * from hola") 
    echo conn.getAllRows(sql"select * from hola")
    echo getLastId(conn) 