#!/bin/bash
echo "****************************************"
echo " Setting up Capstone Environment"
echo "****************************************"

echo "Updating package manager..."
sudo add-apt-repository -y ppa:deadsnakes/ppa
# assume yes for all queries : -y
# Advanced Package Tool, more commonly known as APT, is a collection of tools used to install, update, remove, and otherwise manage software packages on Debian and its derivative operating systems, including Ubuntu and Linux Mint.
# The deadsnakes PPA lets you install multiple Python versions on your Ubuntu system

echo "Installing Python 3.9 and Virtual Environment"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9 python3.9-venv

echo "Making Python 3.9 the default..."
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2

echo "Checking the Python version..."
python3 --version

echo "Creating a Python virtual environment"
python3 -m venv ~/venv

echo "Configuring the developer environment..."
echo "# DevOps Capstone Project additions" >> ~/.bashrc
echo "export GITHUB_ACCOUNT=$GITHUB_ACCOUNT" >> ~/.bashrc
echo 'export PS1="\[\e]0;\u:\W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "' >> ~/.bashrc
echo "source ~/venv/bin/activate" >> ~/.bashrc
# the echo command to append lines to the end of .bashrc script
# export is used to set environment variable in operating system
# PS1 is the primary prompt which is displayed before each command
# And the statement: \[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ dictates how the prompt is going to look like 
# \033[36m] = Cyan
# \u = Username of the current user
# [\033[m] = Reset all styles and colors
# @ = '@' character
# [\033[32m] = Green
# \h = The hostname
# : = ':' character
# [\033[33;1m] = Yellow(bold)
# \w = The current working directory, with $HOME abbreviated with a tilde(~)
# $ = Show '#' if the user ID of a user is 0, otherwise show '$' character


echo "Installing Python depenencies..."
source ~/venv/bin/activate && python3 -m pip install --upgrade pip wheel
source ~/venv/bin/activate && pip install -r requirements.txt

echo "Starting the Postgres Docker container..."
make db

echo "Checking the Postgres Docker container..."
docker ps

echo "****************************************"
echo " Capstone Environment Setup Complete"
echo "****************************************"
echo ""
echo "Use 'exit' to close this terminal and open a new one to initialize the environment"
echo ""
