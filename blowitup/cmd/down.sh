kubectl delete -f blowitup/configmap.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/service_account.yaml
kubectl delete deployments.apps go-memcached-operator
kubectl delete deployments.apps example-memcached
kubectl delete -f deploy/crds/cache.example.com_memcacheds_crd.yaml
