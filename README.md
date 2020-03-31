# applications-deploy

Projet décrivant le déploiment de chaque applications sur le cluster Kubernetes de production.

## Description

Le projet permet de versionner les descripteurs d'objets kubernetes qui seront utilisés afin d'être appliqués au cluster Kubernetes de production.
Pour chaque application que l'on va vouloir déployer on va trouver dans le projet son namespace, puis son dossier correspondant et dans ce dossier les descripteurs décrivant l'application sur Kubernetes.
Ce projet s'inscrit dans la démarche "gitops" -> "si ce n'est pas sur git, ça n'existe pas" et permet d'éviter toute action manuelle sur le cluster.

## Fonctionnement du mode de déploiement

Le mode de déploiment est effectué via la CI/CD de gitlab, une fois la branche taggée.

## Effectuer les tests en local

### Prérequis :
* Avoir docker d'installé et en cours d'exécution
* Avoir docker-compose d'installé sur le poste

### Tester la version que l'on vient de développer

Pour tester la version que lon vient de développer dans un environnement proche de la production il faut tout d'abord build l'image docker. La CI de gitlab s'occupe du build. L'image est stockée dans le container registry du projet, dans l'onglet Packages > Container Registry.
Le nommage des images est le suivant :
* Sur les branches de dev : nom de la branche
* Sur la branche master : master
* Pour la production : nom du tag

Une fois l'image récupérée, copier/coller le chemin de l'image dans le fichier docker-compose.yml à la racine du projet, dans le service armadacar-front, champs image.

### Lancer l'environnement

Le fichier `docker-compose.yml` permet de déployer un environnement en local composé de 4 services :
* hasura-postgres : service postgres pour hasura
* graphql-engine : service hasura mappé sur le port 8080 du pc
* keycloak-postgres : service postgres pour keycloak
* keycloak : service keycloak mappé sur le port 8081
* armadacar-front : service pour le frontend de l'application armadacar mappé sur le port 8082

Pour lancer l'environnement il faut de se positionner dans le répertoire du projet et taper la commande suivante dans un terminal :
```
docker-compose up
```
Ce fonctionnement permet de vérifier les logs applicatifs directement dans le terminal.
Si ce fonctionnement n'est pas désiré, l'option -d ou --detach permet de lancer les conteneurs en mode "détaché" ils ne seront pas liés au terminal, et les logs applicatifs ne seront pas affichés :
```
docker-compose up -d
```
Pour éteindre l'environnement :
```
docker-compose stop <-- stop les conteneurs sans les détruire
docker-compose down <-- stop les conteneurs puis les détruits (permet d'éviter les soucis de cache)
```

Pour plus d'information sur docker-compose, voir ce [lien](https://docs.docker.com/compose/)

### Note sur les tests en local

Le fichier `docker-compose.yml` permet de déployer une version minifiée en local afin de réaliser des tests basiques, permettant de faire abstraction des namespaces, services et pods Kubernetes. Cependant il faut bien comprendre que cette méthode ne permet que de tester les containers dockers et ne permet pas de réaliser des tests réellement proches de la production.
Afin de réaliser des tests sur un environnement proche de celui de production, il est préférable de créer un cluster kubernetes minifié en local avec k3d ou k3s et d'appliquer les descripteurs présents dans le projet.