source blowitup/cmd/down.sh

# Create CR & CRD
kubectl create -f deploy/crds/cache.example.com_memcacheds_crd.yaml
kubectl apply -f deploy/crds/cache.example.com_v1alpha1_memcached_cr.yaml
kubectl wait --for=condition=established crd/memcacheds.cache.example.com
#
# # Build, push, and deploy the go-memcached-operator
operator-sdk build quay.io/asmacdo/go-memcached-operator:vblowup2
docker push quay.io/asmacdo/go-memcached-operator:vblowup2
kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/operator.yaml
