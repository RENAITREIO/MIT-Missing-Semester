cnt=0
fileToTest=./error.sh
fileToRecord=./record.txt
echo '[Record]' > "$fileToRecord"

while true
do
	"$fileToTest" >> "$fileToRecord" 2>&1
	ret=$?
	cnt=$((cnt+1))
	if [ "$ret" -eq 1 ]; then
		break
	fi
done

cat "$fileToRecord"
echo "Times: $cnt"
