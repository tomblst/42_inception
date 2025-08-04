FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install mariadb-server -y

# Copie dans le conteneur le fichier de configuration personalise de MariaDB
COPY conf/server_conf.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Copie dans le conteneur le script d'initialisation
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

# Execute the bash script to create the database and the user
ENTRYPOINT ["sh", "/init.sh"]

EXPOSE 3306