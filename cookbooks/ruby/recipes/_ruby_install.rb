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

rbinst_tar = filename_from_url node['ruby']['rbinst']

remote_file 'download rbinst' do
  path "#{Chef::Config[:file_cache_path]}/#{rbinst_tar}"
  source node['ruby']['rbinst']
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[extract_rbinst]'
end

bash 'extract_rbinst' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  mkdir ruby_install-source
  tar -xf #{rbinst_tar} -C ruby_install-source --strip-components=1
  EOH
  notifies :run, 'bash[install_rbinst]'
  action :nothing
end

bash 'install_rbinst' do
  cwd "#{Chef::Config[:file_cache_path]}/ruby_install-source"
  code <<-EOH
  make install
  EOH
  action :nothing
end
