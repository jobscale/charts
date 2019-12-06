# Install Spark Operator on K8s

Source: [Github](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator)

#### Add Repo for SparkOperator

```bash
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
```

#### Create a Namespace for running spark-jobs

```yaml
# create a file named spark-namespace.yaml and add the following contents to it
apiVersion: v1
kind: Namespace
metadata:
  name: spark-jobs
  labels:
    name: spark-jobs
```

```bash
kubectl create -f spark-namespace.yaml
```

#### Install SparkOperator

```bash
helm install incubator/sparkoperator --namespace spark-operator --name spark --set sparkJobNamespace=spark-jobs --set serviceAccounts.spark.name=spark
```


#### Submit a Sample Spark Command

```bash
# for examples clone this repo
git clone https://github.com/GoogleCloudPlatform/spark-on-k8s-operator
cd spark-on-k8s-operator/examples

# you will find a list of examples here
# since we have deployed on spark jobs namespace, edit the example files to remove `namespace: default` wherever they exist
# create and view a sparkapplication
kubectl apply -f spark-pi-prometheus.yaml
kubectl -n spark-jobs get sparkapplication
kubectl -n spark-jobs describe sparkapplication spark-pi

# view logs from pod
kubectl -n spark-jobs get pods
kubectl -n spark-jobs logs -f "<driver pod name>"
```