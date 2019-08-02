## Scripts to apply PDB per node to osd deployments made by rook.

Just ensure rook is running in the rook-ceph ns with OSDs in the cluster kubectl is pointed at.
The labels applied to the deployments' spec.template.labels will get destroyed when rook eventually reconciles the deployments.

Run the scripts in order and all the OSD pods will be labeled node=<nodename>, and there will be a PDB with maxUnavailable=0 for each node.
