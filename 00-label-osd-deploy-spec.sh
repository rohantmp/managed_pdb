SCRIPTDIR=$(dirname $0)
echo $SCRIPTDIR



#Patch osd deployment templates with node labels. (Ensure osd pods are labeled by node)
kubectl get po -n rook-ceph -l app=rook-ceph-osd -o wide --no-headers|sed 's/(osd-[0-9])-([a-z0-9]+-{0,1})+/\1/g' -E|awk '{ print "kubectl patch deploy -n rook-ceph " $1 " --type json -p \"[{\"op\": \"replace\", \"path\": \"/spec/template/metadata/labels/node\", \"value\": \"" $7 "\"}]\"" }'|tee /dev/tty |bash
kubectl get po -n rook-ceph -l app=rook-ceph-osd --show-labels
