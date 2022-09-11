#!/bin/bash
set -ex

sudo yum update -y

# install Chef Inspec
cd /tmp
curl https://packages.chef.io/files/stable/inspec/5.18.14/amazon/2/inspec-5.18.14-1.el7.x86_64.rpm -o inspec_x86_64.rpm
sudo yum install inspec_x86_64.rpm -y
/opt/inspec/bin/inspec --chef-license=accept

# install Python 3.8
sudo amazon-linux-extras install python3.8 -y
# make python3.8 the default python3 version
sudo ln -s -f /usr/bin/python3.8 /usr/bin/python3

sudo yum install git-2.37.1-1.amzn2.0.1 -y

sudo amazon-linux-extras install ansible2 -y

sudo amazon-linux-extras install java-openjdk11 -y