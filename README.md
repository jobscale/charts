# Qubole Charts

[![Build Status](https://cloud.drone.io/api/badges/qubole/charts/status.svg)](https://cloud.drone.io/qubole/charts)

### Install Helm V2
```bash
# on mac
brew install helm@2
# setup kubernetes cluster and set current context
helm init
```

### Known RBAC Issues in Helm
```bash
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl edit deploy --namespace kube-system tiller-deploy # and add the line serviceAccount: tiller to spec/template/spec

# RBAC Issue only on GKE
kubectl create clusterrolebinding <user_name>-cluster-admin-binding --clusterrole=cluster-admin --user=<user_email>
```
source - [Github Issues](https://github.com/helm/helm/issues/2224)

### Add Qubole's Helm Repo
```bash
helm repo add qubole https://qubole.github.io/charts/
helm repo update
```

### Install Components

* [Logging](docs/logging.md)
* [Monitoring](docs/monitoring.md)
* [Hive Metastore](docs/hive-metastore.md)
* [Spark (Operator and History Server)](docs/sparkoperator.md)
* [Security (Falco)](docs/security.md)
* [Presto Operator](docs/presto-operator.md)
