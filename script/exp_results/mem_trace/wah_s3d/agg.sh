#!/bin/bash
#A Aggregation script which merges all results into one csv file 
# each file only has one column data 
############    WAH  ##############################################

CSVS1=("wah_4var_.001.csv" "wah_4var_.01.csv" "wah_4var_.1.csv" "wah_4var_1.csv" "wah_4var_10.csv"  )


CSVS2=("wah_3var_.001.csv" "wah_3var_.01.csv" "wah_3var_.1.csv" "wah_3var_1.csv" "wah_3var_10.csv" )



CSVS3=("wah_2var_.001.csv" "wah_2var_.01.csv" "wah_2var_.1.csv" "wah_2var_1.csv" "wah_2var_10.csv" )
############    EWAH  ##############################################

#ALL THESE .csv files should begin with ewah, but its a mistake it is epd now 
CSVS4=("epd_4var_.001.csv" "epd_4var_.01.csv" "epd_4var_.1.csv" "epd_4var_1.csv" "epd_4var_10.csv" )

CSVS5=("epd_3var_.001.csv" "epd_3var_.01.csv" "epd_3var_.1.csv" "epd_3var_1.csv" "epd_3var_10.csv" )

CSVS6=("epd_2var_.001.csv" "epd_2var_.01.csv" "epd_2var_.1.csv" "epd_2var_1.csv" "epd_2var_10.csv" )


FILES="${CSVS1[*]} ${CSVS2[*]} ${CSVS3[*]} ${CSVS4[*]} ${CSVS5[*]} ${CSVS6[*]} "

TOFILE="wah_ewah_s3d.csv"

echo " mereg all files ${FILES} to one file ${TOFILE} "

paste -d"," ${FILES} > ${TOFILE}

