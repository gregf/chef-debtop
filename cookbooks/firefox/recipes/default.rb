#
# Cookbook Name:: firefox
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

firefox_tar = filename_from_url node['firefox']['url']

remote_file 'download firefox' do
  path "#{Chef::Config[:file_cache_path]}/#{firefox_tar}"
  source node['firefox']['url']
  ftp_active_mode true
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[extract_firefox]'
  only_if { ! ::File.exist?("#{Chef::Config[:file_cache_path]}/#{firefox_tar}") }
end

bash 'extract_firefox' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  mkdir firefox
  tar -xf #{firefox_tar} -C firefox --strip-components=1
  EOH
  notifies :run, 'bash[install_firefox]'
  action :nothing
end

bash 'install_firefox' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cp -R firefox /opt
  EOH
  action :nothing
end

link '/usr/local/bin/firefox' do
  to '/opt/firefox/firefox'
end
