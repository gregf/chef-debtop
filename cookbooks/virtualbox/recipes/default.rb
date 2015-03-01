#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2015 Greg Fitzgerald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

directory '/etc/apt/sources.list.d' do
  user 'root'
  group 'root'
  mode 0755
end

file '/etc/apt/sources.list.d/virtualbox.list' do
  user 'root'
  group 'root'
  mode 0644
  content 'deb http://download.virtualbox.org/virtualbox/debian wheezy contrib'
end

execute 'install virtualbox key' do
  command 'wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -'
end

execute 'update apt' do
  command 'apt-get update'
end

package 'virtualbox-4.3'
