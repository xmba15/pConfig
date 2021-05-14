#!/usr/bin/env bash

readonly CURRENT_DIR=$(dirname $(realpath $0))

cd ${CURRENT_DIR}/os
bash install_environment.sh
bash replace_dot_files.sh
bash install_docker.sh

cd ${CURRENT_DIR}
