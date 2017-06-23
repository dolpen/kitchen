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

template '/etc/init.d/minecraft' do
  source 'nukkit.erb'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

service 'minecraft' do
  supports :status => true, :restart => false, :reload => false
  action [:start]
end

# end of base recipe

remote_file '/opt/minecraft/minecraft_server.jar' do
  source "http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar"
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create
end

bash 'start_minecraft_service' do
  code <<-EOS
      chkconfig minecraft on
  EOS
end

