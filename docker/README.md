# Memo for collections of dockers #
***

## Basic Commands ##
***

```
    docker build -f [/path/to/Dockerfile] -t [tag_name] .
```

## squash ##
- in /etc/docker/daemon.json configuration file config as following
```bash
{
    "experimental": true
}
```

- reload daemon
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## nvidia-docker ##
***

```
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

*Remember to add --gpus option when creating a new container*

## Docker Ubuntu ROS ##
***

### rviz from docker for nvidia-docker ###
***

```bash
docker run -it --net host --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --name [container name] [image name] /bin/bash
```
