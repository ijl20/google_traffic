#!/bin/bash

# Usage: ./make_video_month.sh <input_root> <base> <YYYY> <MM> <output_root>
# e.g. ./make_video_month.sh /media/tfc/google_traffic_data/cambridge/2019/09 /data/google_traffic_data/2019

INPUT_ROOT=$1

BASE=$2

YYYY=$3

MM=$4

INPUT_DIR=${INPUT_ROOT}/${BASE}/${YYYY}/${MM}

OUTPUT_DIR=$5/${BASE}/${YYYY}/${MM}

EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

mkdir -p ${OUTPUT_DIR}

for i in `seq 1 31`;
do
  DAY_NUM=$(printf "%02d" $i)
  INPUT_DAY_DIR=${INPUT_DIR}/${DAY_NUM}
  if [ -d ${INPUT_DAY_DIR} ];
  then
    echo dir ${INPUT_DAY_DIR} exists
    $EXEC_DIR/make_video.sh ${INPUT_DAY_DIR} ${OUTPUT_DIR}/${BASE}_${YYYY}-${MM}-${DAY_NUM}.mp4
  else
    echo $DAY_DIR not found
  fi
done
