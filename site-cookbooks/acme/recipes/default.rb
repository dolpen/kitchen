#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# security update

package 'epel-release' do
  action :upgrade
end

directory '/opt/letsencrypt' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

execute 'install_certbot' do
  cwd '/opt/letsencrypt'
  command './certbot-auto'
  user 'root'
  returns [0, 1]
  action :nothing
end

remote_file '/opt/letsencrypt/certbot-auto' do
  source 'https://dl.eff.org/certbot-auto'
  owner 'root'
  group 'root'
  mode 0755
  action :create_if_missing
  notifies :run, resources(:execute => 'install_certbot'), :immediately
end


