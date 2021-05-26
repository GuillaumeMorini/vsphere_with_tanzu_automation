# add_provisioning.sh
#!/bin/bash

ROLE="TKG"

GOVC=$(which govc)
if [ $? -ne 0 ]
  then
    >&2 echo "govc is not installed, this is a prerequisite for this script to work"
    exit 1
fi

if [ -z "$GOVC_URL" ] || [ -z "$GOVC_USERNAME" ]  || [ -z "$GOVC_PASSWORD" ]  
  then
    >&2 echo "govc is not configured, this is a prerequisite for this script to work"
    exit 1
fi

cat > role_tkg_provisioning.txt <<'endmsg'
VirtualMachine.Provisioning.Clone
VirtualMachine.Provisioning.CloneTemplate
VirtualMachine.Provisioning.CreateTemplateFromVM
VirtualMachine.Provisioning.Customize
VirtualMachine.Provisioning.DeployTemplate
VirtualMachine.Provisioning.DiskRandomAccess
VirtualMachine.Provisioning.DiskRandomRead
VirtualMachine.Provisioning.FileRandomAccess
VirtualMachine.Provisioning.GetVmFiles
VirtualMachine.Provisioning.MarkAsTemplate
VirtualMachine.Provisioning.MarkAsVM
VirtualMachine.Provisioning.ModifyCustSpecs
VirtualMachine.Provisioning.PromoteDisks
VirtualMachine.Provisioning.PutVmFiles
VirtualMachine.Provisioning.ReadCustSpecs
endmsg

govc role.update -a ${ROLE} $(cat role_tkg_provisioning.txt) 
