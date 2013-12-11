FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN ! DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor mysql-server

# Add image configuration and scripts
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh
ADD ./supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD ./tutum_mysqld.cnf /etc/mysql/conf.d/tutum_mysqld.cnf
ADD ./set_root_pw.sh /set_root_pw.sh
RUN chmod 755 /set_root_pw.sh
ADD ./import_sql.sh /import_sql.sh
RUN chmod 755 /import_sql.sh
RUN /set_root_pw.sh "changeme!now!"

EXPOSE 3306
CMD ["/run.sh"]
