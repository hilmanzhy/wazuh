#!/bin/sh
# postremove script for verprotect-agent
# Verprotect, Inc 2015

if getent passwd verprotect > /dev/null 2>&1; then
  userdel verprotect
fi

if getent group verprotect > /dev/null 2>&1; then
  groupdel verprotect
fi
