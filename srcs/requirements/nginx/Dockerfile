
FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt install nginx -y

# telecharge openSSL pour generer le certificat (https)
RUN apt-get install openssl -y

# cree le dossier pour stocker le certificat et la clef
RUN mkdir -p /etc/nginx/ssl

# Genere un clef et un certificat auto-signe valable 42 jours sans mot de passe
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tbellest.42.fr/UID=tbellest" \
-out /etc/ssl/certs/inception.crt \
-keyout /etc/ssl/private/inception.key

# Copie notre fichier de configuration nginx personnalisé
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Donne les droits d'accès au dossier html a l'utilisateur systeme
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Start the nginx service
CMD [ "nginx", "-g", "daemon off;" ]