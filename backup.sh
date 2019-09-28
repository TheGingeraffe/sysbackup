#!/bin/bash
# Rsync backup solution

# Todays date in ISO-8601 format e.g. 1999-01-01 with 24-hour timestamp
now="$(date +%F)-$(date +%R)"

# Makes package list
rpm -qa | sort > /etc/pkglist.txt

# Create an archive of system files
tar -C / -cf /var/local/backups/system_backup.$now.tar.gz \
--exclude="/{proc,dev,sys,mnt,tmp,home,lost+found}/*" \
--exclude="/etc/udev/rules.d/*" \
--exclude="/var/{run,lock,cache,tmp}/*" \
--exclude="/var/{local,log}/*"

# Create an archive of user files
# tar -C / -cf /var/local/backups/home_backup.$now.tar.gz /home \
# --exclude=/home/baal/transmission/downloads

# Maybe use scp unless I need file differentials

# Remote rsync connection
# rsync -aAX -e ssh ${source} ${ssh_user}@${host_ip}:${destination}

# Remove archive from this machine
