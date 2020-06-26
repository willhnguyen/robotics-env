FROM nvidia/cudagl:10.2-base-ubuntu16.04

# Install packages
RUN apt-get update && \
    apt-get install -y \
        curl wget lsb-release build-essential sudo clang-format && \
    apt-get clean all

# Install ROS Kinetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN apt-get update && \
    apt-get install -y ros-kinetic-desktop-full ros-kinetic-controller-manager \
        python-rosdep python-rosinstall python-rosinstall-generator python-wstool && \
    apt-get clean all
RUN rosdep init

# Install ros-kinetic-librealsense
COPY install_scripts ./install_scripts
RUN ./install_scripts/ros_kinetic_librealsense.sh

# Add Ubuntu user
RUN adduser --disabled-password --gecos "" ubuntu
RUN adduser ubuntu sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ubuntu
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN rosdep update

WORKDIR /workspace
