#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


execute 'stop_plymouth' do
  user 'root'
  command 'plymouth deactivate'
  returns [0, 1]
  action :run
end

cron 'restart nw service' do
  user 'root'
  command 'sudo service network restart'
  minute '0'
end
