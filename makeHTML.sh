#!/bin/bash
# (use "chmod +rx scriptname" to make script executable)
#
# This script builds the HTML pages for the complete SKIRT web site,
# including the documentation derived from the code for SKIRT and PTS.
#
# Instructions:
#   - use on Mac OS X only
#   - the SKIRT8 and PTS repos should be checked out next to the SKIRT8website repo
#   - the "extras" directory should be placed next to the SKIRT8website "git" directory
#   - run this script with "git" as default directory
#

# Generate html documentation in a temporary folder next to the git folder
/Applications/Doxygen.app/Contents/Resources/doxygen root/doxygen/html.doxygen
/Applications/Doxygen.app/Contents/Resources/doxygen skirt/doxygen/html.doxygen
/Applications/Doxygen.app/Contents/Resources/doxygen pts/doxygen/html.doxygen
/Applications/Doxygen.app/Contents/Resources/doxygen tutorials/doxygen/html.doxygen
/Applications/Doxygen.app/Contents/Resources/doxygen benchmarks/doxygen/html.doxygen

# Copy the 'mouse over' SKIRT logo
cp root/images/SkirtLogoSmall-home.png ../html/root/
cp root/images/SkirtLogoSmall-home.png ../html/skirt/
cp root/images/SkirtLogoSmall-home.png ../html/pts/
cp root/images/SkirtLogoSmall-home.png ../html/tutorials/
cp root/images/SkirtLogoSmall-home.png ../html/benchmarks/

# Copy the downloadable data files and publications
rsync -hrt --delete ../extras/downloads/ ../html/downloads/
rsync -hrt --delete ../extras/publications/ ../html/publications/
rsync -hrt --delete benchmarks/skifiles/ ../html/skifiles/

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
