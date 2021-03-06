#!/usr/bin/env python3

# Author: Guillaume Morini1
# Inspired by: Vikas Shitole
# Product: vCenter server/ vSphere Supervisor cluster configuration
# Description: Python script to get info on the vSphere Supervisor cluster on the given cluster
# Reference: https://vthinkbeyondvm.com/script-to-configure-vsphere-supervisor-cluster-using-rest-apis/
# How to setup vCenter REST API environment?: http://vthinkbeyondvm.com/getting-started-with-vcenter-server-rest-apis-using-python/

#TODO: Some additional formatting and null check pending but that is not a blocker to run this script

import requests
import json
import ssl
import atexit
import sys
import argparse
import getpass

from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

s=requests.Session()
s.verify=False

def get_args():
    """ Get arguments from CLI """
    parser = argparse.ArgumentParser(
        description='Arguments for VM relocation')

    parser.add_argument('-s', '--host',
                        required=True,
                        action='store',
                        help='VC IP or FQDN')
						
    parser.add_argument('-u', '--user',
                        required=True,
                        action='store',
                        help='VC username')
						
    parser.add_argument('-p', '--password',
                        required=False,
                        action='store',
                        help='VMC password:')
						
    parser.add_argument('-cl', '--clustername',
                        required=True,
                        action='store',
                        help='cluster name')

    args = parser.parse_args()

    if not args.password:
        args.password = getpass.getpass(
            prompt='Enter VC password:')

    return args

args = get_args()
headers = {'content-type':'application/json'}
session_response= s.post('https://'+args.host+'/rest/com/vmware/cis/session',auth=(args.user,args.password))

if not session_response.ok:
	print ("Session creation is failed, please check")
	quit()

#Getting cluster moid
cluster_object=s.get('https://'+args.host+'/rest/vcenter/cluster?filter.names='+args.clustername)
if len(json.loads(cluster_object.text)["value"])==0:
	print ("NO cluster found, please enter valid cluster name")
	sys.exit()
cluster_id=json.loads(cluster_object.text)["value"][0].get("cluster")
# print ("cluster-id::"+cluster_id)

json_response = s.get('https://'+args.host+'/api/vcenter/namespace-management/clusters/'+cluster_id,headers=headers)
# if json_response.ok:
# 	print ("Enable API invoked, checkout your H5C")
# else:
# 	print ("Enable  API NOT invoked, please check your inputs once again")
print (json_response.text)
session_delete=s.delete('https://'+args.host+'/rest/com/vmware/cis/session',auth=(args.user,args.password))
