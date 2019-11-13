# This is just for personal sanity
# gnome-terminal -x bash -c "printf '\e]2;Nodes\a' && kubectl get nodes -o wide -w; exec bash"
# gnome-terminal -x bash -c "printf '\e]2;Deployments\a' && kubectl get deployments -o wide -w; exec bash"
gnome-terminal -x bash -c "printf '\e]2;Pods\a' && kubectl get pods -o wide -w; exec bash"
#
PODNAME=$(kubectl get pod -l name=go-memcached-operator -o jsonpath="{.items[0].metadata.name}")
kubectl wait --for=condition=Ready pod/$PODNAME
gnome-terminal -x bash -c "printf '\e]2;Memory Rising\a' && kubectl logs $PODNAME -f; exec bash"


# PODNAME=$(kubectl get pod -l name=go-memcached-operator --field-selector "status.phase=Running" -o jsonpath="{.items[0].metadata.name}")
# kubectl logs $PODNAME -f
