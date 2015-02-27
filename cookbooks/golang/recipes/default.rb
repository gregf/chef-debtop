#
# Cookbook Name:: golang
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

golang_tar = filename_from_url node['golang']['url']

remote_file 'download golang' do
  path "#{Chef::Config[:file_cache_path]}/#{golang_tar}"
  source node['golang']['url']
  ftp_active_mode true
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[extract_golang]'
  only_if { ! ::File.exist?("#{Chef::Config[:file_cache_path]}/#{golang_tar}") }
end

bash 'extract_golang' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  tar -xzf #{golang_tar} -C /usr/local
  EOH
  action :nothing
end
