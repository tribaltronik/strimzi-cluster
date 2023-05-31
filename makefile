create: # Create cluster
	kind create cluster --config kind-config.yaml

apply-all:
	$(MAKE) create
	$(MAKE) ingress
	$(MAKE) strimzi

ingress:
    # Install Ingress Nginx
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	kubectl wait --namespace ingress-nginx \
	--for=condition=ready pod \
	--selector=app.kubernetes.io/component=controller \
	--timeout=90s

strimzi:
    # Namespace
	kubectl create namespace kafka
    # Install ClusterRoles, Cluster RoleBindings and CRDs
	kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

	kubectl wait deployment -n kafka strimzi-cluster-operator --for condition=Available=True --timeout=90s

kafka:
	kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml -n kafka 
	kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s -n kafka 
	
destroy:
	kind delete cluster --name strimzi