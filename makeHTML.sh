#!/bin/bash
# (use "chmod +rx scriptname" to make script executable)
#
# This script builds the HTML pages for the complete SKIRT web site,
# including the documentation derived from the code for SKIRT and PTS.
#
# Instructions:
#   - use on Mac OS X only
#   - run this script with "git" as default directory
#

# Generate html documentation in a temporary folder next to the git folder
/Applications/Doxygen.app/Contents/Resources/doxygen root/doxygen/root.doxygen

# Copy the 'mouse over' SKIRT logo
cp root/images/SkirtLogoSmall-home.png ../html/root/SkirtLogoSmall-home.png

# Copy the downloadable data files and publications
rsync -hrt ../extras/downloads/ ../html/downloads/
rsync -hrt ../extras/publications/ ../html/publications/

# Copy some redirecting index.html files
cp root/index_root.html ../html/index.html
cp root/index_downloads.html ../html/downloads/index.html

# Obtain the MathJax repository if it is not yet present
if [ ! -d ../html/mathjax ]; then

    # Clone the repository and checkout version 2.4
    git clone git://github.com/mathjax/MathJax.git ../html/mathjax
    git -C ../html/mathjax checkout -b v2.4-latest origin/v2.4-latest

    # Remove unnecessary files and folders
    xargs -I fname rm -r fname < root/doxygen/mathjax_delete.txt

fi
