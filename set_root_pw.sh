#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "Usage: $0 <password>"
	exit 1
fi

echo "=> Starting MySQL Server"
/usr/bin/mysqld_safe > /dev/null 2>&1 &
sleep 5
echo "   Started with PID $!"

echo "=> Setting root password"
mysqladmin -uroot password "$1"

echo "=> Allowing root external access"
mysql -uroot -p"$1" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$1' WITH GRANT OPTION"

echo "=> Stopping MySQL Server"
mysqladmin -uroot -p"$1" shutdown

echo "=> Done!"
