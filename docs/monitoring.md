# Install Prometheus Monitoring Setup


* Add Qubole's Helm Repo

```bash
helm repo add qubole https://qubole.github.io/charts/
helm repo update
```


**tldr;**
```bash
helm --namespace kube-monitoring --name metrics install qubole/monitoring
```

## Configuration Options

* Prometheus

Parameter | Description | Default
--------- | ----------- | -------
`prometheus.alertmanager.enabled` | If true, create alertmanager | `true`
`prometheus.alertmanager.name` | alertmanager container name | `alertmanager`
`prometheus.alertmanager.image.repository` | alertmanager container image repository | `prom/alertmanager`
`prometheus.alertmanager.image.tag` | alertmanager container image tag | `v0.18.0`
`prometheus.alertmanager.image.pullPolicy` | alertmanager container image pull policy | `IfNotPresent`
`prometheus.alertmanager.prefixURL` | The prefix slug at which the server can be accessed | ``
`prometheus.alertmanager.baseURL` | The external url at which the server can be accessed | `/`
`prometheus.alertmanager.extraArgs` | Additional alertmanager container arguments | `{}`
`prometheus.alertmanager.extraSecretMounts` | Additional alertmanager Secret mounts | `[]`
`prometheus.alertmanager.configMapOverrideName` | Prometheus alertmanager ConfigMap override where full-name is `{{.Release.Name}}-{{.Values.alertmanager.configMapOverrideName}}` and setting this value will prevent the default alertmanager ConfigMap from being generated | `""`
`prometheus.alertmanager.configFromSecret` | The name of a secret in the same kubernetes namespace which contains the Alertmanager config, setting this value will prevent the default alertmanager ConfigMap from being generated | `""`
`prometheus.alertmanager.configFileName` | The configuration file name to be loaded to alertmanager. Must match the key within configuration loaded from ConfigMap/Secret. | `alertmanager.yml`
`prometheus.alertmanager.ingress.enabled` | If true, alertmanager Ingress will be created | `false`
`prometheus.alertmanager.ingress.annotations` | alertmanager Ingress annotations | `{}`
`prometheus.alertmanager.ingress.extraLabels` | alertmanager Ingress additional labels | `{}`
`prometheus.alertmanager.ingress.hosts` | alertmanager Ingress hostnames | `[]`
`prometheus.alertmanager.ingress.tls` | alertmanager Ingress TLS configuration (YAML) | `[]`
`prometheus.alertmanager.nodeSelector` | node labels for alertmanager pod assignment | `{}`
`prometheus.alertmanager.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`prometheus.alertmanager.affinity` | pod affinity | `{}`
`prometheus.alertmanager.schedulerName` | alertmanager alternate scheduler name | `nil`
`prometheus.alertmanager.persistentVolume.enabled` | If true, alertmanager will create a Persistent Volume Claim | `true`
`prometheus.alertmanager.persistentVolume.accessModes` | alertmanager data Persistent Volume access modes | `[ReadWriteOnce]`
`prometheus.alertmanager.persistentVolume.annotations` | Annotations for alertmanager Persistent Volume Claim | `{}`
`prometheus.alertmanager.persistentVolume.existingClaim` | alertmanager data Persistent Volume existing claim name | `""`
`prometheus.alertmanager.persistentVolume.mountPath` | alertmanager data Persistent Volume mount root path | `/data`
`prometheus.alertmanager.persistentVolume.size` | alertmanager data Persistent Volume size | `2Gi`
`prometheus.alertmanager.persistentVolume.storageClass` | alertmanager data Persistent Volume Storage Class | `unset`
`prometheus.alertmanager.persistentVolume.subPath` | Subdirectory of alertmanager data Persistent Volume to mount | `""`
`prometheus.alertmanager.podAnnotations` | annotations to be added to alertmanager pods | `{}`
`prometheus.alertmanager.podSecurityPolicy.annotations` | Specify pod annotations in the pod security policy | `{}` |
`prometheus.alertmanager.replicaCount` | desired number of alertmanager pods | `1`
`prometheus.alertmanager.statefulSet.enabled` | If true, use a statefulset instead of a deployment for pod management | `false`
`prometheus.alertmanager.statefulSet.podManagementPolicy` | podManagementPolicy of alertmanager pods | `OrderedReady`
`prometheus.alertmanager.statefulSet.headless.annotations` | annotations for alertmanager headless service | `{}`
`prometheus.alertmanager.statefulSet.headless.labels` | labels for alertmanager headless service | `{}`
`prometheus.alertmanager.statefulSet.headless.enableMeshPeer` | If true, enable the mesh peer endpoint for the headless service | `{}`
`prometheus.alertmanager.statefulSet.headless.servicePort` | alertmanager headless service port | `80`
`prometheus.alertmanager.priorityClassName` | alertmanager priorityClassName | `nil`
`prometheus.alertmanager.resources` | alertmanager pod resource requests & limits | `{}`
`prometheus.alertmanager.securityContext` | Custom [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for Alert Manager containers | `{}`
`prometheus.alertmanager.service.annotations` | annotations for alertmanager service | `{}`
`prometheus.alertmanager.service.clusterIP` | internal alertmanager cluster service IP | `""`
`prometheus.alertmanager.service.externalIPs` | alertmanager service external IP addresses | `[]`
`prometheus.alertmanager.service.loadBalancerIP` | IP address to assign to load balancer (if supported) | `""`
`prometheus.alertmanager.service.loadBalancerSourceRanges` | list of IP CIDRs allowed access to load balancer (if supported) | `[]`
`prometheus.alertmanager.service.servicePort` | alertmanager service port | `80`
`prometheus.alertmanager.service.type` | type of alertmanager service to create | `ClusterIP`
`prometheus.alertmanagerFiles.alertmanager.yml` | Prometheus alertmanager configuration | example configuration
`prometheus.configmapReload.name` | configmap-reload container name | `configmap-reload`
`prometheus.configmapReload.image.repository` | configmap-reload container image repository | `jimmidyson/configmap-reload`
`prometheus.configmapReload.image.tag` | configmap-reload container image tag | `v0.2.2`
`prometheus.configmapReload.image.pullPolicy` | configmap-reload container image pull policy | `IfNotPresent`
`prometheus.configmapReload.extraArgs` | Additional configmap-reload container arguments | `{}`
`prometheus.configmapReload.extraVolumeDirs` | Additional configmap-reload volume directories | `{}`
`prometheus.configmapReload.extraConfigmapMounts` | Additional configmap-reload configMap mounts | `[]`
`prometheus.configmapReload.resources` | configmap-reload pod resource requests & limits | `{}`
`prometheus.initChownData.enabled`  | If false, don't reset data ownership at startup | true
`prometheus.initChownData.name` | init-chown-data container name | `init-chown-data`
`prometheus.initChownData.image.repository` | init-chown-data container image repository | `busybox`
`prometheus.initChownData.image.tag` | init-chown-data container image tag | `latest`
`prometheus.initChownData.image.pullPolicy` | init-chown-data container image pull policy | `IfNotPresent`
`prometheus.initChownData.resources` | init-chown-data pod resource requests & limits | `{}`
`prometheus.kubeStateMetrics.enabled` | If true, create kube-state-metrics | `true`
`prometheus.kubeStateMetrics.name` | kube-state-metrics container name | `kube-state-metrics`
`prometheus.kubeStateMetrics.image.repository` | kube-state-metrics container image repository| `quay.io/coreos/kube-state-metrics`
`prometheus.kubeStateMetrics.image.tag` | kube-state-metrics container image tag | `v1.5.0`
`prometheus.kubeStateMetrics.image.pullPolicy` | kube-state-metrics container image pull policy | `IfNotPresent`
`prometheus.kubeStateMetrics.args` | kube-state-metrics container arguments | `{}`
`prometheus.kubeStateMetrics.nodeSelector` | node labels for kube-state-metrics pod assignment | `{}`
`prometheus.kubeStateMetrics.podAnnotations` | annotations to be added to kube-state-metrics pods | `{}`
`prometheus.kubeStateMetrics.deploymentAnnotations` | annotations to be added to kube-state-metrics deployment | `{}`
`prometheus.kubeStateMetrics.podSecurityPolicy.annotations` | Specify pod annotations in the pod security policy | `{}` |
`prometheus.kubeStateMetrics.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`prometheus.kubeStateMetrics.replicaCount` | desired number of kube-state-metrics pods | `1`
`prometheus.kubeStateMetrics.priorityClassName` | kube-state-metrics priorityClassName | `nil`
`prometheus.kubeStateMetrics.resources` | kube-state-metrics resource requests and limits (YAML) | `{}`
`prometheus.kubeStateMetrics.securityContext` | Custom [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for kube-state-metrics containers | `{}`
`prometheus.kubeStateMetrics.service.annotations` | annotations for kube-state-metrics service | `{prometheus.io/scrape: "true"}`
`prometheus.kubeStateMetrics.service.clusterIP` | internal kube-state-metrics cluster service IP | `None`
`prometheus.kubeStateMetrics.service.externalIPs` | kube-state-metrics service external IP addresses | `[]`
`prometheus.kubeStateMetrics.service.loadBalancerIP` | IP address to assign to load balancer (if supported) | `""`
`prometheus.kubeStateMetrics.service.loadBalancerSourceRanges` | list of IP CIDRs allowed access to load balancer (if supported) | `[]`
`prometheus.kubeStateMetrics.service.servicePort` | kube-state-metrics service port | `80`
`prometheus.kubeStateMetrics.service.type` | type of kube-state-metrics service to create | `ClusterIP`
`prometheus.nodeExporter.enabled` | If true, create node-exporter | `true`
`prometheus.nodeExporter.name` | node-exporter container name | `node-exporter`
`prometheus.nodeExporter.image.repository` | node-exporter container image repository| `prom/node-exporter`
`prometheus.nodeExporter.image.tag` | node-exporter container image tag | `v0.18.0`
`prometheus.nodeExporter.image.pullPolicy` | node-exporter container image pull policy | `IfNotPresent`
`prometheus.nodeExporter.extraArgs` | Additional node-exporter container arguments | `{}`
`prometheus.nodeExporter.extraHostPathMounts` | Additional node-exporter hostPath mounts | `[]`
`prometheus.nodeExporter.extraConfigmapMounts` | Additional node-exporter configMap mounts | `[]`
`prometheus.nodeExporter.hostNetwork` | If true, node-exporter pods share the host network namespace | `true`
`prometheus.nodeExporter.hostPID` | If true, node-exporter pods share the host PID namespace | `true`
`prometheus.nodeExporter.nodeSelector` | node labels for node-exporter pod assignment | `{}`
`prometheus.nodeExporter.podAnnotations` | annotations to be added to node-exporter pods | `{}`
`prometheus.nodeExporter.pod.labels` | labels to be added to node-exporter pods | `{}`
`prometheus.nodeExporter.podSecurityPolicy.annotations` | Specify pod annotations in the pod security policy | `{}` |
`prometheus.nodeExporter.podSecurityPolicy.enabled` | Specify if a Pod Security Policy for node-exporter must be created | `false`
`prometheus.nodeExporter.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`prometheus.nodeExporter.priorityClassName` | node-exporter priorityClassName | `nil`
`prometheus.nodeExporter.resources` | node-exporter resource requests and limits (YAML) | `{}`
`prometheus.nodeExporter.securityContext` | securityContext for containers in pod | `{}`
`prometheus.nodeExporter.service.annotations` | annotations for node-exporter service | `{prometheus.io/scrape: "true"}`
`prometheus.nodeExporter.service.clusterIP` | internal node-exporter cluster service IP | `None`
`prometheus.nodeExporter.service.externalIPs` | node-exporter service external IP addresses | `[]`
`prometheus.nodeExporter.service.hostPort` | node-exporter service host port | `9100`
`prometheus.nodeExporter.service.loadBalancerIP` | IP address to assign to load balancer (if supported) | `""`
`prometheus.nodeExporter.service.loadBalancerSourceRanges` | list of IP CIDRs allowed access to load balancer (if supported) | `[]`
`prometheus.nodeExporter.service.servicePort` | node-exporter service port | `9100`
`prometheus.nodeExporter.service.type` | type of node-exporter service to create | `ClusterIP`
`prometheus.podSecurityPolicy.enabled` | If true, create & use pod security policies resources | `false`
`prometheus.pushgateway.enabled` | If true, create pushgateway | `true`
`prometheus.pushgateway.name` | pushgateway container name | `pushgateway`
`prometheus.pushgateway.image.repository` | pushgateway container image repository | `prom/pushgateway`
`prometheus.pushgateway.image.tag` | pushgateway container image tag | `v0.8.0`
`prometheus.pushgateway.image.pullPolicy` | pushgateway container image pull policy | `IfNotPresent`
`prometheus.pushgateway.extraArgs` | Additional pushgateway container arguments | `{}`
`prometheus.pushgateway.ingress.enabled` | If true, pushgateway Ingress will be created | `false`
`prometheus.pushgateway.ingress.annotations` | pushgateway Ingress annotations | `{}`
`prometheus.pushgateway.ingress.hosts` | pushgateway Ingress hostnames | `[]`
`prometheus.pushgateway.ingress.tls` | pushgateway Ingress TLS configuration (YAML) | `[]`
`prometheus.pushgateway.nodeSelector` | node labels for pushgateway pod assignment | `{}`
`prometheus.pushgateway.podAnnotations` | annotations to be added to pushgateway pods | `{}`
`prometheus.pushgateway.podSecurityPolicy.annotations` | Specify pod annotations in the pod security policy | `{}` |
`prometheus.pushgateway.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`prometheus.pushgateway.replicaCount` | desired number of pushgateway pods | `1`
`prometheus.pushgateway.schedulerName` | pushgateway alternate scheduler name | `nil`
`prometheus.pushgateway.persistentVolume.enabled` | If true, Prometheus pushgateway will create a Persistent Volume Claim | `false`
`prometheus.pushgateway.persistentVolume.accessModes` | Prometheus pushgateway data Persistent Volume access modes | `[ReadWriteOnce]`
`prometheus.pushgateway.persistentVolume.annotations` | Prometheus pushgateway data Persistent Volume annotations | `{}`
`prometheus.pushgateway.persistentVolume.existingClaim` | Prometheus pushgateway data Persistent Volume existing claim name | `""`
`prometheus.pushgateway.persistentVolume.mountPath` | Prometheus pushgateway data Persistent Volume mount root path | `/data`
`prometheus.pushgateway.persistentVolume.size` | Prometheus pushgateway data Persistent Volume size | `2Gi`
`prometheus.pushgateway.persistentVolume.storageClass` | Prometheus server data Persistent Volume Storage Class |  `unset`
`prometheus.pushgateway.persistentVolume.subPath` | Subdirectory of Prometheus server data Persistent Volume to mount | `""`
`prometheus.pushgateway.priorityClassName` | pushgateway priorityClassName | `nil`
`prometheus.pushgateway.resources` | pushgateway pod resource requests & limits | `{}`
`prometheus.pushgateway.service.annotations` | annotations for pushgateway service | `{}`
`prometheus.pushgateway.service.clusterIP` | internal pushgateway cluster service IP | `""`
`prometheus.pushgateway.service.externalIPs` | pushgateway service external IP addresses | `[]`
`prometheus.pushgateway.service.loadBalancerIP` | IP address to assign to load balancer (if supported) | `""`
`prometheus.pushgateway.service.loadBalancerSourceRanges` | list of IP CIDRs allowed access to load balancer (if supported) | `[]`
`prometheus.pushgateway.service.servicePort` | pushgateway service port | `9091`
`prometheus.pushgateway.service.type` | type of pushgateway service to create | `ClusterIP`
`prometheus.rbac.create` | If true, create & use RBAC resources | `true`
`prometheus.server.enabled` | If false, Prometheus server will not be created | `true`
`prometheus.server.name` | Prometheus server container name | `server`
`prometheus.server.image.repository` | Prometheus server container image repository | `prom/prometheus`
`prometheus.server.image.tag` | Prometheus server container image tag | `v2.13.1`
`prometheus.server.image.pullPolicy` | Prometheus server container image pull policy | `IfNotPresent`
`prometheus.server.enableAdminApi` |  If true, Prometheus administrative HTTP API will be enabled. Please note, that you should take care of administrative API access protection (ingress or some frontend Nginx with auth) before enabling it. | `false`
`prometheus.server.skipTSDBLock` |  If true, Prometheus skip TSDB locking. | `false`
`prometheus.server.configPath` |  Path to a prometheus server config file on the container FS  | `/etc/config/prometheus.yml`
`prometheus.server.global.scrape_interval` | How frequently to scrape targets by default | `1m`
`prometheus.server.global.scrape_timeout` | How long until a scrape request times out | `10s`
`prometheus.server.global.evaluation_interval` | How frequently to evaluate rules | `1m`
`prometheus.server.extraArgs` | Additional Prometheus server container arguments | `{}`
`prometheus.server.extraInitContainers` | Init containers to launch alongside the server | `[]`
`prometheus.server.prefixURL` | The prefix slug at which the server can be accessed | ``
`prometheus.server.baseURL` | The external url at which the server can be accessed | ``
`prometheus.server.env` | Prometheus server environment variables | `[]`
`prometheus.server.extraHostPathMounts` | Additional Prometheus server hostPath mounts | `[]`
`prometheus.server.extraConfigmapMounts` | Additional Prometheus server configMap mounts | `[]`
`prometheus.server.extraSecretMounts` | Additional Prometheus server Secret mounts | `[]`
`prometheus.server.extraVolumeMounts` | Additional Prometheus server Volume mounts | `[]`
`prometheus.server.extraVolumes` | Additional Prometheus server Volumes | `[]`
`prometheus.server.configMapOverrideName` | Prometheus server ConfigMap override where full-name is `{{.Release.Name}}-{{.Values.server.configMapOverrideName}}` and setting this value will prevent the default server ConfigMap from being generated | `""`
`prometheus.server.ingress.enabled` | If true, Prometheus server Ingress will be created | `false`
`prometheus.server.ingress.annotations` | Prometheus server Ingress annotations | `[]`
`prometheus.server.ingress.extraLabels` | Prometheus server Ingress additional labels | `{}`
`prometheus.server.ingress.hosts` | Prometheus server Ingress hostnames | `[]`
`prometheus.server.ingress.tls` | Prometheus server Ingress TLS configuration (YAML) | `[]`
`prometheus.server.nodeSelector` | node labels for Prometheus server pod assignment | `{}`
`prometheus.server.tolerations` | node taints to tolerate (requires Kubernetes >=1.6) | `[]`
`prometheus.server.affinity` | pod affinity | `{}`
`prometheus.server.priorityClassName` | Prometheus server priorityClassName | `nil`
`prometheus.server.schedulerName` | Prometheus server alternate scheduler name | `nil`
`prometheus.server.persistentVolume.enabled` | If true, Prometheus server will create a Persistent Volume Claim | `true`
`prometheus.server.persistentVolume.accessModes` | Prometheus server data Persistent Volume access modes | `[ReadWriteOnce]`
`prometheus.server.persistentVolume.annotations` | Prometheus server data Persistent Volume annotations | `{}`
`prometheus.server.persistentVolume.existingClaim` | Prometheus server data Persistent Volume existing claim name | `""`
`prometheus.server.persistentVolume.mountPath` | Prometheus server data Persistent Volume mount root path | `/data`
`prometheus.server.persistentVolume.size` | Prometheus server data Persistent Volume size | `8Gi`
`prometheus.server.persistentVolume.storageClass` | Prometheus server data Persistent Volume Storage Class |  `unset`
`prometheus.server.persistentVolume.subPath` | Subdirectory of Prometheus server data Persistent Volume to mount | `""`
`prometheus.server.emptyDir.sizeLimit` | emptyDir sizeLimit if a Persistent Volume is not used | `""`
`prometheus.server.podAnnotations` | annotations to be added to Prometheus server pods | `{}`
`prometheus.server.podLabels` | labels to be added to Prometheus server pods | `{}`
`prometheus.server.deploymentAnnotations` | annotations to be added to Prometheus server deployment | `{}`
`prometheus.server.podSecurityPolicy.annotations` | Specify pod annotations in the pod security policy | `{}` |
`prometheus.server.replicaCount` | desired number of Prometheus server pods | `1`
`prometheus.server.statefulSet.enabled` | If true, use a statefulset instead of a deployment for pod management | `false`
`prometheus.server.statefulSet.annotations` | annotations to be added to Prometheus server stateful set | `{}`
`prometheus.server.statefulSet.labels` | labels to be added to Prometheus server stateful set | `{}`
`prometheus.server.statefulSet.podManagementPolicy` | podManagementPolicy of server pods | `OrderedReady`
`prometheus.server.statefulSet.headless.annotations` | annotations for Prometheus server headless service | `{}`
`prometheus.server.statefulSet.headless.labels` | labels for Prometheus server headless service | `{}`
`prometheus.server.statefulSet.headless.servicePort` | Prometheus server headless service port | `80`
`prometheus.server.resources` | Prometheus server resource requests and limits | `{}`
`prometheus.server.securityContext` | Custom [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for server containers | `{}`
`prometheus.server.service.annotations` | annotations for Prometheus server service | `{}`
`prometheus.server.service.clusterIP` | internal Prometheus server cluster service IP | `""`
`prometheus.server.service.externalIPs` | Prometheus server service external IP addresses | `[]`
`prometheus.server.service.loadBalancerIP` | IP address to assign to load balancer (if supported) | `""`
`prometheus.server.service.loadBalancerSourceRanges` | list of IP CIDRs allowed access to load balancer (if supported) | `[]`
`prometheus.server.service.nodePort` | Port to be used as the service NodePort (ignored if `server.service.type` is not `NodePort`) | `0`
`prometheus.server.service.servicePort` | Prometheus server service port | `80`
`prometheus.server.service.type` | type of Prometheus server service to create | `ClusterIP`
`prometheus.server.sidecarContainers` | array of snippets with your sidecar containers for prometheus server | `""`
`prometheus.serviceAccounts.alertmanager.create` | If true, create the alertmanager service account | `true`
`prometheus.serviceAccounts.alertmanager.name` | name of the alertmanager service account to use or create | `{{ prometheus.alertmanager.fullname }}`
`prometheus.serviceAccounts.kubeStateMetrics.create` | If true, create the kubeStateMetrics service account | `true`
`prometheus.serviceAccounts.kubeStateMetrics.name` | name of the kubeStateMetrics service account to use or create | `{{ prometheus.kubeStateMetrics.fullname }}`
`prometheus.serviceAccounts.nodeExporter.create` | If true, create the nodeExporter service account | `true`
`prometheus.serviceAccounts.nodeExporter.name` | name of the nodeExporter service account to use or create | `{{ prometheus.nodeExporter.fullname }}`
`prometheus.serviceAccounts.pushgateway.create` | If true, create the pushgateway service account | `true`
`prometheus.serviceAccounts.pushgateway.name` | name of the pushgateway service account to use or create | `{{ prometheus.pushgateway.fullname }}`
`prometheus.serviceAccounts.server.create` | If true, create the server service account | `true`
`prometheus.serviceAccounts.server.name` | name of the server service account to use or create | `{{ prometheus.server.fullname }}`
`prometheus.server.terminationGracePeriodSeconds` | Prometheus server Pod termination grace period | `300`
`prometheus.server.retention` | (optional) Prometheus data retention | `"15d"`
`prometheus.serverFiles.alerts` | Prometheus server alerts configuration | `{}`
`prometheus.serverFiles.rules` | Prometheus server rules configuration | `{}`
`prometheus.serverFiles.prometheus.yml` | Prometheus server scrape configuration | example configuration
`prometheus.extraScrapeConfigs` | Prometheus server additional scrape configuration | ""
`prometheus.alertRelabelConfigs` | Prometheus server [alert relabeling configs](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alert_relabel_configs) for H/A prometheus | ""
`prometheus.networkPolicy.enabled` | Enable NetworkPolicy | `false` |


* Prometheus Adapter

| Parameter                       | Description                                                                     | Default                                     |
| ------------------------------- | ------------------------------------------------------------------------------- | --------------------------------------------|
| `prometheus-adapter.affinity`                      | Node affinity                                                                   | `{}`                                        |
| `prometheus-adapter.image.repository`              | Image repository                                                                | `directxman12/k8s-prometheus-adapter-amd64` |
| `prometheus-adapter.image.tag`                     | Image tag                                                                       | `v0.5.0`                                    |
| `prometheus-adapter.image.pullPolicy`              | Image pull policy                                                               | `IfNotPresent`                              |
| `prometheus-adapter.image.pullSecrets`             | Image pull secrets                                                              | `{}`                                        |
| `prometheus-adapter.logLevel`                      | Log level                                                                       | `4`                                         |
| `prometheus-adapter.metricsRelistInterval`         | Interval at which to re-list the set of all available metrics from Prometheus   | `1m`                                        |
| `prometheus-adapter.nodeSelector`                  | Node labels for pod assignment                                                  | `{}`                                        |
| `prometheus-adapter.podAnnotations`                | Annotations to add to the pod                                                   | `{}`                                        |
| `prometheus-adapter.priorityClassName`             | Pod priority                                                                    | ``                                          |
| `prometheus-adapter.prometheus.url`                | Url of where we can find the Prometheus service                                 | `http://prometheus.default.svc`             |
| `prometheus-adapter.prometheus.port`               | Port of where we can find the Prometheus service, zero to omit this option      | `9090`                                      |
| `prometheus-adapter.rbac.create`                   | If true, create & use RBAC resources                                            | `true`                                      |
| `prometheus-adapter.resources`                     | CPU/Memory resource requests/limits                                             | `{}`                                        |
| `prometheus-adapter.rules.default`                 | If `true`, enable a set of default rules in the configmap                       | `true`                                      |
| `prometheus-adapter.rules.custom`                  | A list of custom configmap rules                                                | `[]`                                        |
| `prometheus-adapter.rules.existing`                | The name of an existing configMap with rules. Overrides default, custom and external. | ``                                    |
| `prometheus-adapter.rules.external`                | A list of custom rules for external metrics API                                 | `[]`                                        |
| `prometheus-adapter.rules.resource`                | `resourceRules` to set in configmap rules                                       | `{}`                                        |
| `prometheus-adapter.service.annotations`           | Annotations to add to the service                                               | `{}`                                        |
| `prometheus-adapter.service.port`                  | Service port to expose                                                          | `443`                                       |
| `prometheus-adapter.service.type`                  | Type of service to create                                                       | `ClusterIP`                                 |
| `prometheus-adapter.serviceAccount.create`         | If true, create & use Serviceaccount                                            | `true`                                      |
| `prometheus-adapter.serviceAccount.name`           | If not set and create is true, a name is generated using the fullname template  | ``                                          |
| `prometheus-adapter.tls.enable`                    | If true, use the provided certificates. If false, generate self-signed certs    | `false`                                     |
| `prometheus-adapter.tls.ca`                        | Public CA file that signed the APIService (ignored if tls.enable=false)         | ``                                          |
| `prometheus-adapter.tls.key`                       | Private key of the APIService (ignored if tls.enable=false)                     | ``                                          |
| `prometheus-adapter.tls.certificate`               | Public key of the APIService (ignored if tls.enable=false)                      | ``                                          |
| `prometheus-adapter.extraVolumeMounts`             | Any extra volumes mounts                                                        | `[]`                                        |
| `prometheus-adapter.extraVolumes`                  | Any extra volumes                                                               | `[]`                                        |
| `prometheus-adapter.tolerations`                   | List of node taints to tolerate                                                 | `[]`                                        |


* Monitoring

| Parameter                       | Description                              | Default            |
| ------------------------------- | -----------------------------------------| -------------------|
| `nameOverride`                  | Name override for chart                  |    `-`             |
| `fullnameOverride`              | Full Name override for chart             |    `-`             |
| `resources`                     | Resources for pods                       | `-`                |
| `nodeSelector`                  | NodeSelector label                       | `-`                |
| `tolerations`                   | Pod Tolerations                          | `{}`               |
| `affinity`                      | Pod Affinity                             | `{}`               |
| `rbac.create`                   | Weather to create RBAC policies or not   | `true`             |
| `prometheus.enabled`            | Weather or not to enable Prometheus Chart| `true`             |
| `prometheus-adapter.enabled`    | Enable Prometheus Adapter                | `true`             |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install qubole/monitoring --name monitoring \
    --set prometheus.server.terminationGracePeriodSeconds=360
```