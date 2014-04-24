#!/bin/bash
if [ -n "$MYSQL_ADMIN_CREATED" ]; then
	touch /.mysql_admin_created 
fi

if [ ! -f /.mysql_admin_created ]; then
	/create_mysql_admin_user.sh
fi

exec supervisord -n
