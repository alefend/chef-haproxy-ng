#
# Cookbook Name:: haproxy-ng
# Recipe:: default
#
# Copyright 2015 Nathan Williams
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

include_recipe "#{cookbook_name}::install"

if node['haproxy']['use_default_proxies']
  include_recipe "#{cookbook_name}::proxies"
end

execute 'validate-haproxy_instance-haproxy' do
  command 'haproxy -c -f /etc/haproxy/haproxy.cfg'
  notifies :reload, 'service[haproxy]', :delayed
  action :nothing
end

my_proxies = node['haproxy']['proxies'].map do |p|
  Haproxy::Helpers.proxy(p, run_context)
end

haproxy_instance 'haproxy' do
  config node['haproxy']['config']
  tuning node['haproxy']['tuning']
  proxies my_proxies
  notifies :run, 'execute[validate-haproxy_instance-haproxy]', :immediately
end

include_recipe "#{cookbook_name}::service"
