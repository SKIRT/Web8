#!/bin/bash
# (use "chmod +rx scriptname" to make script executable)
#
# This script publishes the External Data resources for SKIRT to the public server
# which can be reached via http://sciences.ugent.be/skirtextdat/
#

# Instructions:
#   - use on Mac OS X only
#   - you need write access to the public server
#   - run this script with "git" as default directory

# Update the data
rsync -hrtvz --delete-after -e "ssh -p 2935" ../extras/skirtextdat/ pcamps@sciences.ugent.be:skirtextdat/
