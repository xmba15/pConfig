FROM  ubuntu:18.04 as base

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS yes

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

# using Japan server makes the build faster
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        gnupg2 \
        sudo \
        lsb-release \
        systemd \
        wget \
        curl \
        git-all \
        openssh-server \
        build-essential \
        git-all \
        cmake \
        software-properties-common \
        && rm -rf /var/lib/apt/lists/*

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
        && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
        ros-melodic-desktop-full \
        python-rosdep \
        && rosdep init \
        && rosdep update \
        && apt-get install -y --no-install-recommends \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        python-catkin-tools \
        && rm -rf /var/lib/apt/lists/*

# Better to use a non-root user so create one with disabled-password
ENV USER=bmax
ENV WORKDIR=/home/${USER}
RUN groupadd ${USER} && useradd -g ${USER} ${USER} && echo "${USER}:${USER}" | sudo chpasswd && usermod -a -G sudo ${USER}

RUN mkdir -p ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

USER ${USER}
WORKDIR ${WORKDIR}
ENV ROS_DISTRO=melodic

RUN echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashrc \
        && echo ". /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# RUN echo $CMAKE_PREFIX_PATH
# RUN mkdir -p ~/ros/${ROS_DISTRO}/src && cd ~/ros/${ROS_DISTRO} && catkin config --init --cmake-args -DCMAKE_BUILD_TYPE=Release
