# applications-deploy

Projet décrivant le déploiment de chaque applications sur le cluster Kubernetes de production.

## Description

Le projet permet de versionner les descripteurs d'objets kubernetes qui seront utilisés afin d'être appliqués au cluster Kubernetes de production.
Pour chaque application que l'on va vouloir déployer on va trouver dans le projet son namespace, puis son dossier correspondant et dans ce dossier les descripteurs décrivant l'application sur Kubernetes.
Ce projet s'inscrit dans la démarche "gitops" -> "si ce n'est pas sur git, ça n'existe pas" et permet d'éviter toute action manuelle sur le cluster.

## Fonctionnement du mode de déploiement

Le mode de déploiment est effectué via la CI/CD de gitlab, via les pipelines.

## Effectuer les tests en local

#### Prérequis :
* Avoir docker d'installé et en cours d'exécution
* Avoir docker-compose d'installé

#### Tester la version que l'on vient de développer

Pour tester la version que lon vient de développer il faut tout d'abord build l'image docker. Pour cela il faut tout d'abord se positionner dans un terminal dans le dossier du projet "ArmadaCar" par exemple.
Pour build l'image docker taper la commande suivante :
```
docker build -t startfleet/armadacar:latest .
```
L'application est maintenant buildée sous forme d'image docker, pour vérifier, on peut lister la liste des images présentes en local avec la commande suivante :
```
docker images
```
Une image nommée "startfleet/armadacar" taggée "latest" doit être présente dans la liste

#### Lancer l'environnement

Le fichier `docker-compose.yml` permet de déployer un environnement en local composé de 4 services :
* hasura-postgres : service postgres pour hasura
* graphql-engine : service hasura mappé sur le port 8080 du pc
* keycloak-postgres : service postgres pour keycloak
* keycloak : service keycloak mappé sur le port 8081

Pour lancer l'environnement il faut de se positionner dans le répertoire du projet et taper la commande suivante dans un terminal :
```
docker-compose up
```

### Note sur les tests en local

Le fichier `docker-compose.yml` permet de déployer une version minifiée en local afin de réaliser des tests basiques, permettant de faire abstraction des namespaces, services et pods Kubernetes. Cependant il faut bien comprendre que cette méthode ne permet que de tester les containers dockers et ne permet pas de réaliser des tests réellement proches de la production.
Afin de réaliser des tests sur un environnement proche de celui de production, il est préférable de créer un cluster kubernetes minifié en local avec k3d ou k3s et d'appliquer les descripteurs présents dans le projet.

[Plus d'informations à venir...]