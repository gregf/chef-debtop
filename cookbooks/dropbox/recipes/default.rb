#
# Cookbook Name:: dropbox
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

dropbox_deb = filename_from_url node['dropbox']['url']

remote_file 'download dropbox' do
  path "#{Chef::Config[:file_cache_path]}/#{dropbox_deb}"
  source node['dropbox']['url']
  ftp_active_mode true
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[install_dropbox]'
  only_if { ! ::File.exist?("#{Chef::Config[:file_cache_path]}/#{dropbox_deb}") }
end

bash 'install_dropbox' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  dpkg -i #{dropbox_deb}
  EOH
  action :nothing
end
