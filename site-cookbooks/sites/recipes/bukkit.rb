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
  source 'conf/bukkit.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

link '/var/www/map' do
  to '/opt/minecraft/plugins/dynmap/web'
end

template '/var/www/minecraft/index.html' do
  source 'pages/bukkit.html.erb'
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end
