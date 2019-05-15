INPUT="missing10"
for i in $(seq 1 1 10)
do
echo trabajando en K=$i
structure.py -K $i --input=$INPUT --format=str --output=missing --cv=100 --seed $RANDOM
done
chooseK.py --input=missing > rangeK.txt
