#
# Cookbook Name:: packages
# Recipe:: default
#
# Copyright 2016, dolpen.net
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel'

update_packages = %w[
  zip
]

update_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
