#!/usr/bin/env bash

# HugePages tunning
function HugePagesTune(){
   if [[ `echo $SRBMINER_ALGO | grep -c "^random"` -gt 0 ]]; then
     echo "Apply HugePages tuning for RandomX ..."
     hugepages -rx
   fi
}

[[ `ps aux | grep "SRBMiner-MULTI" | grep -v grep | wc -l` != 0 ]] &&
  echo -e "${RED}$MINER_NAME miner is already running${NOCOLOR}" &&
  exit 1

cd $MINER_DIR/$MINER_VER

HugePagesTune

unset LD_LIBRARY_PATH

unbuffer ./SRBMiner-MULTI `cat $MINER_NAME.conf` --log-file $MINER_LOG_BASENAME.log #| tee --append $MINER_LOG_BASENAME.log
