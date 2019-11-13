# Eviction Replication

## Warning!
These scripts CAN RESULT IN OUT-OF-MEMORY crashes on the host machine if
not configured properly.

## Summary

These scripts are designed to cause evicton of all pods on a node to
replicate [Operator SDK #1305.](https://github.com/operator-framework/operator-sdk/issues/1305)

Combined, these scripts:
  - Create a kind cluster with 2 worker nodes with strict memory
      eviction policies.
  - Create an operator that proceeds with leader election
  - Trigger expanding memory usage until operator pod is evicted

## Usage

1. If necessary, remove existing kind cluster with `make delete-cluster`
1. Spin up kind cluster with strict memory eviction policies. Set
   `BLOWUP_MINIMUM_MEMORY` environment variable to about 8Gi less than
   the total available memory, then run `make new-cluster`.
1. Deploy the operator with `make up`.
1. Trigger the memory expansion with `make trigger`.

## Details

`./blowitup/cmd/delete-kind-cluster.sh`
  - WARNING!  REMOVES EXISTING CLUSTER

`./blowitup/cmd/new-kind-cluster.sh`
  - Start a new cluster with 2 worker nodes
  - Edit kubelet config of each node to enact strict memory usage policy
  - Restart kubelet

`./blowitup/cmd/up.sh`
  - Deploy the operator components.

`./blowitup/cmd/trigger.sh`
  - Creates a configmap "blowup" that triggers memory expansion. 
  -
After the operator is triggered, it increases memory usage until it is
stopped.  The with an altered config, kubelet triggers eviction of the
operator pod. The operator deployment creates a new pod (or 2[0]). The
new operator pod on the non-failing node attempts Operator-SDK
leader-for-life election, but fails because the Evicted pod remains the
leader. (The leader indicator is a configmap, which is deleted by
garbage collection when the pod is deleted, but not when the pod is
evicted.)

[0]: If the new pod is deployed to the node that is already failing, that node
may also be evicted. 

