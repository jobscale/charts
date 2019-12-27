# Install Spark Operator on K8s

Source: [Github](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator)

#### tl;dr;

```bash
helm install --namespace spark --name spark qubole/spark --set spark-history-server.s3.accessKeyID=<AWS Access Key ID> --set spark-history-server.s3.secretAccessKey=<AWS Secret Access Key>
```


#### Submit a Sample Spark Command

```bash
# for examples clone this repo
cd examples

# to be added
```