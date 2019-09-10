#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo 'Usage ./make_video_day.sh <input_dir> <output_filename>'
    echo e.g.
    echo ./make_video_day.sh /home/ijl20/google_traffic_data/cambridge_centre/2018/10/01 cambridge_centre_2018-10-01.mp4
    echo
    echo Will create file 'cambridge_centre_2018-10-01.mp4' in the current directory
    exit 1
fi

# set script exit code to zero here, will update to 1 if errors during processing
SCRIPT_EXIT_CODE=0

DIRFILES=$1/*.png

echo reading image filenames from "$DIRFILES"

# Step 1. Build the SRT (subtitle) file with the timestamps

SRTFILE=$(mktemp).srt
echo Creating SRT file in $SRTFILE

i=0

# Ensure start with empty subtitle file
echo >$SRTFILE
if [ "$?" -ne 0 ]
then
    # if ERROR, echo to stderr and exit
    echo ERROR make_video_day.sh Cannot create subtitle file \"$SRTFILE\" 1>&2
    exit 1
fi

for f in $DIRFILES;
do
    # add the 'index' of the current subtitle 1..n
    echo $(( i + 1 )) >>$SRTFILE;

    # add the time1->time2 range for the current subtitle
    ss=$(( $i % 60 ));
    mm=$(( $i / 60 ));
    echo "00:$(printf '%02g' $mm):$(printf '%02g' $ss),000 --> 00:$(printf '%02g' $mm):$(printf '%02g' $ss),999" >>$SRTFILE;

    # e.g. with 1538398734.981_2018-10-01-13-58-54.png
    # add the actual subtitle text, i.e. the date/time from the file name
    FILENAME=$(basename $f)
    #echo Making subtitle from $FILENAME

    FILEDATE=${FILENAME:15:10}

    FILETIME=${FILENAME:26:8}
    # replace '_' with ' '
    SUBTITLE="${FILEDATE} ${FILETIME}"
    echo $SUBTITLE >>$SRTFILE;

    # add trailing blank line after each subtitle
    echo >>$SRTFILE;

    i=$((i + 1));
done

# Step 2. Create the mp4 video file including the timestamps as subtitles

echo Creating video file $VIDEOFILE

#ffmpeg -framerate 1 -pattern_type glob -i "$DIRFILES" -vf subtitles=$SRTFILE -c:v libx264 -s 1920,1080 -r 1 -pix_fmt yuv420p -scodec copy $2
ffmpeg -n -framerate 1 -pattern_type glob -i "$DIRFILES" -i $SRTFILE -c:v libx264 -s 1920,1080 -r 1 -pix_fmt yuv420p -c:s mov_text $2 >/dev/null 2>/dev/null

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]
then
    echo ERROR make_video_day.sh $1 $2 ffmpeg returned $EXIT_CODE
    SCRIPT_EXIT_CODE=1
fi

exit ${SCRIPT_EXIT_CODE}

