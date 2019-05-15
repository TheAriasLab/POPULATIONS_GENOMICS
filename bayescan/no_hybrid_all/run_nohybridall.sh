ls -d */ > dirs.txt
for i in $(cat dirs)
do 
cd $i
echo -----------------------------------------------------------
echo ---------------------- Running $i -------------------------
echo -----------------------------------------------------------
/BayeScan2.1/source/bayescan_2.1 no_hybrid.bayescan
cd ..
done
