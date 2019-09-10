#!/bin/bash

if [ "$#" -ne 4 ]
then
  echo 'This script will compress a 'year' nested directory of PNG files into monthly directories of 'day' MP4 files'
  echo
  echo 'Usage: ./make_video_year.sh <input_root> <base> <YYYY> <output_root>'
  echo 'e.g. ./make_video_year.sh /media/tfc/google_traffic_data cambridge 2019 /data/google_traffic_data'
  echo
  echo 'The input directory structure is expected to be <input_root>/<base>/<YYYY>/<month>/<day>/*.png'
  echo 'The output files will be <output_root>/<base>/<YYYY>/<month>/<base>_<YYYY>-<month>-<day>.mp4'
  exit 1
fi

INPUT_ROOT=$1

BASE=$2

YYYY=$3

OUTPUT_ROOT=$4

EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# set script exit code to zero here, will update to 1 if errors during processing
SCRIPT_EXIT_CODE=0

for i in `seq 1 12`;
do
  MM=$(printf "%02d" $i)
  INPUT_MONTH_DIR=${INPUT_ROOT}/${BASE}/${YYYY}/${MM}
  if [ -d "${INPUT_ROOT}/${BASE}/${YYYY}/${MM}" ]
  then
    $EXEC_DIR/make_video_month.sh ${INPUT_ROOT} ${BASE} ${YYYY} ${MM} ${OUTPUT_ROOT}
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]
    then
        # echo to stderr
        >&2 echo make_video_year error in ${INPUT_ROOT}/${BASE}/${YYYY}
        SCRIPT_EXIT_CODE=1
    fi
  else
    echo ${INPUT_ROOT}/${BASE}/${YYYY}/${MM} not found
  fi
done

exit ${SCRIPT_EXIT_CODE}

