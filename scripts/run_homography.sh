#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -a
source $SCRIPT_DIR/.env
set +a

NVIDIA=$(echo "$NVIDIA" | tr '[:upper:]' '[:lower:]')
if [ "${NVIDIA:-true}" = "true" ]; then
  echo "Running with NVIDIA support"
  RENDERER="--nvidia"
else
  echo "Running without NVIDIA support"
  RENDERER="--devices /dev/dri"
fi

rocker $RENDERER  --x11 \
  --name drive_ros_camera_homograph \
  --network host \
  --env ROS_MASTER_URI \
  --env-file $SCRIPT_DIR/.env \
  knowledgebase.datah.com.br:5000/synkar/delivery/autonomy:${HOMOGRAPHY_VERSION:-latest} \
  ${@:-"roslaunch drive_ros_camera_homography homography_estimator.launch"}
