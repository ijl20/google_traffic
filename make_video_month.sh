#!/bin/bash

if [ "$#" -ne 5 ]
then
  echo 'This script will compress a month of 'day' directories  of PNG files into a direcotry of MP4 files'
  echo
  echo 'Usage: ./make_video_month.sh <input_root> <base> <YYYY> <MM> <output_root>'
  echo 'e.g. ./make_video_month.sh /media/tfc/google_traffic_data cambridge 2019 09 /data/google_traffic_data'
  echo
  echo 'The input directory structure is expected to be <input_root>/<base>/<YYYY>/<MM>/<day>/*.png'
  echo 'The output files will be <output_root>/<base>/<year>/<month>/<base>_<YYYY>-<MM>-<day>.mp4'
  exit 1
fi

INPUT_ROOT=$1

BASE=$2

YYYY=$3

MM=$4

OUTPUT_ROOT=$5

INPUT_DIR=${INPUT_ROOT}/${BASE}/${YYYY}/${MM}

OUTPUT_DIR=${OUTPUT_ROOT}/${BASE}/${YYYY}/${MM}

EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

mkdir -p ${OUTPUT_DIR}

# set script exit code to zero here, will update to 1 if errors during processing
SCRIPT_EXIT_CODE=0

for i in `seq 1 31`;
do
  DAY_NUM=$(printf "%02d" $i)
  INPUT_DAY_DIR=${INPUT_DIR}/${DAY_NUM}
  if [ -d ${INPUT_DAY_DIR} ];
  then
    echo dir ${INPUT_DAY_DIR} exists
    $EXEC_DIR/make_video_day.sh ${INPUT_DAY_DIR} ${OUTPUT_DIR}/${BASE}_${YYYY}-${MM}-${DAY_NUM}.mp4
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]
    then
        # echo to stderr
        >&2 echo make_video_month.sh error in ${INPUT_ROOT}/${BASE}/${YYYY}/${MM}
        SCRIPT_EXIT_CODE=1
    fi
  else
    echo $INPUT_DAY_DIR not found
  fi
done

exit ${SCRIPT_EXIT_CODE}

