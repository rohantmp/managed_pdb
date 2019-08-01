NODENAMES=$(kubectl get nodes --no-headers -o jsonpath='{ .items[*].metadata.name }')

SCRIPTDIR=$(dirname $0)

mkdir -p ${SCRIPTDIR}/osd_pdbs
kubectl get deploy -n rook-ceph -l app=rook-ceph-osd --no-headers|awk '{ print $4 }'|grep 0
if [[ $? -eq 0 ]]
then
	echo Please ensure that all pods are running for this script to be accurate.
	exit 1
fi

for NODENAME in $NODENAMES
do
	OSDCOUNT=$(kubectl get po -n rook-ceph --no-headers -o wide -l node=${NODENAME}|wc|awk '{ print $1 }')
	echo $NODENAME has $OSDCOUNT OSDs.
	if [[ $OSDCOUNT -gt 0 ]]
	then
		sed "s/NODENAME/${NODENAME}/g;s/OSDCOUNT/${OSDCOUNT}/g" osd_pdb.yaml.template > ${SCRIPTDIR}/osd_pdbs/${NODENAME}.yaml
	fi
done


