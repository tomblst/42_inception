#!/bin/sh

# Stop if  error 
set -e

# Prépare le dossier socket
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialise la base de données si besoin
if [ ! -f "/var/lib/mysql/.init_done" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

    # Lance MariaDB en arrière-plan pour l'init
    mysqld_safe --skip-networking &
    pid="$!"

    # Attend que MariaDB soit prêt
    until mysqladmin ping --silent; do
        sleep 1
    done

    # Création de la base et de l'utilisateur
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    # Marque l'init comme terminé
    touch /var/lib/mysql/.init_done

    # Arrête le serveur temporaire
    mysqladmin -uroot -p"${SQL_ROOT_PASSWORD}" shutdown
    # Nettoie le socket
    rm -rf /run/mysqld/*
fi

# Lance MariaDB en avant-plan (pour Docker)
exec mysqld_safe
