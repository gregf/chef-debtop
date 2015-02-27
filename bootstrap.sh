#!/bin/bash

set -e

# Install Chef Client
curl -L https://www.chef.io/chef/install.sh | sudo bash

# Make sure system is up to date
apt-get update --quiet --yes
apt-get upgrade --quiet --yes

# Install git
apt-get install --quiet --yes git

# install chefdk
cd /tmp
wget -c https://opscode-omnibus-packages.s3.amazonaws.com/debian/6/x86_64/chefdk_0.4.0-1_amd64.deb
dpkg -i chefdk_0.4.0-1_amd64.deb

# clone repository

cd /tmp
git clone https://github.com/gregf/chef-debtop

# Run chef

cd /tmp/chef-debtop
chef-solo -c config/solo.rb -j config/debtop.json
