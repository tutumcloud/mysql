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
ADD ./tutum_mysqld.conf /etc/mysql/conf.d/tutum_mysqld.conf
ADD ./set_root_pw.sh /set_root_pw.sh
