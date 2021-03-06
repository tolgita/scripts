#!/bin/bash
# evacuate_failed_host.sh
# Checks for failed host and migrate instances off (instaces are in ACTIVE state even on failed nodes)
# Works only if there is ONE failed host
# Credentials must be sourced before using the script
HOSTDOWN=`nova service-list | grep nova-compute | grep down | awk '{print $6}'`
echo "Host $HOSTDOWN is down!"
SERVERDOWN=`openstack server list --os-cloud mycloud --long --all-projects | grep $HOSTDOWN |  awk '{print $4}'`
echo "Found these instances on failed host:"
echo $SERVERDOWN
for i in $SERVERDOWN; do
  echo "Evacuating server $i"
  openstack server migrate --os-cloud mycloud --shared-migration $i
done
