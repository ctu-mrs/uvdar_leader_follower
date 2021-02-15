#!/bin/bash

set -e

distro=`lsb_release -r | awk '{ print $2 }'`
[ "$distro" = "18.04" ] && ROS_DISTRO="melodic"
[ "$distro" = "20.04" ] && ROS_DISTRO="noetic"

MY_PATH=`pwd`

echo "Starting install preparation"

sudo apt-get -y install git

echo "clone uvdar_core"
cd
git clone https://github.com/ctu-mrs/uvdar_core.git

echo "clone uvdar_gazebo_plugin"
cd
git clone https://github.com/ctu-mrs/uvdar_gazebo_plugin.git

echo "clone summer_school_supervisor"
cd
git clone https://github.com/ctu-mrs/summer_school_supervisor.git

echo "clone uav_core"
cd
git clone https://github.com/ctu-mrs/uav_core.git
cd uav_core
echo "running the main install.sh"
./installation/install.sh

echo "clone simulation"
cd
git clone https://github.com/ctu-mrs/simulation.git
cd simulation
echo "running the main install.sh"
./installation/install.sh

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
ln -s ~/uav_core
ln -s ~/simulation
ln -s ~/uvdar_core
ln -s ~/uvdar_gazebo_plugin
ln -s ~/summer_school_supervisor summer_school_supervisor
ln -s "$MY_PATH" uvdar_leader_follower
source /opt/ros/$ROS_DISTRO/setup.bash
cd ~/catkin_ws

echo "installation part ended"
