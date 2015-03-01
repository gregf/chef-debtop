#
# Cookbook Name:: printer
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

pkgs = %W(cups splix)

pkgs.each do |pkg|
  package pkg
end

execute "Add printer to cups" do
  command "lpadmin -p Samsung_ML-2010 -E -v 'usb://Samsung/ML-2010?serial=3A61BKCL604365M.' -m 'drv:///splix-samsung.drv/ml2010.ppd'"
end

execute "Set default printer" do
  command "lpoptions -d Samsung_ML-2010"
end
