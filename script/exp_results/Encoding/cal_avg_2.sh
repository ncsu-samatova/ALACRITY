#!/bin/bash

FILES=$1
NUM=5
for log_p in `ls *.log_p_p` ; do

	cat $log_p |  awk -v avg=$NUM '
	BEGIN {
	   total=0;
	   line = 0;
	}
	{
	   total +=$1;
	   line +=1 ;
	   if (line % avg == 0) {
		   print total/line; 
		   total=0;
		   line = 0;
	   }
	}
	END {
	}
	' > $log_p"_avg"
done



