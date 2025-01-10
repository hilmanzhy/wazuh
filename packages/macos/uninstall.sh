#!/bin/sh

## Stop and remove application
sudo /Library/Ossec/bin/verprotect-control stop
sudo /bin/rm -r /Library/Ossec*

# remove launchdaemons
/bin/rm -f /Library/LaunchDaemons/com.verprotect.agent.plist

## remove StartupItems
/bin/rm -rf /Library/StartupItems/VERPROTECT

## Remove User and Groups
/usr/bin/dscl . -delete "/Users/verprotect"
/usr/bin/dscl . -delete "/Groups/verprotect"

/usr/sbin/pkgutil --forget com.verprotect.pkg.verprotect-agent
/usr/sbin/pkgutil --forget com.verprotect.pkg.verprotect-agent-etc

# In case it was installed via Puppet pkgdmg provider

if [ -e /var/db/.puppet_pkgdmg_installed_verprotect-agent ]; then
    rm -f /var/db/.puppet_pkgdmg_installed_verprotect-agent
fi

echo
echo "Verprotect agent correctly removed from the system."
echo

exit 0
