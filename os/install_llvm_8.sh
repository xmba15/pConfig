#!/usr/bin/env bash

sudo -l
sudo bash -c 'echo "" >> /etc/apt/sources.list'
sudo bash -c 'echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" >> /etc/apt/sources.list'
sudo bash -c 'echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" >> /etc/apt/sources.list'

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-get -y update
sudo apt-get install -y libllvm-8-ocaml-dev libllvm8 llvm-8 llvm-8-dev llvm-8-doc llvm-8-examples llvm-8-runtime
sudo apt-get install -y clang-8 clang-tools-8 clang-8-doc libclang-common-8-dev libclang-8-dev libclang1-8 clang-format-8 python-clang-8
