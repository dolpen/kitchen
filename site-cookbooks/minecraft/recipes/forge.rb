#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'minecraft::default'

version = node['minecraft']['forge_version']

execute 'install_forge' do
  cwd '/opt/minecraft'
  command 'java -jar minecraft_server_installer.jar nogui --installServer'
  action :nothing
end

remote_file '/opt/minecraft/minecraft_server.jar' do
  source "http://files.minecraftforge.net/maven/net/minecraftforge/forge/#{version}/forge-#{version}-universal.jar"
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create_if_missing
  notifies :run, resources(:execute => 'install_forge')
end


remote_file '/opt/minecraft/minecraft_server_installer.jar' do
  source "http://files.minecraftforge.net/maven/net/minecraftforge/forge/#{version}/forge-#{version}-installer.jar"
  owner 'minecraft'
  group 'minecraft'
  mode 0644
  action :create_if_missing
  notifies :run, resources(:execute => 'install_forge')
end

directory '/opt/minecraft/plugins' do
  owner 'minecraft'
  group 'minecraft'
  mode 0755
  action :create
end

bash 'start_minecraft_service' do
  code <<-EOS
      chkconfig minecraft on
  EOS
end

