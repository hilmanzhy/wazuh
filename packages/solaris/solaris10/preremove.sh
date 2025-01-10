#!/bin/sh
# preremove script for verprotect-agent
# Verprotect, Inc 2015

control_binary="verprotect-control"

if [ ! -f /var/ossec/bin/${control_binary} ]; then
  control_binary="ossec-control"
fi

/var/ossec/bin/${control_binary} stop
