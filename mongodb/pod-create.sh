mongoPrefix=$1
StorageClass=$2
ycsbPrefix=$3

for i in {1..3}; do

echo "Creating mongodb and ycsb pods in namespace : $mongoPrefix-$i"
echo "+++++++++++++++++++"

	sh deploy-mongodb.sh $mongoPrefix-$i $StorageClass ;
        sh ycsb.sh $ycsbPrefix-$i $mongoPrefix-$i
	date
echo "Pods in namespace : $mongoPrefix-$i created"
echo "____________________________"
	sleep 3
done

