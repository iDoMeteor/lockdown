# Distro determination
determine_distro () {
  if [ -f /etc/os-release ]
  then
    if [[ `cut -d= -f2 /etc/os-release` =~ 'Amazon Linux' ]]
    then
      DISTRO='Amazon Linux'
    elif [[ `cut -d= -f2 /etc/os-release` =~ 'CentOS' ]]
    then
      DISTRO='CentOS'
    elif [[ `cut -d= -f2 /etc/os-release` =~ 'Fedora' ]]
    then
      DISTRO='Fedora'
      PACKAGE_MANAGER='dnf'
    elif [[ `cut -d= -f2 /etc/os-release` =~ 'RHEL' ]]
    then
      DISTRO='RHEL'
    elif [[ `cut -d= -f2 /etc/os-release` =~ 'Red Hat' ]]
    then
      DISTRO='RHEL'
    elif [[ `cut -d= -f2 /etc/os-release` =~ 'Ubuntu' ]]
    then
      DISTRO='Ubuntu'
      PACKAGE_MANAGER='apt-get'
    fi
  elif [ -f /etc/system-release ]
  then
    if [[ `cut -d= -f2 /etc/system-release` =~ 'CentOS' ]]
    then
      DISTRO='CentOS'
    fi
  fi
}
