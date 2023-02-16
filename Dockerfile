# This file needs to be renamed to Dockerfile

FROM centos

# General Operating System Setup
RUN cd /etc/yum.repos.d/ \
&& sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
&& sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y update
RUN yum -y install zip
RUN yum -y install passwd
RUN yum -y install telnet
RUN yum -y install vim
RUN yum -y install java-1.8.0-openjdk
RUN { echo "password"; echo "password"; } | passwd root
RUN useradd postgres
RUN { echo "password"; echo "password"; } | passwd postgres
RUN  dnf install -y postgresql-server
COPY postgres-start.sh /home/postgres
RUN chown -R postgres:postgres /home/postgres
RUN chmod 777 home/postgres/postgres-start.sh
RUN su - postgres -c 'initdb -D /home/postgres/data -U postgres'
RUN echo 'host            all     all             all                     trust' >> /home/postgres/data/pg_hba.conf
RUN echo "listen_addresses='*'" >> /home/postgres/data/postgresql.conf
EXPOSE 5432   
USER postgres
CMD /home/postgres/postgres-start.sh