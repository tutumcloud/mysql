#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 <password> </path/to/sql_file.sql>"
	exit 1
fi

echo "=> Starting MySQL Server"
/usr/bin/mysqld_safe > /dev/null 2>&1 &
sleep 5
echo "   Started with PID $!"

echo "=> Importing SQL file"
mysql -uroot -p"$1" < "$2"

echo "=> Stopping MySQL Server"
mysqladmin -uroot -p"$1" shutdown

echo "=> Done!"
