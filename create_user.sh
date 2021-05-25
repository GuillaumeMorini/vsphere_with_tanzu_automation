# create_user.sh
#!/bin/bash

GOVC=$(which govc)
if [ $? -ne 0 ]
  then
    >&2 echo "govc is not installed, this is a prerequisite for this script to work"
    exit 1
fi

ROLE=TKG
USER=tkg-user
DOMAIN=vsphere.local
PASSWORD='VMware1!'
DATACENTER=Datacenter

cat > role_tkg.txt <<'endmsg'
Cns.Searchable
Datastore.AllocateSpace
Datastore.Browse
Datastore.FileManagement
Global.DisableMethods
Global.EnableMethods
Global.Licenses
Network.Assign
Resource.AssignVMToPool
Sessions.GlobalMessage
Sessions.ValidateSession
StorageProfile.View
System.Anonymous
System.Read
System.View
VApp.Import
VirtualMachine.Config.AddExistingDisk
VirtualMachine.Config.AddNewDisk
VirtualMachine.Config.AddRemoveDevice
VirtualMachine.Config.AdvancedConfig
VirtualMachine.Config.CPUCount
VirtualMachine.Config.ChangeTracking
VirtualMachine.Config.DiskExtend
VirtualMachine.Config.EditDevice
VirtualMachine.Config.Memory
VirtualMachine.Config.RawDevice
VirtualMachine.Config.RemoveDisk
VirtualMachine.Config.Settings
VirtualMachine.Interact.PowerOff
VirtualMachine.Interact.PowerOn
VirtualMachine.Inventory.CreateFromExisting
VirtualMachine.Inventory.Delete
VirtualMachine.Provisioning.DeployTemplate
VirtualMachine.Provisioning.DiskRandomRead
VirtualMachine.Provisioning.GetVmFiles
VirtualMachine.State.CreateSnapshot
VirtualMachine.State.RemoveSnapshot
endmsg

govc role.create ${ROLE} $(cat role_tkg.txt) 
govc sso.user.create -p ${PASSWORD} ${USER}
govc permissions.set -principal "${USER}@${DOMAIN}" -role=${ROLE} -propagate=true  /
