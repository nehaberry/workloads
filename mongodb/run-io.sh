mongoPrefix=$1
ycsbPrefix=$2
logLocation=$3

for i in {1..3}; do 
echo "Running IO on $mongoPrefix-$i"
echo "+++++++++++++++++++"

echo "run-workload-mongodb.sh $mongoPrefix-$i $ycsbPrefix-$i "
	nohup sh run-workload-mongodb.sh $mongoPrefix-$i $ycsbPrefix-$i >$logLocation/$mongoPrefix-$i.log & 

echo "IO started in $mongoPrefix-$i "
echo "____________________________"
	sleep 5 
done

