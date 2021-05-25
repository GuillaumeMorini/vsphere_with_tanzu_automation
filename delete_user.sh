# delete_user.sh

ROLE=TKG
USER=tkg-user
DOMAIN=vsphere.local
PASSWORD='VMware1!'
DATACENTER=Datacenter

govc permissions.remove -principal "${USER}@${DOMAIN}" /
govc sso.user.rm ${USER}
govc role.remove ${ROLE}
