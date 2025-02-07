#!/bin/bash 

IMAGE_NAME="browser-base"
PARAMS_FILE="params.env"

if [ -z "$1" ]; then
  # Set default value if not provided
  IMAGE_TAG="latest"
else
  IMAGE_TAG="$1"
fi

if [ -f $PARAMS_FILE ]; then
    export $(grep -v '^#' $PARAMS_FILE | xargs)
fi

check_docker() {
    if command -v docker &>/dev/null; then
        echo "=== Docker is installed on your system. ==="
    else
        echo "=== Docker is not installed on your system. Exiting... ==="
        exit 1;
    fi
}

check_docker

echo "=== Starting build docker image: ${IMAGE_NAME}:${IMAGE_TAG}. ==="

docker build \
    --build-arg VNC=${VNC} \
    --build-arg USER=${USER} \
    --build-arg RESOLUTION=${RESOLUTION} \
    -t $IMAGE_NAME:$IMAGE_TAG .


if [ $? -eq 0 ]; then
  echo "=== Build is finished. ==="
  exit 0;
fi
