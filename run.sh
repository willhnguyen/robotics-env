#!/bin/bash

# Run docker with current directory (pwd) as /workspace
xhost +local:root # for the lazy and reckless
docker run --rm -it \
    --name robond \
    --privileged \
    -e DISPLAY=:1 \
    --gpus all \
    --env="QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v `pwd`:/workspace \
    docker.pkg.github.com/willhnguyen/robotics-env/robotics-env:latest \
    /bin/bash
