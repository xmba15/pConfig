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

# Better to use a non-root user so create one with disabled-password
ENV USER=bmax
ENV WORKDIR=/home/${USER}
RUN groupadd ${USER} && useradd -g ${USER} ${USER} && echo "${USER}:${USER}" | sudo chpasswd && usermod -a -G sudo ${USER}

RUN mkdir -p ${WORKDIR}
RUN chown -R ${USER}:${USER} ${WORKDIR}

USER ${USER}
WORKDIR ${WORKDIR}
