# Install EFK Logging Setup


* Add Qubole's Helm Repo
```bash
helm repo add qubole https://qubole.github.io/charts/
helm repo update
```


**tldr;**
```bash
helm --namespace kube-monitoring --name metrics install qubole/logging
```
