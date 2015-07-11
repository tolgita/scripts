#!/bin/bash
# evacuate_node.sh <node>
# Credentials must be sourced before using the script
INSTANCES=`openstack server list --os-cloud mycloud --long --host $1 --all-projects | grep | grep $1 |  awk '{print $4}'`

echo "Evacuating instances:"
echo $INSTANCES
echo "From:"
echo $1

for i in $INSTANCES; do
  echo "Evacuating server $i"
  nova evacuate --on-shared-storage $i
done

echo "Turning nova-compute off on node:"
echo $1
openstack compute service set  --os-cloud mycloud  --disable $1 nova-compute
