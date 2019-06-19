# workloads

Running MongoDB and PGSQL on OCP 4.x

The key objective is to document detailed steps to bring up Mongodb and PGSQL pods in an  OCS 4.x environment. 

NB: 
1. The scripts are taken from https://github.com/iamniting/ocs.git

2. Currently, the PVC Access Mode = RWO for both the workloads. Need to change the Access Mode for PGSQL once RAW Block volume support is introduced.

3. In all the scripts, the names of pods, their DeploymentConfigs and their respective namespaces are kept SAME for simplicity.

4. Both mongodb and pgsql folder have a README copied from here for better understanding.

# Mongodb Workload

#Pre-requisites 

1. Clone the github repo 
$ git clone https://github.com/nehaberry/workloads.git

2. Edit the deploy-mongodb.sh to change volumeCapacity and memoryLimit as per test requirement.

3. Edit the run-workload-mongodb.sh to change following params based on test requirement:
    threads, recordCount, operationCount, iterations

4. Edit the wrapper scripts (pod-create.sh and run-io.sh) as per test requirements.

## Workflow for creating single pod and pvc

1. Navigate to mongodb folder
    $ cd ./mongodb

2. Create Mongodb pod (sh deploy-mongodb.sh <name of pod/namespace> <Storageclass Name>
    e.g 
	$ sh deploy-mongodb.sh mongodb-1 csi-rbd


3. Create the ycsb pod (syntax:  sh ycsb.sh <name> <namespace>)
    e.g.
	$ sh ycsb.sh ycsb-1 mongodb-1
      
4. Start the Workload (syntax: sh run-workload-mongodb.sh <mongodbDC> <ycsbDC>)
    e.g. 
	$ sh run-workload-mongodb.sh mongodb-1 ycsb-1

5. Check the run logs in files prefixed with output-* in the current folder
     
## Workflow for creating Multiple pods(each attached with 1 pvc)

1. Create a set of mongodb & ycsb pods (syntax: sh pod-create.sh <mongoPrefix> <StorageClassName> <ycsb-prefix>)
    e.g. 
	$ sh pod-create.sh mongodb csi-rbd ycsb

2. Run  Workload (syntax:  run-io.sh <mongoPrefix> <ycsbPrefix> <logLocation>)
    e.g.
	$ sh run-io.sh sh mongodb ycsb ./iter1/
    NB: The workload is run in background using nohup.

4. Check IO
	Navigate to the LogLocation folder and check the run logs.


# PGSQL Workload

Pre-requisites: 

1. Clone the github repo 
    $ git clone https://github.com/nehaberry/workloads.git

2. Edit the deploy-pgsql.sh to change volumeCapacity and memoryLimit as per test requirement.

3. Edit the run-workload-pgsql.sh to change following params based on test requirement:
    scaling, clients, threads, transactions, iterations

4. Edit the wrapper scripts (pod-create.sh and run-io.sh) as per test requirements.

## Workflow for creating single pod and pvc


1. Navigate to pgsql folder 
	  $ cd ./pgsql

2. Create PGSQL pod (syntax: sh deploy-pgsql.sh <name> <Storageclass> )
    e.g. 
	$ sh deploy-pgsql.sh pgsql-1 csi-rbd
      
3. Run Workload (syntax:  sh run-workload-pgsql.sh <pgsqlDC> )
    e.g. 
	$ sh run-workload-pgsql.sh pgsql-1

4. Check the run logs in files prefixed with output-* in the current folder
     
## Workflow for creating Multiple pods(each attached with 1 pvc)

1. Create multiple pods (syntax: sh pod-create.sh <pgsqlPrefix> <StorageClassName> )
    e.g 
	$ sh pod-create.sh pgsql csi-rbd 

2. Run  Workload (syntax: run-io.sh <pgsqlPrefix>  <logLocation>)
    e.g 
	$ sh run-io.sh pgsql ./iter1/

3. Check IO
    Navigate to the LogLocation folder and check the logs.
