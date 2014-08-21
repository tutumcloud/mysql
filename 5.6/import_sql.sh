#!/bin/bash

if [[ $# -ne 3 ]]; then
	echo "Usage: $0 <username> <password> </path/to/sql_file.sql>"
	exit 1
fi

echo "=> Starting MySQL Server"
/usr/bin/mysqld_safe > /dev/null 2>&1 &
sleep 5
echo "   Started with PID $!"

echo "=> Importing SQL file"
mysql -u"$1" -p"$2" < "$3"

echo "=> Stopping MySQL Server"
mysqladmin -u"$1" -p"$2" shutdown

echo "=> Done!"
