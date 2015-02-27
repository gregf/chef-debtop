#!/bin/bash

set -e

# Install Chef Client
curl -L https://www.chef.io/chef/install.sh | sudo bash

# Make sure system is up to date
apt-get update --quiet --yes
apt-get upgrade --quiet --yes

# Install git
apt-get install --quiet --yes git

# clone repository

#git clone https://github.com/gregf/chef-debtop

# Run chef

chef-solo -c config/solo.rb -j config/debtop.json
