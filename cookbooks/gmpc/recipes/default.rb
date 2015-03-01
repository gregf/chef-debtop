#
# Cookbook Name:: gmpc
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

packages = %w(build-essential
              libc6
              libcairo2
              libgdk-pixbuf2.0-0
              libglib2.0-0
              libgtk-3-0
              libgtk-3-dev
              valac
              libsoup2.4-1
              libsoup2.4-dev
              libpango1.0-0
              libsqlite3-0
              libxml2
              libnotify-dev
              zlib1g
              gob2
              gir1.2-glib-2.0
              libtool
              intltool
              autoconf
              gnome-doc-utils
              libcurl4-openssl-dev
              cmake
              mpc
              mpd
              mpdscribble
              libsqlite3-dev)

packages.each do |pkg|
  package pkg
end

git "#{Chef::Config[:file_cache_path]}/libglyr" do
  repository 'https://github.com/sahib/glyr.git'
  reference 'master'
  action :sync
  notifies :run, "bash[install_libglyr]"
end

bash 'install_libglyr' do
  cwd "#{Chef::Config[:file_cache_path]}/libglyr"
  code <<-EOH
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local . && make && make install
    EOH
  environment 'PREFIX' => '/usr/local', 'PKG_CONFIG_PATH' => '/usr/local/lib/pkgconfig'
end

git "#{Chef::Config[:file_cache_path]}/libmpd" do
  repository 'git://git.musicpd.org/master/libmpd.git'
  reference 'master'
  action :sync
  notifies :run, "bash[install_libmpd]"
end

bash 'install_libmpd' do
  cwd "#{Chef::Config[:file_cache_path]}/libmpd"
  code <<-EOH
    ./autogen.sh --prefix=/usr/local && make clean && make && make install
    EOH
  environment 'PREFIX' => '/usr/local', 'PKG_CONFIG_PATH' => '/usr/local/lib/pkgconfig'
end

git "#{Chef::Config[:file_cache_path]}/gmpc" do
  repository 'https://github.com/DaveDavenport/gmpc.git'
  reference 'master'
  action :sync
  notifies :run, "bash[install_gmpc]"
end

bash 'install_gmpc' do
  cwd "#{Chef::Config[:file_cache_path]}/gmpc"
  code <<-EOH
    ./autogen.sh --prefix=/usr/local --enable-maintainermode && make clean && make && make install
    EOH
  environment 'PREFIX' => '/usr/local', 'PKG_CONFIG_PATH' => '/usr/local/lib/pkgconfig'
end

bash 'update ld cache' do
  code 'ldconfig'
end
