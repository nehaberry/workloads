#!/bin/bash
### This script is used for creating DC for YCSB
### $1 is name of the DC
### eg. sh ycsb.sh <name> <namespace> 


name=$1
namespace=$2

echo "kind: 'DeploymentConfig'
apiVersion: 'v1'
metadata:
  name: '$name'
  namespace: '$namespace'
spec:
  template:
    metadata:
      labels:
        name: 'ycsb'
    spec:
      containers:
        - name: 'ycsb'
          image: 'docker.io/hongkailiu/ycsb:002'
  triggers:
    - type: 'ConfigChange'
  replicas: 1" | oc create -f -
