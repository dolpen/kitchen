#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'nginx::default'

template '/etc/nginx/conf.d/factorio.conf' do
  source 'conf/factorio.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

cookbook_file '/etc/nginx/ssl/dhparam.pem' do
  source 'dhparam2048.pem'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

directory '/var/www/factorio' do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

template '/var/www/factorio/index.html' do
  source 'pages/factorio.html.erb'
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

