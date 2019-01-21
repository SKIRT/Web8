#!/bin/bash
# (use "chmod +rx scriptname" to make script executable)
#
# This script publishes the External Data resources for SKIRT to the public server
# which can be reached via http://sciences.ugent.be/skirtextdat/
#

# Instructions:
#   - use on Mac OS X only
#   - you need write access to the public server
#   - the "Resources8" directory should be placed next to the Web8 repo
#     and include the "skirtextdat" directory
#   - run this script with "git" as default directory

# Update the data
rsync -hrtvz --delete-after -e "ssh -p 2935" ../../Resources8/skirtextdat/ pcamps@sciences.ugent.be:skirtextdat/
