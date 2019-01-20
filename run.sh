#!/bin/bash

# define your list of boxes (each must have config/<box_id>.sh)
declare -a boxes=("cambridge"
                  "cambridge_centre"
                 )

# get script directory

IMG_DIR="/media/tfc/google_traffic_map"

echo Writing image files to "${IMG_DIR}"
#IMG_DIR="/home/ijl20/google_traffic_data"

EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo EXEC_DIR=${EXEC_DIR}

# iterate the boxes

for config_id in "${boxes[@]}"
do
    echo $config_id
    CONFIG_SH="${EXEC_DIR}/config/${config_id}.sh"
    echo running \"${CONFIG_SH}\"
    source "${CONFIG_SH}"
    echo google_lat "${google_lat}"
    echo box_title- ${box_title} # from config file
    CAPTURE_URL="@${google_lat},${google_lng},${google_zoom}/data=!5m1!1e1"
    CAPTURE_DIR="${IMG_DIR}/${box_id}"
    echo CAPTURE_URL \"${CAPTURE_URL}\"
    echo CAPTURE_DIR \"${CAPTURE_DIR}\"
    "${EXEC_DIR}/capture_map.sh" ${CAPTURE_URL} ${CAPTURE_DIR}
    #"${EXEC_DIR}/capture_map.sh" '@${google_lat},${google_lng},${google_zoom}/data=!5m1!1e1' "${IMG_DIR}/${box_id}"
done

#/home/ijl20/google_traffic/capture_map.sh  '@52.2122231,0.1196616,13z/data=!5m1!1e1' /data/tfc/google_traffic_map/      cambridge

