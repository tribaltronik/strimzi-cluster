# Strimzi Kafka Cluster
Apache Kafka cluster on Kubernetes

https://strimzi.io/

### Requirements
- Docker
- Makefile
- Kind
- kubectl

### Create cluster

> make create

or 

> kind create cluster --config kind-config.yaml

### Create namespace and Strimzi operator

> kubectl create namespace kafka

>   kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka



### Destroy everything

> make destroy

or 

> kind delete cluster --name strimzi
