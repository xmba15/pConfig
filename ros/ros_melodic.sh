#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


# Installing packages
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-melodic-desktop-full

# Installing catkin tools
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential
sudo apt-get install python-catkin-tools


echo "export ROS_DISTRO=melodic" >> ~/.bash_ros
export ROS_DISTRO=melodic
mkdir -p ~/ros/$ROS_DISTRO/src
cd ~/ros/$ROS_DISTRO
source /opt/ros/$ROS_DISTRO/setup.bash
echo $CMAKE_PREFIX_PATH
catkin config --init --cmake-args -DCMAKE_BUILD_TYPE=Release


cd ~/ros/$ROS_DISTRO
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -r -n -y
