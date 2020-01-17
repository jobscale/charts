# Install Presto Operator

## **Install**

#### Helm v2
```bash
helm install --name presto --namespace presto qubole/presto
```

#### Helm V3
```bash
kubectl create ns presto
helm install --namespace presto presto qubole/presto
```

#### Kustomize
```bash
kubectl create -k kustomize/presto/base/
```

### Creating a Sample Presto Cluster

```yaml
# presto-cluster.yaml
apiVersion: engineservice.hybrid.qubole.com/v1
kind: PrestoCluster
metadata:
  name: meta-two-presto-cluster
spec:
  monitoring:
    prometheus: 
      enable: true
      rules:
        - pattern: "com.facebook.presto.execution:name=QueryManager:RunningQueries"
          type: GAUGE
        - pattern: "com.facebook.presto.execution:name=QueryManager:FailedQueries.FiveMinute.Count"
          type: GAUGE
        - pattern: "com.facebook.presto.execution:name=QueryManager:QueuedQueries.FiveMinute.Count"
          type: GAUGE
        - pattern: "jvm_gc_collection_seconds"
          type: GAUGE
  additionalCatalogs:
    hive.properties: |
      connector.name=hive-hadoop2
      hive.metastore.uri=thrift://metastore-hive-metastore.hive-metastore:9083
  coordinator:
    cpuLimit: "600Mi"
    additionalProperties: |
      coordinator=true
      http-server.http.port=8080
      discovery-server.enabled=true
      discovery.uri=http://presto-service-meta-two-presto-cluster.default:8080
  worker:
    replicas: 3
    additionalProperties: |
      coordinator=false
      http-server.http.port=8080
      discovery.uri=http://presto-service-meta-two-presto-cluster.default:8080
  service:
    type: LoadBalancer
```

```bash
kubectl apply -f presto-cluster.yaml
```