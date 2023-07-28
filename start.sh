#!/bin/bash

BASE_IMAGE=nvidia/cuda
DEFAULT_CUDA_IMAGE_TAG=12.2.0-devel-ubuntu20.04

# Parse command-line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--tag)
    image_tag="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

DOCKER_IMAGE=$BASE_IMAGE:${image_tag:-$DEFAULT_CUDA_IMAGE_TAG}
docker run -it --rm --gpus all -v ${PWD}:/app/ -w /app/ $DOCKER_IMAGE bash
