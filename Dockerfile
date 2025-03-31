FROM node:latest

# Définir le répertoire de travail
WORKDIR /app

# Copier tous les fichiers et dossiers sauf le dossier 'scripts'
COPY . /app
RUN rm -rf /app/scripts

# Installer Newman
RUN npm install -g newman

# Définir la commande par défaut
CMD ["newman", "--version"]
