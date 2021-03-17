# vsphere_with_tanzu_automation

Scripts to automate interaction with Workload Management and Supervisor cluster in vSphere with Tanzu

* **list_storage_policies.py** list all storage policies created on a vSphere cluster

Example of usage if you are already using GOVC and configured GOVC environment variables:
./list_storage_policies.py -s $(echo $GOVC_URL | sed  's/http:\/\///' | sed 's/https:\/\///') -u $GOVC_USERNAME -p $GOVC_PASSWORD

* **get_supervisor_cluster.py** show details on the configured supervisor cluster

Example of usage if you are already using GOVC and configured GOVC environment variables:
./get_supervisor_cluster.py -s $(echo $GOVC_URL | sed  's/http:\/\///' | sed 's/https:\/\///') -u $GOVC_USERNAME -p $GOVC_PASSWORD -cl Cluster  

* **list_namespaces.py** list all namespaces created on a vSphere supervisor cluster

Example of usage if you are already using GOVC and configured GOVC environment variables:
./list_namespaces.py  -s $(echo $GOVC_URL | sed  's/http:\/\///' | sed 's/https:\/\///') -u $GOVC_USERNAME -p $GOVC_PASSWORD

* **create_namespace.py** create a new namespace on a vSphere supervisor cluster

Example of usage if you are already using GOVC and configured GOVC environment variables:
./create_namespace.py  -s $(echo $GOVC_URL | sed  's/http:\/\///' | sed 's/https:\/\///') -u $GOVC_USERNAME -p $GOVC_PASSWORD -subject $(echo $GOVC_USERNAME | cut -d'@' -f 1) -domain $(echo $GOVC_USERNAME | cut -d'@' -f 2) -sp "Tanzu Storage Policy" -cl Cluster -ns test 



