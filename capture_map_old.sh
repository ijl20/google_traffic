#!/bin/bash
#SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
#WINDOW_ID=$(cat $SCRIPTPATH/window_id.txt)

#
# Get a 1920x1080 screenshot of the google maps traffic page
# Usage:
#    ./capture_map.sh <google map string> <destination directory>
# e.g. for central Cambridge :
#    ./capture_map.sh '@52.2042928,0.1211853,15z/data=!5m1!1e1' ~/google_traffic_data/cambridge_centre/2018/10/01
#

# Set up MAP_STRING to hold the specific part of the Google Maps address
if [ -z $1 ]
then
    # default map string is Cambridge area
    MAP_STRING='@52.2122231,0.1196616,13z/data=!5m1!1e1'
else
    MAP_STRING=$1
fi

# Set up SAVE_DIR to hold the destination directory for the .png file
YYYY=$(date +"%Y")
MM=$(date +"%m")
DD=$(date +"%d")
TODAY=$YYYY-$MM-$DD
NOW=$(date +"%H-%M-%S")
TS=$(($(date +"%s%N")/1000000)) # unix timestamp in milliseconds
TS=${TS:0:10}.${TS:10} # convert for timestamp as seconds.milliseconds

if [ -z $2 ]
then
    SAVE_DIR=~/google_traffic_data/cambridge
else
    SAVE_DIR=$2
fi

SAVE_DIR=$SAVE_DIR/$YYYY/$MM/$DD

# Create the save directory (and intermediates) if necessary
mkdir -p $SAVE_DIR

SAVE_FILE=$SAVE_DIR/${TS}_${TODAY}-$NOW.png

google-chrome --headless --disable-gpu --screenshot=$SAVE_FILE --window-size=1920,1080 "https://www.google.co.uk/maps/$MAP_STRING"

chmod a+r $SAVE_FILE


