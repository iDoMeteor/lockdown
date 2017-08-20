#   Amazon Linux, CentOS
#     service x start|stop|etc
#     chkconfig x on|off
# Begin starting services
if (( ! SILENT )) ; then echo "Starting services for $DISTRO"; fi
$DRY_RUN service fail2ban start
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to start fail2ban, exiting."
    exit 1
fi
$DRY_RUN service ipset start
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to start ipset, exiting."
    exit 1
fi
$DRY_RUN service iptables start
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to start iptables, exiting."
    exit 1
fi
# Begin stopping & disabling conflicting services
if [ `pidof nftables` ]
then
  if (( ! SILENT )) ; then echo "Stopping & disabling nftables"; fi
  $DRY_RUN service nftables stop
  $DRY_RUN chkconfig nftables off
fi
if [ `pidof firewalld` ]
then
  if (( ! SILENT )) ; then echo "Stopping & disabling firewalld"; fi
  $DRY_RUN service firewalld stop
  $DRY_RUN chkconfig firewalld off
fi
# Begin enabling services
if (( ! SILENT )) ; then echo "Enabling services for $DISTRO"; fi
$DRY_RUN chkconfig fail2ban on
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to enable fail2ban, exiting."
fi
$DRY_RUN chkconfig ipset on
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to enable ipset, exiting."
fi
$DRY_RUN chkconfig iptables on
if [ 0 -ne $? ] && [ -z $DRY_RUN ]
then
    echo "Failed to enable iptables, exiting."
fi
if (( ! SILENT )) ; then echo "Service configuration completed successfully!"; fi

