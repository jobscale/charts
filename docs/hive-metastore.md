#### tl;dr;

```bash
helm install --namespace hive-metastore --name metastore qubole/hive-metastore
```


## Configuration Options

| Parameter                       | Description                              | Default            |
| ------------------------------- | -----------------------------------------| -------------------|
| `nameOverride`                  | Name override for chart                  | `-`                |
| `fullnameOverride`              | Full Name override for chart             | `-`                |
| `imagePullSecrets`              | Secrets Required to Pull Images          | `[]`               |
| `resources`                     | Resources for pods                       | `-`                |
| `nodeSelector`                  | NodeSelector label                       | `-`                |
| `tolerations`                   | Pod Tolerations                          | `{}`               |
| `affinity`                      | Pod Affinity                             | `{}`               |
| `rbac.create`                   | To create RBAC policies or not           | `true`             |
| `image.repository`              | Repository of Image to pull              | `gcr.io/hybrid-qubole/hive-metastore`|
| `image.tag`                     | Tag of Image                             | `latest`           |
| `image.pullPolicy`              | Image Pull Policy                        | `Always`           |
| `podSecurityContext`            | podSecurityContext for deployment        | `{]`               |
| `securityContext`               | security context on pod                  | `{}`               |
| `service.type`                  | Hive Metastore Service Type              | `ClusterIP`        |
| `service.port`                  | Hive Metastore Service Port              | `9083`             |
| `mysql.enabled`                 | if enabled, setup MySQL within Cluster   | `true`             |
| `mysql.mysqlUser`               | MySQL Username                           | `hive`             |
| `mysql.mysqlDatabase`           | MySQL Database name                      | `metastore`        |
| `mysql.mysqlPassword`           | MySQL Password for username              | `password`         |
| `configs.DB_TYPE`               | DB Type conf for Metastore               | `mysql`            |
| `configs.CONNECTION_URI`        | JDBC Connection URI for Database         | `jdbc:mysql://metastore-mysql:3306/metastore` |
| `configs.CONNECTION_USER`       | Metastore DB User                        | `hive`             |  
| `configs.CONNECTION_PASSWORD`   | Metastore Password                       | `password`         |
| `configs.CONNECTION_DRIVER`     | JDBC Driver for connection               | `com.mysql.jdbc.Driver` |
| `configs.AWS_ACCESS_KEY_ID`     | AWS Access Key ID                        | ``                 |
| `configs.AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key                    | ``                 |

