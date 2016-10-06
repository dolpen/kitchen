#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx::default'
include_recipe 'letsencrypt::default'

site=node['minecraft']['domain']['play']
sans=Array[site]


directory '/var/www/minecraft' do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end


=begin
directory "/etc/nginx/ssl/#{site}" do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

# Request the real certificate
letsencrypt_certificate "#{site}" do
  alt_names sans
  fullchain "/etc/nginx/ssl/#{site}/fullchain.pem"
  chain     "/etc/nginx/ssl/#{site}/server.crt"
  key       "/etc/nginx/ssl/#{site}/server.crt"
  method    'http'
  wwwroot   '/var/www/minecraft'
  notifies  :reload, 'service[nginx]'
end
=end

cookbook_file '/etc/nginx/ssl/dhparam.pem' do
  source 'dhparam2048.pem'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

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

link '/var/www/minecraft/backup' do
  to '/opt/minecraft/backup'
end

link '/var/www/minecraft/chat' do
  to '/opt/minecraft/chat'
end


