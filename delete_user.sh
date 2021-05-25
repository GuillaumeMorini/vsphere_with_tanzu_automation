# delete_user.sh
#!/bin/bash

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

ROLE=TKG
USER=tkg-user
DOMAIN=vsphere.local
PASSWORD='VMware1!'
DATACENTER=Datacenter

govc permissions.remove -principal "${USER}@${DOMAIN}" /
govc sso.user.rm ${USER}
govc role.remove ${ROLE}
