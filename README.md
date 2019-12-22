# applications-deploy

Projet décrivant le déploiment de chaque applications sur le cluster Kubernetes de production.

## Description

Le projet permet d'écrire les descripteurs d'objets kubernetes qui seront utilisés afin d'être appliqués au cluster Kubernetes de production.
Pour chaque application que l'on va vouloir déployer on va trouver dans le projet son namespace, puis son dossier correspondant et dans ce dossier les descripteurs décrivant l'application sur Kubernetes.
Ce projet s'inscrit dans la démarche "gitops" -> "si ce n'est pas sur git, ça n'existe pas" et permet d'éviter toute action manuelle sur le cluster.

## Fonctionnement du mode de déploiement

Le mode de déploiment est effectué via la CI/CD de gitlab, via les pipelines.

### Note sur les tests en local

Le fichier docker-compose.yml permet de déployer une version minifiée en local afin de réaliser des tests basiques, permettant de faire abstraction des namespaces, services et pods Kubernetes. Cependant il faut bien comprendre que cette méthode ne permet que de tester les containers dockers et ne permet pas de réaliser des tests réellement proches de la production.
Afin de réaliser des tests sur un environnement proche de celui de production, il est préférable de créer un cluster kubernetes minifié en local avec k3d et d'appliquer les descripteurs présents dans le projet.
[Plus d'informations à venir...]