#!/bin/bash
#Exports a list of all instances grouped by compute node somewhere visible 
date > /usr/share/foreman/public/servers.txt
for i in {1..5}; do openstack server list --os-cloud mycloud --long --host compute0$i.domain --all-projects ; done >> /usr/share/foreman/public/servers.txt
