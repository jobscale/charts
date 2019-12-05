# Qubole Charts

[![Build Status](https://cloud.drone.io/api/badges/qubole/charts/status.svg)](https://cloud.drone.io/qubole/charts)

### Add Qubole's Helm Repo
---
```bash
helm repo add qubole https://qubole.github.io/charts/
helm repo update
```

### Install Components
---

#### EFK logging (Backed by S3/HDFS/PV)
```bash
helm --namespace kube-logging --name efk install qubole/logging
```

#### Prometheus Metrics Setup
```bash
helm --namespace kube-monitoring --name metrics install qubole/monitoring
```
