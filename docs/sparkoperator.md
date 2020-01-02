# Install Spark Operator on K8s

Source: [Github](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator)

## **Install**     

#### Helm v2
```bash
helm --namespace spark --name spark install qubole/spark --set spark-history-server.s3.accessKeyID=<AWS Access Key ID> --set spark-history-server.s3.secretAccessKey=<AWS Secret Access Key>
```

#### Helm V3
```bash
kubectl create ns spark
helm install --namespace qubole-logging spark qubole/spark --set spark-history-server.s3.accessKeyID=<AWS Access Key ID> --set spark-history-server.s3.secretAccessKey=<AWS Secret Access Key>
```

#### Kustomize
```bash
# add your aws secret and access key to kustomization.yaml for history server
kubectl create -k kustomize/spark/base/
```


### Creating Jar for Spark-Submit

```bash
# build docker image
cd stable/spark/examples
docker build -t spark-scala-jar-builder .

# place your .scala file in stable/spark/examples/scripts directory

# to compile the default example scripts to jar
docker run -it -v $(pwd):/examples spark-scala-jar-builder sh /examples/scripts/build-jar.sh

# to compile a custom script in the current directory
docker run -it -v $(pwd):/examples spark-scala-jar-builder sh /examples/scripts/build-jar.sh /path/to/script-file.scala
```

### Submit a spark application with the above Jar

1. Copy the Jar file to any location on S3
2. in the [file: /stable/spark/examples/spark-tpc-ds-create-tables.yaml](/stable/spark/examples/spark-tpc-ds-create-tables.yaml):
    1. replace `{AWS_ACCESS_KEY_ID}`  and `(AWS_SECRET_ACCESS_KEY}` with your AWS creds
    2. replace `{HIVE_METASTORE_URI}` with the uri of hive metastore already installed on the cluster
    3. replace `{JAR_LOCATION}` with the S3 location of your JAR
3. kubectl apply -f `stable/spark/examples/spark-tpc-ds-create-tables.yaml`


### Access Spark History Server UI

```bash
kubectl port-forward -n spark svc/spark-spark-history-server 18080
# access at http://localhost:18080
```

### Helm Configuration Options

Refer: https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/api-docs.md