#!/bin/bash
if [ -n "$MYSQL_ADMIN_CREATED" ]; then
	echo 'Skipping creating admin account on MySQL'
else
	if [ ! -f /.mysql_admin_created ]; then
		/create_mysql_admin_user.sh
	fi
fi

exec supervisord -n
