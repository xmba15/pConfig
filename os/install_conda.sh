#!/usr/bin/env bash

sudo -l

readonly ANACONDA_INSTALLATION_FILE="Anaconda3-2020.07-Linux-x86_64.sh"

wget https://repo.anaconda.com/archive/${ANACONDA_INSTALLATION_FILE}
chmod a+x ${ANACONDA_INSTALLATION_FILE}
bash ${ANACONDA_INSTALLATION_FILE} -b
$HOME/anaconda3/bin/conda init
