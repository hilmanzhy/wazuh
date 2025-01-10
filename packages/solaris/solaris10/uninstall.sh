#!/bin/sh
# uninstall script for verprotect-agent
# Verprotect, Inc 2015

control_binary="verprotect-control"

if [ ! -f /var/ossec/bin/${control_binary} ]; then
  control_binary="ossec-control"
fi

## Stop and remove application
/var/ossec/bin/${control_binary} stop
rm -rf /var/ossec/

## stop and unload dispatcher
#/bin/launchctl unload /Library/LaunchDaemons/com.verprotect.agent.plist

# remove launchdaemons
rm -f /etc/init.d/verprotect-agent
rm -rf /etc/rc2.d/S97verprotect-agent
rm -rf /etc/rc3.d/S97verprotect-agent

## Remove User and Groups
userdel verprotect 2> /dev/null
groupdel verprotect 2> /dev/null

exit 0
