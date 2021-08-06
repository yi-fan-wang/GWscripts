condor_status \
-constraint 'PartitionableSlot =?= True' \
-autoformat lscpu_model_name | sort |\
uniq -c | sort -g
