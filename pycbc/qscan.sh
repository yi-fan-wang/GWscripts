gps=1248112066.462
name=GW190725+17:47:28UTC
m1=13
m2=8
gpsm=`echo "scale=0;($gps-100)/1" | bc -l`
gpsp=`echo "scale=0;($gps+100)/1" | bc -l`
echo 'gps time: '$gps
echo '['$gpsm','$gpsp']'

/work/yifan.wang/3ogcPE/subthreshold/pycbc_plot_qscan \
--time-windows 1,1 0.5,0.5 --strain-high-pass 9 --sample-rate 2048 --pad-data 2 \
--frame-type L1_GWOSC_O3a_4KHZ_R1 --channel-name L1:GWOSC-4KHZ_R1_STRAIN \
--gps-start-time $gpsm --gps-end-time $gpsp --center-time $gps \
--output-file $name-L.png \
--mass1 $m1 --mass2 $m2 \
--qtransform-qrange-lower 10 \
--qtransform-qrange-upper 10 

/work/yifan.wang/3ogcPE/subthreshold/pycbc_plot_qscan \
--time-windows 1,1 0.5,0.5 --strain-high-pass 9 --sample-rate 2048 --pad-data 2 \
--frame-type V1_GWOSC_O3a_4KHZ_R1 --channel-name V1:GWOSC-4KHZ_R1_STRAIN \
--gps-start-time $gpsm --gps-end-time $gpsp --center-time $gps \
--output-file $name-V.png \
--qtransform-qrange-lower 10 \
--qtransform-qrange-upper 10 
