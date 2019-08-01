## Scripts to apply PDB per node to osd deployments made by rook.

Just ensure rook is running in the rook-ceph ns with OSDs in the cluster kubectl is pointed at.
The labels applied to the deployments' spec.template.labels will get destroyed when rook eventually reconciles the deployments.
