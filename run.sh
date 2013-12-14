#!/bin/bash
if [ ! -f /.mysql_admin_created ]; then
	/create_mysql_admin_user.sh
fi
supervisord -n
