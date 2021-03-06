#!/bin/bash

VARS=("naive_avg.csv"  "simple_avg.csv"   "epfd_avg.csv" "rpfd_avg.csv" "erpfd_avg.csv"   )
FINAL="final"
TMPS=("n.tmp" "s.tmp" "m.tmp" "r.tmp" "e.tmp")
for ((line=1; line < 16 ; line ++ )); do 
    for ((i=0; i < ${#VARS[@]}; i++)); do 
	VFILE=${VARS[i]}
 	TMPF=${TMPS[i]}
	echo "$VFILE $TMPF"
	head -${line} ${VFILE} | tail -1 | sed -e"s/,/\n/g" > $TMPF
    done 
    paste -d"," ${TMPS[0]} ${TMPS[1]} ${TMPS[2]} ${TMPS[3]} ${TMPS[4]}  > $FINAL$line".csv"
#    for ((j=0; j < ${#TMPS[@]}; j++)); do 
#	paste -d"," $FINAL ${TMPS[j]} >> $FINAL
#    done


done 

    paste -d"," $FINAL"1.csv" $FINAL"2.csv" $FINAL"3.csv" $FINAL"4.csv" $FINAL"5.csv" > $FINAL"4var.csv"
    paste -d"," $FINAL"6.csv" $FINAL"7.csv" $FINAL"8.csv" $FINAL"9.csv" $FINAL"10.csv" > $FINAL"3var.csv"
    paste -d"," $FINAL"11.csv" $FINAL"12.csv" $FINAL"13.csv" $FINAL"14.csv" $FINAL"15.csv" > $FINAL"2var.csv"
