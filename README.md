# Applications-Deploy

This project is used to deploy each application of our infrastructure on the production environnement in the Kubernetes cluster.

## Description

This project permits the versionning of each Kubernetes descriptor that will be applied to the Kubernetes cluster in the production environement.
For each app we will find a folder which will contain all descriptors for the app : deployment, service and sometimes ingress. These descriptors are used to describe how the app is deployed in production and how it will behave.
This project follow the "gitops" approach which says "if it is not in git, it doesn't exists" and prevent manual actions on the production cluster.

## How to deploy ?

To deploy an app, we use Gitlab CI/CD. 
Tagging a branch is not necessary to deploy a new version of an app, because the projects are able to deploy from their own CI but is used to "fix" the "state" of the cluster so we can rollback anytime.

## Test the app locally

### Preconditions :

* Docker is installed locally and running
* docker-compose is installed

### Test the version of the app we just developped

To test the version of the  app we just developped in a local environnement close the production, we need to build the corresponding docker image. According to our work organization the docker image is built in the project's CI with the name of the branch we're developping on. The image is then pushed to the project's container registry in the Packages > Container Registry tab.

The naming convention is the following :

* On the dev branch : name of the branch (e.g your-branch-name)
* On the master branch : master
* For production : name of the tag (e.g v1.0)

Once the image is built, we can copy/paste the path of the image in the `docker-compose.yml` in the root directory of this project, in the app's service, in the image field.

### Launch the environment

At the moment the `docker-compose.yml` launched a local environment with 5 services :

* hasura-postgres : postgres service for hasura
* graphql-engine : hasura service mapped on the port 8080. 
* keycloak-postgres : postgres service for keycloak
* keycloak : keycloak service mapped on port 8081 
* armadacar-front : application service mapped on port 8082

To launch the environment we need to position ourselves in the root folder of the project in a terminal and type the following command :
```
docker-compose up
```
This command will launch each service described in the `docker-compose.yml` and display their logs directly into the terminal.
If you do not want to check the applications logs, you can use the option -d or --detach to launch the containers in the detached mode :
```
docker-compose up -d
```
To turn off the environement :
```
docker-compose stop <-- stop the containers without removing them
docker-compose down <-- stop the container and remove them (avoid cache and naming conflicts)
```

For more informations, check docker-compose's [documentation](https://docs.docker.com/compose/)

### Note on the local tests

As said, the `docker-compose.yml`launches multiple containers, permitting to get close of the production environement and achieve tests that are dependants with keycloak for example. While it's usefull, it doesn't reproduce Kubernetes namespaces, ingresses, services or pods.

To test on a closest environment to production, it is prefered to deploy a local Kubernetes cluster (e.g with k3s which is used in production or minikube) and apply this project's descriptors to the cluster using kubectl.

#### Additionnal ressources

k3s' [documentation](https://rancher.com/docs/k3s/latest/en/)
kubectl's [documentation](https://kubernetes.io/fr/docs/reference/kubectl/overview/)