#!/usr/bin/env python3

# Author: Guillaume Morini1
# Inspired by: Vikas Shitole
# Product: vCenter server/ vSphere Supervisor namespace configuration
# Description: Python script to get details on existing namespace on the top of vSphere Supervisor cluster
# Reference: https://vthinkbeyondvm.com/script-to-configure-vsphere-supervisor-cluster-using-rest-apis/
# How to setup vCenter REST API environment?: http://vthinkbeyondvm.com/getting-started-with-vcenter-server-rest-apis-using-python/

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

json_response = s.get('https://'+args.host+'/api/vcenter/namespaces/instances',headers=headers)

if not json_response.ok:
	print("Supervisor Namespace creation NOT invoked, please check your inputs once again")

print(json_response.text)
session_delete=s.delete('https://'+args.host+'/rest/com/vmware/cis/session',auth=(args.user,args.password))
