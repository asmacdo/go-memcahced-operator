# The config map tells the operator that its time to run the memory consumer
kubectl create -f blowitup/configmap.yaml

# Delete a pod to trigger reconciliation.
PODNAME=$(kubectl get pod -l memcached_cr=example-memcached -o jsonpath="{.items[0].metadata.name}")
kubectl wait --for=condition=Ready pod/$PODNAME
kubectl delete pod $PODNAME
