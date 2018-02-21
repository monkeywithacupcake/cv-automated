#!/bin/bash

#=====================================================================
#          FILE:  cv.sh
#         USAGE:  Run manually to generate my CV
#   DESCRIPTION:  Uses Pandoc to pull together Markdown documents
#                 & process them with Pandoc to generate my CV
#        AUTHOR:  Jess Chandler based on Scott Granneman (RSG), scott@ChainsawOnATireSwing.com
#     REFERENCE: https://www.chainsawonatireswing.com/2013/05/28/how-i-create-manage-my-cv-using-markdown-pandoc/
#       VERSION:  1.0
#       CREATED:  05/11/2013 11:50:30 CDT
#      REVISION:  02/21/2018 09:59:30 JST
#=====================================================================

###
## Variables
#
myName="Jane Awesome"
# Directory for CV which is same as this file!
cvDir=`dirname $0`

# Directory for CV Builds
cvBuildDir=$cvDir/Builds
# Temp for html5
cvTmpDir=$cvDir/Builds/tmp
# Name of the output files
cvName="$myName - CV - $(date +%Y-%m-%d)"
clName="$myName - Letter - $(date +%Y-%m-%d)"
###
## Create HTML files for each Markdown file
#

for i in $(ls $cvBuildDir/*md) ; do
  echo $i
  # Get the name of the file, sans extension, for generating HTML file
  cvBuildName=$(basename "$i" .md)
  # Convert to HTML
  pandoc --section-divs -f markdown -t html5 -o $cvTmpDir/$cvBuildName.html $i
done

###
## Join the HTML files into one HTML CV
#

pandoc -H $cvBuildDir/style.css --section-divs -f markdown -t html5 \
-o "$cvTmpDir/$cvName.html" \
-A $cvTmpDir/description.html \
-A $cvTmpDir/experience.html \
-A $cvTmpDir/education.html \
-A $cvTmpDir/skills.html \
-A $cvTmpDir/articles.html \
$cvBuildDir/cv.md

###
## Convert the HTML CV into PDF CV
#

pandoc -H $cvBuildDir/cv.tex "$cvTmpDir/$cvName.html" -o "$cvDir/$cvName.pdf"

###
## Cover Letter
#

# Convert to HTML
pandoc --section-divs -f markdown -t html5 -o "$cvTmpDir/$clName.html" "$cvBuildDir/cover-letter.md"

# Convert HTML to PDF
pandoc -H $cvBuildDir/cv.tex "$cvTmpDir/$clName.html" -o "$cvDir/$clName.pdf"


###
## Repeat this process for other files that you want to create such as references or a separate publications list
#
