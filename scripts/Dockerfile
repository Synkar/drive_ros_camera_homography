FROM ros:noetic-ros-base-focal

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install ROS packages and tools
RUN apt-get update && apt-get install -y \
    ros-noetic-rqt-image-view \
    ros-noetic-swri-console \
    ros-noetic-rqt \
    ros-noetic-rqt-common-plugins \
    ros-noetic-rqt-robot-plugins \
    ros-noetic-rqt-runtime-monitor \
    ros-noetic-image-geometry \
    python3-pip \
    python3-opencv \
    libopencv-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    pkg-config \
    build-essential \
    cmake \
    git \
    wget \
    python3-catkin-tools \
    python3-osrf-pycommon \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

# Creating a catkin workspace
COPY ./ /root/synkar_ws/src/drive_ros_camera_homography

# Build the catkin workspace
RUN source /opt/ros/noetic/setup.bash && \
    cd /root/synkar_ws && \
    catkin config --init --extend /opt/ros/noetic && \
    catkin build

# Source the workspace setup file
RUN echo '#!/bin/bash' > /root/entrypoint.sh && \
    echo 'source /opt/ros/noetic/setup.bash' >> /root/entrypoint.sh && \
    echo 'source /root/synkar_ws/devel/setup.bash' >> /root/entrypoint.sh && \
    echo 'exec "$@"' >> /root/entrypoint.sh && \
    chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]

WORKDIR /root/synkar_ws
