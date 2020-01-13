# Install Security Components


#### Add Qubole's Helm Repo

```bash
helm repo add qubole https://qubole.github.io/charts/
helm repo update
```


## **Install**

#### Helm v2
```bash
helm --namespace qubole-security --name falco install qubole/security
```

#### Helm V3
```bash
kubectl create ns qubole-security
helm install --namespace qubole-security falco qubole/security
```

#### Kustomize
```bash
kubectl create -k kustomize/security/base/
```

### Helm Configuration Options

Refer: https://github.com/helm/charts/tree/master/stable/falco

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
| `podSecurityContext`            | podSecurityContext for deployment        | `{]`               |
| `securityContext`               | security context on pod                  | `{}`               |

