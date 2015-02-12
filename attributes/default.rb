#
# Cookbook Name:: haproxy-ng
# Attribute:: default
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

default['haproxy'].tap do |haproxy|
  haproxy['install_method'] = 'package'
  haproxy['app_role'] = 'app'
  haproxy['proxies'] = []
  haproxy['config'] = [
    'daemon',
    'user haproxy',
    'group haproxy',
    'pidfile /var/run/haproxy.pid'
  ]
  haproxy['tuning'] = [
    'maxconn 50000'
  ]
end
