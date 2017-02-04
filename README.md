# chef-small-stuff

The main purpose for this cookbook is to provide some recipes that aren't easily found or to provide recipes on top of cookbooks like [mysql](https://github.com/chef-cookbooks/mysql) that only provides resources.

## Recipes

* jpegoptim - installs jpegoptim package
* optipng - installs optipng package
* pngcrush - installs pngcrush package
* mysql_client - installs mysql client binaries and development libraries.
* mysql_server - installs mysql server.

## Usage

Besides mysql_server recipe, all other recipes don't have configuration attributes and you just have to include them in other to run them.

```
include_recipe "small-stuff::jpegoptim"
include_recipe "small-stuff::optipng"
include_recipe "small-stuff::pngcrush"
include_recipe "small-stuff::mysql_client"
```

### Recipe mysql_server

This recipe is built using the mysql_service resource of the [mysql](https://github.com/chef-cookbooks/mysql) cookbook and creates a mysql server instance. Most of the allowed parameters are directly mapped to the resource parameters. Most of the descriptions bellow come from the [mysql](https://github.com/chef-cookbooks/mysql) readme.

```
include_recipe "small-stuff::mysql_server"
```

*Options*
```
node['small-stuff']['mysql']['service_name'] = 'default' # Mysql resource name. Default value is 'default'
node['small-stuff']['mysql']['version'] = '5.5' # Allows the user to select from the versions available for the platform, where applicable. When omitted, it will install the default MySQL version for the target platform. Available version numbers are 5.0, 5.1, 5.5, 5.6, and 5.7, depending on platform.
node['small-stuff']['mysql']['port'] = '3316' # determines the listen port for the mysqld service. When omitted, it will default to '3306'.
node['small-stuff']['mysql']['bind_address'] = '0.0.0.0' # determines the listen IP address for the mysqld service. When omitted, it will be determined by MySQL. If the address is "regular" IPv4/IPv6address (e.g 127.0.0.1 or ::1), the server accepts TCP/IP connections only for that particular address. If the address is "0.0.0.0" (IPv4) or "::" (IPv6), the server accepts TCP/IP connections on all IPv4 or IPv6 interfaces.
node['small-stuff']['mysql']['socket'] = '/var/run/mysqld/mysql.sock' # determines where to write the socket file for the mysql_service instance. Useful when configuring clients on the same machine to talk over socket and skip the networking stack. When set to nil, it defaults to a calculated value based on platform and instance name.
node['small-stuff']['mysql']['mysqld_options'] = {'max_allowed_packet' => '128M'} # A key value hash of options to be rendered into the main my.cnf. Defaults to nil.
node['small-stuff']['mysql']['server_root_password'] = 'root_pass' Root user password. defaults to 'ilikerandompasswords'
node['small-stuff']['mysql']['allow_remote_root_access'] = false # Grants root user access from a remote address.
```
