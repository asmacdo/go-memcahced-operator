if [[ -z "${BLOWUP_MINIMUM_MEMORY}" ]]; then
  echo "BLOWUP_MINIMUM_MEMORY environment variable must be set."
  echo "Sane values are about 8Gi less than total 'avail Mem' from 'top'."
  echo "Setting this value too low can result in host system crash."
  exit 1
fi

kind create cluster --config blowitup/kind-config.yaml
docker exec -it kind-worker sed -i "/evictionHard:/a \ \ memory.available:\ ${BLOWUP_MINIMUM_MEMORY}" /var/lib/kubelet/config.yaml
docker exec -it kind-worker sed -i "s/evictionPressureTransitionPeriod:\ 5m0s/evictionPressureTransitionPeriod:\ 5s/g" /var/lib/kubelet/config.yaml
docker exec -it kind-worker systemctl restart kubelet
docker exec -it kind-worker2 sed -i "/evictionHard:/a \ \ memory.available:\ ${BLOWUP_MINIMUM_MEMORY}" /var/lib/kubelet/config.yaml
docker exec -it kind-worker2 sed -i 's/evictionPressureTransitionPeriod:\ 5m0s/evictionPressureTransitionPeriod:\ 5s/g' /var/lib/kubelet/config.yaml
docker exec -it kind-worker2 systemctl restart kubelet

# The nodes might go offline for a short time.
sleep 10
kubectl wait --for=condition=Ready node/kind-worker
kubectl wait --for=condition=Ready node/kind-worker2
