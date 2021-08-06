#for event in GW210105-deglitched
#for event in GW210105-glitched-flow25
inputfile=result.hdf
extoutputfile=extract.hdf
fitsfile=extract.fits
outputfolder=plot

mkdir $outputfolder
echo "extract event"
pycbc_inference_extract_samples --force  \
--parameters 'mass1_from_mchirp_q(srcmchirp,q):srcmass1' \
	     'mass2_from_mchirp_q(srcmchirp,q):srcmass2'     \
	     'chi_eff_from_spherical(mass1_from_mchirp_q(srcmchirp,q),mass2_from_mchirp_q(srcmchirp,q),spin1_a, spin1_polar,spin2_a, spin2_polar):chi_eff' \
	     'chi_p_from_spherical(mass1_from_mchirp_q(srcmchirp,q),mass2_from_mchirp_q(srcmchirp,q),spin1_a,spin1_azimuthal,spin1_polar,spin2_a,spin2_azimuthal,spin2_polar):chi_p' \
	     'redshift_from_comoving_volume(comoving_volume):redshift' \
	     'distance_from_comoving_volume(comoving_volume):distance' \
	     srcmchirp q spin1_a spin1_polar spin1_azimuthal spin2_a spin2_polar spin2_azimuthal dipole_b \
	     'trigger_time + delta_tc:tc' \
	     delta_tc \
	     '*' \
--input-file $inputfile \
--output-file $extoutputfile

echo "make fits"
pycbc_inference_create_fits --maxpts 1000 --tc 'trigger_time+delta_tc' --input-file $extoutputfile --output-file $fitsfile

echo "plot intrinsic "
pycbc_inference_plot_posterior \
    --plot-contours  \
    --plot-marginal  \
    --plot-scatter \
    --plot-prior inference-GW200105.ini \
    --z-arg snr \
    --input-file  $extoutputfile \
    --output-file $outputfolder/mass.png \
    --parameters srcmass1 \
    	         srcmass2 \
		 srcmchirp \
		 q \
		 chi_eff dipole_b \
		 distance \
		 inclination 

echo "plot intrinsic "

pycbc_inference_plot_posterior \
    --plot-contours  \
    --plot-marginal  \
    --plot-scatter \
    --z-arg snr \
    --plot-prior inference-GW200105.ini \
    --input-file  $extoutputfile \
    --output-file $outputfolder/spin.png \
    --parameters spin1_a \
    		spin2_a \
		 chi_eff \
		 chi_p \

echo "plot extrinsic "

pycbc_inference_plot_posterior \
    --plot-contours  \
    --plot-marginal  \
    --plot-scatter \
    --z-arg snr \
    --plot-prior inference-GW200105.ini \
    --input-file  $extoutputfile \
    --output-file $outputfolder/ext.png \
    --parameters delta_tc \
    		coa_phase \
		ra \
		dec \

echo "plot sky map "
pycbc_inference_plot_skymap --colormap Blues  --input-file $fitsfile --output-file $outputfolder/sky.png
