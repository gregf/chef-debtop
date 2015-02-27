#
# Cookbook Name:: ruby
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

chruby_tar = filename_from_url node['ruby']['chruby']

remote_file 'download chruby' do
  path "#{Chef::Config[:file_cache_path]}/#{chruby_tar}"
  source node['ruby']['chruby']
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[extract_chruby]'
end

bash 'extract_chruby' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  mkdir chruby-source
  tar -xf #{chruby_tar} -C chruby-source --strip-components=1
  EOH
  notifies :run, 'bash[install_chruby]'
  action :nothing
end

bash 'install_chruby' do
  cwd "#{Chef::Config[:file_cache_path]}/chruby-source"
  code <<-EOH
  make install
  EOH
  action :nothing
end
