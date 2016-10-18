#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'nginx::default'

template '/etc/nginx/conf.d/main.conf' do
  source 'conf/main.conf.erb'
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

directory '/var/www/main' do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

template '/var/www/main/index.html' do
  source 'pages/main.html.erb'
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end

cron 'reboot nginx' do
  user 'root'
  command 'service nginx restart'
  hour '10'
  minute '0'
  day '1'
  month '*/2'
end

cron 'update main cert' do
  user 'root'
  command '/opt/letsencrypt/certbot-auto certonly --webroot -w /var/www/main/ -d dolpen.net'
  hour '0'
  minute '0'
  day '1'
  month '*/2'
end



