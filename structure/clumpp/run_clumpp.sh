#Run clumpp for sumarize for summarize MCMC and take this results to distruct for visualization based on paramfiles provided
# run clump ind
rm paramfile
cp paramfile_ind paramfile
CLUMPP
mkdir -p ./../distruct
rm paramfile
# run clump pop
cp paramfile_pop paramfile
CLUMPP
