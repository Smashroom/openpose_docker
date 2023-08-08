#!/usr/bin/env bash
if [[ -z "$DISPLAY" ]]
then
    export DISPLAY=":0"
fi

readarray -t ALL_DISPLAYS <<< $(cd /tmp/.X11-unix && for x in X*; do echo ":${x#X}"; done)
if [[ -z ${ALL_DISPLAYS[@]} ]]
then
    echo "No displays available. Exiting."
    exit 1
else
    export DISPLAY="${ALL_DISPLAYS[0]}"
fi

# enable access to xhost from the container
xhost +local:root

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT=$(realpath "${SCRIPT_DIR}/..")
REPO_MOUNT="/workspace/openpose_ws"

# TODO: replace by the image name built by VS Code devcontainer extension
IMAGE="openpose:python-support-cv2"

echo "Mounting ${REPO_ROOT} in ${REPO_MOUNT}"

docker run -it \
    --rm \
    --privileged \
    --net=host \
    --runtime=nvidia \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --cap-add=SYS_PTRACE \
    --security-opt=seccomp:unconfined \
    --security-opt=apparmor:unconfined \
    -v ${REPO_ROOT}:${REPO_MOUNT} \
    ${IMAGE} \
    bash
