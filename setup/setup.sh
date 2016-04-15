#!/bin/bash

cat << EOT >> /etc/sudoers.d/base
dolpen ALL=(ALL) ALL
%dolpen ALL=(ALL) NOPASSWD: ALL
Defaults:dolpen !requiretty
EOT

chmod 440 /etc/sudoers.d/base
useradd dolpen
echo "next : passwd dolpen"
echo "next : visudo -f /etc/sudoers.d/base"
