for ITEM in "apple" "banana" "orange"
do
	echo "Fruit: $ITEM"
done

for i in {1..3}
do
	echo "number $i"
done

for FILE in $(ls *.sh)
do 
	echo "File: $FILE"
done
