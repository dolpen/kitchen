#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2016, dolpen.net
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

update_packages = %w[
  gcc
  make
  openssl-devel
  readline-devel
]

update_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

cookbook_file '/etc/profile.d/rbenv.sh' do
  source 'rbenv.sh'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end



git '/opt/rbenv' do
  repository 'git://github.com/sstephenson/rbenv.git'
  revision 'master'
  user 'root'
  group 'root'
end


directory '/opt/rbenv/plugins' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

git '/opt/rbenv/plugins/ruby-build' do
  repository 'git://github.com/sstephenson/ruby-build.git'
  revision 'master'
  user 'root'
  group 'root'
end


