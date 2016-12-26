#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'sites::minecraft'

template '/etc/nginx/conf.d/minecraft.conf' do
  source 'conf/vanilla.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

template '/var/www/minecraft/index.html' do
  source 'pages/vanilla.html.erb'
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end
