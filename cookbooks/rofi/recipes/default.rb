#
# Cookbook Name:: rofi
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

pkgs = %W(autoconf libxinerama-dev libpango1.0-dev libxft-dev)

pkgs.each do |pkg|
  package pkg
end

git "#{Chef::Config[:file_cache_path]}/rofi" do
  repository 'https://github.com/DaveDavenport/rofi.git'
  action :sync
  notifies :run, "bash[compile_rofi]"
end

bash 'compile_rofi' do
  cwd "#{Chef::Config[:file_cache_path]}/rofi"
  code <<-EOH
  autoreconf --install
  ./configure
  make -j2 && make install
  EOH
end
