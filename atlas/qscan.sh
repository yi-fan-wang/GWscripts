gps=1253489343.113
name=190925
m1=10.653880378373605
m2=14.063826070838909
gpsm=`echo "scale=0;($gps-100)/1" | bc -l`
gpsp=`echo "scale=0;($gps+100)/1" | bc -l`
echo 'gps time: '$gps
echo '['$gpsm','$gpsp']'

/work/yifan.wang/3ogcPE/subthreshold/pycbc_plot_qscan \
--time-windows 1,1 0.5,0.5 --strain-high-pass 9 --sample-rate 2048 --pad-data 2 \
--frame-type L1_GWOSC_O3a_4KHZ_R1 --channel-name L1:GWOSC-4KHZ_R1_STRAIN \
--gps-start-time $gpsm --gps-end-time $gpsp --center-time $gps \
--output-file $name-L.png \
--qtransform-qrange-lower 10 \
--qtransform-qrange-upper 10 

/work/yifan.wang/3ogcPE/subthreshold/pycbc_plot_qscan \
--time-windows 1,1 0.5,0.5 --strain-high-pass 9 --sample-rate 2048 --pad-data 2 \
--frame-type H1_GWOSC_O3a_4KHZ_R1 --channel-name H1:GWOSC-4KHZ_R1_STRAIN \
--gps-start-time $gpsm --gps-end-time $gpsp --center-time $gps \
--output-file $name-H.png \
--qtransform-qrange-lower 10 \
--qtransform-qrange-upper 10 

/work/yifan.wang/3ogcPE/subthreshold/pycbc_plot_qscan \
--time-windows 1,1 0.5,0.5 --strain-high-pass 9 --sample-rate 2048 --pad-data 2 \
--frame-type V1_GWOSC_O3a_4KHZ_R1 --channel-name V1:GWOSC-4KHZ_R1_STRAIN \
--gps-start-time $gpsm --gps-end-time $gpsp --center-time $gps \
--output-file $name-V.png \
--qtransform-qrange-lower 10 \
--qtransform-qrange-upper 10 
