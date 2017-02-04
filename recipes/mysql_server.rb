#
# Cookbook Name:: mysql
# Recipe:: mysql_server
#
# The MIT License (MIT)
#
# Copyright:: 2017, The Authors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

mysql_service node['small-stuff']['mysql']['service_name'] do
  version node['small-stuff']['mysql']['version'] unless node['small-stuff']['mysql']['version'].nil? 
  bind_address node['small-stuff']['mysql']['bind_address'] unless node['small-stuff']['mysql']['bind_address'].nil?
  port node['small-stuff']['mysql']['port'] unless node['small-stuff']['mysql']['port'].nil?
  data_dir node['small-stuff']['mysql']['data_dir'] unless node['small-stuff']['mysql']['data_dir'].nil? || node['small-stuff']['mysql']['data_dir'] == ""
  mysqld_options node['small-stuff']['mysql']['mysqld_options'] unless node['small-stuff']['mysql']['mysqld_options'].nil?
  socket node['small-stuff']['mysql']['socket'] unless node['small-stuff']['mysql']['socket'].nil?
  initial_root_password node['small-stuff']['mysql']['server_root_password'] unless node['small-stuff']['mysql']['server_root_password'].nil?
  action [:create, :start]
end

if node['small-stuff']['mysql']['allow_remote_root_access']

  mysql2_chef_gem 'default' do
    action :install
  end

  mysql_connection_info = {
    :host     => '127.0.0.1',
    :username => 'root',
    :password => node['small-stuff']['mysql']['server_root_password']
  }

  mysql_database_user 'root' do
    connection    mysql_connection_info
    password      node['small-stuff']['mysql']['server_root_password']
    host          '%'
    action        :grant
  end
end