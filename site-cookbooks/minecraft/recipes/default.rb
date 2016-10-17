#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
include_recipe 'screen'

group 'minecraft'

user 'minecraft' do
  system true
  comment 'Minecraft Server'
  home '/home/minecraft'
  gid 'minecraft'
  action :create
end

directory '/home/minecraft' do
  owner 'minecraft'
  group 'minecraft'
  mode 0700
  action :create
end

directory '/opt/minecraft' do
  owner 'minecraft'
  group 'minecraft'
  mode 0755
  action :create
end

directory '/opt/minecraft/backup' do
  owner 'minecraft'
  group 'minecraft'
  mode 0755
  action :create
end

directory '/opt/minecraft/logs' do
  owner 'minecraft'
  group 'minecraft'
  mode 0777
  action :create
end

directory '/opt/minecraft/chat' do
  owner 'minecraft'
  group 'minecraft'
  mode 0777
  action :create
end

file '/opt/minecraft/eula.txt' do
  content "eula=true"
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create
end

template '/opt/minecraft/server.properties' do
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create
end

template '/opt/minecraft/banned-ips.json' do
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create
end

template '/opt/minecraft/banned-players.json' do
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create
end

dropbox_decoded = Chef::EncryptedDataBagItem.load('secrets','dropbox')
template '/etc/init.d/minecraft' do
  variables ({
      :secret => dropbox_decoded['secret']
  })
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

service 'minecraft' do
  supports :status => true, :restart => false, :reload => false
  action [:start]
end

cron 'backup game' do
  user 'minecraft'
  command '/etc/init.d/minecraft backup'
  hour '18'
  minute '0'
end

cron 'generate logs' do
  user 'minecraft'
  command "/etc/init.d/minecraft chatlog"
#  command "find /opt/minecraft/logs -type f -daystart -mtime '0' -name '*.log.gz' | sort -n | tr \\\\n \\\\0 | xargs -0 zcat | grep '^\\[[0-9:]*\\]\\s\\[Server thread\\/INFO\\]:\\s<' | sed -e 's/\\[Server\\sthread\\/INFO\\]:\\s//g' > /opt/minecraft/chat/`date +\\%Y\\%m\\%d -d '-1 day'`.txt"
  hour '19'
  minute '30'
end

#cron 'reboot game' do
#  user 'minecraft'
#  command '/etc/init.d/minecraft restart'
#  hour '19'
#  minute '0'
#end

cron 'reboot server' do
  user 'root'
  command 'sudo reboot'
  hour '19'
  minute '0'
end

cron 'delete old backup' do
  user 'minecraft'
  command 'find /opt/minecraft/backup -type f -mtime "+7" | xargs rm -f'
  hour '5'
  minute '0'
end

cron 'delete old logs' do
  user 'minecraft'
  command 'find /opt/minecraft/logs -type f -mtime "+7" | xargs rm -f'
  hour '5'
  minute '10'
end




