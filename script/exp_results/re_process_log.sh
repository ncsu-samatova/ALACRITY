#!/bin/bash

TMP1="t1.log"
TMP2="t2.log"

#for log in "naive.log" "simple.log" "merged.log" "epfd.log" "rpfd.log" ; do 
#for log in "timing_encode_flash.log" ; do 
#LOGS="bmap_build_thrpt_s3d_gts_flash.log_p"
LOGS="timing_encode_gts.log_p"

for log in $LOGS ; do 
#log="timing_encode_gts_potential.log"  
	#delete qsub output
	sed '/^[a-zA-Z].*$/d' $log  > $TMP1
	F_OUT=$log"_p" # final output has the "_p" as suffix at end of file name	
	#delete empty line 
	sed '/^$/d' $TMP1 > $F_OUT

done


rm -f $TMP1 $TMP2

./cal_avg_2.sh $F_OUT 5
