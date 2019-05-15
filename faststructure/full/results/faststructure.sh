INPUT="full"
for i in 1 2 3 4 5 6 7 8 9 10
do
echo trabajando en K=$i
structure.py -K $i --input=$INPUT --format=str --output=missing --cv=100 --seed $RANDOM
done
chooseK.py --input=missing > rangeK.txt
