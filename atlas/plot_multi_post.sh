outputfolder=plot

mkdir $outputfolder

for file in $(ls ./)
do 
{
    if [ "${file##*.}" = "hdf" ]; then
	    echo $file
	pycbc_inference_plot_posterior \
    --plot-contours  \
    --plot-marginal  \
    --plot-scatter \
    --z-arg snr \
    --input-file  $file \
    --output-file $outputfolder/$(echo $file | cut -d . -f1).png \
    --parameters srcmchirp \
		 q \
		 parity_amu 
    fi
}&
done
wait

