PODNAME=$(kubectl get pods --field-selector=status.phase=Running -l name=go-memcached-operator -o jsonpath="{.items[0].metadata.name}")
kubectl logs ${PODNAME} -f
