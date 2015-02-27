#
# Cookbook Name:: apt
# Recipe:: default
#
# Copyright 2015 Greg Fitzgerald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cookbook_file '/etc/apt/sources.list' do
  owner 'root'
  group 'root'
  mode 0644
  source 'apt/sources.list'
  action :create
end

execute 'apt-get update' do
  command 'apt-get update'
  not_if { ::File.exist?('/var/lib/apt/periodic/update-success-stamp') }
end

execute 'apt-get upgrade' do
  command 'apt-get -o "Dpkg::Options::=--force-confnew" --force-yes -fuy upgrade'
  environment('DEBIAN_FRONTEND' => 'noninteractive') 
end

execute 'apt-get dist-upgrade' do
  command 'apt-get -o "Dpkg::Options::=--force-confnew" --force-yes -fuy dist-upgrade'
  environment('DEBIAN_FRONTEND' => 'noninteractive') 
end

# Automatically remove packages that are no longer needed for dependencies
execute 'apt-get autoremove' do
  command 'apt-get -y autoremove'
end

# Automatically remove .deb files for packages no longer on your system
execute 'apt-get autoclean' do
  command 'apt-get -y autoclean'
end
