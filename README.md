# openpose-docker
A docker build file for CMU openpose with Python API support

https://hub.docker.com/r/cwaffles/openpose

### Requirements
- Nvidia Docker runtime: https://github.com/NVIDIA/nvidia-docker#quickstart
- CUDA 10.0 or higher on your host, check with `nvidia-smi`

## Installation

1. Clone the repo to this folder
```
git clone git@github.com:CMU-Perceptual-Computing-Lab/openpose.git
```
2. Update the submodules
```
git submodule update --init --recursive --remote
```
3. Build the docker container (can be run parallel with Steps 1-2)
```
$ cd docker
$ chmod +x build_devcontainer.sh
$ ./build_devcontainer.sh 
```
4. Once everything is finished run the container
```
$ cd docker
$ chmod +x run_devcontainer.sh
$ ./run_devcontainer.sh
```
5. Let's build our lovely repo within the container
```
$ cd /workspace/openpose_ws/openpose
$ mkdir build
$ cd build
$ cmake -DBUILD_PYTHON=ON -DUSE_CUDNN=OFF .. && make -j `nproc`
```

Voila! 


## FAQ

1. If you get the following error while compiling with `CPU` support:
```
/usr/bin/ld: error: ../../caffe/lib/libcaffe.so: file too short
```

run the following command within the build directory:

`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/workspace/openpose_ws/openpose/build/caffe/lib/`


2. 
