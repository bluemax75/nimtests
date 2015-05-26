import db_mysql
from mysql import rollback, commit, autocommit

import unittest

suite "Test MySQL usage cases":
    setup:
        # Open connection
        var conn = db_mysql.open("127.0.0.1:3306", "root", "sipview", "centrex")
        discard conn.autocommit(false) # Set autocommit to off

        # Reset hola table
        conn.exec(sql"drop table if exists hola")
        conn.exec(sql"create table hola (id int, name varchar(255))")
        conn.exec(sql"insert into hola values (1,'pepe'), (2, 'lolo')")
        discard conn.commit

    # teardown:
    #     conn.close

    test "Connection test":
        # Just close connection from setup
        echo "Pass"
        conn.close

    test "Query testing":
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
        conn.close

    test "Multiple result queries":
        # No se puede guardar en una variaable el resultado de conn.rows
        # Hay que usarlo directo en un for
        for i in conn.rows(sql"select * from hola"):
            echo repr i
        conn.close

    test "Modification tests":
        conn.exec(sql"insert into hola (name) values ('pedro')")
        echo conn.execAffectedRows(sql"update hola set name='pipi' where id=2")
        let res = conn.rollback

        let hola_rows = conn.getRow(sql"select count(*) from hola")
        check(hola_rows[0] == "2")
        conn.close

