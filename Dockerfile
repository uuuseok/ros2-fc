FROM ubuntu:22.04

LABEL maintainer='useok'
LABEL description='ubuntu 22.04 ros2 humble'

SHELL ["/bin/bash", "-c"]

# for ignore set keyboard layout
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt update -y
# for ignore set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y build-essential gcc make perl dkms vim x11-apps wget sudo git


# set locale
RUN apt update && apt install locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8


#setup sources
RUN apt install -y software-properties-common
RUN add-apt-repository universe


RUN apt update && apt install curl -y
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


#install ROS2 packages
RUN apt update -y
RUN apt upgrade -y

RUN apt install -y ros-humble-desktop
RUN apt install -y ros-dev-tools


#environment setup
RUN source /opt/ros/humble/setup.bash


#WORKDIR /root
#RUN mkdir -p ros2_ws/src
#WORKDIR ros2_ws
#RUN colcon build --symlink-install

# setup ros environment
#RUN sh -c "echo \"source /opt/ros/humble/setup.bash\" >> ~/.bashrc"
#RUN sh -c "echo \"source ~/ros2_ws/install/local_setup.bash\" >> ~/.bashrc"

RUN apt-get install -y ros-humble-cartographer ros-humble-cartographer-ros ros-humble-navigation2 ros-humble-nav2-bringup


WORKDIR /root
ENTRYPOINT ["/bin/bash"]

