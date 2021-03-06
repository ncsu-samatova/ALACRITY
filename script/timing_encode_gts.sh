#!/bin/bash
# this script is used for timing the encoding method, 
# encoding method now include RPFD, and EPFD

ALAC_DIR=/tmp/work/zgong/work/intersection/alac_multi_engine/

source $ALAC_DIR/script/env_setting_flash_sith.sh

function is_in_qsub() {
    hostname | grep -v login
}

function subtest() {

    if ! is_in_qsub; then
        rm -f $TMP_DS
#        mkdir -p $TMP_WORK_DIR
#        cp -r ${DATA_DIR} $TMP_DS
	# we are not execute exactly on one dataset , abandon the dir folder 
        cp  ${DATA_DIR} $TMP_DS
        echo "Settling..."
        sleep 2s  # Wait for the copy to settle
        echo "qsub..."
	# this strange calling is because we can not add 'x' on the qsub command 
	$QSUB -x $TMP_SCRIPT $COMMAND $DS_ELM_SIZE $EN_MTD $TMP_DS $TMP_OUT_DIR >> $LOG_FILE
        echo "Settling..."
        sleep 1s # Settle again
    else
        echo "Must be run on a login node"
        exit 1     
    fi
}

if hostname | grep -q sith; then
  QSUB="qsub -I -lwalltime=1:0:0,nodes=1:ppn=32 "
elif hostname | grep -q lens; then
  QSUB="qsub -I -ACSC025EWK -q comp_mem -lwalltime=1:0:0,nodes=1:ppn=16 "
fi

TMP_SCRIPT=$ALAC_DIR/script/encode_template.sh

DATA_DIR=""
WHERECLS=""
COMMAND=""
COMMAND=${ENCODE}
#####################need to been changed #########################
iter=10
DS_ELM_SIZE=275869696 #number of element in the dataset 
DATA_DIR="/lustre/widow2/scratch/xzou2/widow0-20130305/sigmod_2GB/"
TMP_DS=$ALAC_DIR/../data/temp/gts/potential
TMP_OUT_DIR=$ALAC_DIR/../data/temp/gts//tmp_out
LOG_FILE=$ALAC_DIR/../result/throughput/timing_encode_gts_potential.log
####################end of to be changed ##########################################

EN_MTD="x"  # ENCODE METHOD x = PFD, h = RPFD, r = EPFD
echo "PFD" >> ${LOG_FILE}
for ((k=1;k<=${iter}; k++ )); do
	subtest
done
echo >> ${LOG_FILE}

EN_MTD="h" 
echo "RPFD" >> ${LOG_FILE}
for ((k=1;k<=${iter}; k++ )); do
	subtest
done
echo >> ${LOG_FILE}


EN_MTD="r" 
echo "EPFD" >> ${LOG_FILE}
for ((k=1;k<=${iter}; k++ )); do
	subtest
done
echo >> ${LOG_FILE}

