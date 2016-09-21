#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cron 'restart nw service' do
  user 'root'
  command 'sudo service network restart'
  minute '0'
end
