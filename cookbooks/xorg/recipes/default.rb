#
# Cookbook Name:: xorg
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

pkgs = %w(xorg xserver-xorg)

pkgs.each do |pkg|
  package pkg
end

directory '/etc/X11/xorg.conf.d' do
  owner 'root'
  group 'root'
  mode 0755
end

cookbook_file '/etc/X11/xorg.conf.d/10-mouse.conf' do
  owner 'root'
  group 'root'
  mode 0644
  source '10-mouse.conf'
end
