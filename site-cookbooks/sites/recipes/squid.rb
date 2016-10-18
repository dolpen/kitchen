#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'nginx::default'

template '/etc/nginx/conf.d/squid.conf' do
  source 'conf/squid.conf.erb'
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

directory '/var/www/squid' do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

cron 'update squid cert' do
  user 'root'
  command '/opt/letsencrypt/certbot-auto certonly --webroot -w /var/www/squid/ -d squid.dolpen.net'
  hour '5'
  minute '0'
  day '1'
  month '*/2'
end


