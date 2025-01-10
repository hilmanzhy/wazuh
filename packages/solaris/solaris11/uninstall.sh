#!/bin/sh
# uninstall script for verprotect-agent
# Verprotect, Inc 2015

install_path=$1
control_binary=$2

## Stop and remove application
${install_path}/bin/${control_binary} stop
rm -r /var/ossec*

# remove launchdaemons
rm -f /etc/init.d/verprotect-agent

## Remove User and Groups
userdel verprotect
groupdel verprotect

exit 0
