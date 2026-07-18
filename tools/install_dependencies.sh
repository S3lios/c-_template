#!/usr/bin/env bash

set -euo pipefail


echo "Installing Ubuntu/Debian dependencies..."


sudo apt update


sudo apt install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    doxygen \
    graphviz \
    texlive \
    texlive-latex-extra \
    texlive-pictures \
    texlive-fonts-recommended \
    latexmk \
    libgtest-dev \
    clang \
    clang-format \
    clang-tidy \
    clang-tools \
    python3 \
    commitizen \
echo
echo "Installed versions:"
echo


echo "CMake:"
cmake --version | head -n 1


echo "Compiler:"
c++ --version | head -n 1


echo "Clang:"
clang --version | head -n 1


echo "clang-format:"
clang-format --version


echo "clang-tidy:"
clang-tidy --version


echo "Doxygen:"
doxygen --version


echo "Git:"
git --version


echo "LaTeX:"
pdflatex --version | head -n 1


echo "Graphviz:"
dot -V


echo "GoogleTest:"
dpkg -s libgtest-dev | grep Version


echo
echo "Done."