tutum-docker-mysql
================

Base docker image to run a MySQL database server


Usage
-----

To create the image `tutum/docker-mysql`, execute the following command on the tutum-docker-mysql folder:

	sudo docker build -t tutum/docker-mysql .


Mounting the database file volume
---------------------------------

In order to persist the database data, you can mount a local folder from the host on the container to store the database files. To do so:

	$ID=$(sudo docker run -d -v /path/in/host:/var/lib/mysql tutum/mysql-php /bin/bash -c "/usr/bin/mysql_install_db")

This will mount the local folder `/path/in/host` inside the docker in `/var/lib/mysql` (where MySQL will store the database files by default). `mysql_install_db` creates the initial database structure.

Remember that this will mean that your host must have `/path/in/host` available when you run your docker image!


Initializing the server
-----------------------

To set your initial root password, run:

	ID=$(sudo docker run -d tutum/docker-mysql /bin/bash -c "/set_root_pw.sh <newpassword>")

Where `<newpassword>` is the password to be set for the root account. It will store the new container ID (like `d35bf1374e88`) in $ID. To create an image from that, execute:

	sudo docker commit $ID tutum/my-mysql-server

To import a SQL backup which is stored for example in the folder `/tmp/sqlbackup` in the host, run the following:

	ID=$(sudo docker run -d -v /tmp/sqlbackup:/tmp tutum/my-mysql-server /bin/bash -c "/import_sql.sh <rootpassword> /tmp/<dump.sql>")

Where `<rootpassword>` is the root password set earlier and `<dump.sql>` is the name of the SQL file to be imported.

You can now push your changes to the registry:

	sudo docker push tutum/my-mysql-server


Running the MySQL server
------------------------

Run the `/run.sh` script to start MySQL (via supervisor):

	ID=$(sudo docker run -d -p 3306 tutum/my-mysql-server /run.sh)


It will store the new container ID (like `d35bf1374e88`) in $ID. Get the allocated external port:

	sudo docker port $ID 3306


It will print the allocated port (like 4751). Test your deployment:

	mysql -uroot -p -h127.0.0.1 -P4751

Done!
