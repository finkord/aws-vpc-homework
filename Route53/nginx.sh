#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
sudo systemctl enable nginx
sudo systemctl restart nginx