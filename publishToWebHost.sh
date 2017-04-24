#!/bin/bash
# (use "chmod +rx scriptname" to make script executable)
#
# This script publishes the SKIRT web site to the public web host.
#
# Instructions:
#   - use on Mac OS X only
#   - you need write access to the public web host
#   - first run the makeHTML script
#   - run this script with "git" as default directory

# Mount the webhost at a local mount point
mkdir -p ../webhost
mount_smbfs smb://pcamps@webhost.ugent.be/_skirt ../webhost

# Update the web site
rsync -hrtv --delete-after ../html/ ../webhost/WWW/

# Unmount the webhost and remove the mount point
umount ../webhost
rm -d ../webhost
